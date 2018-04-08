/** Class Gui
 *
 */
Class TotalCmd
{
	_TcPane 	:= new TcPane().setActivePane()
	_tc_has_focus	:= false

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
		if( this._tc_has_focus )
			this._TcPane.setActivePane()
		
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
		OnMessage( $MsgNum, "onWIndowChange_ts" )
	} 
	
}

/** On window changed callback
  */
onWIndowChange_ts( $wParam, $lParam )
{
	WinGetTitle, $title, ahk_id %$lParam%
	WinGetClass, $class, ahk_id %$lParam%

	If ( $class=="TTOTAL_CMD" )
		$TabsSwitcher.TotalCmd().totalCommanderHasFocus()
		
	else if ( $title=="TabsSwitcher" )
		$TabsSwitcher.TotalCmd().tabsSwitcherHasFocus()
}




















