#include-once

; #INDEX# =======================================================================================================================
; Title .........: PokerStars Constants
; AutoIt Version : 3.8.8.1
; Description ...: PokerStars Constants describes buttons, controls, table titles, etc...
;				   Use with PokerStars UDF
; Author(s) .....: Walkman
; ===============================================================================================================================

; #CONSTANTS# ===================================================================================================================
Global Const $POKERSTARS_VERSION = '8.6.8.9'
Global Const $POKERSTARS_PROCESSNAME = 'PokerStars.exe'

; Window and table lasses
Global Const $POKERSTARS_WINDOW_CLASS = '[CLASS:#32770]'
Global Const $POKERSTARS_LOBBY = '[TITLE:PokerStars Lobby; CLASS:#32770]'
Global Const $POKERSTARS_LOBBY_LOGGED_IN = '[TITLE:PokerStars Lobby - Logged in as ; CLASS:#32770]'
Global Const $POKERSTARS_CASHIER = '[TITLE:Cashier; CLASS:#32770]'
Global Const $POKERSTARS_WINDOW_REGISTER = '[TITLE:Tournament Registration; CLASS:#32770]'
Global Const $POKERSTARS_TOURNAMENT_TABLES = '[REGEXPTITLE:^\$.*Tournament; CLASS:PokerStarsTableFrameClass]'
Global Const $POKERSTARS_TOURNAMENT_TABLES_REGEXP = '(?<=Tournament )[0-9]*'	; lookbehind regexp, only the tournament id is returned
Global Const $POKERSTARS_TOURNAMENT_LOBBIES = '[REGEXPTITLE:^Tournament [0-9]* Lobby; CLASS:#32770]'
Global Const $POKERSTARS_WINDOW_FILTER = "[REGEXPTITLE:^$; CLASS:#32770]"   ; Filter Window has empty title. This will not find PokerStars Lobby, but find Filter window

; TODO: convert to hex value
Global Const $POKERSTARS_WINDOW_DEFAULT_GWL_STYLE = 382664704

Global Const $POKERSTARS_TAB_CHAT = '[CLASS:PokerStarsChatClass; INSTANCE:1]'
Global Const $POKERSTARS_TAB_INFO = '[CLASS:PokerStarsFrameClass; INSTANCE:2]'
Global Const $POKERSTARS_TAB_NOTES = '[CLASS:PokerStarsNoteEditorClass; INSTANCE:1]'
Global Const $POKERSTARS_TAB_NOTES_SELECTOR = '[CLASS:PokerStarsNoteSelectorClass; INSTANCE:1]'
Global Const $POKERSTARS_TAB_NOTES_NAME = '[CLASS:Edit; INSTANCE:1]'
Global Const $POKERSTARS_TAB_NOTES_DATE = '[CLASS:PokerStarsNoteDateControlClass; INSTANCE:1]'
Global Const $POKERSTARS_TAB_STATS = '[CLASS:PokerStarsFrameClass; INSTANCE:3]'

; Buttons and controls. These often change on updates
Global Const $POKERSTARS_BUTTON_CASHIER = '[CLASS:PokerStarsButtonClass; INSTANCE:1]'
Global Const $POKERSTARS_BUTTON_LOGIN = '[CLASS:PokerStarsButtonClass; INSTANCE:2]'
Global Const $POKERSTARS_BUTTON_REGISTER = '[CLASS:PokerStarsButtonClass; INSTANCE:146]'
Global Const $POKERSTARS_BUTTON_REGISTER_OK = '[CLASS:PokerStarsButtonClass; INSTANCE:1]'
Global Const $POKERSTARS_BUTTON_UNREGISTER = '[CLASS:PokerStarsButtonClass; INSTANCE:145]'
Global Const $POKERSTARS_BUTTON_REGISTER_TO_ANY = '[CLASS:PokerStarsButtonClass; INSTANCE:9]'
Global Const $POKERSTARS_BUTTON_TOURNEY_LOBBY = '[CLASS:PokerStarsButtonClass; INSTANCE:11]'
Global Const $POKERSTARS_BUTTON_OBSERVE_TABLE = '[CLASS:PokerStarsButtonClass; INSTANCE:6]'

Global Const $POKERSTARS_INPUT_FILTER = "[CLASS:PokerStarsFilterClass; INSTANCE:1]"  ; First control in the window
Global Const $POKERSTARS_BUTTON_SIT_AND_GO_FILTER = '[CLASS:PokerStarsButtonClass; INSTANCE:34]'
Global Const $POKERSTARS_BUTTON_FILTER_RESET = '[CLASS:PokerStarsButtonClass; INSTANCE:2]'
Global Const $POKERSTARS_BUTTON_FILTER_IS_ON = '[CLASS:PokerStarsButtonClass; INSTANCE:3]'
Global Const $POKERSTARS_BUTTON_FILTER_IS_OFF = '[CLASS:PokerStarsButtonClass; INSTANCE:4]'

