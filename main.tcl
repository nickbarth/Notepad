#!/usr/bin/env wish

# globals
set current_file ""

# code
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
		.text insert 1.0 [string trimright $data]
	}

	set current_file $file_path
}

# app
wm title . "Notepad"

text .text -yscrollcommand {.yscrollbar set} -highlightthickness 0 -font {Helvetica -18 normal} -undo 1
scrollbar .yscrollbar -command {.text yview}

# layout
pack .yscrollbar -side right -fill y
pack .text -side left -fill both -expand 1 -padx 5 -pady 5
focus .text

# menu
menu .menu
menu .menu.apple -tearoff 0
.menu.apple add command -label "About" -command {
  tk_messageBox -title "About Notepad" -message "Notepad v1.0.1" -detail "By Nick Barth 2019"
}
.menu add cascade -menu .menu.apple
. configure -menu .menu

# hotkeys
bind . <Command-n> { set current_file ""; .text delete 1.0 end }
bind . <Command-s> file_save
bind . <Command-o> file_open
bind . <Command-a> { .text tag add sel 1.0 end }
