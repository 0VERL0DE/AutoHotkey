#requires Autohotkey v2

/*

FilePath := "R:\YEU-2021-1502\6_OUTPUT\course_3161\folders.json"
Props := GetFullDetails(FilePath)
;Props := FSO_GetSpecificProperty(FilePath,"System.FileOwner")
TestGui := Gui()
ListView := TestGui.AddListView("w600 r20", ["PropName","PropValue"])

For Each, Prop In Props
   ListView.Add("", Prop.N, Prop.V)

Listview.Add("","Encoding",GetEncoding(FilePath))
Listview.Add("","Magic Bytes",GetSignature(FilePath))
Listview.ModifyCol()
TestGui.Show()
Return
GuiClose:
ExitApp

*/

/* 

; LOOP FILES: files only, recursive
Loop Files, %inputVar%\*, R  ; recursive, files, no dirs
  Type := "File"


; LOOP FOLDERS: folders only, recursive
Loop Files, %inputVar%\*, RD  
  Type := "Folder"


; EVERYTHING: files and folders, recursive
Loop Files, %inputVar%\*, RD  
  type := (ifinstring, a_loopFileAttrib, D) ? "Folder" : "File"





; REGEX test
Type := (RegExMatch(inputVar, "(?<=\\|^)[^\\\/]+\.[^\\\/]+(?=\\?$)")) ? "File" : "Dir" 
Type := (RegExMatch(inputVar, "(?<=\\|^)[^\\\/\.]+(?=\\?$)")) ? "Dir" : "File" 

*/


; ATTRIBUTES
; ----------------------------------

	;set attributes of all files in array
	FSO_SetAttributes(arrFiles:="",ishidden:="",issystem:="",isreadonly:=""){
		/*
		R = READONLY
		A = ARCHIVE
		S = SYSTEM
		H = HIDDEN
		N = NORMAL (this is valid only when used without any other attributes)
		O = OFFLINE
		T = TEMPORARY
		*/
			hidden := ishidden ? "+H" : "-H"
			System := issystem ? "+S" : "-S"
			ReadOnly := isreadonly ? "+R" : "-R"
		
		For file in FSO_GetValidPaths(arrFiles)
		{
			FileSetAttrib(hidden System ReadOnly , GetEncoding(file))
		}
		Sleep 100
	;; refresh
	}

; VALID
; ----------------------------------

; Filter out valid paths
; Files AND folders
; IN		ARRAY	-> return array with all valid paths
;			STRING	-> check if string contains valid path and return in array
; OUT		ARRAY
FSO_GetValidPaths(rawInput){
	arrPaths := Array()
	; input is string
  
  If Type(rawInput) = "String" {
	  ; If the path exists → turn into single entry array
	  If FileExist(rawInput){
		arrPaths.Push(rawInput)
	  }
  
	; input is array
	}Else{
	  For rawpath in rawInput{
      If FileExist(rawpath){
        arrPaths.Push(rawPath)
      }
	  }
	}  
  Return arrPaths
}

; return only valid paths to FOLDERS
FSO_GetFolderPaths(rawinput){
	arrPaths := []
		
	; input is string
  If Type(rawInput) = "String" {
	  ; If the path exists → turn into single entry array
	  If InStr(FileExist(rawInput), "D"){
		arrPaths[1] := rawInput  
	  }
  
	; input is array
	}Else{
	  For rawpath in rawInput{
		If InStr(FileExist(rawInput[rawPath]), "D"){
		  arrPaths.Push(rawInput[rawPath])
		}
	  }
	}  
  Return arrPaths
}
  
; return only valid paths to FILES
FSO_GetFilePaths(rawInput){
	arrPaths := []
		
	; input is string
  If Type(rawInput) = "String" {
		; If the path exists → turn into single entry array
		If FileExist(rawInput) And Not InStr(FileExist(rawinput), "D"){
		arrPaths[1] := rawInput  
		}

	; input is array
	}Else{
		For rawpath in rawInput{
		If FileExist(rawInput[rawPath])  And Not InStr(FileExist(rawInput), "D"){
			arrPaths.Push(rawInput[rawPath])
		}
		}
	}  
	Return arrPaths
}
   
