/** Class TabsLoader
*/
Class TabsLoader
{
	_usercmd_ini	:= "" ; save commands
	_wincmd_ini	:= "" ; set keyboard shortcuts
	_cmd_load_tabs	:= "em_TabsSwitcher_load-tabs"
	;_cmd_run_tabswitcher	:= "em_TabsSwitcher_run"	

	/** _setTabsPath
	 */
	__New()
	{
		$_wincmd_ini	= %Commander_Path%\wincmd.ini
		$_usercmd_ini	= %Commander_Path%\usercmd.ini		
		this._wincmd_ini	:= $_wincmd_ini
		this._usercmd_ini	:= $_usercmd_ini		
	}
	/** load tabs file
	 */
	loadTabs( $tab_file_path )
	{
		;this.createCommandRunTabSwitcher()
		this._editCommandLoadTabs("OPENTABS """ $tab_file_path """")
		this._createShortcut()
		this._executeShortcut()
	} 
	/** Edit command in wincmd.ini
		This command is loadnig tab files
	 */
	_editCommandLoadTabs( $open_tabs_cmd )
	{
		IniWrite, %$open_tabs_cmd%, % this._usercmd_ini, % this._cmd_load_tabs, cmd
	}
	
	/** create command in wincmd.ini
	 */
	createCommandRunTabSwitcher()
	{
		$param := """%P\""" ; "
		IniWrite, % A_ScriptDir "\TabsSwitcher.ahk",	% this._usercmd_ini, % this._cmd_run_tabswitcher, cmd
		IniWrite, %$param%,	% this._usercmd_ini, % this._cmd_run_tabswitcher, param		
	}
	
	/** create keyboard shortcut to run this._cmd_load_tabs command
		create keyboard shortcut in section "ShortcutsWin"
		section "ShortcutsWin" runs keyboard shortcuts with win key 
	 */
	_createShortcut()
	{
		$keyboard_shortcut :=  ; Ctrl + alt + Shift
		this._setShortcutToIni( "ShortcutsWin", "CAS+F9", this._cmd_load_tabs )
	}
	/**
	  create command in Usercmd.ini
	 */
	_setShortcutToIni( $section, $key, $value )
	{
		IniWrite, %$value%, % this._wincmd_ini, %$section%, %$key%
	}
	
	/**
		https://autohotkey.com/docs/commands/WinExist.htm#function
	 */
	_executeShortcut()
	{
		$hwnd	:= WinExist("ahk_exe TOTALCMD64.EXE")
		if( ! $hwnd )
			$hwnd 	:= WinExist("ahk_exe TOTALCMD.EXE")
				
		if( $hwnd ){
			ControlSend,, {LWin down}{Ctrl down}{Alt down}{Shift down}{F9}{LWin up}{Ctrl up}{Alt up}{Shift up}, % "ahk_id " $hwnd
		}

	} 
	
}

