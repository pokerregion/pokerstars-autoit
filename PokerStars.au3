#include-once
#include 'PokerStarsConstants-8.6.8.9.au3'
#include <WinAPI.au3>
#include <GuiMenu.au3>
#include <Constants.au3>
#include <WindowsConstants.au3>
#include 'MouseClickPlus.au3'
#include 'FileWalkman.au3'
#include <Array.au3>

; #INDEX# =======================================================================================================================
; Title .........: PokerStars
; AutoIt Version : 3.8.8.1
; Description ...: Functions helping to manipulate PokerStars software
; Author(s) .....: Walkman (W2lkm2n on PokerStars)
; Dll ...........:
; ===============================================================================================================================

; #VARIABLES# ===================================================================================================================
Global $__gbCashierDisabled = False
Global $__gsMoveMenuText = ''
; ===============================================================================================================================

; #FUNCTION# ====================================================================================================================
; Name ..........: _PokerStars_ShowCashier
; Description ...:
; Syntax ........: _PokerStars_ShowCashier()
; Parameters ....:
; Return values .: None
; Author ........: Walkman
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _PokerStars_OpenCashier()
	Dim $hPokerStarsLobby
	If Not WinExists($hPokerStarsLobby) Then Return
	If StringInStr(WinGetTitle($hPokerStarsLobby), $POKERSTARS_TEXT_LOGGED_IN) <> 0 Then
		Return WinMenuSelectItem($hPokerStarsLobby, '', $POKERSTARS_MENU_LOBBY[1], $POKERSTARS_MENUITEM_CASHIER[1])
	Else
		TrayTip("Not Logged in", "You need to log in to open the cashier !", 1000, 3)
		Return False
	EndIf
EndFunc

; #FUNCTION# ====================================================================================================================
; Name ..........: _PokerStars_CloseCashier
; Description ...:
; Syntax ........: _PokerStars_CloseCashier()
; Parameters ....:
; Return values .: None
; Author ........: Walkman
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _PokerStars_CloseCashier()
	Dim $hPokerStarsLobby
	If Not WinExists($hPokerStarsLobby) Then Return
	Local $hCashier = WinGetHandle($POKERSTARS_CASHIER)
	If $hCashier <> '' Then WinClose($hCashier)
EndFunc

; #FUNCTION# ====================================================================================================================
; Name ..........: _PokerStars_ClickRegister
; Description ...:
; Syntax ........: _PokerStars_ClickRegister()
; Parameters ....:
; Return values .:
; Author ........: Walkman
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _PokerStars_ClickRegister()
	Dim $hPokerStarsLobby
;~ 	ConsoleWrite('@@ Debug(' & @ScriptLineNumber & ') : $hPokerStarsLobby = ' & $hPokerStarsLobby & @crlf & '>Error code: ' & @error & @crlf) ;### Debug Console
;~ 	ConsoleWrite(WinGetText($hPokerStarsLobby) & @CRLF)
;~ 	If Not WinExists($hPokerStarsLobby) Then Return 0
	If 0 <> StringInStr(WinGetText($hPokerStarsLobby), $POKERSTARS_TEXT_REGISTER, 1) Then
;~ 		TrayTip('Regisztráció', 'Most Regisztrált volna.', 1000, 1)
;~ 	  ConsoleWrite("Register szöveg megvan..." & @CRLF)
;~ 	  ConsoleWrite("Reg button: " & $POKERSTARS_BUTTON_REGISTER & @CRLF)
	  Return ControlClick($hPokerStarsLobby, '', $POKERSTARS_BUTTON_REGISTER)
	EndIf
	Return 0
EndFunc

; #FUNCTION# ====================================================================================================================
; Name ..........: _PokerStars_ClickUnRegister
; Description ...:
; Syntax ........: _PokerStars_ClickUnRegister()
; Parameters ....:
; Return values .: None
; Author ........: Walkman
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _PokerStars_ClickUnRegister()
	Dim $hPokerStarsLobby
	If Not WinExists($hPokerStarsLobby) Then Return 0

	Local $sLobbyText = WinGetText($hPokerStarsLobby)
	If StringInStr($sLobbyText, $POKERSTARS_TEXT_REGISTER, 1) <> 0 Then
		Return 1
	ElseIf StringInStr($sLobbyText, $POKERSTARS_TEXT_UNREGISTER, 1) <> 0 Then
		Return ControlClick($hPokerStarsLobby, '', $POKERSTARS_BUTTON_UNREGISTER)
	Else
		Return 0
	EndIf
