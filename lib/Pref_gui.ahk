#Requires AutoHotkey v2.0
ini := A_ScriptDir "\Checklist.ini"
pGui := Gui(,'Preferences')
pGui.backcolor := 0xffb7ffe3
pGui.OnEvent('Close',(*)=>(pGui.Hide(),tGui.Show()))
pGui.SetFont("s12")
sel := IniRead(ini,"Selected","templet","Default")
List := MultiLine(IniRead(ini,"Templates",sel,"Task 1¶Task 2¶Task 3"))
AllTemplates := []
try templestList := IniRead(ini,"Templates")
if !IsSet(templestList)
{
	IniWrite("Task 1¶Task 2¶Task 3",ini,"Templates","Default")
	IniWrite("Task A¶Task B¶Task C",ini,"Templates","Example")
	templestList := IniRead(ini,"Templates")
}

for k, v in StrSplit(templestList,'`n')
{
	RegExMatch(v,'(.*)=(.*)',&t)
	AllTemplates.Push(t[1])
}

pGui.AddText("xm w80",'Templates:')
pGui.AddComboBox('x+m yp-3 vTmp',AllTemplates).OnEvent('change',ChangeList)
pGui['tmp'].text := sel
pGui.AddButton('x+m h29 disabled vAdd' ,'Add').OnEvent('click',AddTemplate)
pGui.AddButton('x+m h29 vDel','Remove').OnEvent('click',DelTemplate)
pGui.AddText("xm",'Modify Check list')
pGui.AddEdit("xm +multi w500 h500 vList",List).OnEvent('change',ChangeList)
; pGui.SetFont('cgreen')
pGui.AddGroupBox('xm w300 h80 cred','Show/Hide')
pGui.AddHotkey("xp+20 yp+30 vHK section",)
pGui.AddCheckBox( "x+m vWK yp+3", "Win") ;.onEvent('click',eventhandler)
startcheck := IniRead(ini,'Settings','Show',1) ? '+Checked' : '-Checked'
startctrl := pGui.AddCheckbox('x+m+40 yp-20 vShow section ' startcheck, 'Display on Startup')
startctrl.OnEvent('click',(*)=>IniWrite(pGui['Show'].value,ini,'Settings','Show'))

startupcheck := IniRead(ini,'Settings','StartupRun',1) ? '+Checked' : '-Checked'
startupctrl := pGui.AddCheckbox('xs ' startupcheck, 'Add to Windows Startup')



WK := pGui['WK'].value := IniRead(ini,'Hotkeys','WK',0)
pGui['HK'].value := HK :=  IniRead(ini,'Hotkeys','HK','^NumpadMult')
if WK
	HK := '#' HK
Hotkey(pGui.oldHK := HK,Showhide,'on')
; pGui.SetFont('cBlack')
pGui.AddButton('xm+' 360 ' vApply','Apply').OnEvent('click',ApplySettings)
pGui.AddButton('x+m','Cancel').OnEvent('click',(*)=>(pGui.Hide(),sleep( 100),tGui.Show()))
; pGui.Show()

AddTemplate(*)
{
	List := pGui['List'].value := Trim(RegExReplace(pGui['List'].value, '(^|\R)\K\s+'),'`n')
	if !pGui['List'].value
		return
	
	tmp := pGui['Tmp'].Text
	if !tmp
		return

	for k, v in AllTemplates
		if v = tmp
			return
	IniWrite(SingleLine(List),ini,"Templates",tmp)
	AllTemplates.push(tmp)
	pGui['Tmp'].Delete()
	MainSel.Delete()
	pGui['Tmp'].Add(AllTemplates)
	MainSel.Add(AllTemplates)
	pGui['Tmp'].text := tmp
	MainSel.text := tmp
	pGui['add'].opt('+Disabled')
	pGui['apply'].opt('-Disabled')
	pGui['Del'].opt('-Disabled')
}

