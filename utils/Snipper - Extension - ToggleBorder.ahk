/* ;--------------------------------------------------------------------------------------------------------------------
[Extension] Toggle Border (by Speedmaster)
File Name : Snipper - Extension - ToggleBorder.ahk
Version : 2023 05 01

Usage : Use context menu item or press B to hide or show snipped image border

*/ ;---------------------------------------------------------------------------------------------------------------------


; CONTEXT MENU -------------------------------------------------------
Extensions.Push({ SM: { Text: 'TOGGLE: Border', Func: SM_Borders } })

; DEFAULT SHORTCUTS ---------------------------------------------------
#HotIf WinActive('SnipperWindow ahk_class AutoHotkeyGUI')
b::SM_Borders()
#HotIf

SM_Borders(yorder:=false) {
	Hwnd := WinGetID('A')
	 Style := WinGetStyle("ahk_id" Hwnd)

	if (Style & 0x2000)  ; toggle selected
	{
		WinSetStyle("-0x2000", "ahk_id " Hwnd)
		WinSetRegion(, "ahk_id " Hwnd)
		return false
	}
	else                 ; retore selected
	{
		WinGetPos(&X, &Y, &W, &H, "ahk_id " Hwnd)
		W -= 6, H -= 6
		WinSetStyle("+0x2000", "ahk_id " Hwnd)
		WinSetRegion("3-3 W" W " H" H,  Hwnd)
		return true
	}
}

