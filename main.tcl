#!/usr/bin/env wish

# app
wm title . "Notepad"
wm iconphoto . -default [image create photo -file icon.gif]
wm geometry . 900x500+[expr {([winfo vrootwidth  .] - 900)/2}]+[expr {([winfo vrootheight .] - 500)/2}]

entry .find -textvariable search -font {Courier -18 normal} -highlightthickness 0 -borderwidth 0 -foreground #222222 -background #dddddd -selectforeground #000000 -selectbackground #060d7b -border 5 -relief flat 
text .text -yscrollcommand {.yscrollbar set} -highlightthickness 0 -font {Courier -18 normal} -undo 1 -background #eeeeee -foreground #222222 -selectbackground #bcbcbc -selectforeground #000000 -border 10 -relief flat
scrollbar .yscrollbar -command {.text yview}

# layout
pack .yscrollbar -side right -fill y
pack .text -side left -fill both -expand 1
focus .text

# menu
menu .menu
menu .menu.apple -tearoff 0
.menu.apple add command -label "About" -command {
    tk_messageBox -title "About Notepad" -message "Notepad v1.0.1" -detail "By Nick Barth 2019"
}
.menu add cascade -menu .menu.apple
. configure -menu .menu

# globals
set current_file ""
set search ""
set search_start 1.0
set search_end 1.0

# procs
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

proc show_search {} {
    global search

    set search ""
    pack .find -side top -fill x -expand 1 -before .text
    .text tag remove sel 1.0 end
    focus .find
}

proc search_file {find_next} {
    global search
    global search_start 0
    global search_end 0

    if {!$find_next} {
      set search_start 1.0
      set search_end 1.0
    }

    pack forget .find
    set pos [.text search $search $search_end]

    # not found
    if {$pos == ""} {
        return
    }

    .text tag remove sel $search_start $search_end

    set line [lindex [split $pos .] 0]
    set col [lindex [split $pos .] 1]
    set len [string length $search]
    set end [expr $len + $col]
    set endpos "$line.$end"

    .text tag add sel $pos $endpos
    .text mark set insert $endpos
    focus .text

    set search_start $pos
    set search_end $endpos
}

# hotkeys
bind . <Command-n> { set current_file ""; .text delete 1.0 end }
bind . <Command-s> file_save
bind . <Command-o> file_open
bind . <Command-f> show_search
bind . <Command-g> { search_file 1 }
bind . <Escape> { .text tag remove sel 1.0 end }
bind .text <Command-a> { .text tag add sel 1.0 end; .text mark set insert end }
bind .find <Return> { search_file 0 }
bind .find <Escape> { .text tag remove sel 1.0 end; pack forget .find; .text mark set insert end; focus .text }
