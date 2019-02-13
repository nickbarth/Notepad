wm title . "Notepad"

text .text -yscrollcommand {.yscrollbar set} -highlightthickness 0 -font {Helvetica -18 normal}
scrollbar .yscrollbar -command {.text yview}

pack .yscrollbar -side right -fill y
pack .text -side left -fill both -expand 1 -padx 5 -pady 5
