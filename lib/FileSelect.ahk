#Requires AutoHotkey v2.0

;; INITIALIZATION - ENVIRONMENT
;{-----------------------------------------------
;

#include <FSO>


#Warn All, Off
#SingleInstance force
DetectHiddenWindows true
SetWinDelay(0)
;}

SetCapsLockState("AlwaysOff")


CapsLock::
{ ; V1toV2: Added bracket


    ;ValidSelection := InputRect(&x1, &y1, &x2, &y2)

        ;OutputDebug("selected: " x1 "," y1 " - " x2 "," y2)

		/*
		Msgbox "Path of active Explorer:`n" Explorer_GetActivePath()[1]

		For v in Explorer_GetAll() {
			AllItems .= v "`n"
		}
		Msgbox "All items in active Explorer: `n" AllItems

		For v in Explorer_GetSelected() {
			SelectedItems .= v "`n"
		}
		Msgbox "Selected items in active Explorer: `n" SelectedItems
		
		*/

		Explorer_CreateListView(Explorer_GetSelected())

		
		;FSO_SetAttributes(Explorer_GetSelected(),,,1)

} ; V1toV2: Added bracket in the end





; get array of all items in active explorer window
; IN		hwnd of active explorer window
; OUT		Array[x] := "fullpath"
Explorer_GetAll(hwnd:="")
{
	arrReturn := []

	if !(window := Explorer_GetActiveHwnd(hwnd))
		return ErrorLevel := "No active window"
	if (window="desktop")
	{
		hwWindow := ControlGetHWND("SysListView321", "ahk_class Progman")
		if !hwWindow ; #D mode
			hwWindow := ControlGetHWND("SysListView321", "A")
		files := ListViewGetContent( "Col1",,"ahk_id" hwWindow)
		base := SubStr(A_Desktop, -1, 1)=="\" ? SubStr(A_Desktop, 1, -1) : A_Desktop
		Loop Parse, files, "`n", "`r"
		{
			path := base "\" A_LoopField
			if FileExist(path)
			{ ; ignore special icons like Computer (at least for now)
				ret .= path "`n"
				arrReturn.Push(path)
			}
				
		}
	}
	else
	{
		;if selection
		;	collection := window.document.SelectedItems
		;else
			collection := window.document.Folder.Items
		for item in collection
		{
			ret .= item.path "`n"
			arrReturn.Push(item.path)
		}
	}
	return arrReturn ;Trim(ret,"`n")
}

; Get array of selected DIRS/FILES
Explorer_GetSelected(hwnd:="")
{
	arrReturn := []

	if !(window := Explorer_GetActiveHwnd(hwnd))
		return ErrorLevel := "ERROR"
	if (window="desktop")
	{
		hwWindow := ControlGetHWND("SysListView321", "ahk_class Progman")
		if !hwWindow ; #D mode
			hwWindow := ControlGetHWND("SysListView321", "A")
		files := ListViewGetContent("Selected" "Col1",,"ahk_id" hwWindow)
		base := SubStr(A_Desktop, -1, 1)=="\" ? SubStr(A_Desktop, 1, -1) : A_Desktop
		Loop Parse, files, "`n", "`r"
		{
			path := base "\" A_LoopField
			if FileExist(path)
			{ ; ignore special icons like Computer (at least for now)
				ret .= path "`n"
				arrReturn.Push(path)
			}
				
		}
	}
	else
	{
		;if selection
			collection := window.document.SelectedItems
		;else
		;	collection := window.document.Folder.Items
		for item in collection
		{
			ret .= item.path "`n"
			arrReturn.Push(item.path)
		}
	}
	return arrReturn ;Trim(ret,"`n")
}










; Get Hwnd of window under cursor
; IN		Screen
; OUT		hwnd
Explorer_GetActiveHwnd(hwnd:="")
{
	; thanks to jethrow for some pointers here
    process := WinGetprocessName("ahk_id" hwnd := hwnd? hwnd:WinExist("A"))
    class := WinGetClass("ahk_id " hwnd)
	
	if (process!="explorer.exe")
		return
	if (class ~= "(Cabinet|Explore)WClass")
	{
		for window in ComObject("Shell.Application").Windows
			if (window.hwnd==hwnd)
				return window
	}
	else if (class ~= "Progman|WorkerW") 
		return "desktop" ; desktop found
}


