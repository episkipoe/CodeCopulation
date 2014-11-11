set mutateRate  0.1
set ABThreshold 0.5

set fileMother [tk_getOpenFile -title {Specify Mother Source} -filetypes {{ASM *.s}}]
set fileFather [tk_getOpenFile -title {Specify Father Source} -filetypes {{ASM *.s}}]
set fileChild  [tk_getSaveFile -title {Specify Child Source} -filetypes {{ASM *.s}}]

foreach fN [list fileMother fileFather] {
	if {[file extension [set $fN]] == ".c"} {
		exec "gcc -S $fN"
	}
}

set ::maxCalls 1
set ::varOffset 0 ; set ::jmpOffset 0 
set ::trailingCode {}
proc readParent {parentFile parentID} {
	set fParent [open $parentFile "r"]
	set curState ""
	set nVars 0 ; set nJmp 0
	while {1} {
		if [eof $fParent] { break }
		gets $fParent line
		if [regexp {^LC(\d+):} $line whole curLbl] {
			if {$curLbl>$nVars} {
				set nVars $curLbl 
			}
			#puts "def $curLbl -> [expr $curLbl+$::varOffset]"
			incr curLbl $::varOffset
			set curState addLabel
		} elseif {[string first "\t.text" $line]==0} {
			set curState ""
		} elseif {[string first "\t.def" $line] == 0} {
			set funcName [string range [lindex $line 1] 0 end-1] ;#trim ending :
			set ::funcDef($parentID,$funcName) $line
			lappend ::funcList($parentID) $funcName
			set curState ""
		} elseif [regexp {^_([^:]+):} $line] {
			set curState addFunc
		} elseif {$curState == "addLabel"} {
			#puts "addLabel $line in $curLbl"
			lappend ::addLabel($curLbl) $line
		} elseif {$curState == "addFunc"} {
			if [regexp {\$LC(\d+),} $line whole curLbl] {
				#puts "use $curLbl -> [expr $curLbl+$::varOffset]"
				regsub {\$LC\d+} $line "\$LC[expr $curLbl + $::varOffset]" line
			} elseif [regexp {^L(\d+):} $line whole curLbl] {
				#puts "define $curLbl add $::jmpOffset"
				regsub {L\d+} $line "L[expr $curLbl + $::jmpOffset]" line
				if {$curLbl>$nJmp} {
					set nJmp $curLbl
				}
			} elseif [regexp {L(\d+)$} $line whole curLbl] {
				#puts "use $curLbl add $::jmpOffset"
				regsub {L\d+} $line "L[expr $curLbl + $::jmpOffset]" line
			} elseif {[string first "\tcall" $line] == 0} {
				set fName [lindex $line 1]
				if [info exists ::funcCalled($fName)] {
					incr ::funcCalled($fName) 
					if {$::funcCalled($fName) > $::maxCalls} {
						set maxCalls $::funcCalled($fName) 
					}
				} else {
					set ::funcCalled($fName) 1
				}
			} 
			lappend ::funcBody($parentID,$funcName) $line
			if {$line == "\tret"} { set curState "" }
		} else { ;#no state, can be stuff like .comm
			lappend ::trailingCode $line
		}
	}
	close $fParent
	incr nVars ; incr nJmp
	return [list $nVars $nJmp]
}

proc GetFunctionSimilarity {body1 body2} {
	set totalLines [expr [llength $body1] + [llength $body2]]
	set matches 0

	set lineList {}
	foreach line $body1 {
		if [info exists lineList1($line)] {
			incr lineList1($line)
		} else {
			set lineList1($line) 1
			lappend lineList $line
		}
	}
	foreach line $body2 {
		if [info exists lineList2($line)] {
			incr lineList2($line)
		} else {
			set lineList2($line) 1
			lappend lineList $line
		}
	}
	foreach line [lsort -unique $lineList] {
		if {[info exists lineList1($line)] && [info exists lineList2($line)]} {
			incr matches [expr $lineList1($line) + $lineList2($line)]
		}
	}
	return [expr $matches / double($totalLines)]
}

