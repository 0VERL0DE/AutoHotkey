#Requires AutoHotkey v2.0

; ===============================================================================================================================

IBStyles := Map()
IBStyles["electric-blue"] := [[0xFF1E90FF, , , , 0xFFFFFFFF, 1], [0xFF1E90FF, , , , 0xFFFFFF00, 2], [0xFF104E8B, , , , 0xFFFFFFFF, 1], [0xFFD3D3D3, , , , 0xFFFFFFFF, 1]]
IBStyles["neon-green"] := [[0xFF32CD32, , , , 0xFFFFFFFF, 1], [0xFF32CD32, , , , 0xFFFF00FF, 2], [0xFF228B22, , , , 0xFFFFFFFF, 1], [0xFFD3D3D3, , , , 0xFFFFFFFF, 1]]
IBStyles["vivid-coral"] := [[0xFFFF6347, , , , 0xFFFFFFFF, 1], [0xFFFF6347, , , , 0xFF00FFFF, 2], [0xFFCD5C5C, , , , 0xFFFFFFFF, 1], [0xFFD3D3D3, , , , 0xFFFFFFFF, 1]]
IBStyles["bright-violet"] := [[0xFF8A2BE2, , , , 0xFFFFFFFF, 1], [0xFF8A2BE2, , , , 0xFFADFF2F, 2], [0xFF4B0082, , , , 0xFFFFFFFF, 1], [0xFFD3D3D3, , , , 0xFFFFFFFF, 1]]
IBStyles["sunny-yellow"] := [[0xFFFFFF00, , , , 0xFFFFFFFF, 1], [0xFFFFFF00, , , , 0xFFFF69B4, 2], [0xFFBDB76B, , , , 0xFFFFFFFF, 1], [0xFFD3D3D3, , , , 0xFFFFFFFF, 1]]

IBStyles["electric-blue-outline"] := [[0xFFFFFFFF, , , , 0xFF1E90FF, 1], [0xFFFFFFFF, , , , 0xFFFFFF00, 2], [0xFF1E90FF, , , , 0xFF1E90FF, 1], [0xFFD3D3D3, , , , 0xFF1E90FF, 1]]
IBStyles["neon-green-outline"] := [[0xFFFFFFFF, , , , 0xFF32CD32, 1], [0xFFFFFFFF, , , , 0xFFFF00FF, 2], [0xFF32CD32, , , , 0xFF32CD32, 1], [0xFFD3D3D3, , , , 0xFF32CD32, 1]]
IBStyles["vivid-coral-outline"] := [[0xFFFFFFFF, , , , 0xFFFF6347, 1], [0xFFFFFFFF, , , , 0xFF00FFFF, 2], [0xFFFF6347, , , , 0xFFFF6347, 1], [0xFFD3D3D3, , , , 0xFFFF6347, 1]]
IBStyles["bright-violet-outline"] := [[0xFFFFFFFF, , , , 0xFF8A2BE2, 1], [0xFFFFFFFF, , , , 0xFFADFF2F, 2], [0xFF8A2BE2, , , , 0xFF8A2BE2, 1], [0xFFD3D3D3, , , , 0xFF8A2BE2, 1]]
IBStyles["sunny-yellow-outline"] := [[0xFFFFFFFF, , , , 0xFFFFFF00, 1], [0xFFFFFFFF, , , , 0xFFFF69B4, 2], [0xFFFFFF00, , , , 0xFFFFFF00, 1], [0xFFD3D3D3, , , , 0xFFFFFF00, 1]]

