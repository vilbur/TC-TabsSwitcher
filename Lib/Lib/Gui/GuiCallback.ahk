/** Callbacks for controls
 *
 */
Class GuiCallback Extends GuiCallbackMethods
{
	/**
	 */
	_BTN_TEST()
	{
		$data	:= this._getGuiData()
		Dump($data, "data", 1)
	}
	/*---------------------------------------
		TABS
	-----------------------------------------
	*/
	/**
	 */
	GUI_AddNewTabsSubmit($Event, $tabset, $tabsgroup)
	{
		;$Event.message(50)

		$tabs	:= {}		
		$form_data	:= $Event.data
		$active_pane	:= this.TotalCmd().activePane() "tabs"
		
		if( $form_data.lefttabs )
			$tabs.lefttabs := ""
			
		if( $form_data.righttabs )
			$tabs.righttabs := ""	
		
		;MsgBox,262144,, % $tabs.GetCapacity(),2 
		

		if( $tabs.GetCapacity()>0 && $form_data.tabfile )
		{
			this.new_tabs.close()
			
			For $pane, $s in $tabs
				if( $form_data[$pane] )
					$tabs[$pane] := this.TotalCmd().getTabs($pane "")
			
			;$tabs_active	:= $tabs[$active_pane]
			;$tabs_inactive	:= $tabs[$active_pane=="lefttabs"?"righttabs":"lefttabs"]		
			;Dump($tabs, "tabs", 1)
			
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
	_DD_TabsetsChanged($Event)
	{		
		if( $Event.value == "Add" )
			this._tabsetAddNew()
				
		else if(  $Event.value == "Remove" )
			this._tabsetAddRemove()
	}	
	/**
	 */
	_DD_TabsetRootChanged($Event)
	{
		;this._gui.alwaysOnTop(false)
	
		$data	:= this._getGuiData()

		if( $Event.value == "Add" )
			this._tabsRootCreate( $data )
		
		else if( $Event.value == "Remove" )
			this._tabsRootRemove( $data )
	}
	/** 
	 */
	_DD_TabsGroupChanged( $Event )
	{
		if( $Event.value == "Add" )
			this["_tabsgroup" $Event.value]()
				

	}
	/** 
	 */
	_DD_TabfileChanged( $Event )
	{
		this["_tabfile" $Event.value]()
	}
	
	/*---------------------------------------
		LISTBOX
	-----------------------------------------
	*/
	/**
	 */
	_LB_TabsetRootChanged( $Event )
	{
		$data	:= this._getGuiData()

		if( $data.tabsgroup=="_shared" )
			this._updateFolderList( $data )			
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