; EMPTY
; ----------------------------------
; return empty DIRS and FILES (ignores RASHNDOCT)
FSO_GetEmptyObjects(arrPaths){
	arrEmptyObjects := []

	For index in FSO_GetEmptyFiles(arrPaths)
		arrEmptyObjects.Push(FSO_GetEmptyFiles(arrPaths)[index])
	For index in FSO_GetEmptyDirs(arrPaths)
		arrEmptyObjects.Push(FSO_GetEmptyDirs(arrPaths)[index])

return arrEmptyObjects
}
  
; Get array of empty FILES  (ignores RASHNDOCT)
FSO_GetEmptyFiles(folderpath:=""){
		arrEmptyFiles := []
		objFSO := ComObject("Scripting.FileSystemObject")
		objFSO.Error := false                   ;disable COM error messages
		Loop Files, folderpath "\*.*", "R"
		{
			; actually empty file
			if (objFSO.GetFile(A_LoopFilePath).Size = 0){
				arrEmptyFiles.Push(A_LoopFilePath)
			}
			else
			; allow some room for magic bytes
			if (objFSO.GetFile(A_LoopFilePath).Size < 10){
				arrEmptyFiles.Push(A_LoopFilePath)
			}
		}
return arrEmptyFiles
}
  
; Get array of empty DIRS (ignores RASHNDOCT)
FSO_GetEmptyDirs(folderpath:=""){
		arrEmptyDirs := []
		objFSO := ComObject("Scripting.FileSystemObject")
		objFSO.Error := false                  ;disable COM error messages
		Loop Files, folderpath "\*.*", "DR"
			if (objFSO.GetFolder(A_LoopFilePath).Size = 0)
				arrEmptyDirs.Push(A_LoopFilePath)
return arrEmptyDirs
}
  
; Delete all empty DIRS and FILES (ignores RASHNDOCT)
FSO_DeleteEmptyObjects(arrPaths){
	arrEmptyObjects := []

	For index in FSO_DeleteEmptyFiles(arrPaths)
		arrEmptyObjects.Push(FSO_DeleteEmptyFiles(arrPaths)[index])
	For index in FSO_DeleteEmptyDirs(arrPaths)
		arrEmptyObjects.Push(FSO_DeleteEmptyDirs(arrPaths)[index])

return arrEmptyObjects
}

; Delete array of empty FILES  (ignores RASHNDOCT)
FSO_DeleteEmptyFiles(folderpath:=""){
		arrEmptyFiles := []
		objFSO := ComObject("Scripting.FileSystemObject")
		objFSO.Error := false                      ;disable COM error messages
		Loop Files, folderpath "\*.*", "R"
			if (objFSO.GetFile(A_LoopFilePath).Size = 0){
				arrEmptyFiles.Push(A_LoopFilePath)
				FileDelete(A_LoopFilePath)
			} 
			else 
			if (objFSO.GetFile(A_LoopFilePath).Size < 10){
				arrEmptyFiles.Push(A_LoopFilePath)
				FileDelete(A_LoopFilePath)
			}
return arrEmptyFiles
}

; Delete array of empty DIRS (ignores RASHNDOCT)
FSO_DeleteEmptyDirs(folderpath:=""){
		arrEmptyDirs := []
		objFSO := ComObject("Scripting.FileSystemObject")
		objFSO.Error := false               ;disable COM error messages
		Loop Files, folderpath "\*.*", "DR"
			if (objFSO.GetFolder(A_LoopFilePath).Size = 0){
				arrEmptyDirs.Push(A_LoopFilePath)
				DirDelete(A_LoopFilePath)
			}
return arrEmptyDirs
}



