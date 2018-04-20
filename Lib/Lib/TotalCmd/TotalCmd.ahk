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
	totalCommanderHasFocus( $Event )
	{
		If ( $Event.class=="TTOTAL_CMD" )
			this._tc_has_focus := true
	}
	/**
	 */
	tabsSwitcherHasFocus( $Event )
	{
		;$Event.message()
		if( ! this._tc_has_focus )
			return
			

		;this.Parent()._Gui._gui.redraw(false)
		;sleep,500
		this._TcPane.setActivePane()
		
		this.Parent()._Gui._TEXT_update()
		
		this._tc_has_focus := false
		
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
		
		return % this.stringifyTabs($tabs) "activetab=" $tabs.activetab
	}
	/**
	 */
	stringifyTabs($tabs)
	{
		For $index, $tab in $tabs 
			$tabs_string .= this.stringifySingleTab($index, $tab) 

		return % $tabs_string	
	}
	
	/**
	 */
	stringifySingleTab($index ,$tabs)
	{
		For $key, $value in $tabs
			$string .= $index "_" $key "=" $value "`n"
		
		return $string
	}
	
	/** Set Total commander window title by loaded tabs
	  * IF TABSGROUP DEFINED:
	  *		"Tabs-Group: TabFile"
	  *
	  * IF TABS ARE SHARED:
	  *		"Root-Folder: TabFile"
	 */
	_setWindowTitleByTabs($data, $options)
	{
		if( ! $options.title )
			return
		
		$title := ( $data.tabsgroup != "_shared" ? $data.tabsgroup : $data.folder ) ": " $data.tabfile
		
		 this._TcPane.title( $title )			
	} 
}

















