#Requires AutoHotkey 2.0.4


/* 
Win+MButton Set/ reset the Window under the mouse cursor:
    Always On Top
    Transparent to 120
    Let mouse click through the window.
Win+WheelUp Increase the opacity of the window under the mouse cursor.
Win+WheelDown Decreases the window opacity of the window under the mouse cursor.

When there's a window set click thorugh, alt+tab will restore the window to its original state.

*/


#MButton::
#WheelUp::
#WheelDown::

ClickThrough(hk?)
{
    SetWinDelay 0
    Static toggle := false, MouseWin := unset

	if hk ~= "S)#WheelUp|#WheelDown" { ; Win + WheelUp/ WheelDown to adjust the window opacity 
        WinID    := (MouseWin ?? MWin())
        curtrans := !(curtrans := WinGetTransparent(WinID)) ? 0 : curtrans
        newTrans := hk = "#WheelUp" ? Min(255, curtrans+8) : Max(0, curtrans-8)
        Return WinSetTransparent(newTrans, WinID)
	}

	if toggle := !toggle
         MouseWin := MWin()

	WinSetAlwaysOnTop(toggle, MouseWin)
	WinSetTransParent(toggle ? 120 : 255, MouseWin)
	WinSetExStyle(toggle ? "+32" : "-32", MouseWin)
	HotKey("!Tab", ClickThrough, toggle ? "On" : "Off") ; When there's a window set click thorugh, alt+tab will restore the window to its original state

	MWin() => (MouseGetPos(,, &_MWin), _MWin)
}