; Get path of active Explorer window
; IN		Hwnd of active window
; OUT		Array[1] := "fullpath"
Explorer_GetActivePath(hwnd:="")
{
	arrPath := []
	if !(window := Explorer_GetActiveHwnd(hwnd))
		return ErrorLevel := "ERROR"
	if (window="desktop")
		return A_Desktop
	path := window.LocationURL
	path := RegExReplace(path, "ftp://.*@", "ftp://")
	; StrReplace() is not case sensitive
	; check for StringCaseSense in v1 source script
	; and change the CaseSense param in StrReplace() if necessary
	path := StrReplace(path, "file:///",,,, 1)
	; StrReplace() is not case sensitive
	; check for StringCaseSense in v1 source script
	; and change the CaseSense param in StrReplace() if necessary
	path := StrReplace(path, "/", "\")
	
	; thanks to polyethene
	Loop
		If RegExMatch(path, "i)(?<=%)[\da-f]{1,2}", &hex){
			; StrReplace() is not case sensitive
			; check for StringCaseSense in v1 source script
			; and change the CaseSense param in StrReplace() if necessary

			path := StrReplace(path, "%" hex[]  , Chr("0x" . hex[] ))

		}
		Else{
			 Break
		}

	arrPath.Push((path))
	return arrPath
}




InputRect(&X1, &Y1, &X2, &Y2)
    {
        global vInputRectState := 0
        global CapsButtonIsHeld := 0

        InputRect_Return(ThisHotkey){
        }
        
        CapsButtonIsHeldTimer(*){
            CapsButtonIsHeld += 20
        return
    } 

    InputRect_End(ThisHotkey)
    {
        if !vInputRectState
            vInputRectState := -1
        Hotkey("*LButton", "Off")
        Hotkey("*RButton", "Off")
        Hotkey("Esc", "Off")
        SetTimer(InputRect_Update,0)
        SetTimer(CapsButtonIsHeldTimer,0)

        ; Gui1.Destroy()
        ; Gui2.Destroy()
        ; Gui3.Destroy()
        ; Gui4.Destroy()


        return 
    } ; V1toV2: Added bracket in the end



    ; Start button timer to enable/disable selection    
	DetectHiddenWindows(true)

    ; draw rectangle with 4 flat rectangles
    static r := 3

;     Gui1 := Gui()
;     Gui1.Opt("-Caption +ToolWindow +AlwaysOnTop")
; ;    Gui1.Color("Red")
;     Gui2 := Gui()
;     Gui2.Opt("-Caption +ToolWindow +AlwaysOnTop")
; ;    Gui2.Color("Red")
;     Gui3 := Gui()
;     Gui3.Opt("-Caption +ToolWindow +AlwaysOnTop")
; ;    Gui3.Color("Red")
;     Gui4 := Gui()
;     Gui4.Opt("-Caption +ToolWindow +AlwaysOnTop")
; ;    Gui4.Color("Red")

    ; define actions for other buttons
	Hotkey("*LButton", InputRect_Return)
	Hotkey("*RButton", InputRect_End)
	Hotkey("Esc", InputRect_End)


    ; Wait for LButton down, get initial coords
	ErrorLevel := !KeyWait("LButton", "D, T5")
    If ErrorLevel {
        OutputDebug("Abort")
        ; free mouse, exit
        Hotkey("*LButton", "Off")
        Exit()
    }

    ; drag needed to select files
    Send("{LButton down}")
	MouseGetPos(&xorigin, &yorigin)

    SetTimer(CapsButtonIsHeldTimer.Bind("time"),20)
    OutputDebug("Origin " xorigin "," yorigin)

    ; Start looping until key released
	SetTimer(InputRect_Update,10)
	ErrorLevel := !KeyWait("LButton", "U")
    OutputDebug("LButton up")
    Send("{LButton Up}")

    ; restore all hotkeys and stop updating
	Hotkey("*LButton", "Off")
	Hotkey("Esc", InputRect_End, "Off")
	SetTimer(InputRect_Update,0)
    SetTimer(CapsButtonIsHeldTimer,0)

    ; destroy rectangle

    ; Gui1.Destroy()
    ; Gui2.Destroy()
    ; Gui3.Destroy()
    ; Gui4.Destroy()


    
    ; filter types of input
	If (CapsButtonIsHeld > 400){
		XDiff := Abs(x2 - x1)
		YDiff := Abs(y2 - y1)
		If (XDiff > 30) Or (YDiff > 30) {
			OutputDebug("Rect")
            return x1 y1 y2 y2
		}Else{
			OutputDebug("Hold on " x2 "," y2 "(" XDiff YDiff ")  (" CapsButtonIsHeld "ms)")
            return x2 y2
		}
	}Else{
		OutputDebug("trigger <400 ms -> Click (" CapsButtonIsHeld "ms)")
		;Send {Click Right}
        Exit()
	}

	return

    ;Loop to scan/update while button is held
	InputRect_Update()

      ;  if !vInputRectState
     ;   {
{ ; V1toV2: Added bracket
            MouseGetPos(&x, &y)

            if (x < xorigin)
                x1 := x, x2 := xorigin
            else x2 := x, x1 := xorigin
            if (y < yorigin)
                y1 := y, y2 := yorigin
            else y2 := y, y1 := yorigin
            
            OutputDebug("updating: " xorigin "," yorigin " - " x2 "," y2)

            ; Update the "selection rectangle".
            ; Gui1.Show("NA X" x1 " Y" y1 " W" x2-x1 " H" r)
            ; Gui2.Show("NA X" x1 " Y" y2-r " W" x2-x1 " H" r)
            ; Gui3.Show("NA X" x1 " Y" y1 " W" r " H" y2-y1)
            ; Gui4.Show("NA X" x2-r " Y" y1 " W" r " H" y2-y1)

     ;   }
     ;   vInputRectState := 1






    
	return
} ; V1toV2: Added bracket before function




}






Explorer_CreateListView(arrsel){

	myGui := Gui()
	SB := myGui.AddStatusBar()
	LV := myGui.Add("ListView", "w685 h200  Grid AltSubmit", ["Name", "Size", "Attr", "Encoding", "Created", "Access", "Modif"])
	LV.OnEvent("DoubleClick", MyListView.Bind("DoubleClick"))
	HLV := LV.hwnd

	FSObj := FSO_GetAllProps(arrsel)
	For i,File in FSObj
	{
		LV.Add("Checked",File.Name, File.Size, File.Attr, File.Encoding, File.TimeC, File.TimeA, File.TimeM)
	}

	LV.ModifyCol  ; Auto-size each column to fit its contents.
;--


;Encoding := FileGetEncoding(FilePath)
;CodePage := FileGetFormat(FilePath)
;EOLType := FileGetEolType(FilePath)
;LineCount := FileGetLineCount(FilePath)
;Props := FileGetProps(FilePath)    
;Validity := FileValidate(FilePath)

;  Gui RButtonMenu: Add, Button,  x0 y0 w332 h23, %FilePath%
;   Gui RButtonMenu: Add, Button,  x0 y24 w80 h23, %CodePage%
;  Gui RButtonMenu: Add, Button, x128 y24 w203 h23, Breaks: %EOLType%
;   Gui RButtonMenu: Add, Button, x80 y24 w47 h23, %LineCount%


;    Gui RButtonMenu: Add, ListView, x0 w300 r20 h200  -Hdr +LV0x10000, PropName|PropValue
;    For Each, Prop In Props
;      LV_Add("", Prop.N, Prop.V)
;    LV_ModifyCol()


;--
	; Display the window and return. The script will be notified whenever the user double clicks a row.
	myGui.Title := "File Info"
	myGui.Show()
	return



	MyListView(A_GuiEvent, GuiCtrlObj, Info, *)
{ ; V1toV2: Added bracket
		RowText := LV.GetText(A_EventInfo)  ; Get the text from the row's first field.
			;FilePath := "C:\Users\loder\Downloads\contacts.xml"
;Encoding := FileGetEncoding(FilePath)
;CodePage := FileGetFormat(FilePath)
;EOLType := FileGetEolType(FilePath)
;LineCount := FileGetLineCount(FilePath)
;Props := FileGetProps(FilePath)    
;Validity := FileValidate(FilePath)

	SB := MyGui.Add("StatusBar")

		if (A_GuiEvent = "Normal"){
			SB.SetText(A_EventInfo " : " RowText "")
		}
		if (A_GuiEvent = "DoubleClick")
		{
			SB.SetText(A_EventInfo " : " RowText)

		}
	return
} ; V1toV2: Added bracket in the end
			

}












 

~$#Lbutton::		;	<-- Snip Image Only
{
    Outputdebug "button down"
	Area := SelectScreenRegion('LButton')
	If (Area.W > 8 and Area.H > 8){
		;SnipArea(Area, false, true, SnipVisible, &guiSnips)
		;Explorer_CreateListView(Explorer_GetSelected())

		;for k, v in Area.OwnProps() {
        ;    Outputdebug k "=" v 
        ;}
    }
}



; SelectScreenRegion
SelectScreenRegion(Key, Color := 'Lime', Color_Inactive := 'Red', Transparent := 80)
{
	; Initialize
	Static guiSSR, guiInfoDialog, DisplayWH := true, X, Y, W, H


	If !IsSet(guiSSR)
	{
		guiSSR := Gui('+AlwaysOnTop -Caption +Border +ToolWindow +LastFound -DPIScale +Resize', 'SnipperSelect')
		guiSSR.MarginX := 0, guiSSR.MarginY := 0
		guiSSR.BackColor := 1, WinSetTransColor(1, guiSSR)
		guiSSR.OnEvent('Size', guiSSR_Size)
		guiSSR.Background := guiSSR.Add('Text', 'w' A_ScreenWidth ' h' A_ScreenHeight ' Background' Color)
		If InStr(A_OSVersion, '6.1') ; win 7
			WinSetTransparent(Transparent, guiSSR)
		Else
			WinSetTransparent(Transparent, guiSSR.Background)
		guiSSR.InfoWH := guiSSR.Add('Text', 'Background' Color ' w175 h75 Center', 'XXXX x YYYY')
		guiSSR.AspectRatio := false
		OnMessage(0x84, WM_NCHITTEST)
		OnMessage(0x83, WM_NCCALCSIZE)
		OnMessage(0x214, WM_SIZING)
		OnMessage(0x0232, WM_EXITSIZEMOVE)
		OnExit((*) => OnMessage(0x83, WM_NCCALCSIZE, 0)) ; WM_NCCALCSIZE will cause error if Gui exist while closing
	}
	If !IsSet(guiInfoDialog)
	{
		guiInfoDialog := Gui('+AlwaysOnTop -MinimizeBox')
		guiInfoDialog.TextW := guiInfoDialog.Add('Text', 'y20', 'Width')
		guiInfoDialog.EditW := guiInfoDialog.Add('Edit', 'r1 w40 x50 yp')
		guiInfoDialog.TextH := guiInfoDialog.Add('Text', 'xp+60 yp', 'Height')
		guiInfoDialog.EditH := guiInfoDialog.Add('Edit', 'r1 w40 xp+50 yp')
		(guiInfoDialog.CheckRatio := guiInfoDialog.Add('CheckBox', 'xp+60 yp-10', 'Lock Ratio')).OnEvent('Click', guiInfoDialog_CheckRatio)
		(guiInfoDialog.CheckWH := guiInfoDialog.Add('CheckBox', 'xp yp+20 Checked' DisplayWH, 'Display W x H')).OnEvent('Click', guiInfoDialog_CheckWH)
		(guiInfoDialog.ButtonApply := guiInfoDialog.Add('Button', 'Default xm yp+40 w80', 'Apply')).OnEvent('Click', guiInfoDialog_Click)
		(guiInfoDialog.ButtonOK := guiInfoDialog.Add('Button', 'yp xp+100 w80', 'Ok')).OnEvent('Click', guiInfoDialog_Click)
		(guiInfoDialog.ButtonCancel := guiInfoDialog.Add('Button', 'yp xp+100 w80', 'Cancel')).OnEvent('Click', guiInfoDialog_Click)
	}

	guiSSR.AdvanceSelectMode := false, guiSSR.AspectRatio := false
	ControlSetChecked(0, guiInfoDialog.CheckRatio)


	; Drag Selection
	CoordMode('Mouse', 'Screen')
	MouseGetPos(&sX, &sY)
	guiSSR.Show('x' sX ' y' sY ' w1 h1')
	Wprev := Hprev := 0
	Loop
	{
		MouseGetPos(&eX, &eY)
		W := Abs(sX - eX), H := Abs(sY - eY)
		X := Min(sX, eX), Y := Min(sY, eY)
		If A_Index < 50
			guiSSR.Background.Redraw()
		guiSSR.Move(X, Y, W, H)
		Display_WH(false)
		Sleep 10
	} Until !GetKeyState(Key, 'p')


	; Advanced Selection
	If GetKeyState("Shift")
	{
		guiSSR.AdvanceSelectMode := true, guiSSR_Active := true
		ControlFocus(A_ScriptHwnd)
		Loop
		{
			Display_WH()
			If GetKeyState('RButton', 'P')
				InfoWH_RButton
			If WinActive('A') = A_ScriptHwnd and !guiSSR_Active
			{
				guiSSR.InfoWH.Opt('Background' Color)
				guiSSR.InfoWH.Redraw()
				guiSSR_Active := true
			}
			Else If WinActive('A') != A_ScriptHwnd and guiSSR_Active
			{
				guiSSR.InfoWH.Opt('Background' Color_Inactive)
				guiSSR.InfoWH.Redraw()
				guiSSR_Active := false
			}
			Sleep 10
		} Until GetKeyState('Enter', 'P') and WinActive('A') = A_ScriptHwnd
	}

	guiSSR.GetPos(&X, &Y, &W, &H)
	guiSSR.Hide()
	Return { X: X, Y: Y, W: W, H: H, X2: X + W, Y2: Y + H }

	Display_WH(MarkAspectRatio := true)
	{
		If GetKeyState('Shift', 'P') or DisplayWH and (W > 60 and H > 35)
		{
			guiSSR.GetPos(&X, &Y, &W, &H)
			If W != Wprev or H != Hprev
			{
				FontSize := MinMax(Min(W // 25, H // 5), 8, 20)
				PosWHx := Max(1, (W - FontSize * 6) // 2), PosWHy := Max(1, (H - FontSize * 2) // 2)
				guiSSR.InfoWH.SetFont('s' FontSize)
				guiSSR.InfoWH.Text := (guiSSR.AspectRatio && MarkAspectRatio ? '[' W 'x' H ']' : W 'x' H)
				guiSSR.InfoWH.Move(PosWHx, PosWHy, FontSize ** 1.7 + 15, FontSize * 2)
				guiSSR.InfoWH.Visible := true
				Wprev := W, Hprev := H
			}
		}
		Else
		{
			guiSSR.InfoWH.Visible := false
			Wprev := Hprev := 0
			guiSSR.Background.Redraw
		}
	}

	InfoWH_RButton()
	{
		MouseGetPos(, , , &OutputVarControl, 2)
		If OutputVarControl = guiSSR.InfoWH.Hwnd
			guiInfoDialog.Show('AutoSize')
	}

	InfoWH_LButton()
	{
		MouseGetPos(, , , &OutputVarControl, 2)
		If OutputVarControl = guiSSR.InfoWH.Hwnd
			WinActivate('ahk_id' A_ScriptHwnd)
	}

	guiInfoDialog_Click(GuiCtrlObj, Info)
	{
		If GuiCtrlObj.Text = 'Apply'
		{
			If guiInfoDialog.EditW.Value and guiInfoDialog.EditH.Value
			{
				guiSSR.Move(X, Y, guiInfoDialog.EditW.Value, guiInfoDialog.EditH.Value)
				(guiInfoDialog.CheckRatio.Value && guiSSR.AspectRatio := guiInfoDialog.EditW.Value / guiInfoDialog.EditH.Value)
			}
			Else
				(!guiInfoDialog.EditW.Value ? guiInfoDialog.EditW.Focus() : guiInfoDialog.EditH.Focus())
			Return
		}
		If GuiCtrlObj.Text = 'Ok'
		{
			If guiInfoDialog.EditW.Value and guiInfoDialog.EditH.Value
			{
				guiSSR.Move(X, Y, guiInfoDialog.EditW.Value, guiInfoDialog.EditH.Value)
				(guiInfoDialog.CheckRatio.Value && guiSSR.AspectRatio := guiInfoDialog.EditW.Value / guiInfoDialog.EditH.Value)
			}
			Else
			{
				(!guiInfoDialog.EditW.Value ? guiInfoDialog.EditW.Focus() : guiInfoDialog.EditH.Focus())
				Return
			}
		}
		guiInfoDialog.Hide
	}

    MinMax(Num, MinNum, MaxNum) => Min(Max(Num, MinNum), MaxNum)


	guiInfoDialog_CheckWH(GuiCtrlObj, Info)
	{
		DisplayWH := GuiCtrlObj.Value
	}

	guiInfoDialog_CheckRatio(GuiCtrlObj, Info)
	{
		If GuiCtrlObj.Value
			guiSSR.AspectRatio := W / H, guiSSR.InfoWH.Text := '[' W 'x' H ']'
		Else
			guiSSR.AspectRatio := false, guiSSR.InfoWH.Text := W 'x' H
	}

	guiSSR_Size(guiSSR, WindowMinMax, Width, Height)
	{
		If guiSSR.AdvanceSelectMode
		{
			guiSSR.Background.Move(0, 0), guiSSR.Background.Redraw()
			Display_WH()
		}
	}

	;{ WM Event Functions - Selection
	WM_SIZING(wParam, lParam, msg, hwnd)
	{
		If guiSSR.AspectRatio
		{
			L := NumGet(lParam, 0, "Int"), T := NumGet(lParam, 4, "Int")
			r := NumGet(lParam, 8, "Int"), B := NumGet(lParam, 12, "Int")
			Switch wParam
			{
				Case 1, 2, 7, 8: NumPut('int', T + ((r - L) / guiSSR.AspectRatio), lParam, 12)	; L, R, BL, BR = adjust B
				Case 3, 6: NumPut('int', L + ((B - T) * guiSSR.AspectRatio), lParam, 8)			; T, B = adjust R
				Case 4, 5: NumPut('int', B - ((r - L) / guiSSR.AspectRatio), lParam, 4)			; T,TR = adjust T
			}
		}
	}

	WM_EXITSIZEMOVE(wParam, lParam, msg, hwnd)
	{
		If hwnd = guiSSR.Hwnd
		{
			ControlFocus(A_ScriptHwnd)
		}
	}

	WM_NCCALCSIZE(wParam, lParam, msg, hwnd)
	{
		If hwnd != guiSSR.Hwnd
			Return

		If guiSSR.AdvanceSelectMode
			Return 0x0300	; WVR_REDRAW
		Return 0
	}

	WM_NCHITTEST(wParam, lParam, msg, hwnd)
	{
		Static Border_Size := 10

		If hwnd != guiSSR.Hwnd or !guiSSR.AdvanceSelectMode
			Return

		X := lParam << 48 >> 48, Y := lParam << 32 >> 48
		WinGetPos(&gX, &gY, &gW, &gH)

		hit_Left := X < gX + Border_Size
		hit_Right := X >= gX + gW - Border_Size
		hit_Top := Y < gY + Border_Size
		hit_Bottom := Y >= gY + gH - Border_Size

		If hit_Top
		{
			If hit_Left
				Return 0xD
			Else If hit_Right
				Return 0xE
			Else
				Return 0xC
		}
		Else If hit_Bottom
		{
			If hit_Left
				Return 0x10
			Else If hit_Right
				Return 0x11
			Else
				Return 0xF
		}
		Else If hit_Left
			Return 0xA
		Else If hit_Right
			Return 0xB

		; else default hit-testing
	}
	;}
}
;}

