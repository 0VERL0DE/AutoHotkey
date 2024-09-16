#SingleInstance
#Requires Autohotkey v2.0-
/**
 * ============================================================================ *
 * Want a clear path for learning AutoHotkey?                                   *
 * Take a look at our AutoHotkey Udemy courses.                                 *
 * They're structured in a way to make learning AHK EASY                        *
 * Right now you can  get a coupon code here: https://the-Automator.com/Learn   *
 * ============================================================================ *
 */
Explorer_GetSelection(hwnd:='')
{
	selFiles := []
	process := WinGetProcessName('ahk_id' hwnd := hwnd? hwnd:WinExist('A'))
	class := WinGetClass('ahk_id' hwnd)
	if (process != 'explorer.exe')
		return (ToolTip('Nothing was Selected'), SetTimer((*)=>Tooltip, 2500), selFiles)

	if (class ~= 'i)Progman|WorkerW')
	{
		files:=ListViewGetContent('Selected Col1', 'SysListView321', 'ahk_class' class)
		Loop Parse, files, '`n', '`r'
			selFiles.Push(A_Desktop '\' A_LoopField)
	}
	else if (class ~= '(Cabinet|Explore)WClass')
	{
		for window in ComObject('Shell.Application').Windows
		{
			if (window.hwnd!=hwnd)
				continue
			
			for item in window.Document.SelectedItems
				selFiles.Push(item.path)
			break
		}
	}

	return selFiles
}