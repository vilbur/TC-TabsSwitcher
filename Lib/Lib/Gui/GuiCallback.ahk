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