EndFunc

; #FUNCTION# ====================================================================================================================
; Name ..........: _PokerStars_ClickTableButton
; Description ...:
; Syntax ........: _PokerStars_ClickTableButton($hTable, $sButton)
; Parameters ....: $hTable              - A Tournament Table Window handle.
;                  $sButton             - Which button to click ? Info, Stats, Notes or Chat
; Return values .: None
; Author ........: Walkman
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _PokerStars_ClickTableButton($hTable, $sButton)
	Local $iMCM = Opt("MouseCoordMode", 2)

	Local $aPos = ControlGetPos($hTable, '', $POKERSTARS_TAB_INFO)
	ConsoleWrite('! Tabinfo X: ' & $aPos[0] & " Y: " & $aPos[1] & ' W: ' & $aPos[2] & ' H: ' & $aPos[3] & @CRLF)

	Local $iHalfX = Floor($aPos[0] + $aPos[2])/2
	Local $iY = $aPos[1] - 8
	Local $iPart = Floor($iHalfX/3)-5

	; TODO: make it work with every theme !
	;~ $classic = True
	;~ If $classic Then $y -= 30

	Switch $sButton
		Case 'Info'
			$iX = $iHalfX
		Case 'Stats'
			$iX = $iHalfX - $iPart
		case 'Notes'
			$iX = $iHalfX - 2 * $iPart
		Case 'Chat'
			$iX = $iHalfX - 3 * $iPart
	EndSwitch

	; Clicking without moving the mouse. Requires MouseClickPlus UDF
	_MouseClickPlus($hTable, $iX, $iY)

	Opt('MouseCoordMode', $iMCM)
EndFunc

; #FUNCTION# ====================================================================================================================
; Name ..........: _PokerStars_ApplyLayout
; Description ...:
; Syntax ........: _PokerStars_ApplyLayout()
; Parameters ....:
; Return values .:
; Author ........: Walkman
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _PokerStars_ApplyLayout()
	Dim $hPokerStarsLobby
	If Not WinExists($hPokerStarsLobby) Then Return
	Return WinMenuSelectItem($hPokerStarsLobby, '', $POKERSTARS_MENU_VIEW[1], $POKERSTARS_MENUITEM_APPLY_ACTIVE_LAYOUT[1])
EndFunc

; #FUNCTION# ====================================================================================================================
; Name ..........: _PokerStars_CloseWindows
; Description ...:
; Syntax ........: _PokerStars_CloseWindows($aWindowsToClose)
; Parameters ....: $aWindowsToClose     - An array of unknowns.
; Return values .: None
; Author ........: Walkman
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _PokerStars_CloseWindows($aWindowsToClose)
	Local $iMatchMode = Opt('WinTitleMatchMode', 3)
	Local $iWinWaitDelay = Opt('WinWaitDelay', 0)

	For $i = 0 To Ubound($aWindowsToClose)-1
		If $aWindowsToClose[$i] = '' Then ContinueLoop ; security check
		WinKill($aWindowsToClose[$i])
	Next

	$hRegWindow = WinGetHandle($POKERSTARS_WINDOW_REGISTER)
	If @error = 1 Then Return
	Sleep(100)

	$aWinClasses = StringSplit(WinGetClassList($hRegWindow), @LF)
;~ 	ConsoleWrite($aWinClasses[0] & @CRLF)

	; one or two buttons
	If $aWinClasses[0] <= 3 Then
		WinKill($hRegWindow)
	Else
		ControlClick( $hRegWindow, '', $POKERSTARS_BUTTON_REGISTER_OK)
	EndIf

	Opt('WinTitleMatchMode', $iMatchMode)
	Opt('WinWaitDelay', $iWinWaitDelay)

