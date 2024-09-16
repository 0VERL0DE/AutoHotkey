#Requires AutoHotkey v2.0

UseGDIP()
Tool()

Tool()
{
	IBStyles := [ [0x80F0F0F0,, 0xFF000000, 4, 0x80F0F0F0, 1]
				, [0x80CFCFCF,, 0xFF000000, 4, 0x80CFCFCF, 1]
				, [0x80DCDCDC,, 0xFF666666, 4, 0x80DCDCDC, 1]
				, [0x80EAEAEA,, 0xFF0078D7, 4, 0x80EAEAEA, 1] ]

	Main := Gui("")
	Main.MarginX := 0
	Main.MarginY := 0
	;Main.BackColor := "F3F3F3"


	; == Segoe UI Symbol (pre Win 10)
	Main.SetFont("s14", "Segoe UI Symbol")
	Main.AddButton("xm+3 ym+4  w250 h36 0x100", Chr(0xE10F) " Segoe UI Symbol pre win10")

	IB01 := Main.AddButton("xm+3 y+4 w250 h36 0x100 vIB01", " " Chr(0xE10F) "   Home")
	IB01.OnEvent("Click", TabSelect)
	CreateImageButton(IB01, 0, IBStyles*)

	IB02 := Main.AddButton("xm+3 y+4 w250 h36 0x100 vIB02", " " Chr(0xE115) "   Settings")
	IB02.OnEvent("Click", TabSelect)
	CreateImageButton(IB02, 0, IBStyles*)
	IB03 := Main.AddButton("xm+3 y+4 w250 h36 0x100 vIB03", " " Chr(0xE1D0) "   Calc")
	IB03.OnEvent("Click", TabSelect)
	CreateImageButton(IB03, 0, IBStyles*)



	; == Segoe MDL2 Assets (with Win 10)   https://docs.microsoft.com/en-us/windows/apps/design/style/segoe-ui-symbol-font
	Main.SetFont("s14", "Segoe MDL2 Assets")
	Main.AddButton("x+10 ym+4  w250 h36 0x100", Chr(0xE80F) " Segoe MDL2 Assets win10")

	IB04 := Main.AddButton("xp y+4 w250 h36 vIB04 0x100", " " Chr(0xE80F) "   Home")
	IB04.OnEvent("Click", TabSelect)
	CreateImageButton(IB04, 0, IBStyles*)

	Main.AddText("xp y+5 w250 h36 0x200", " " Chr(0xE713) . "   Settings")

	Main.AddText("xp y+4 w250 h36 0x200", " " Chr(0xE8EF) . "   Calc")



	; == Segoe Fluent Icons (with Win 11)   https://docs.microsoft.com/en-us/windows/apps/design/style/segoe-fluent-icons-font
	Main.SetFont("s14", "Segoe Fluent Icons")
	Main.AddButton("x+10 ym+4  w250 h36 0x100", Chr(0xE80F) " Segoe Fluent Icons win11")

	IB05 := Main.AddButton("xp y+4 w250 h36 vIB05 0x100", " " Chr(0xE80F) "   Home")
	IB05.OnEvent("Click", TabSelect)
	CreateImageButton(IB05, 0, IBStyles*)

	Main.AddText("xp y+5 w250 h36 0x200", " " Chr(0xE713) . "   Settings")

	Main.AddText("xp y+4 w250 h36 0x200", " " Chr(0xE8EF) . "   Calc")




	T3 := Main.AddTab3("xm ym-2 w0 h0 -Wrap Choose1 AltSubmit", ["1", "2", "3", "4"])
	Main.Show("w800 h400")

	TabSelect(BtnCtrl, *)
	{
		static TCM_GETITEMCOUNT := 0x1304

		/* todo
		T3.Choose(k := SubStr(BtnCtrl.Name, 4, 1))

		loop SendMessage(TCM_GETITEMCOUNT, 0, 0, T3.hWnd)
		{
			; ...
		}
		*/
	}

}


#Include CreateImageButton.ahk