;----


GetFullDetails(FilePath) {
   ; The properties in 'Exclude' caused problems during my tests
   Static Exclude := Map("System.SharedWith", 1)
   SplitPath(FilePath, &FileName , &FileDir)
   If (FileDir = "")
      FileDir := A_WorkingDir
   Props := {}
   If (SFI := ComObject("Shell.Application").NameSpace(FileDir).ParseName(FileName)) {
      PropList := SFI.ExtendedProperty("System.PropList.FullDetails")
      If (SubStr(PropList, 1, 5) = "prop:") {
         Props := Map()
         PropCount := 0
         For Each, PropName In StrSplit(SubStr(PropList, 6), ";", "*") {
            If Exclude.Has(PropName)
               Continue
            If InStr(PropName, ".PropGroup.") {
               PropName := ">>>>> " . StrSplit(PropName, ".")[3] . " <<<<<"
               Props[++PropCount] := {N: PropName, V: ""}
               Continue
            }
            PropVal := SFI.ExtendedProperty(PropName)
            If IsObject(PropVal) {
               If (ComObjType(PropVal) & 0x2000) { ; VT_ARRAY
                  Values := ""
                  For Value In PropVal
                     Values .= Value . ", "
                  Props[++PropCount] := {N: PropName, V: RTrim(Values, ", ")}
               }
            }
            Else If (PropVal != "") {
               Props[++PropCount] := {N: PropName, V: PropVal}
            }
         }
      }
   }
   Return Props
}

; get value of specific property
; e.g. System.FileOwner
FSO_GetSpecificProperty(FilePath, PropertyName){

     SplitPath(FilePath, &FileName , &FileDir)
     If (FileDir = "")
        FileDir := A_WorkingDir
     If (SFI := ComObject("Shell.Application").NameSpace(FileDir).ParseName(FileName)) {
        PropVal := SFI.ExtendedProperty(PropertyName)

        PropVal := RegExReplace(PropVal,"YCOMMLOC\\?")

        return PropVal
     }
}

;---



; Add properties to array of paths
FSO_GetAllProps(arrPaths){
  FSObj := map()

  ; Loop over all paths in array
  For File in arrPaths {

      ; single file/dir loop to enable usage of A_LoopFile...
      Loop Files File, "DF"
      {
          ; Create sub-array
          SplitPath(A_LoopFilePath, &NameExt, &Dir, &Ext, &Name, &Drv)
          
          FSObj[File] := Map()
          ; NOTE: instead of index, a string can also be used as name of the object

          ; Fill sub-array with key-value pairs
          FSObj[File].Name := NameExt
          FSObj[File].NameNoExt := Name
          FSObj[File].Dir := Dir
          FSObj[File].Drv := Drv
          FSObj[File].Ext := Ext
          FSObj[File].Attr := A_LoopFileAttrib
          FSObj[File].Path := A_LoopFilePath
          FSObj[File].Owner := FSO_GetSpecificProperty(A_LoopFileFullPath,"System.FileOwner")

          If RegExMatch(Ext,"png|jpg|gif") {
            FSObj[File].Encoding := "Binary (" Ext ")"
          }Else{
            FSObj[File].Encoding := GetEncoding(File)
          }

          ; file is actually a folder
          If A_LoopFileSize = 0 {
            FolderSize := 0
            Loop Files, File "\*.*", "R" {
                FolderSize += A_LoopFileSize
            }
            FSObj[File].Size := FolderSize
            ; file is a file
          }Else{
            FSObj[File].Size := A_LoopFileSize
          }
          FSObj[File].TimeC := A_LoopFileTimeCreated
          FSObj[File].TimeA := A_LoopFileTimeAccessed
          FSObj[File].TimeM := A_LoopFileTimeModified

          ; Break to prevent more loops
          Break
      }
  }
  Return ;FSObj

}