IBStyles["electric-blue-round"] := [[0xFF1E90FF, , , 8, 0xFFFFFFFF, 1], [0xFF1E90FF, , , 8, 0xFFFFFF00, 2], [0xFF104E8B, , , 8, 0xFFFFFFFF, 1], [0xFFD3D3D3, , , 8, 0xFFFFFFFF, 1]]
IBStyles["neon-green-round"] := [[0xFF32CD32, , , 8, 0xFFFFFFFF, 1], [0xFF32CD32, , , 8, 0xFFFF00FF, 2], [0xFF228B22, , , 8, 0xFFFFFFFF, 1], [0xFFD3D3D3, , , 8, 0xFFFFFFFF, 1]]
IBStyles["vivid-coral-round"] := [[0xFFFF6347, , , 8, 0xFFFFFFFF, 1], [0xFFFF6347, , , 8, 0xFF00FFFF, 2], [0xFFCD5C5C, , , 8, 0xFFFFFFFF, 1], [0xFFD3D3D3, , , 8, 0xFFFFFFFF, 1]]
IBStyles["bright-violet-round"] := [[0xFF8A2BE2, , , 8, 0xFFFFFFFF, 1], [0xFF8A2BE2, , , 8, 0xFFADFF2F, 2], [0xFF4B0082, , , 8, 0xFFFFFFFF, 1], [0xFFD3D3D3, , , 8, 0xFFFFFFFF, 1]]
IBStyles["sunny-yellow-round"] := [[0xFFFFFF00, , , 8, 0xFFFFFFFF, 1], [0xFFFFFF00, , , 8, 0xFFFF69B4, 2], [0xFFBDB76B, , , 8, 0xFFFFFFFF, 1], [0xFFD3D3D3, , , 8, 0xFFFFFFFF, 1]]
; ===============================================================================================================================

UseGDIP()

MyGui := Gui(, "Bootstrap Buttons")
MyGui.MarginX := 20
MyGui.MarginY := 20
MyGui.SetFont("s11", "Segoe UI")
CreateImageButton("SetDefGuiColor", 0xFFF0F0F0)

; -----------------------------------------------------------------------------

Btn11 := MyGui.AddButton("xm ym w80 h24", "electric-blue")
CreateImageButton(Btn11, 0, IBStyles["electric-blue"]*)

Btn12 := MyGui.AddButton("x+20 yp w80 h24", "neon-green")
CreateImageButton(Btn12, 0, IBStyles["neon-green"]*)

Btn13 := MyGui.AddButton("x+20 yp w80 h24", "vivid-coral")
CreateImageButton(Btn13, 0, IBStyles["vivid-coral"]*)

Btn14 := MyGui.AddButton("x+20 yp w80 h24", "bright-violet")
CreateImageButton(Btn14, 0, IBStyles["bright-violet"]*)

; -----------------------------------------------------------------------------

Btn21 := MyGui.AddButton("x+20 yp w80 h24", "electric-blue")
CreateImageButton(Btn21, 0, IBStyles["electric-blue-outline"]*)

Btn22 := MyGui.AddButton("x+20 yp w80 h24", "neon-green")
CreateImageButton(Btn22, 0, IBStyles["neon-green-outline"]*)

Btn23 := MyGui.AddButton("x+20 yp w80 h24", "vivid-coral")
CreateImageButton(Btn23, 0, IBStyles["vivid-coral-outline"]*)

Btn24 := MyGui.AddButton("x+20 yp w80 h24", "bright-violet")
CreateImageButton(Btn24, 0, IBStyles["bright-violet-outline"]*)

; -----------------------------------------------------------------------------

Btn31 := MyGui.AddButton("xm y+20 w80 h24", "electric-blue")
CreateImageButton(Btn31, 0, IBStyles["electric-blue-round"]*)

Btn32 := MyGui.AddButton("x+20 yp w80 h24", "neon-green")
CreateImageButton(Btn32, 0, IBStyles["neon-green-round"]*)

Btn33 := MyGui.AddButton("x+20 yp w80 h24", "vivid-coral")
CreateImageButton(Btn33, 0, IBStyles["vivid-coral-round"]*)

Btn34 := MyGui.AddButton("x+20 yp w80 h24", "bright-violet")
CreateImageButton(Btn34, 0, IBStyles["bright-violet-round"]*)

