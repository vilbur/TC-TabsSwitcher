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
	getCurrentTabs( $pane )
	{
		IniRead, $tabs, % this._wincmd_ini, %$pane% 
			Loop Parse, $tabs, `n
				if( ! InStr( A_LoopField, "activelocked" ) && ! InStr( A_LoopField, "activecaption" ) )
					$tabs_string .= A_LoopField "`n"
					
		return $tabs_string
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




