GetSignature(oStringContainer,SignatureFormat := "HEX"){
        ;	0. BUFFER CONVERSION
        ;------------------------------------------

        ; BUFFER => continue with buffer
        If IsObject(oStringContainer) = true {
            sInputType := "Buffer"

            bRawBinaryData := oStringContainer
        }


        ; FILE => read 5 first bytes into buffer for better performance
        else if FileExist(oStringContainer){
            Outputdebug "input is file"

            sInputType := "File"
            bRawBinaryData := FileRead(oStringContainer,"RAW m5")

        }


        ; STRING => read all bytes into buffer
        Else  {

            sInputType := "String"

            ; get byte size needed if converted to UTF-8, and remove size for terminating NULL
            iRequiredBufferLen := StrPut(oStringContainer,"UTF-8") -1

            bRawBinaryData := Buffer(iRequiredBufferLen)
            StrPut(oStringContainer,bRawBinaryData,iRequiredBufferLen,"UTF-8")

        }

        Try{
            SIG2 :=  Format("{1:X}", NumGet(bRawBinaryData,0,"UChar")) " " Format("{1:X}", NumGet(bRawBinaryData,1,"UChar"))
            SIG3 := SIG2 " " Format("{1:X}", NumGet(bRawBinaryData,2,"UChar"))
            SIG4 := SIG3 " " Format("{1:X}", NumGet(bRawBinaryData,3,"UChar"))
            SIG5 := SIG4 " " Format("{1:X}", NumGet(bRawBinaryData,4,"UChar"))
        }

        switch signatureformat {
            case "UTF-8":
                return StrGet(bRawBinaryData,5,"UTF-8")
            case "ANSI":
                return StrGet(bRawBinaryData,5,"CP0") 
            case "HEX":
                return SIG5
            default:
                return StrGet(bRawBinaryData,5,"UTF-8")
        }

}


