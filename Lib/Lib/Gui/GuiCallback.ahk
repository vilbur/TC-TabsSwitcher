/** Callbacks for controls
 *
 */
Class GuiCallback Extends GuiCallbackMethods
{
	/**
	 */
	_TEST()
	{
		MsgBox,262144,, Callback Test,2 		
		;MsgBox,262144,listbox_new, % "root_tabset: " this._last_focused_listbox.root_tabset "`n`nfolder_tabfile: " this._last_focused_listbox.folder_tabfile,5

	}
	/*---------------------------------------
		GUI
	-----------------------------------------
	*/

	/**
	 */
	GUI_AddNewTabsSubmit($Event, $tabset, $tabsgroup)
	{
		$tabs	:= {}		
		$form_data	:= $Event.data
		$tab_filename	:= $form_data.tabfile

		if( $tab_filename && ( $form_data.left || $form_data.right ) )
		{
			this.new_tabs.close()
			
			$TabsGroup	:= this.TabsGroup( $tabset, $tabsgroup )
			$tab_file_path	:= $TabsGroup.getTabFilePath($tab_filename)
			
			;MsgBox,262144,tab_file_path, %$tab_file_path%,3 
			this.TotalCmd()._TcTabs.save($tab_file_path)
	
			$TabsGroup.setTabFile($tab_filename, $tab_file_path)
			
		} else
			MsgBox,262144,MISSING FIELDS, Fill tabs name and at least one side of tabs, 10 
	}
	/*---------------------------------------
		TABS
	-----------------------------------------
	*/
	/**
	 */
	_TAB_SelectByNumber( $Event )
	{
		$Tabs	:= this._gui.Tabs_Tabsets
		$Tabs.select( $Event.key )
	}
	/**
	 */
	_TabsChanged( $Event )
	{
		this._TEXT_update()
	}	
	/*---------------------------------------
		RADIO
	-----------------------------------------
	*/
	/**
	 */
	_R_replaceChanged( $Event )
	{
		$data	:= this._getGuiData()

		if(  $data.tabsgroup!="_shared" ) ; do not update if switching between radio buttons
			this._tabsGroupUnselect($data)
		
		this._TEXT_update()
	}
	/*---------------------------------------
		DROPDOWN
	-----------------------------------------
	*/
	
	/**
	 */
	_DD_Changed($Event, $control_name)
	{		
		this["_" $control_name $Event.value](this._getGuiData())
	}

	/*---------------------------------------
		LISTBOX
	-----------------------------------------
	*/
	/**
	 */
	_LB_ToggleRootsAndTabset( $Event, $listbox_name )
	{
		this._LB_focus(  this._last_focused_listbox.root_tabset=="LB_TabsetRoot" ? "LB_TabsGroup" : "LB_TabsetRoot" )
	}
	/**
	 */
	_LB_FoldersAndTabfile( $Event, $listbox_name )
	{
		this._LB_focus(  this._last_focused_listbox.folder_tabfile=="LB_Folder" ? "LB_Tabfile" : "LB_Folder" )
	}
	/**
	 */
	_LB_SelectNext( $Event )
	{
		$data	:= this._getGuiData()
		
		MsgBox,262144,, _LB_SelectNext,2 
		;if( $data.tabsgroup=="_shared" )
			;this._updateFolderList( $data )
		
		;if( $Event.type=="DoubleClick")
			;this.Parent().loadTabs()
	}
	/**
	 */
	_LB_TabsetRootChanged( $Event )
	{
		$data	:= this._getGuiData()
		
		if( $data.tabsgroup=="_shared" )
			this._updateFolderList( $data )
		
		if( $Event.type=="DoubleClick")
			this.Parent().loadTabs()
	}
	/**
	 */
	_LB_TabsGroupChanged( $Event )
	{
		if( $Event.type=="DoubleClick")
			return % this.Parent().loadTabs()
		
		$data	:= this._getGuiData()
		
		if( $data.tabsgroup!="_shared" )
			this._tabsGroupUpdateGui( $data )
			
		this._TEXT_update()
	}
	/**
	 */
	_LB_FolderChanged( $Event )
	{
		if( $Event.type=="LeftClick" )
			this._folderChanged($Event)
		
		else if( $Event.type=="DoubleClick")
			this.Parent().loadTabs()
	}
	/**
	 */
	_LB_TabfileChanged( $Event )
	{
		$control_key	:= GetKeyState("control", "P")
		
		if( $Event.type=="DoubleClick" ){
			if( $control_key )
				this.Parent().openTabs()			
			else
				this.Parent().loadTabs()
		}
		else
			this._tabfileSelected($Event)
	}


	/*---------------------------------------
		OPTIONS
	-----------------------------------------
	*/
	/** Set option to ini by options control
	 */
	_setOption($Event, $option)
	{		
		IniWrite, % $Event.value, %$ini_path%, options, %$option%
		
		this._options[$option] := $Event.value
		
		if( $option=="on_top" )
			this._gui.alwaysOnTop($Event.value)
		;MsgBox,262144,, OnTop,2 
			
		else if( $option=="center_window" && $Event.value)
			this._gui._centerToWindow()

	}
	
	
	
	
}

