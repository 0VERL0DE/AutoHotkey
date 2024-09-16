#Requires AutoHotkey v2.0
#Include CreateImageButton.ahk
UseGDIP()
Main := Gui("", "Image Buttons")
Main.BackColor := "Blue"
Main.MarginX := 50
Main.MarginY := 20
Main.SetFont("s10")
Main.OnEvent("Close", Main_Close)
Main.OnEvent("Escape", Main_Close)
; CreateImageButton("SetDefGuiColor", "Blue") ; Gui.BackColor is default for v1.0.01+
; Common button --------------------------------------------------------------------------------------------------------
; MsgBox("Button1")
Btn1 := Main.AddButton("w200", "CommonButton")
; Unicolored button rounded by half of its height with different colors for states normal, hot and defaulted -----------
; MsgBox("Button2")
Btn2 := Main.AddButton("w200 Default", "Button 1`nLine 2")
Opt1 := [0x80CF0000, , "White", "H", "Red", 4]
Opt2 := ["Red"]
Opt5 := [, , , , "0xC0C0FF"]
If !CreateImageButton(Btn2, 0, Opt1, Opt2, , , Opt5)
   MsgBox("", "CreateImageButton Error Btn2")
; Vertical bicolored  button with different 3D-style colors for states normal, hot, and pressed ------------------------
; MsgBox("Button3")
Btn3 := Main.AddButton("w200 h30", "&Button 2")
Opt1 := [0xC0E0E0E0, 0xC0B0E0FF, 0x60000000]
Opt2 := [0xE0E0E0, 0xB0E0FF, "Black"]
Opt3 := [ , , "Red"]
If !CreateImageButton(Btn3, 1, Opt1, Opt2, Opt3)
   MsgBox("", "CreateImageButton Error Btn3")
; Raised button with different 3D-style colors for states normal, hot, and disabled ------------------------------------
; MsgBox("Button4")
Btn4 := Main.AddButton("w200 Disabled", "Button 3")
Btn4.Name := "Btn4"
Opt1 := [0x80404040, 0xC0C0C0, "Yellow"]
Opt2 := [0x80606060, 0xF0F0F0, 0x606000]
Opt4 := [0xC0A0A0A0, 0xC0A0A0A0, 0xC0404040]
If !CreateImageButton(Btn4, 8, Opt1, Opt2, , Opt4)
   MsgBox("", "CreateImageButton Error Btn4")
Main.SetFont()
Chk1 := Main.AddCheckBox("xp y+0 w200", "Enable")
Chk1.OnEvent("Click", Chk1Clicked)
; Image button without caption with different pictures for states normal and hot ---------------------------------------
; MsgBox("Button5")
Btn5 := Main.AddButton("w200 h30")
Opt1 := ["PIC1.jpg"]
Opt2 := ["PIC2.jpg"]
If !CreateImageButton(Btn5, 0, Opt1, Opt2)
   MsgBox("", "CreateImageButton Error Btn5")
Main.Show()
Return
; ----------------------------------------------------------------------------------------------------------------------
Main_Close(GuiObj) {
   ExitApp
}
; ----------------------------------------------------------------------------------------------------------------------
Chk1Clicked(CtrlObj, Info) {
   CtrlObj.Gui["Btn4"].Enabled := CtrlObj.Value
}
; ----------------------------------------------------------------------------------------------------------------------
; Loads and initializes the Gdiplus.dll.
; Must be called once before you use any of the DLL functions.
; ----------------------------------------------------------------------------------------------------------------------
#DllLoad "Gdiplus.dll"
UseGDIP(Params*) {
   Static GdipObject := 0
   If !IsObject(GdipObject) {
      GdipToken  := 0
      SI := Buffer(24, 0) ; size of 64-bit structure
      NumPut("UInt", 1, SI)
      If DllCall("Gdiplus.dll\GdiplusStartup", "PtrP", &GdipToken, "Ptr", SI, "Ptr", 0, "UInt") {
         MsgBox("GDI+ could not be startet!`n`nThe program will exit!", A_ThisFunc, 262160)
         ExitApp
      }
      GdipObject := {__Delete: UseGdipShutDown}
   }
   UseGdipShutDown(*) {
      DllCall("Gdiplus.dll\GdiplusShutdown", "Ptr", GdipToken)
   }
}