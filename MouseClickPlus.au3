#include-once
#include <SendMessage.au3>

; #FUNCTION# ====================================================================================================================
; Name ..........: _MouseClickPlus
; Description ...: Sends a click to window.
; Syntax ........: _MouseClickPlus($hWnd[, $sButton = 'left' [, $vX [, $vY [, $iClicks = 1]]]])
; Parameters ....: $hWnd                - A window handle to send click(s) to
;                  $sButton             - [optional] 'left' (default) or 'right'
;                  $vX                  - [optional] X coordinate
;                  $vY                  - [optional] Y coordinate
;                  $iClicks             - [optional] Number of clicks to send. Default is 1.
; Return values .: None
; Author ........: Insolence <insolence_9@yahoo.com>
; Modified ......: Walkman
; Remarks .......: You MUST be in "MouseCoordMode" 0 to use this without bugs.
;				   Not entirely accurate, but works minimized.
; Related .......: _SendMessage, DllCall, MouseGetPos
; Link ..........: http://www.autoitscript.com/forum/topic/7112-minimized-clicking-great-for-game-bots/page__hl__Insolence
; Example .......: No
; ===============================================================================================================================
Func _MouseClickPlus($hWnd, $vX = '', $vY = '', $sButton = 'left', $iClicks = 1)
	Local $MK_LBUTTON = 0x0001
	Local $WM_LBUTTONDOWN = 0x0201
	Local $WM_LBUTTONUP = 0x0202

	Local $MK_RBUTTON = 0x0002
	Local $WM_RBUTTONDOWN = 0x0204
	Local $WM_RBUTTONUP = 0x0205

	Local $WM_MOUSEMOVE = 0x0200

	If $sButton = 'left' Then
		$Button = $MK_LBUTTON
		$ButtonDown = $WM_LBUTTONDOWN
		$ButtonUp = $WM_LBUTTONUP
	ElseIf $sButton = 'right' Then
		$Button = $MK_RBUTTON
		$ButtonDown = $WM_RBUTTONDOWN
		$ButtonUp = $WM_RBUTTONUP
	EndIf

	If $vX = "" Or $vY = "" Then
		$MouseCoord = MouseGetPos()
		$vX = $MouseCoord[0]
		$vY = $MouseCoord[1]
	EndIf

;~ 	Local $stPoint = DllStructCreate('long;long')

	Local $stPoint = _MakeLong($vX, $vY)
;~ 	DllStructSetData($stPoint, 1, $vX)
;~ 	DllStructSetData($stPoint, 2, $vY)
;~ 	ConsoleWrite('$stPoint: ' & $stPoint & ' _Makelong(): ' & _Makelong($vX, $vY) & @CR)

	Local $i = 0
	For $i = 1 To $iClicks
		_SendMessage($hWnd, $WM_MOUSEMOVE, 0, $stPoint)
		_SendMessage($hWnd, $ButtonDown, $Button, $stPoint)
		_SendMessage($hWnd, $ButtonUp, $Button, $stPoint)
	Next
EndFunc   ;==>_MouseClickPlus2

Func _MakeLong($LoWord,$HiWord)
	Return BitOR($HiWord * 0x10000, BitAND($LoWord, 0xFFFF))
 EndFunc