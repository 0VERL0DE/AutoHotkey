#Requires AutoHotkey v2.0

#Include ImageButtons_StyleButton.ahk
#Include GuiResizer.ahk


#SingleInstance Force
SetWinDelay(10)



myGui := Gui()
myGui.opt("+Resize +MinSize250x150")
myGui.OnEvent("Size", GuiResizer)
ButtonOK := myGui.Add("Button", "", "&OK")

OkayAgain := myGui.Add("Button", "x+10", "&OK")
ButtonOK.wp := 0.5
OkayAgain.xp := -0.45
OkayAgain.wp := 0.4

StyleButton(ButtonOK, 0, "success")
StyleButton(OkayAgain, 0, "critical-round")


; Finished := myGui.Add("Button", "", "Finished")
; my custom method for GuiResizer formatting
; GuiReSizer.FormatOpt(Finished, .1, .2, 0.8, 0.2)
; Cancel := myGui.Add("Button", "", "Cancel")
; my custom method for GuiResizer formatting
; GuiReSizer.FormatOpt(Cancel, .1, .5, 0.8, 0.2)

;StyleButton(Finished, 0, "info-round")
;StyleButton(Cancel, 0, "critical-round")

myGui.OnEvent('Close', (*) => ExitApp())
myGui.Title := "Window"
myGui.Show("w620 h320")