EndFunc

; #FUNCTION# ====================================================================================================================
; Name ..........: _PokerStars_FindAPlayer
; Description ...:
; Syntax ........: _PokerStars_FindAPlayer()
; Parameters ....:
; Return values .: None
; Author ........: Walkman
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _PokerStars_FindAPlayer()
	Dim $hPokerStarsLobby
	If Not WinExists($hPokerStarsLobby) Then
		TrayTip("PokerStars not running", "You need to start PokerStars to find a player!", 1000, 1)
		Return False
	EndIf
	Return WinMenuSelectItem($hPokerStarsLobby, '', $POKERSTARS_MENU_REQUESTS, $POKERSTARS_MENUITEM_FIND_A_PLAYER )
EndFunc

; #FUNCTION# ====================================================================================================================
; Name ..........: _PokerStars_RemoveCashier
; Description ...: Disables the Cashier menu, Cashier button and set a hotkey for the callback function instead of CTRL-4
; Syntax ........: _PokerStars_RemoveCashier([$sCallbackForHotkey = 'YourFunction'])
; Parameters ....: $sCallbackForHotkey  - [optional] A string value for your callback function
; Return values .:
; Author ........: Walkman
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _PokerStars_DisableCashier($sCallbackForHotkey = '__PokerStars_CashierHotKey')
	Dim $hPokerStarsLobby, $__gbCashierDisabled

	If $__gbCashierDisabled Or Not WinExists($hPokerStarsLobby) Then Return

	ControlDisable($hPokerStarsLobby, '', $POKERSTARS_BUTTON_CASHIER)

	Local $hMenu = _GuictrlMenu_Getmenu($hPokerStarsLobby)
	; make sure the menu is what we want
	If _GUICtrlMenu_GetItemText($hMenu, $POKERSTARS_MENU_CASHIER[0]) = $POKERSTARS_MENU_CASHIER[1] Then
		_GUICtrlMenu_SetItemDisabled($hMenu, $POKERSTARS_MENU_CASHIER[0])
	EndIf

	Local $hLobbyMenu = _GUICtrlMenu_GetItemSubMenu($hMenu, $POKERSTARS_MENU_LOBBY[0])
;~ 	ConsoleWrite('! ' & _GUICtrlMenu_GetItemText($hLobbyMenu, $POKERSTARS_MENUITEM_CASHIER[0]) & @CR)
	If $POKERSTARS_MENUITEM_CASHIER[1] = _GUICtrlMenu_GetItemText($hLobbyMenu, $POKERSTARS_MENUITEM_CASHIER[0]) Then
		_GUICtrlMenu_RemoveMenu($hLobbyMenu, $POKERSTARS_MENUITEM_CASHIER[0])
		_GUICtrlMenu_RemoveMenu($hLobbyMenu, $POKERSTARS_MENUITEM_CASHIER[0])	; Remove the dash menuitem to look good :)
	EndIf

	HotKeySet($POKERSTARS_HOTKEY_CASHIER, $sCallbackForHotkey)

	$__gbCashierDisabled = True

EndFunc

; #INTERNAL_USE_ONLY# ===========================================================================================================
; Name ..........: __PokerStars_CashierHotkey
; Description ...:
; Syntax ........: __PokerStars_CashierHotkey()
; Parameters ....:
; Return values .: None
; Author ........: Walkman
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func __PokerStars_CashierHotKey()
	TrayTip('Cashier disabled', 'You disabled the cashier!',1000, 1)
EndFunc

; #FUNCTION# ====================================================================================================================
; Name ..........: _PokerStars_EnableCashier
; Description ...:
; Syntax ........: _PokerStars_EnableCashier()
; Parameters ....:
; Return values .: None
; Author ........: Walkman
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _PokerStars_EnableCashier()
	Dim $hPokerStarsLobby, $__gbCashierDisabled

	If Not WinExists($hPokerStarsLobby) Then Return

	ControlEnable($hPokerStarsLobby, '', $POKERSTARS_BUTTON_CASHIER)

	Local $hMenu = _GuictrlMenu_Getmenu($hPokerStarsLobby)
	_GUICtrlMenu_SetItemEnabled($hMenu, $POKERSTARS_MENU_CASHIER[0])

	HotKeySet($POKERSTARS_HOTKEY_CASHIER)

	$__gbCashierDisabled = False
