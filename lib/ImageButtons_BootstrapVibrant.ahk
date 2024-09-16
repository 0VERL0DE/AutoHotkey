; ===============================================================================================================================

IBStyles := Map()
IBStyles["info"] := [[0xFF46B8DA, , , , ,], [0xFF8ED1F0], [0xFF25739E], [0xFFD6D6D6]]
IBStyles["success"] := [[0xFF5CB85C, , , , ,], [0xFFA0EBA0], [0xFF3C7A3C], [0xFFD6D6D6]]
IBStyles["warning"] := [[0xFFF0AD4E, , , , ,], [0xFFFFDC8A], [0xFFBF7E30], [0xFFD6D6D6]]
IBStyles["critical"] := [[0xFFD43F3A, , , , ,], [0xFFFF8780], [0xFFAE2B26], [0xFFD6D6D6]]

IBStyles["info-outline"] := [[0xFFF0F0F0, , , , 0xFF46B8DA, 2], [0xFFB4E5FC], [0xFFA6D6E7], [0xFFF0F0F0]]
IBStyles["success-outline"] := [[0xFFF0F0F0, , , , 0xFF5CB85C, 2], [0xFFD9F2D9], [0xFFB8DAB8], [0xFFF0F0F0]]
IBStyles["warning-outline"] := [[0xFFF0F0F0, , , , 0xFFF0AD4E, 2], [0xFFFFF5DB], [0xFFFFE3B3], [0xFFF0F0F0]]
IBStyles["critical-outline"] := [[0xFFF0F0F0, , , , 0xFFD43F3A, 2], [0xFFFFDFDD], [0xFFFFB3B1], [0xFFF0F0F0]]

IBStyles["info-round"] := [[0xFF46B8DA, , , 8, 0xFF46B8DA, 2], [0xFF8ED1F0], [0xFF25739E], [0xFFF0F0F0]]
IBStyles["success-round"] := [[0xFF5CB85C, , , 8, 0xFF5CB85C, 2], [0xFFA0EBA0], [0xFF3C7A3C], [0xFFF0F0F0]]
IBStyles["warning-round"] := [[0xFFF0AD4E, , , 8, 0xFFF0AD4E, 2], [0xFFFFDC8A], [0xFFBF7E30], [0xFFF0F0F0]]
IBStyles["critical-round"] := [[0xFFD43F3A, , , 8, 0xFFD43F3A, 2], [0xFFFF8780], [0xFFAE2B26], [0xFFF0F0F0]]

IBStyles["info-outline-round"] := [[0xFFF0F0F0, , , 8, 0xFF46B8DA, 2], [0xFFB4E5FC], [0xFFA6D6E7], [0xFFF0F0F0]]
IBStyles["success-outline-round"] := [[0xFFF0F0F0, , , 8, 0xFF5CB85C, 2], [0xFFD9F2D9], [0xFFB8DAB8], [0xFFF0F0F0]]
IBStyles["warning-outline-round"] := [[0xFFF0F0F0, , , 8, 0xFFF0AD4E, 2], [0xFFFFF5DB], [0xFFFFE3B3], [0xFFF0F0F0]]
IBStyles["critical-outline-round"] := [[0xFFF0F0F0, , , 8, 0xFFD43F3A, 2], [0xFFFFDFDD], [0xFFFFB3B1], [0xFFF0F0F0]]
; ===============================================================================================================================

UseGDIP()

MyGui := Gui(, "Bootstrap Buttons")
MyGui.MarginX := 20
MyGui.MarginY := 20
MyGui.SetFont("s11", "Segoe UI")
CreateImageButton("SetDefGuiColor", 0xFFF0F0F0)

; -----------------------------------------------------------------------------

Btn11 := MyGui.AddButton("xm ym w80 h24", "Info")
CreateImageButton(Btn11, 0, IBStyles["info"]*)

Btn12 := MyGui.AddButton("x+20 yp w80 h24", "Success")
CreateImageButton(Btn12, 0, IBStyles["success"]*)

Btn13 := MyGui.AddButton("x+20 yp w80 h24", "Warning")
CreateImageButton(Btn13, 0, IBStyles["warning"]*)

Btn14 := MyGui.AddButton("x+20 yp w80 h24", "Critical")
CreateImageButton(Btn14, 0, IBStyles["critical"]*)

; -----------------------------------------------------------------------------

Btn21 := MyGui.AddButton("x+20 yp w80 h24", "Info")
CreateImageButton(Btn21, 0, IBStyles["info-outline"]*)

Btn22 := MyGui.AddButton("x+20 yp w80 h24", "Success")
CreateImageButton(Btn22, 0, IBStyles["success-outline"]*)

