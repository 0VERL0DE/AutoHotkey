#Requires AutoHotkey v2.0

GroupAdd "TaskBars", "ahk_class Shell_TrayWnd"
GroupAdd "TaskBars", "ahk_class Shell_SecondaryTrayWnd"

; ctrl + h to hide taskbar, does not resize screen area
^h:: {
    static taskbarVisible := 1
    Win%(taskbarVisible ^= 1) ? 'Show' : 'Hide'%("ahk_group TaskBars")
  }