EndFunc

; #FUNCTION# ====================================================================================================================
; Name ..........: _PokerStars_DisableStarsLobbyMove
; Description ...:
; Syntax ........: _PokerStars_DisableStarsLobbyMove()
; Parameters ....:
; Return values .: None
; Author ........: Walkman
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _PokerStars_DisableLobbyMove()
	Dim $hPokerStarsLobby
	If Not WinExists($hPokerStarsLobby) Then Return

	Local $hSysMenu = _GUICtrlMenu_GetSystemMenu($hPokerStarsLobby, 0)
	$__gsMoveMenuText = _GUICtrlMenu_GetItemText($hSysMenu, $SC_MOVE, False)
	_GUICtrlMenu_RemoveMenu($hSysMenu, $SC_MOVE, False)
;~ 	_GUICtrlMenu_DrawMenuBar($hPokerStarsLobby)
EndFunc

; #FUNCTION# ====================================================================================================================
; Name ..........: _PokerStars_EnableLobbyMove
; Description ...:
; Syntax ........: _PokerStars_EnableLobbyMove()
; Parameters ....:
; Return values .: None
; Author ........: Walkman
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _PokerStars_EnableLobbyMove()
	Dim $hPokerStarsLobby
	If Not WinExists($hPokerStarsLobby) Then Return

	Local $hSysMenu = _GUICtrlMenu_GetSystemMenu($hPokerStarsLobby, 0)
	Local $sMenuText = _GUICtrlMenu_GetItemText($hSysMenu, $SC_MOVE, False)
	ConsoleWrite('@@ Debug(' & @ScriptLineNumber & ') : $sMenuText = ' & $sMenuText & @crlf & '>Error code: ' & @error & @crlf) ;### Debug Console
	; TODO: Name by constant
	If $sMenuText = '' Then	_GUICtrlMenu_InsertMenuItem($hSysMenu, 1, $__gsMoveMenuText, $SC_MOVE)
EndFunc

; #FUNCTION# ====================================================================================================================
; Name ..........: _PokerStars_ToggleWindowButtons
; Description ...:
; Syntax ........: _PokerStars_ToggleWindowButtons($hTable[, $bAll = True])
; Parameters ....: $hTable              - A handle value.
;                  $bAll                - [optional] A binary value. Default is True.
; Return values .: None
; Author ........: Walkman
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _PokerStars_ToggleWindowButtons($hTable, $bAll = True)
	Local $iOldStyle = _WinAPI_GetWindowLong($hTable, $GWL_STYLE)
	ConsoleWrite('GWL: ' & $GWL_STYLE & @CRLF)
;~ 	ConsoleWrite('@@ Debug(' & @ScriptLineNumber & ') : $iOldStyle = ' & $iOldStyle & @crlf & '>Error code: ' & @error & @crlf) ;### Debug Console

	If $bAll Then
		Local $iNewStyle = BitXOr($iOldStyle, $WS_SYSMENU)
	Else
		; Might be useful for tournament lobbies
		Local $iNewStyle = BitXOr($iOldStyle, $WS_MINIMIZEBOX, $WS_MAXIMIZEBOX)
	EndIf

	Local $iSuccess = _WinAPI_SetWindowLong($hTable, $GWL_STYLE, $iNewStyle)
	_WinAPI_SetWindowPos($hTable, 0, 0, 0, 0, 0, BitOR($SWP_FRAMECHANGED, $SWP_NOMOVE, $SWP_NOSIZE))
	Return $iSuccess
EndFunc