DelTemplate(*)
{
	global sel
	tmp := pGui['Tmp'].Text
	if !tmp 
	|| tmp = 'Default'
		return
	IniDelete(ini,"Templates",tmp)
	for k, v in AllTemplates
	{
		if v = tmp
		{
			AllTemplates.RemoveAt(k)
			if v = sel
				sel := 0
		}
	}
	
	pGui['Tmp'].Delete()
	pGui['Tmp'].Add(AllTemplates)

	MainSel.Delete()
	MainSel.Add(AllTemplates)
	MainSel.choose(0)

	if sel
		ControlChooseString(sel,pGui['Tmp'],pgui) ;pGui['Tmp'].text := sel
	else
		ControlChooseIndex(AllTemplates.length, pGui['Tmp'],pgui) ;pGui['Tmp'].value := AllTemplates.length
}

ChangeList(ctrl,*)
{
	static defaultList := "Task 1¶Task 2¶Task 3"
	tmp := pGui['Tmp'].Text
	if !tmp
		return
	list := IniRead(ini,"Templates",tmp,0)
	switch ctrl.name
	{
		case 'Tmp':
			pGui['add'].opt('+Disabled')
			pGui['Del'].opt('-Disabled')
			if list
				pGui['List'].value := MultiLine(list)
			else
			{

				pGui['List'].value := ''
				pGui['apply'].opt('+Disabled')
				pGui['Del'].opt('+Disabled')
				
			}
		case 'List':
			if pGui['List'].value
			&& !list
				pGui['add'].opt('-Disabled')
			else
			{
				pGui['add'].opt('+Disabled')
			}
	}
}

ApplySettings(*)
{
	; if pGui['add'].Enabled
	; 	AddTemplate()
	List := pGui['List'].value := Trim(RegExReplace(pGui['List'].value, '(^|\R)\K\s+'),'`n')
	tmp := pGui['Tmp'].Text
	if !tmp
		return
	IniWrite(tmp,ini,"Selected","templet")
	tGui.Hide()
	list := SingleLine(pGui['List'].value)
	IniWrite(list,ini,"Templates",tmp)
	Hotkey(pGui.oldHK,Showhide,'off')

	WK := pGui['WK'].value
	HK := pGui['HK'].value
	IniWrite(WK,ini,'Hotkeys','WK')
	IniWrite(HK,ini,'Hotkeys','HK')
	if WK
		HK := '#' HK

	try MainSel.Text := tmp
	catch
		MainSel.choose(0)

	IniWrite(startupctrl.value,ini,'Settings','StartupRun')
	script.Autostart(startupctrl.value)

	tray.Rename('Show Check List`t' HKToString(pGui.oldHK),'Show Check List`t' HKToString(HK))
	Hotkey(pGui.oldHK := HK,Showhide,'on')
	BuildLV()	
	pGui.Hide()
	tGui.Title := 'Checklist: ' tmp
	tGui.Show()
}

; SingleLine2(str) => StrReplace(StrReplace(str,'`n','¶'),'`r')
SingleLine(str) 
{
	newstr := ''
	for i, line in removeDuplicates(StrSplit(str,'`n','`r'))
		newstr.= line '`n'

	str := Trim(newstr,'`n')
	return StrReplace(StrReplace(str,'`n','¶'),'`r')
}

MultiLine(str)  => StrReplace(str,'¶','`n')

; GetList2(str) => StrSplit(MultiLine(str), "`n", "`r")
GetList(str)
{
	str := StrSplit(MultiLine(str), "`n", "`r")
	return removeDuplicates(str)
}


removeDuplicates(inputList) {
	existingValues := map()
	outputList := []
	for each, value in inputList {
		if (existingValues.has(value))
			continue
		existingValues[value] := 0
		outputList.Push(value)
	}
	return outputList
}

Showhide(*) => tGui.Show()

HKToString(hk)
{
	if !hk
		return

	temphk := []

	if InStr(hk, '#')
		temphk.Push('Win+')
	if InStr(hk, '^')
		temphk.Push('Ctrl+')
	if InStr(hk, '+')
		temphk.Push('Shift+')
	if InStr(hk, '!')
		temphk.Push('Alt+')
	
	hk := RegExReplace(hk, '[#^+!]')
	for mod in temphk
		fixedMods .= mod
	return (fixedMods ?? '') StrUpper(hk)
}
