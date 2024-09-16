;******************************************************************************
; Want a clear path for learning AutoHotkey?                                  *
; Take a look at our AutoHotkey Udemy courses.                                *
; They're structured in a way to make learning AHK EASY                       *
; Right now you can  get a coupon code here: https://the-Automator.com/Learn  *
;******************************************************************************
#SingleInstance
#Requires Autohotkey v2.0-
;--
/**
 * ============================================================================ *
 * @Author   :                                                                  *
 * @Homepage :                                                                  *
 *                                                                              *
 * @Created  : February 11, 2023                                                *
 * @Modified : February 11, 2023                                                *
 * ============================================================================ *
 */

built_in_vars := Map(
	'A_AhkPath', A_AhkPath,
	'A_AhkVersion', A_AhkVersion,
	'A_AllowMainWindow', A_AllowMainWindow,
	'A_AppData', A_AppData,
	'A_AppDataCommon', A_AppDataCommon,
	'A_Args', A_Args,
	'A_Clipboard', A_Clipboard,
	'A_ComputerName', A_ComputerName,
	'A_ComSpec', A_ComSpec,
	'A_ControlDelay', A_ControlDelay,
	'A_CoordModeCaret', A_CoordModeCaret,
	'A_CoordModeMenu', A_CoordModeMenu,
	'A_CoordModeMouse', A_CoordModeMouse,
	'A_CoordModePixel', A_CoordModePixel,
	'A_CoordModeToolTip', A_CoordModeToolTip,
	'A_Cursor', A_Cursor,
	'A_DD', A_DD,
	'A_DDD', A_DDD,
	'A_DDDD', A_DDDD,
	'A_DefaultMouseSpeed', A_DefaultMouseSpeed,
	'A_Desktop', A_Desktop,
	'A_DesktopCommon', A_DesktopCommon,
	'A_DetectHiddenText', A_DetectHiddenText,
	'A_DetectHiddenWindows', A_DetectHiddenWindows,
	'A_EndChar', A_EndChar,
	'A_EventInfo', A_EventInfo,
	'A_FileEncoding', A_FileEncoding,
	'A_HotkeyInterval', A_HotkeyInterval,
	'A_HotkeyModifierTimeout', A_HotkeyModifierTimeout,
	'A_Hour', A_Hour,
	'A_IconFile', A_IconFile,
	'A_IconHidden', A_IconHidden,
	'A_IconNumber', A_IconNumber,
	'A_IconTip', A_IconTip,
	'A_Index', A_Index,
	'A_InitialWorkingDir', A_InitialWorkingDir,
	'A_Is64bitOS', A_Is64bitOS,
	'A_IsAdmin', A_IsAdmin,
	'A_IsCompiled', A_IsCompiled,
	'A_IsCritical', A_IsCritical,
	'A_IsPaused', A_IsPaused,
	'A_IsSuspended', A_IsSuspended,
	'A_KeyDelay', A_KeyDelay,
	'A_KeyDelayPlay', A_KeyDelayPlay,
	'A_KeyDuration', A_KeyDuration,
	'A_KeyDurationPlay', A_KeyDurationPlay,
	'A_Language', A_Language,
	'A_LastError', A_LastError,
	'A_LineFile', A_LineFile,
	'A_LineNumber', A_LineNumber,
	'A_ListLines', A_ListLines,
	'A_LoopField', A_LoopField,
	'A_LoopFileName', A_LoopFileName,
	'A_LoopReadLine', A_LoopReadLine,
	'A_LoopRegName', A_LoopRegName,
	'A_MaxHotkeysPerInterval', A_MaxHotkeysPerInterval,
	'A_MenuMaskKey', A_MenuMaskKey,
	'A_Min', A_Min,
	'A_MM', A_MM,
	'A_MMM', A_MMM,
	'A_MMMM', A_MMMM,
	'A_MouseDelay', A_MouseDelay,
	'A_MouseDelayPlay', A_MouseDelayPlay,
	'A_MSec', A_MSec,
	'A_MyDocuments', A_MyDocuments,
	'A_Now', A_Now,
	'A_NowUTC', A_NowUTC,
	'A_OSVersion', A_OSVersion,
	'A_PriorHotkey', A_PriorHotkey,
	'A_PriorKey', A_PriorKey,
	'A_ProgramFiles', A_ProgramFiles,
	'A_Programs', A_Programs,
	'A_ProgramsCommon', A_ProgramsCommon,
	'A_PtrSize', A_PtrSize,
	'A_RegView', A_RegView,
	'A_ScreenDPI', A_ScreenDPI,
	'A_ScreenHeight', A_ScreenHeight,
	'A_ScreenWidth', A_ScreenWidth,
	'A_ScriptDir', A_ScriptDir,
	'A_ScriptFullPath', A_ScriptFullPath,
	'A_ScriptHwnd', A_ScriptHwnd,
	'A_ScriptName', A_ScriptName,
	'A_Sec', A_Sec,
	'A_SendLevel', A_SendLevel,
	'A_SendMode', A_SendMode,
	'A_Space', A_Space,
	'A_StartMenu', A_StartMenu,
	'A_StartMenuCommon', A_StartMenuCommon,
	'A_Startup', A_Startup,
	'A_StartupCommon', A_StartupCommon,
	'A_StoreCapsLockMode', A_StoreCapsLockMode,
	'A_Tab', A_Tab,
	'A_Temp', A_Temp,
	'A_ThisFunc', A_ThisFunc,
	'A_ThisHotkey', A_ThisHotkey,
	'A_TickCount', A_TickCount,
	'A_TimeIdle', A_TimeIdle,
	'A_TimeIdleKeyboard', A_TimeIdleKeyboard,
	'A_TimeIdleMouse', A_TimeIdleMouse,
	'A_TimeIdlePhysical', A_TimeIdlePhysical,
	'A_TimeSincePriorHotkey', A_TimeSincePriorHotkey,
	'A_TimeSinceThisHotkey', A_TimeSinceThisHotkey,
	'A_TitleMatchMode', A_TitleMatchMode,
	'A_TitleMatchModeSpeed', A_TitleMatchModeSpeed,
	'A_TrayMenu', A_TrayMenu,
	'A_UserName', A_UserName,
	'A_WDay', A_WDay,
	'A_WinDelay', A_WinDelay,
	'A_WinDir', A_WinDir,
	'A_WorkingDir', A_WorkingDir,
	'A_YDay', A_YDay,
	'A_YWeek', A_YWeek,
	'A_YYYY', A_YYYY,
	'A_LoopFileExt', A_LoopFileExt,
	'A_LoopFilePath', A_LoopFilePath,
	'A_LoopFileFullPath', A_LoopFileFullPath,
	'A_LoopFileShortPath', A_LoopFileShortPath,
	'A_LoopFileShortName', A_LoopFileShortName,
	'A_LoopFileDir', A_LoopFileDir,
	'A_LoopFileTimeModified', A_LoopFileTimeModified,
	'A_LoopFileTimeCreated', A_LoopFileTimeCreated,
	'A_LoopFileTimeAccessed', A_LoopFileTimeAccessed,
	'A_LoopFileAttrib', A_LoopFileAttrib,
	'A_LoopFileSize', A_LoopFileSize,
	'A_LoopFileSizeKB', A_LoopFileSizeKB,
	'A_LoopFileSizeMB', A_LoopFileSizeMB,
	'A_LoopRegType', A_LoopRegType,
	'A_LoopRegKey', A_LoopRegKey,
	'A_LoopRegTimeModified', A_LoopRegTimeModified,
	'FALSE', FALSE,
	'TRUE', TRUE
)

main := Gui('+ToolWindow +AlwaysOnTop', 'Built in Variable Viewer')
main.BackColor := 'White'

main.AddEdit('vSearch w300').OnEvent('Change', (*)=>Filter(main['Search'].Value))

lv := main.AddListView('w700 r20', ['Variable Name', 'Current Value'])

lv.Opt('-Redraw')
for name, val in built_in_vars
	lv.Add('', name, val != '' ? val : '...')
lv.Opt('+Redraw')

loop lv.GetCount('Col')
	lv.ModifyCol(A_Index, 'AutoHDR')

main.Show()
return

Filter(query:='')
{
	lv.Opt('-Redraw')
	lv.Delete()
	for name, val in built_in_vars
		if name ~= 'i)\Q' query '\E'
		|| (type(val) ~= 'i)Object|Array|Map|Menu' = 0 && val ~= 'i)\Q' query '\E')
			lv.Add('', name, val != '' ? val : '...')
	lv.Opt('+Redraw')
}

Esc::Filter()