; #FUNCTION# ====================================================================================================================
; Name ..........: _PokerStars_RestoreWindowButtons
; Description ...:
; Syntax ........: _PokerStars_RestoreWindowButtons($hTable)
; Parameters ....: $hTable              - A handle value.
; Return values .: None
; Author ........: Walkman
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _PokerStars_RestoreWindowButtons($hTable)
	Local $iSuccess = _WinAPI_SetWindowLong($hTable, $GWL_STYLE, $POKERSTARS_WINDOW_DEFAULT_GWL_STYLE)
	_WinAPI_SetWindowPos($hTable, 0, 0, 0, 0, 0, BitOR($SWP_FRAMECHANGED, $SWP_NOMOVE, $SWP_NOSIZE))
	Return $iSuccess
EndFunc

; #FUNCTION# ====================================================================================================================
; Name ..........: _PokerStars_CloseTables
; Description ...:
; Syntax ........: _PokerStars_CloseTables()
; Parameters ....:
; Return values .: None
; Author ........: Walkman
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _PokerStars_CloseAllTables()
	Local $iDelay = Opt('WinWaitDelay', 0)
	Local $aTables = WinList($POKERSTARS_TOURNAMENT_TABLES)
	For $i = 1 to $aTables[0][0]
		WinClose($aTables[$i][1])
		ConsoleWrite("+ Closing table: " & $aTables[$i][0] & @LF)
	Next
	Opt('WinWaitDelay', $iDelay)
EndFunc

; #FUNCTION# ====================================================================================================================
; Name ..........: _PokerStars_CloseLobbies
; Description ...:
; Syntax ........: _PokerStars_CloseLobbies()
; Parameters ....:
; Return values .: None
; Author ........: Walkman
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _PokerStars_CloseAllLobbies()
	Local $iDelay = Opt('WinWaitDelay', 0)
	Local $aLobbies = WinList($POKERSTARS_TOURNAMENT_LOBBIES)
	For $i = 1 to $aLobbies[0][0]
		WinKill($aLobbies[$i][1])
		ConsoleWrite("+Closing lobby: " & $aLobbies[$i][0] & @LF)
	Next
	Opt('WinWaitDelay', $iDelay)
EndFunc

; #FUNCTION# ====================================================================================================================
; Name ..........: _PokerStars_OpenRandomLobbies
; Description ...:
; Syntax ........: _PokerStars_OpenRandomLobbies([$iNumber = 12])
; Parameters ....: $iNumber             - [optional] An integer value. Default is 12.
; Return values .: None
; Author ........: Walkman
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _PokerStars_OpenRandomLobbies($iNumber = 12)
	Dim $hPokerStarsLobby
	If Not WinExists($hPokerStarsLobby) Then Return False
	WinActivate($hPokerStarsLobby)
	Send('^{HOME}')
	Local $i
	For $i = 1 To $iNumber
		ControlFocus($hPokerStarsLobby, '', $POKERSTARS_LIST_TOURNAMENTS)
		Send('{Down}')
		ControlClick($hPokerStarsLobby, '', $POKERSTARS_BUTTON_TOURNEY_LOBBY)
		Sleep(100)
		WinActivate($hPokerStarsLobby)
		Sleep(100)
	Next
EndFunc

; #FUNCTION# ====================================================================================================================
; Name ..........: _PokerStars_OpenTableFromLobby
; Description ...:
; Syntax ........: _PokerStars_OpenTableFromLobby($hLobby)
; Parameters ....: $hLobby              - A handle value.
; Return values .: None
; Author ........: Walkman
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _PokerStars_OpenTableFromLobby($hLobby)
	Dim $hPokerStarsLobby
	If Not WinExists($hPokerStarsLobby) Then Return False
	Return ControlClick($hLobby, '', $POKERSTARS_BUTTON_OBSERVE_TABLE)
EndFunc