Btn23 := MyGui.AddButton("x+20 yp w80 h24", "Warning")
CreateImageButton(Btn23, 0, IBStyles["warning-outline"]*)

Btn24 := MyGui.AddButton("x+20 yp w80 h24", "Critical")
CreateImageButton(Btn24, 0, IBStyles["critical-outline"]*)

; -----------------------------------------------------------------------------

Btn31 := MyGui.AddButton("xm y+20 w80 h24", "Info")
CreateImageButton(Btn31, 0, IBStyles["info-round"]*)

Btn32 := MyGui.AddButton("x+20 yp w80 h24", "Success")
CreateImageButton(Btn32, 0, IBStyles["success-round"]*)

Btn33 := MyGui.AddButton("x+20 yp w80 h24", "Warning")
CreateImageButton(Btn33, 0, IBStyles["warning-round"]*)

Btn34 := MyGui.AddButton("x+20 yp w80 h24", "Critical")
CreateImageButton(Btn34, 0, IBStyles["critical-round"]*)

; -----------------------------------------------------------------------------

Btn41 := MyGui.AddButton("x+20 yp w80 h24", "Info")
CreateImageButton(Btn41, 0, IBStyles["info-outline-round"]*)

Btn42 := MyGui.AddButton("x+20 yp w80 h24", "Success")
CreateImageButton(Btn42, 0, IBStyles["success-outline-round"]*)

Btn43 := MyGui.AddButton("x+20 yp w80 h24", "Warning")
CreateImageButton(Btn43, 0, IBStyles["warning-outline-round"]*)

Btn44 := MyGui.AddButton("x+20 yp w80 h24", "Critical")
CreateImageButton(Btn44, 0, IBStyles["critical-outline-round"]*)

; -----------------------------------------------------------------------------

Btn51 := MyGui.AddButton("xm y+20 w200 h40", "Info")
CreateImageButton(Btn51, 0, IBStyles["info"]*)

Btn52 := MyGui.AddButton("x+20 yp w200 h40", "Success")
CreateImageButton(Btn52, 0, IBStyles["success"]*)

Btn53 := MyGui.AddButton("x+20 yp w200 h40", "Warning")
CreateImageButton(Btn53, 0, IBStyles["warning"]*)

Btn54 := MyGui.AddButton("x+20 yp w200 h40", "Critical")
CreateImageButton(Btn54, 0, IBStyles["critical"]*)

; -----------------------------------------------------------------------------

Btn61 := MyGui.AddButton("xm y+20 w200 h40", "Info")
CreateImageButton(Btn61, 0, IBStyles["info-outline"]*)

Btn62 := MyGui.AddButton("x+20 yp w200 h40", "Success")
CreateImageButton(Btn62, 0, IBStyles["success-outline"]*)

Btn63 := MyGui.AddButton("x+20 yp w200 h40", "Warning")
CreateImageButton(Btn63, 0, IBStyles["warning-outline"]*)

Btn64 := MyGui.AddButton("x+20 yp w200 h40", "Critical")
CreateImageButton(Btn64, 0, IBStyles["critical-outline"]*)

; -----------------------------------------------------------------------------

Btn71 := MyGui.AddButton("xm y+20 w200 h40", "Info")
CreateImageButton(Btn71, 0, IBStyles["info-round"]*)

Btn72 := MyGui.AddButton("x+20 yp w200 h40", "Success")
CreateImageButton(Btn72, 0, IBStyles["success-round"]*)

Btn73 := MyGui.AddButton("x+20 yp w200 h40", "Warning")
CreateImageButton(Btn73, 0, IBStyles["warning-round"]*)

Btn74 := MyGui.AddButton("x+20 yp w200 h40", "Critical")
CreateImageButton(Btn74, 0, IBStyles["critical-round"]*)

; -----------------------------------------------------------------------------

Btn81 := MyGui.AddButton("xm y+20 w200 h40", "Info")
CreateImageButton(Btn81, 0, IBStyles["info-outline-round"]*)

Btn82 := MyGui.AddButton("x+20 yp w200 h40", "Success")
CreateImageButton(Btn82, 0, IBStyles["success-outline-round"]*)

Btn83 := MyGui.AddButton("x+20 yp w200 h40", "Warning")
CreateImageButton(Btn83, 0, IBStyles["warning-outline-round"]*)

Btn84 := MyGui.AddButton("x+20 yp w200 h40", "Critical")
CreateImageButton(Btn84, 0, IBStyles["critical-outline-round"]*)

; -----------------------------------------------------------------------------

MyGui.Show()

; ===============================================================================================================================

#Include CreateImageButton.ahk
#Include UseGDIP.ahk