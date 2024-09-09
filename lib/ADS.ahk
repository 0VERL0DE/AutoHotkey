#Requires AutoHotkey v2.0


; Modifying data streams updates the last modified time
; File (size, contents,etc) remain unhanged


; Get the string contained in the alternate stream named "comments"
GetMetaStr(AbsFilePath, StreamName := "comments"){

    command := "Get-Content -Path '" . AbsFilePath . "' -Stream 'comments' 2>$null"

    MetaStr := PS_cmd('powershell -Command "' . command . '"')

    if MetaStr {
        return MetaStr
    }else{
        return ""
    }
}

; checks if the file has an alternate data stream
HasMetaStr(AbsFilePath,StreamName := "*"){

    command := "Get-Item -Path '" AbsFilePath "' -stream " StreamName " 2>$null "
     . " | Where-Object {$_.stream -ne ':$DATA' -and $_.Length -gt 0 }"
     . " | ForEach-Object { '`"{0}`",`"{1}`",`"{2}`"' -f $_.FileName, $_.Stream, $_.Length }"

    FilesWithStream := PS_cmd('powershell -Command "' . command . '"')

    if FilesWithStream {
            
        ; best practice: list of associative arrays
        FileArray := Array()
        For FoundFile in StrSplit(Trim(FilesWithStream,"`r`n`t"),"`n"){
            arrFileProps := StrSplit(FoundFile,",")
            SplitPath(arrFileProps[1],&FileName)

            Props := Map()
                Props.AbsPath := arrFileProps[1]
                Props.FileName := FileName
                Props.StreamName := arrFileProps[2]
                Props.StreamSize := arrFileProps[3]
            FileArray.Push(Props)
        }
        return FileArray
        
    }else{
        return ""
    }


}


; Set the string contained in the alternate data stream named "comments"
SetMetaStr(AbsFilePath, MetaStr, StreamName := "comments"){

    command := "Set-Content -Path '" . AbsFilePath . "' -Stream 'comments' -Value '" . MetaStr . "'"

    PS_cmd('powershell -Command "' . command . '"')

    return
}

; Clear the MetaStr in the default stream "comments"
DeleteMetaStr(AbsFilePath, StreamName := "comments"){

    ; Clear the content of the specified stream
    command := "clear-content '" AbsFilePath "' -Stream '" StreamName "'"
    PS_cmd('powershell -Command "' . command . '"')

    ; Delete the empty stream item
    command := "remove-item '" AbsFilePath "' -Stream '" StreamName "'"
    PS_cmd('powershell -Command "' . command . '"')

    return
}


; Read the metastr and append text to it
AppendMeta(AbsFilePath, MetaStr, StreamName := "comments"){

    OriginalMetaStr := GetMetaStr(AbsFilePath, StreamName)

    NewMetaStr := OriginalMetaStr MetaStr

    SetMetaStr(AbsFilePath,NewMetaStr)

    return
}


; get a list of files in the specified folder that have an alternate data stream
; returns an array of files, each file ia set of property value pairs
;    FileArray[index].property
GetFilesWithStream(AbsFolderPath,StreamName := "*"){

    command := "Get-Item -Path '" AbsFolderPath "\*' -stream " StreamName " 2>$null "
     . " | Where-Object {$_.stream -ne ':$DATA' -and $_.Length -gt 0 }"
     . " | ForEach-Object { '`"{0}`",`"{1}`",`"{2}`"' -f $_.FileName, $_.Stream, $_.Length }"

    FilesWithStream := PS_cmd('powershell -Command "' . command . '"')

    ; best practice: list of associative arrays
    FileArray := Array()
    For FoundFile in StrSplit(Trim(FilesWithStream,"`r`n`t"),"`n"){
        arrFileProps := StrSplit(FoundFile,",")
        SplitPath(arrFileProps[1],&FileName)

        Props := Map()
            Props.AbsPath := arrFileProps[1]
            Props.FileName := FileName
            Props.StreamName := arrFileProps[2]
            Props.StreamSize := arrFileProps[3]
        FileArray.Push(Props)
    }

    return FileArray
}

#Include <PowerShell>