/** Callbacks for controls
 *
 */
Class GuiCallback Extends GuiCallbackMethods
{
	/**
	 */
	_BTN_TEST()
	{
		;$data	:= this._getGuiData()
		;Dump($data, "data", 1)
		
		MsgBox,262144,listbox_new, % "root_tabset: " this._last_focused_listbox.root_tabset "`n`nfolder_tabfile: " this._last_focused_listbox.folder_tabfile,5

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
		;$active_pane	:= this.TotalCmd().activePane() "tabs"

		if( $form_data.left )
			$tabs.left := ""
			
		if( $form_data.right )
			$tabs.right := ""	

		;Dump($form_data, "form_data", 1)	
		if( $tabs.GetCapacity()>0 && $form_data.tabfile )
		{
			this.new_tabs.close()
			
			For $pane, $s in $tabs
				if( $form_data[$pane] )
					$tabs[$pane] := this.TotalCmd().getTabs($pane)
			
			this.TabsGroup( $tabset, $tabsgroup ).createNewTabfile($tabs, $form_data.tabfile)
			
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

}

