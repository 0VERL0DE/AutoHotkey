; https://the-Automator.com/Objects
SetTitleMatchMode 2
OBJID_NATIVEOM := -16
hwnd := ControlGetHwnd("_WwG1","- Word ahk_class OpusApp") ;identify the hwnd for Word

; OBJID_NATIVEOM In response to this object identifier, 
; third-party applications can expose their own object model. 
; Third-party applications can return any COM interface in response to this object identifier.
; https://docs.microsoft.com/en-us/windows/win32/winauto/object-identifiers
Obj:=ObjectFromWindow(hwnd, OBJID_NATIVEOM)
return

;***borrowd & tweaked from Acc.ahk Standard Library*** by Sean  Updated by jethrow*****************
ObjectFromWindow(hWnd, idObject := -4) {
	IID := Buffer(16)
	if DllCall("oleacc\AccessibleObjectFromWindow", "ptr",hWnd, "uint",idObject &= 0xFFFFFFFF
			, "ptr",-16 + NumPut("int64", idObject == 0xFFFFFFF0 ? 0x46000000000000C0 : 0x719B3800AA000C81, NumPut("int64", idObject == 0xFFFFFFF0 ? 0x0000000000020400 : 0x11CF3C3D618736E0, IID))
			, "ptr*", ComObj := ComValue(9,0)) = 0
		; returns the Com Object directly - see previous function for a variation
		Return ComObj
}