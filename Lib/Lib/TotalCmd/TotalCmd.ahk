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
	
	
	/*---------------------------------------
		TABS
	-----------------------------------------
	*/

	/** get curretn tabs from ini
	 */
	getTabs( $side )
	{
		$tabs := this._TcPane.TcTabs().getTabs($side)
		
		return % this.stringifyTabs($tabs) "`nactivetab=" $tabs.activetab
	}
	/**
	 */
	stringifyTabs($tabs)
	{
		For $index, $tab in $tabs 
			$tabs_string .= this.stringifySingleTab($index, $tab) "`n"

		return % SubStr( $tabs_string, 1, StrLen($tabs_string) -2 )
		;return % $tabs_string	
	}
	
	/**
	 */
	stringifySingleTab($index ,$tabs)
	{
		For $key, $value in $tabs
			$string .= $index "_" $key "=" $value "`n"
		
		return % SubStr( $string, 1, StrLen($string) -2 )
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




