; -----------------------------------------------------------------------------

Btn41 := MyGui.AddButton("x+20 yp w80 h24", "electric-blue")
CreateImageButton(Btn41, 0, IBStyles["electric-blue-round"]*)

Btn42 := MyGui.AddButton("x+20 yp w80 h24", "neon-green")
CreateImageButton(Btn42, 0, IBStyles["neon-green-round"]*)

Btn43 := MyGui.AddButton("x+20 yp w80 h24", "vivid-coral")
CreateImageButton(Btn43, 0, IBStyles["vivid-coral-round"]*)

Btn44 := MyGui.AddButton("x+20 yp w80 h24", "bright-violet")
CreateImageButton(Btn44, 0, IBStyles["bright-violet-round"]*)

; -----------------------------------------------------------------------------

Btn51 := MyGui.AddButton("xm y+20 w200 h40", "electric-blue")
CreateImageButton(Btn51, 0, IBStyles["electric-blue"]*)

Btn52 := MyGui.AddButton("x+20 yp w200 h40", "neon-green")
CreateImageButton(Btn52, 0, IBStyles["neon-green"]*)

Btn53 := MyGui.AddButton("x+20 yp w200 h40", "vivid-coral")
CreateImageButton(Btn53, 0, IBStyles["vivid-coral"]*)

Btn54 := MyGui.AddButton("x+20 yp w200 h40", "bright-violet")
CreateImageButton(Btn54, 0, IBStyles["bright-violet"]*)

; -----------------------------------------------------------------------------

Btn61 := MyGui.AddButton("xm y+20 w200 h40", "electric-blue")
CreateImageButton(Btn61, 0, IBStyles["electric-blue-outline"]*)

Btn62 := MyGui.AddButton("x+20 yp w200 h40", "neon-green")
CreateImageButton(Btn62, 0, IBStyles["neon-green-outline"]*)

Btn63 := MyGui.AddButton("x+20 yp w200 h40", "vivid-coral")
CreateImageButton(Btn63, 0, IBStyles["vivid-coral-outline"]*)

Btn64 := MyGui.AddButton("x+20 yp w200 h40", "bright-violet")
CreateImageButton(Btn64, 0, IBStyles["bright-violet-outline"]*)

; -----------------------------------------------------------------------------

Btn71 := MyGui.AddButton("xm y+20 w200 h40", "electric-blue")
CreateImageButton(Btn71, 0, IBStyles["electric-blue-round"]*)

Btn72 := MyGui.AddButton("x+20 yp w200 h40", "neon-green")
CreateImageButton(Btn72, 0, IBStyles["neon-green-round"]*)

Btn73 := MyGui.AddButton("x+20 yp w200 h40", "vivid-coral")
CreateImageButton(Btn73, 0, IBStyles["vivid-coral-round"]*)

Btn74 := MyGui.AddButton("x+20 yp w200 h40", "bright-violet")
CreateImageButton(Btn74, 0, IBStyles["bright-violet-round"]*)

; -----------------------------------------------------------------------------

Btn81 := MyGui.AddButton("xm y+20 w200 h40", "electric-blue")
CreateImageButton(Btn81, 0, IBStyles["electric-blue-round"]*)

Btn82 := MyGui.AddButton("x+20 yp w200 h40", "neon-green")
CreateImageButton(Btn82, 0, IBStyles["neon-green-round"]*)

Btn83 := MyGui.AddButton("x+20 yp w200 h40", "vivid-coral")
CreateImageButton(Btn83, 0, IBStyles["vivid-coral-round"]*)

Btn84 := MyGui.AddButton("x+20 yp w200 h40", "bright-violet")
CreateImageButton(Btn84, 0, IBStyles["bright-violet-round"]*)

; -----------------------------------------------------------------------------

MyGui.Show()

; ===============================================================================================================================

#Include CreateImageButton.ahk
#Include UseGDIP.ahk