; Get encoding of file, string or buffer
;   - String: get encoding that should be used
;   - File: get encoding from signature, or guess
;   - Buffer: get encoding from signature, or guess
GetEncoding(oStringContainer){

  Static mKnownSignatures := Map(
      "EF BB BF",                 "UTF-8",            ;ï»¿
      "FE FF",                    "UTF-16 BE",        ;þÿ
      "FF FE",                    "UTF-16 LE",        ;ÿþ
      "00 00 FE FF",              "UTF-32 BE",        ;NULLNULLþÿ
      "FF FE 00 00",              "UTF-32 LE",        ;ÿþNULLNULL
      "2B 2F 76",                 "UTF-7",            ;+/v
      "F7 64 4C",                 "UTF-1",            ;÷dL
      "DD 73 66 73",              "UTF-EBCDIC",       ;Ýsfs
      "0E FE FF",                 "SCSU",             ;^Nþÿ (^N is "shift out")
      "FB EE 28",                 "BOCU-1",           ;ûî(
      "84 31 95 33",              "GB18030",          ;„1•3
      "50 4B 03 04",              "Archive",          ;PK❃❄
      "50 4B 05 06",              "Archive empty",    ;PK❅❆
      "50 4B 07 08",              "Archive",          ;PK❇❈
      "50 4B",                    "Zip",              ;PK...
      "25 50 44 46",              "PDF",              ;%PDF-
      "D0 CF 11 E0 A1",           "OLE",              ;ÝÝ❑à¡±❚á
      "37 7A BC AF 27",           "7-ZIP",            ;7z¼¯'❜
      "50 4B 03 04 14",           "Office",           ;PK...
      "3C 3F 78 6D 6C",           "XML",              ;<?xml
      "4D 5A",                    "Executable"        ;MZ
      )

    OS := ComObject("Shell.Application") 
  


  ;	0. BUFFER CONVERSION
  ;------------------------------------------

  ; BUFFER => continue with buffer
      If IsObject(oStringContainer) = true {
          sInputType := "Buffer"
  
          bRawBinaryData := oStringContainer
      }


      ; FILE => read 5 first bytes into buffer for better performance
      else if FileExist(oStringContainer){
          Outputdebug "input is file"
  
          sInputType := "File"
          bRawBinaryData := FileRead(oStringContainer,"RAW m5")
  
      }
   

  ; STRING => read all bytes into buffer
  Else  {

      sInputType := "String"

      ; get byte size needed if converted to UTF-8, and remove size for terminating NULL
      iRequiredBufferLen := StrPut(oStringContainer,"UTF-8") -1

      bRawBinaryData := Buffer(iRequiredBufferLen)
      StrPut(oStringContainer,bRawBinaryData,iRequiredBufferLen,"UTF-8")

  }

  ;	1. SIGNATURE SCAN
  ;------------------------------------------

  ; Get multiple Signature versions from buffer, start checking longest first
  ; String will not have signature, only buffers
  Try{
      SIG2 :=  Format("{1:X}", NumGet(bRawBinaryData,0,"UChar")) " " Format("{1:X}", NumGet(bRawBinaryData,1,"UChar"))
      SIG3 := SIG2 " " Format("{1:X}", NumGet(bRawBinaryData,2,"UChar"))
      SIG4 := SIG3 " " Format("{1:X}", NumGet(bRawBinaryData,3,"UChar"))
      SIG5 := SIG4 " " Format("{1:X}", NumGet(bRawBinaryData,4,"UChar"))

      ; Check if signature matches known signatures
      If mKnownSignatures.Has(SIG5){
          Outputdebug "File contains " mKnownSignatures[SIG5] " marker"
          return mKnownSignatures[SIG5] . " BOM"
      }
      Else If mKnownSignatures.Has(SIG4){
          Outputdebug "File contains " mKnownSignatures[SIG4] " marker"
          return mKnownSignatures[SIG4] . " BOM"
      }
      Else If mKnownSignatures.Has(SIG3){
          Outputdebug "File contains " mKnownSignatures[SIG3] " marker"
          return mKnownSignatures[SIG3] . " BOM"
      }
      Else If mKnownSignatures.Has(SIG2){
          Outputdebug "File contains " mKnownSignatures[SIG2] " marker"
          return mKnownSignatures[SIG2] . " BOM"
      }Else{
          Outputdebug "Unknown file signature " 

          Outputdebug "    UTF-8:  " StrGet(bRawBinaryData,5,"UTF-8")
          Outputdebug "    ANSI:   " StrGet(bRawBinaryData,5,"CP0") 
          Outputdebug "    Hex:    " SIG5
      }
  
  }
  ;	2. FULL SIZE CHECK
  ;------------------------------------------

  ; ANSI chars are 1 byte, UTF-8 chars are 1 to 4 bytes long
  ; a         1 unit      1 Len      1 byte
  ; �         1 unit      1 Len      2 bytes
  ; ?         1 unit      1 Len      3 bytes
  ; ??        1 unit      2 Len      4 bytes     
  ; *some apps count units, others length. AHK counts Length, VSCode units

  Outputdebug "counting chars per byte... "

  ; read entire file in buffer before continuing
  if sInputType = "File" {
      bRawBinaryData := FileRead(oStringContainer,"RAW")
  }

  ; compare Buffer size vs character count 
  iBufferSize := bRawBinaryData.Size
  iStringLen := StrLen(StrGet(bRawBinaryData,"UTF-8"))
      
  if iBufferSize = iStringLen {
      ; every byte is a character -> ANSI
      Outputdebug "File is ANSI (" iBufferSize " bytes)"
      return "ANSI (guess)"        
  }
  Else{
      ; some characters consist of multiple bytes -> unknown encoding -> guess UTF-8 RAW
      Outputdebug iBufferSize " bytes for " iStringLen " chars -> UTF-8 RAW"
      return "UTF-8 RAW (guess)"
  }
}