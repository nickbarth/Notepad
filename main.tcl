#!/usr/bin/env wish

wm title . "Notepad"

menu .m
. configure -menu .m

text .text -yscrollcommand {.yscrollbar set} -highlightthickness 0 -font {Helvetica -18 normal} -undo 1
scrollbar .yscrollbar -command {.text yview}

pack .yscrollbar -side right -fill y
pack .text -side left -fill both -expand 1 -padx 5 -pady 5
focus .text

set current_file ""

proc file_save {} {
	global current_file

	if {$current_file == ""} {
		set current_file [tk_getSaveFile]
	}

	if {$current_file != ""} {
		set fp [open $current_file w]
		puts $fp [ .text get 1.0 end ]
		close $fp
	}
}

proc file_open {} {
	global current_file

	set file_path [tk_getOpenFile]

	if {$file_path != ""} {
		.text delete 1.0 end
		set fp [open $file_path r]
		set data [read $fp]
		close $fp
		.text insert 1.0 $data end
	}

	set current_file $file_path
}

bind . <Command-n> { set current_file ""; .text delete 1.0 end }
bind . <Command-s> file_save
bind . <Command-o> file_open
bind . <Command-a> { .text tag add sel 1.0 end }
