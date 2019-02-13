wm title . "Notepad"

text .text -yscrollcommand {.yscrollbar set} -highlightthickness 0 -font {Helvetica -18 normal}
scrollbar .yscrollbar -command {.text yview}

pack .yscrollbar -side right -fill y
pack .text -side left -fill both -expand 1 -padx 5 -pady 5

menu .m
. configure -menu .m

menu .m.f -tearoff 0
.m add cascade -menu .m.f -command filecmd   -label File
.m.f add command -label Exit -command { exit }

menu .m.e -tearoff 0
.m add cascade -menu .m.e -command searchcmd -label Edit

menu .m.o -tearoff 0
.m add cascade -menu .m.o -command searchcmd -label Format

menu .m.h -tearoff 0
.m add cascade -menu .m.h -command helpcmd   -label Help
.m.h add command -label About -command {.
  tk_messageBox \
  -title "About" \
  -message "Notepad v1.0" \
  -icon info -type ok \
  -detail "Made By Nick B. 2019"
}
