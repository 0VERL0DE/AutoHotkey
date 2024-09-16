#Requires AutoHotkey v1.0
#singleinstance, force
#NoEnv
SetBatchLines, -1
Preview := new ImagePreview( 500   ; max width
                           , 300   ; max height
                           , 0   ; delay before show preview
                           , 220   ; preview transparency (0 - 255)
                           ,  15   ; x-offset from cursor
                           , -15 ) ; y-offset from cursor
Return

class ImagePreview
{
   static set := false
   
   __New(maxW, maxH, delayShowPreview, transparent, x_offsetFromCursor, y_offsetFromCursor) {
      if ImagePreview.set
         Return ""
      
      ImagePreview.set := true
      settings := { hGui: this.hGui := this.CreateGui(transparent)
                  , maxW: maxW
                  , maxH: maxH
                  , delay: delayShowPreview
                  , x_offset: x_offsetFromCursor
                  , y_offset: y_offsetFromCursor }
                  
      this.OnMouse := new this.MouseWatcher(settings)
      this.MouseHook := new this.WindowsHook(WH_MOUSE_LL := 14, this.OnMouse.MouseProc)
      
      VarSetCapacity(POINT, 8, 0)
      DllCall("GetCursorPos", "Int64", &POINT)
      this.OnMouse.LowLevelMouseProc(0, 0x0200, &POINT)
   }
   
   __Delete() {
      this.MouseHook := ""
      try Gui, % this.hGui . ": Destroy"
      ImagePreview.set := false
   }
   
   CreateGui(transparent) {
      static exStyles := (WS_EX_TRANSPARENT := 0x00000020) | (WS_EX_NOACTIVATE := 0x08000000)
      Gui, New, +hwndhGui -Caption +Border +LastFound +AlwaysOnTop +E%exStyles% -DpiScale
      WinSet, Transparent, % transparent
      Gui, Color, White
      Gui, Margin, 0, 0
      Return hGui
   }
   
   class MouseWatcher
   {
      __New(settings) {
         this.settings := settings
         this.MouseProc := ObjBindMethod(this, "LowLevelMouseProc")
         this.SetCapacity("Point", 8)
         this.pPoint := this.GetAddress("Point")
         DllCall("RtlZeroMemory", "Ptr", this.pPoint)
         this.mouseTimer := ObjBindMethod(this, "WatchMouse")
         this.delayTimer := ObjBindMethod(this, "ShowPreview")
      }
      
      LowLevelMouseProc(nCode, wParam, lParam) {
         static WM_MOUSEMOVE := 0x200
         if (wParam = WM_MOUSEMOVE) {
            DllCall("RtlMoveMemory", "Ptr", this.pPoint, "Ptr", lParam, "Ptr", 8)
            timer := this.mouseTimer
            SetTimer, % timer, -10
         }
         Return DllCall("CallNextHookEx", "Ptr", 0, "Int", nCode, "Ptr", wParam, "Ptr", lParam)
      }
      
      WatchMouse() {
         static GA_ROOT := 2, prevImagePath := "", imagePattern := "i)\.(ico|png|jpe?g|bmp|gif|tiff?|tga)$"
         POINT := NumGet(this.pPoint, "Int64")
         hWnd := DllCall("WindowFromPoint", "Int64", POINT, "Ptr")
         hWnd := DllCall("GetAncestor", "Ptr", hWnd, "UInt", GA_ROOT, "Ptr")
         try folderPath := this.GetFolderPathFromHwnd(hWnd)
         timer := this.delayTimer
         o := this.settings
         if !folderPath {
            prevImagePath := ""
            Gui, % o.hGui . ": Hide"
            SetTimer, % timer, Off
            Return
         }
         try fileName := this.GetFileNameUnderCursor(POINT)
         this.imagePath := folderPath . "\" . fileName
         if !(fileName ~= imagePattern && FileExist(this.imagePath)) {
            prevImagePath := ""
            Gui, % o.hGui . ": Hide"
            SetTimer, % timer, Off
            Return
         }
         if (this.imagePath != prevImagePath) {
            prevImagePath := this.imagePath
            Gui, % o.hGui . ": Hide"
            SetTimer, % timer, % "-" . o.delay
         }
      }
      
