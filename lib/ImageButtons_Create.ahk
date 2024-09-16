#Requires AutoHotkey v2.0

; Example how to set it up.
IBStyles := Map()
IBStyles["info"] := CreateButtonOptions("Black","White")


CreateButtonOptions(ColorRGB,TextColor:="",Rounded:=0,BorderWidth:= 1,BorderColor:= "",TargetColor:=""){
    StartColor := ARBG_FromRBG(ColorRGB)
    TargetColor := TargetColor="" ? "" : ARBG_FromRBG(TargetColor)
    TextColor := TextColor = "" ? "" : ARBG_FromRBG(TextColor)
    Rounded := Rounded
    BorderColor := BorderWidth=0 ? "" : BorderColor="" ? LightenDarkenColor(ARBG_FromRBG(ColorRGB),-50) : ColorRGB
    BorderWidth := BorderWidth
    ;            PBS_NORMAL    = 1
    ;	         PBS_HOT       = 2
    ;	         PBS_PRESSED   = 3
    ;	         PBS_DISABLED  = 4
    ;	         PBS_DEFAULTED = 5
    ;	         PBS_STYLUSHOT = 6
    return [[StartColor, TargetColor, TextColor, Rounded, BorderColor, BorderWidth] ; PBS_NORMAL
        , [LightenDarkenColor(StartColor, 50), TargetColor, TextColor, Rounded, BorderColor, BorderWidth] ; PBS_HOT
        , [LightenDarkenColor(StartColor, 100), TargetColor, TextColor, Rounded, BorderColor, BorderWidth] ; PBS_PRESSED
        , [LightenDarkenColor(StartColor, 30,1), TargetColor, TextColor, Rounded, BorderColor, BorderWidth]] ; PBS_DISABLED
}


LightenDarkenColor(colRBG, amt := 0, Gray := 0) {
    oColors := { Black: 0x000000, Silver: 0xC0C0C0, Gray: 0x808080, White: 0xFFFFFF, Maroon: 0x800000, Red: 0xFF0000, Purple: 0x800080, Fuchsia: 0xFF00FF, Green: 0x008000, Lime: 0x00FF00, Olive: 0x808000, Yellow: 0xFFFF00, Navy: 0x000080, Blue: 0x0000FF, Teal: 0x008080, Aqua: 0x00FFFF }
    if oColors.HasOwnProp(colRBG) {
        colRBG := oColors.%ColRBG%
    }
    r := Max(Min((colRBG >> 16) + amt, 255), 0)
    b := Max(Min(((colRBG >> 8) & 0x00FF) + amt, 255), 0)
    g := Max(Min((colRBG & 0x0000FF) + amt, 255), 0)

    if Gray {
        ;   r := (r + b + g)/3
        ;   b := r
        ;   g := r
    }
    newColorRBG := g | (b << 8) | (r << 16)
    return newColorRBG
}

; ===============================================================================================================================

/********************************************
 * ARGB(A,RGB)
 * 
 * returns the ARGB value from RGB
 * 
 * 
 */
ARBG_FromRBG(colRBG, A := 0) {
    oColors := { Black: 0x000000, Silver: 0xC0C0C0, Gray: 0x808080, White: 0xFFFFFF, Maroon: 0x800000, Red: 0xFF0000, Purple: 0x800080, Fuchsia: 0xFF00FF, Green: 0x008000, Lime: 0x00FF00, Olive: 0x808000, Yellow: 0xFFFF00, Navy: 0x000080, Blue: 0x0000FF, Teal: 0x008080, Aqua: 0x00FFFF }
    if oColors.HasOwnProp(colRBG) {
        colRBG := oColors.%ColRBG%
    }
    A := A & 0xFF, colRBG := colRBG & 0xFFFFFF
    return ((colRBG | (A << 24)) & 0xFFFFFFFF)
}