Global Const $POKERSTARS_CHECKBOX_SHOW_RUNNING = '[CLASS:Button; INSTANCE:50]'
Global Const $POKERSTARS_CHECKBOX_SHOW_COMPLETED = '[CLASS:Button; INSTANCE:51]'

Global Const $POKERSTARS_LIST_TOURNAMENTS = '[CLASS:PokerStarsListClass; INSTANCE:1]'
Global Const $POKERSTARS_SLIDER_BET = '[CLASS:PokerStarsSliderClass; INSTANCE:1]'
Global Const $POKERSTARS_SLIDER_BET_EDITOR = '[CLASS:PokerStarsSliderEditorClass; INSTANCE:1]'

; Texts
Global Const $POKERSTARS_TEXT_OK = 'OK'
Global Const $POKERSTARS_TEXT_FILTER_IS = 'Filter is'
Global Const $POKERSTARS_TEXT_FILTER_IS_ON = 'Filter is On'
Global Const $POKERSTARS_TEXT_FILTER_IS_OFF = 'Filter is Off'
Global Const $POKERSTARS_TEXT_FILTER_WINDOW = 'Help' & @LF & 'Reset' & @LF  & 'Filter is ' ; 'On' or 'Off' doesn't matter
Global Const $POKERSTARS_TEXT_LOGGED_IN = 'Logged in as'
Global Const $POKERSTARS_TEXT_CASHIER = 'Cashier' & @LF
Global Const $POKERSTARS_TEXT_REGISTER = 'Register' & @LF	; If not LF at the end, 'register to any is also found'
Global Const $POKERSTARS_TEXT_UNREGISTER = 'Unregister' & @LF
; TODO: MAY NOT WORK !! NOT TESTED YET
Global Const $POKERSTARS_TEXT_SHOWLOBBY = 'Show Lobby' & @LF & 'Close' & @LF & @LF

; Menus [id, name]
Global Const $POKERSTARS_MENU_LOBBY[2]        = [0, '&Lobby']
Global Const $POKERSTARS_MENU_ACCOUNT[2]      = [1, '&Account']
Global Const $POKERSTARS_MENU_CASHIER[2]      = [2, '&Cashier']
Global Const $POKERSTARS_MENU_LANGUAGE[2]     = [3, 'La&nguage']
Global Const $POKERSTARS_MENU_REQUESTS[2]     = [4, '&Requests']
Global Const $POKERSTARS_MENU_OPTIONS[2]      = [5, '&Options']
Global Const $POKERSTARS_MENU_VIEW[2]         = [6, '&View']
Global Const $POKERSTARS_MENU_POKER_SCHOOL[2] = [7, 'Poker School']
Global Const $POKERSTARS_MENU_HELP[2]         = [8, '&Help']

; Menu items [id, name]
Global Const $POKERSTARS_MENUITEM_CASHIER[2]             = [2, 'Cashier...	Ctrl+4']
Global Const $POKERSTARS_MENUITEM_APPLY_ACTIVE_LAYOUT[2] = [15, 'Apply Active Layout']
Global Const $POKERSTARS_MENUITEM_FIND_A_PLAYER[2]       = [13, 'Find a Player...']

; PokerStars default HotKeys
Global Const $POKERSTARS_HOTKEY_CASHIER = '^4'
Global Const $POKERSTARS_HOTKEY_LOGIN = '^L'

Global Const $POKERSTARS_HOTKEY_FIND_A_PLAYER = '^F'
Global Const $POKERSTARS_HOTKEY_FIND_A_TEAM_POKERSTARS_PLAYER = '^P'
Global Const $POKERSTARS_HOTKEY_FIND_A_TOURNAMENT = '^T'

Global Const $POKERSTARS_HOTKEY_REGISTERED_IN_TOURNAMENTS = '^R'
Global Const $POKERSTARS_HOTKEY_WAITING_ON_TABLES = '^Y'
Global Const $POKERSTARS_HOTKEY_DISPLAY_INSTANT_HAND_HISTORY = '^I'

Global Const $POKERSTARS_HOTKEY_MUCK_LOSING_HANDS = '^U'
Global Const $POKERSTARS_HOTKEY_MUCK_DONT_SHOW_WINNING_HANDS = '^D'
Global Const $POKERSTARS_HOTKEY_MUCK_DONT_SHOW_WHEN_FOLDING_LAST = '^O'

Global Const $POKERSTARS_HOTKEY_RESET_TO_DEFAULT_SIZE = '^B'
Global Const $POKERSTARS_HOTKEY_TILE_TABLES = '^9'
Global Const $POKERSTARS_HOTKEY_CASCADE_TABLES = '^0'
Global Const $POKERSTARS_HOTKEY_STACK_TABLES = '^8'
Global Const $POKERSTARS_HOTKEY_APPLY_ACTIVE_LAYOUT = '^3'
Global Const $POKERSTARS_HOTKEY_DETACHED_CHAT = '^2'
