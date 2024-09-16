#Requires AutoHotkey v2.0

; =============================================================================================================================
IBStyles := Map()
IBStyles["dark"] := [[0xFF1C1C1C, 0xFF1A1A1A, 0xFFFFFFFF, 0, 0xFF1A1A1A, 1],  ; Normal Condition: Very Dark Gray
                                        [0xFF262626, 0xFF1A1A1A, 0xFFFFFFFF, 0, 0xFF1A1A1A, 1],  ; On Mouse: Darker Gray
                                        [0xFF2F2F2F, 0xFF1A1A1A, 0xFFFFFFFF, 0, 0xFF1A1A1A, 1],  ; Mouse Click: Very Dark Gray
                                        [0xFF626262, 0xFF474747, 0xFFFFFFFF, 0, 0xFF474747, 1]]  ; Disabled Light Gray
UseGDIP()
MyGui := Gui(, "Bootstrap Buttons")
MyGui.BackColor := "000000"
MyGui.MarginX := 20
MyGui.MarginY := 20
MyGui.SetFont("s11", "Segoe UI")
CreateImageButton("SetDefGuiColor", 0xFFF0F0F0)

; -----------------------------------------------------------------------------
BtnDarkSmall := MyGui.AddButton("xm ym w80 h24", "Dark")
CreateImageButton(BtnDarkSmall, 0, IBStyles["dark"]*)

BtnDarkBig := MyGui.AddButton("xm y+20 w200 h40", "Dark Button")
CreateImageButton(BtnDarkBig, 0, IBStyles["dark"]*)

MyGui.Show()
; ===============================================================================================================================
; ----------------------------------------------------------------------------------------------------------------------
; Loads and initializes the Gdiplus.dll.
; Must be called once before you use any of the DLL functions.
; ----------------------------------------------------------------------------------------------------------------------
#DllLoad "Gdiplus.dll"
UseGDIP() {
   Static GdipObject := 0
   If !IsObject(GdipObject) {
      GdipToken := 0
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
#Include CreateImageButton.ahk
;#Include UseGDIP.ahk