; #FUNCTION# ====================================================================================================================
; Name ..........: _PokerStars_FloatLobby
; Description ...:
; Syntax ........: _PokerStars_FloatLobby()
; Parameters ....:
; Return values .: None
; Author ........: Walkman
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _PokerStars_FloatLobby()
	Dim $hPokerStarsLobby
	IF Not WinExists($hPokerStarsLobby) Then Return
	Local $aStarsPos = WinGetPos($hPokerStarsLobby)
	Local $aMousePos = MouseGetPos()
	; TODO: _Make it with WinAPI_TrackMouseEvent() on WinAPIEx UDF !
	If $aMousePos[0] <= 10 And $aMousePos[1] <= $aStarsPos[3] And $aStarsPos[0] < 0 Then
		_WinAPI_SetWindowPos($hPokerStarsLobby, $HWND_TOP, 0, 0, 0, 0, BitOr($SWP_NOMOVE, $SWP_NOSIZE))
		WinMove($hPokerStarsLobby, '', 0, 0, -1, -1, 2)
	ElseIf ($aStarsPos[0] >= 0) And (($aMousePos[0] > $aStarsPos[2]+20) Or ($aMousePos[1] > $aStarsPos[3]+20)) Then
		Winmove($hPokerStarsLobby, '', -$aStarsPos[2]+ 10, 0, -1,-1,2)
	EndIf
EndFunc

; #FUNCTION# ====================================================================================================================
; Name ..........: _PokerStars_RestoreLobby
; Description ...:
; Syntax ........: _PokerStars_RestoreLobby()
; Parameters ....:
; Return values .: None
; Author ........: Walkman
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _PokerStars_RestoreLobby()
	Dim $hPokerStarsLobby
	IF Not WinExists($hPokerStarsLobby) Then Return
	ConsoleWrite('@@ Debug(' & @ScriptLineNumber & ') : RESTORE $hPokerStarsLobby = ' & $hPokerStarsLobby & @crlf & '>Error code: ' & @error & @crlf) ;### Debug Console
	Local $aPos = WingetPos($hPokerStarsLobby)
	If $aPos[0] < 0 Or $aPos[0] >= @DesktopWidth Or $aPos[1] < 0 Or $aPos[1] > @DesktopHeight Then WinMove($hPokerStarsLobby, '', 0,0, -1, -1, 2)
EndFunc

Func _PokerStars_SaveFilter($sPokerStarsPath, $sIniFile, $sFilterName = 'Default')
	Dim $hFilterWindow
	If Not $hFilterWindow Then Return False

	Local $sPSVersion = FileGetVersion($sPokerStarsPath)
	ConsoleWrite('@@ Debug(' & @ScriptLineNumber & ') : $sPSVersion = ' & $sPSVersion & @crlf & '>Error code: ' & @error & @crlf) ;### Debug Console

	Local $sInput = ControlGetText($hFilterWindow, '', $POKERSTARS_INPUT_FILTER)

	Local $aButtonRange[2] = [1, 51], $sButtons = ''
	For $i = $aButtonRange[0] To $aButtonRange[1]
		$sButtons &= ControlCommand($hFilterWindow, '', '[CLASS:Button; INSTANCE:' & $i & ']', 'IsChecked')
		$sButtons &= '|'
	Next
	$sButtons = StringTrimRight($sButtons, 1)

	Local $aEditRange[2] = [1, 5], $sEdits = ''
	For $i = $aEditRange[0] To $aEditRange[1]
		$sEdits &= ControlCommand($hFilterWindow, '', '[CLASS:Edit; INSTANCE:' & $i & ']', 'GetLine', 1)
		$sEdits &= '|'
	Next
	$sEdits = StringTrimRight($sEdits, 1)

	Local $sData = 'PSVersion=' & $sPSVersion & @LF & _
				   'Input=' & $sInput & @LF & _
				   'Buttons=' & $sButtons & @LF & _
				   'Edits=' & $sEdits
	IniWriteSection($sIniFile, $sFilterName, $sData )
	_FileWalkman_IniNewLine($sIniFile)
EndFunc

