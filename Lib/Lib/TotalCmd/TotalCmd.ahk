/** Class Gui
 *
 */
Class TotalCmd Extends Parent
{
	_TcPane 	:= new TcPane().setActivePane()
	_tc_has_focus	:= false
	_wincmd_ini	:= ""
	
	__New()
	{
		$wincmd_ini	= %Commander_Path%\wincmd.ini		
		this._wincmd_ini	:= $wincmd_ini
	}
	
	/**
	 */
	activePane()
	{
		return this._TcPane.getActivePane()
	}
	/**
	 */
	getDir($pane:="source")
	{
		$path := $pane=="source" ? this._TcPane.getSourcePath() : this._TcPane.getTargetPath()
		
		SplitPath, $path, $dir_name

		return $dir_name
	}
	/**
	 */
	totalCommanderHasFocus()
	{
		this._tc_has_focus := true
	}
	/**
	 */
	tabsSwitcherHasFocus()
	{
		if( ! this._tc_has_focus )
			return
		
		this._TcPane.setActivePane()
		
		this.Parent()._Gui._TEXT_update()
		
		this._tc_has_focus := false
	}
	/**
	 */
	watchTotalCommanderWindow()
	{
		Gui +LastFound 
		$Hwnd := WinExist()
		DllCall( "RegisterShellHookWindow", UInt, $Hwnd )
		$MsgNum := DllCall( "RegisterWindowMessage", Str,"SHELLHOOK" )
		OnMessage( $MsgNum, "onWindowChange" )
	}
	/** get curretn tabs from ini
	 */
	getTabs( $pane )
	{
		this._TcPane.saveConfig()

		$tabs := {}
		
		IniRead, $tabs_ini, % this._wincmd_ini, %$pane%
		{			
			Loop Parse, $tabs_ini, `n
				this._setTab( $tabs, A_LoopField )
					
			this._setActiveTabCaptions( $tabs )
		}
		return stringifyObject($tabs)
	}
	/**
	 */
	_setTab( ByRef $tabs, $ini_line )
	{
		$key_value	:= StrSplit( $ini_line, "=")
		$tabs[$key_value[1]]	:= $key_value[2]
	}
	/**
	 */
	_setActiveTabCaptions( ByRef $tabs )
	{
		if( ! $tabs.activecaption )
			return 
		
		$tabs[$tabs.activetab "_caption"] := $tabs.activecaption
		
		$tabs.delete("activecaption")
		$tabs.delete("activelocked")		
	}

	
	
}

/** On window changed callback
  */
onWindowChange( $wParam, $lParam )
{
	WinGetTitle, $title, ahk_id %$lParam%
	WinGetClass, $class, ahk_id %$lParam%

	If ( $class=="TTOTAL_CMD" )
		$TabsSwitcher.TotalCmd().totalCommanderHasFocus()
		
	else if ( $title=="TabsSwitcher" )
		$TabsSwitcher.TotalCmd().tabsSwitcherHasFocus()
}




















