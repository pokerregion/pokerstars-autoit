#include-once

; #FUNCTION# ====================================================================================================================
; Name ..........: _FileWalkman_IniNewLine
; Description ...: New line before each section in a .ini file to make it more readable.
; Syntax ........: _FileWalkman_IniNewLine($sFileName)
; Parameters ....: $sFileName           - A string value.
; Return values .: None
; Author ........: rudi
; Modified ......: Walkman
; Remarks .......:
; Related .......:
; Link ..........: http://www.autoitscript.com/forum/topic/93796-iniwrite/#entry673784
; Example .......: No
; ===============================================================================================================================
Func _FileWalkman_IniNewLine($sFileName)
	Local $sIniText = FileRead($sFileName)
	Local $sFixedIni = StringRegExpReplace($sIniText, '(\r\n){1,}\[' , @CRLF & @CRLF & '\[')

	Local $hFile = FileOpen($sFileName, 2)
	FileWrite($hFile, $sFixedIni)
	FileClose($hFile)
EndFunc