; TODO: check if filter is still valid after PokerStars update
Func _PokerStars_LoadFilter($sPokerStarsPath, $sIniFile, $sFilterName = "Default")
	Local $sPSVersion = IniRead($sIniFile, $sFilterName, 'PSVersion', '0.0.0.0')
	If FileGetVersion($sPokerStarsPath) <> $sPSVersion Then Return "Need recheck"

	Local $sInput = IniRead($sIniFile, $sFilterName, 'Input', '')
	ConsoleWrite('@@ Debug(' & @ScriptLineNumber & ') : $sInput = ' & $sInput & @crlf & '>Error code: ' & @error & @crlf) ;### Debug Console

	Local $aButtons = StringSplit(IniRead($sIniFile, $sFilterName, 'Buttons', ''), '|')
	ConsoleWrite('Button number: ' & $aButtons[0] & @CRLF)
	_ArrayDisplay($aButtons)

	Local $aEdits = StringSplit(IniRead($sIniFile, $sFilterName, 'Edits', ''), '|')
	ConsoleWrite('Edit number: ' & $aEdits[0] & @CRLF)
	_ArrayDisplay($aEdits)

	Dim $aRet[3] = [$sInput, $aButtons, $aEdits]
	Return $aRet
EndFunc

Func _PokerStars_SetFilter($aFilter)
	Dim $hPokerStarsLobby
	Local $hFilterWindow = WinGetHandle($POKERSTARS_WINDOW_FILTER, $POKERSTARS_TEXT_FILTER_IS)
	If @error then
		ControlClick($hPokerStarsLobby, '', $POKERSTARS_BUTTON_SIT_AND_GO_FILTER)
		ConsoleWrite("Sit and Go Filter gomb megnyomva" & @CRLF)
		$hFilterWindow = WinWait($POKERSTARS_WINDOW_FILTER, $POKERSTARS_TEXT_FILTER_IS)
		ConsoleWrite("Ablak elõugrott" & @CRLF)
	EndIf

;~ 	MsgBox(0, "Controls", WinGetClassList($hFilterWindow))

	; Just a security test, make sure we catch only The filter window, as it has no title
	Local $sWinText = WinGetText($hFilterWindow)

	$bFound = StringRegExp($sWinText, $POKERSTARS_TEXT_FILTER_WINDOW)
;~ 	ConsoleWrite('@@ Debug(' & @ScriptLineNumber & ') : $bFound = ' & $bFound & @crlf & '>Error code: ' & @error & @crlf) ;### Debug Console

;~ 	Opt("WinDetectHiddenText", $PrevWinDetect)

	; TODO: if not found, implement WinList() based search mode and execute here
	If $bFound = 0 Then
		TrayTip("Something bad happened", "I was not able to find the filter window." & @LF & "Exiting...", 5000, 3)
		Return False
	EndIf


	Sleep(500)

	Local $aButtons = $aFilter[1]
	For $i = 1 To $aButtons[0]
		If $aButtons[$i] = 1 Then
			ControlCommand($hFilterWindow, '', 'Button' & $i  , "Check")
		Else
			ControlCommand($hFilterWindow, '', 'Button' & $i , 'UnCheck')
		EndIf
	Next

	Local $aEdits = $aFilter[2]
	For $i = 1 To $aEdits[0]
		ControlSetText($hFilterWindow, '', 'Edit' & $i, $aEdits[$i])
		ControlCommand($hFilterWindow, '', 'Combobox' & $i , 'ShowDropDown', '')
	Next

	; Only click it if is turned off
	; Unnecesary, because if you click on buttons after Reset, it will be active
 	;If StringRegExp(WinGetText($hFilterWindow), "Filter is Off") Then ControlClick($hFilterWindow, '', $FILTER_IS_OFF_BUTTON)

	$bSuccess = ControlSetText( $hFilterWindow, '', $POKERSTARS_INPUT_FILTER, $aFilter[0])
	If $bSuccess Then
		TrayTip("Filter beállítva", $aFilter[0], 3000, 1)
	Else
		TrayTip("Filter beállítás sikertelen", "Nem sikerült beállítani a filtert: " & $aFilter[0], 3000, 3)
	EndIf
EndFunc

Func _PokerStars_GetTournamentId($sTableTitle)
	$aMatches = StringRegExp($sTableTitle, $POKERSTARS_TOURNAMENT_TABLES_REGEXP, 1)
	If Not @error Then
		Return $aMatches[0]
	Else
		SetError(@error)
		Return False
	EndIf

EndFunc