proc findAlleles {p1 p2} {
	set parent1Functions $::funcList($p1)
	foreach funcName $parent1Functions {
		if ![info exists ::funcBody($p1,$funcName)] { continue }
		if {$funcName == "_main"} { continue }
		set b1 $::funcBody($p1,$funcName)
		foreach tName $::funcList($p2) {
			if {$tName == "_main"} { continue }
			if [info exists ::funcBody($p2,$tName)] { 
				set b2 $::funcBody($p2,$tName)
				set callPct [expr $::funcCalled($tName) / double($::maxCalls)]
				if {$funcName == $tName} { 
					set fs 2.0
				} else {
					set fs [GetFunctionSimilarity $b1 $b2] 

					if {$fs > $::ABThreshold} {
						set ABName "${funcName}${tName}"
						puts "create $ABName"
						lappend ::funcList($p1) $ABName
						#exclude the ret from body 1 then do body 2	
						set ::funcBody($p1,$ABName) [concat [lrange $b1 0 end-1] $b2]
						set ::funcDef($p1,$ABName) "\t.def\t${ABName};\t.scl\t2;\t.type\t32;\t.endef\n"
						lappend ::alleleList($funcName) [list 1.0 $ABName]
					}

				}
				#puts "$fs from $callPct"

				if {$fs > 0} {
					lappend ::alleleList($funcName) [list $fs $tName]
				}
			}
		}
	}
}

proc mutate {code} {
	#if {$::mutateRate < [expr rand()]} { return $code }

	#check for alleles
	if {[string first "\tcall" $code] == 0} {
		set funcName [lindex $code 1]
		if [info exists ::alleleList($funcName)] {
			set alleleTotal 0
			foreach alleleInfo $::alleleList($funcName) {
				foreach {score allele} $alleleInfo { break }
				set alleleTotal [expr $alleleTotal + $score]
			}
			set target [expr rand()*$alleleTotal]
			foreach alleleInfo $::alleleList($funcName) {
				foreach {score allele} $alleleInfo { break }
				if {$target < $score} {
					puts "$funcName -> $allele "
					return "\tcall\t$allele"
				}
				set target [expr $target - $score]
			}
		} 
	}

	#random mutation
	return $code
}

proc writeFunctions {fChild parentID} {
	foreach funcName $::funcList($parentID) {
		if [info exists ::funcWritten($funcName)] { continue }
		puts $fChild ".globl $funcName\n$::funcDef($parentID,$funcName)"
		if ![info exists ::funcBody($parentID,$funcName)] { continue }
		puts $fChild "${funcName}:"
		foreach line $::funcBody($parentID,$funcName) {
			puts $fChild [mutate $line]
		}
		set ::funcWritten($funcName) 1
	}
}

foreach {nVars nJmp} [readParent $fileMother 0] { break }
incr ::varOffset $nVars ; incr ::jmpOffset $nJmp
#puts "vars: $varOffset jmps: $::jmpOffset"
foreach {nVars nJmp} [readParent $fileFather 1] { break }
incr ::varOffset $nVars ; incr ::jmpOffset $nJmp
#puts "vars: $varOffset jmps: $::jmpOffset"

findAlleles 0 0
findAlleles 0 1

proc writeChild {fileName} {
	set fChild [open $fileName "w"]

	#write variables
	for {set varIdx 0} {$varIdx < $::varOffset} {incr varIdx} {
		puts $fChild "LC${varIdx}:\n[join $::addLabel($varIdx) \n]\n.text"
	}

	writeFunctions $fChild 0
	writeFunctions $fChild 1
	if {$::trailingCode != {}} {
		puts $fChild [join $::trailingCode \n]
	}
	close $fChild
}

writeChild $fileChild

#exit
