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
		;this.Tabsets().Callback($Event, this._getGuiData())
		if( $Event.value == "Add" )
			MsgBox,262144,, Test,2 
				
		;else if( $Event.value == "Remove" )
			;this._Callback.delete( this.Tabset($data.tabset) )		
	}
	/** 
	 */
	_DD_TabfileChanged( $Event )
	{
		$data	:= this._getGuiData()
		MsgBox,262144,, _DD_TabfileChanged,2 
		;this.Tabfile($data.tabset, $data.tabsgroup, $data.tabfile).Callback($Event, $data)
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