      ShowPreview() {
         static hPic := 0
         ( hPic && DllCall("DestroyWindow", "Ptr", hPic) )
         imageSize := this.GetImageSize(this.imagePath)
         RegExMatch(imageSize, "(\d+)\D+(\d+)", m)
         w := m1, h := m2
         o := this.settings
         if (w > o.maxW) {
            prevW := w
            w := o.maxW
            h := w * h / prevW
         }
         if (h > o.maxH) {
            prevH := h
            h := o.maxH
            w := h * w / prevH
         }
         Gui, % o.hGui . ": Add", Pic, x0 y0 w%w% h%h% hwndhPic, % this.imagePath
         x := NumGet(this.pPoint + 0, "Int")     + o.x_offset
         y := NumGet(this.pPoint + 4, "Int") - h + o.y_offset
         (x < 0 && x := 0), (y < 0 && y := 0)
         (x + w > A_ScreenWidth  && x := A_ScreenWidth  - w)
         (y + h > A_ScreenHeight && y := A_ScreenHeight - h)
         Gui, % o.hGui . ": Show", NA x%x% y%y% w%w% h%h%
      }
      
      GetFolderPathFromHwnd(hWnd) {
         WinGetClass, winClass, ahk_id %hWnd%
         if !(winClass ~= "^(Progman|WorkerW|(Cabinet|Explore)WClass)$")
            Return ""
         
         shellWindows := ComObjCreate("Shell.Application").Windows
         if (winClass ~= "Progman|WorkerW")
            shellFolderView := shellWindows.Item( ComObject(VT_UI4 := 0x13, SWC_DESKTOP := 0x8) ).Document
         else {
            for window in shellWindows
               if (hWnd = window.HWND) && (shellFolderView := window.Document)
                  break
         }
         Return shellFolderView.Folder.Self.Path
      }
      
      GetFileNameUnderCursor(POINT) {
         AccObj := this.AccObjectFromPoint(POINT, childId)
         if !value := AccObj.accValue(childId)
            value := AccObj.accName(childId)
         Return value
      }
      
      AccObjectFromPoint(pt, ByRef childId) {
         static VT_DISPATCH := 9, F_OWNVALUE := 1, hLib := DllCall("LoadLibrary", "Str", "oleacc", "Ptr")
         AccObject := 0, VarSetCapacity(varChild, 8 + A_PtrSize*2, 0)
         if DllCall("oleacc\AccessibleObjectFromPoint", "Int64", pt, "PtrP", pAcc, "Ptr", &varChild) = 0
            childId := NumGet(varChild, 8, "UInt"), AccObject := ComObject(VT_DISPATCH, pAcc, F_OWNVALUE)
         Return AccObject
      }
      
      GetImageSize(imagePath) {
         SplitPath, imagePath, name, dir
         Folder := ComObjCreate("Shell.Application").NameSpace(dir)
         FolderItem := Folder.ParseName(name)
         Return Folder.GetDetailsOf(FolderItem, 31)
      }
   }
   
   class WindowsHook {
      __New(type, CallBack, isGlobal := true) {
         this.Clbk := new this.BoundFuncCallback(CallBack, 3, "Fast")
         this.hHook := DllCall("SetWindowsHookEx", "Int", type, "Ptr", this.Clbk.addr
                                                 , "Ptr", !isGlobal ? 0 : DllCall("GetModuleHandle", "UInt", 0, "Ptr")
                                                 , "UInt", isGlobal ? 0 : DllCall("GetCurrentThreadId"), "Ptr")
      }
      __Delete() {
         this.Delete("Clbk")
         DllCall("UnhookWindowsHookEx", "Ptr", this.hHook)
      }
      
      class BoundFuncCallback
      {
         __New(BoundFuncObj, paramCount, options := "") {
            this.pInfo := Object( {BoundObj: BoundFuncObj, paramCount: paramCount} )
            this.addr := RegisterCallback(this.__Class . "._Callback", options, paramCount, this.pInfo)
         }
         __Delete() {
            ObjRelease(this.pInfo)
            DllCall("GlobalFree", "Ptr", this.addr, "Ptr")
         }
         _Callback(Params*) {
            Info := Object(A_EventInfo), Args := []
            Loop % Info.paramCount
               Args.Push( NumGet(Params + A_PtrSize*(A_Index - 2)) )
            Return Info.BoundObj.Call(Args*)
         }
      }
   }
}