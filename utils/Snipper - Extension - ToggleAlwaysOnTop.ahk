/* ;--------------------------------------------------------------------------------------------------------------------
[Extension] Toggle Always On Top (by Speedmaster)
File Name : Snipper - Extension - ToggleAlwaysOnTop.ahk
Version : 2023 05 01

Usage : Press PageUp / PageDown to activate / desactivate Always On top

*/ ;---------------------------------------------------------------------------------------------------------------------


; CONTEXT MENU -------------------------------------------------------
Extensions.Push({ SM: { Text: 'TOGGLE: AlwaysOnTop', Func: SM_SwitchAlwaysontop } })


; DEFAULT SHORTCUTS ---------------------------------------------------
#HotIf WinActive('SnipperWindow ahk_class AutoHotkeyGUI')
PGDN::SM_AlwaysOnBottom()
PGUP::SM_AlwaysOnTop()
#HotIf


;----- FUNCTIONS ------------------------------------------
SM_AlwaysOnBottom(){
Hwnd := WinGetID("A")
	guisnip:=GuiFromHwnd(hwnd)
	guiSnip.Opt("-AlwaysOnTop")
}

SM_AlwaysOnTop(){
Hwnd := WinGetID("A")
	guisnip:=GuiFromHwnd(hwnd)
	guiSnip.Opt("+AlwaysOnTop")
}

SM_SwitchAlwaysontop(border:=""){

	Hwnd := WinGetID('A')
	 Style := WinGetExStyle("ahk_id" Hwnd)

	if (Style & 0x8)  ; toggle selected
	{
		SM_AlwaysOnBottom()
		return false
	}
	else                 ; retore selected
	{
		SM_AlwaysOnTop()
		return true
	}

}

