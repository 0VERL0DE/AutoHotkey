#SingleInstance
#Requires AutoHotkey v2.0+ ; prefer 64-Bit
;RunWait "S:\AHK Studio Backup Remover\src\StudioBackup Remover2.ahk" ;Remove Studio backups
query := '*.ahk'
drive := 'b:'
last_modified := DateAdd(A_Now, -6, 'Days')

main := gui()
main.SetFont('s12')
lv := main.AddListView('w800 r20', ['File Name', 'Location', 'Size'])
lv.OnEvent('DoubleClick', (*)=>Run(ListViewGetContent('Col2 Selected', lv)))
pg := main.AddProgress('w800 r1')

sb := main.AddStatusBar()
sb.SetText(' Finding recently modified files...')
main.Show()

lv.Opt('-Redraw')
fCount := 0
loop files, drive '\' query, 'FDR'
{
	
	modified_time := FileGetTime(A_LoopFileFullPath, 'M')
	
	if last_modified > modified_time
		continue
	
	if Instr(A_LoopFileFullPath,"AHK-Studio Backup") ;skip AHK Studio backup files
		Continue
	
	fCount++
}

sb.SetText(' ' fCount ' files found')
pg.Opt('Range1-' fCount)
loop files, drive '\' query, 'FDR'
{
	
	modified_time := FileGetTime(A_LoopFileFullPath, 'M')
	
	if last_modified > modified_time
		continue
	
	if Instr(A_LoopFileFullPath,"AHK-Studio Backup") ;Skip AHK studio backup files
		Continue
		
	pg.Value += 1
	file_size := FileGetSize(A_LoopFileFullPath, 'KB')
	SplitPath A_LoopFileFullPath, &fName, &fDir
	
	lv.Add('', fName, fDir, file_size ' KB')
}

loop lv.GetCount('col')
	lv.ModifyCol(A_Index, 'AutoHdr')

lv.ModifyCol(2, 200 ' Sort')
lv.Opt('+Redraw')
sb.SetText(' ' lv.GetCount() ' files found')
return