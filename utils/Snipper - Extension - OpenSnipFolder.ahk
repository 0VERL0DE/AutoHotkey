/* ;--------------------------------------------------------------------------------------------------------------------
[Extension] Open Snip Images Folder (by Speedmaster)
File Name : Snipper - Extension - OpenSnipFolder.ahk
Version : 2023 05 02

Usage : Use the context menu to browse the snip image folder

*/ ;---------------------------------------------------------------------------------------------------------------------

; CONTEXT MENU -------------------------------------------------------
Extensions.Push({ SM: { Text: 'OPEN:  Snipper - Images Folder', Func: OpenSnipFolder } })

OpenSnipFolder(borders := false)
{
	try run "explore " Settings_SavePath_Image
}

