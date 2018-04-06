/** Callbacks for controls
 *
 *
 */
Class GuiCallback Extends Parent
{
	_MsgBox 	:= new MsgBox()
	
	/**
	 */
	_BTN_TEST()
	{
		;MsgBox,262144,, Test,2
		$data	:= this._getGuiData()
		Dump($data, "data", 1)
		
		;this._getActiveTab().Controls
		;					;.get("R_replace.Folder")
		;					.get("R_replace.Root")							
		;					.edit(0)

				
		;this._getActiveTab().Controls.get("LB_TabsGroup").select(0)		
		;this._LB_unselect("LB_TabsGroup")
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
		;Dump($data, "data", 1)
		;Dump($data.tabset, "data.tabset", 1)				
		;Dump($data.tabsetroot, "data.tabsetroot", 1)
		;
		;Dump( this.Tabset($data.tabset )._getTabsRootFolders( $data.tabsetroot ) , "data", 1)

		if( $data.tabsgroup ) ; do not update if switching between radio buttons
		{
			this._LB_unselect("LB_TabsGroup")
			this._LB_set( "LB_Folder", this.Tabset($data.tabset )._getTabsRootFolders( $data.tabsetroot ), 1 )
			this._LB_set( "LB_Tabfile", this.TabsGroup($data.tabset, "_shared" ).getTabFilenames() , 1 )

		}
			
	}
	
	/*---------------------------------------
		DROPDOWN
	-----------------------------------------
	*/
	/**
	 */
	_DD_TabsetTypeChanged($Event)
	{
		this._gui.alwaysOnTop(false)
		
		if( $Event.value == "unique file" )
			FileSelectFile, $output, 32, A_WorkingDir, Select unique file in tree
		else
			FileSelectFolder, $output, % "*"  A_WorkingDir, 0, Select unique folder in tree			
		
		if( $output )
			this._EDIT_TabsetTypeEdit($Event.value, $output)

		this._gui.alwaysOnTop()
	}
	/** 
	 */
	_DD_TabsetsChanged( $Event )
	{
		this.Tabsets().Callback($Event, this._getGuiData())
	}
	/** 
	 */
	_DD_TabfileChanged( $Event )
	{
		$data	:= this._getGuiData()

		this.Tabfile($data.tabset, $data.tabsgroup, $data.tabfile).Callback($Event, $data)
	}
	
	/*---------------------------------------
		LISTBOX
	-----------------------------------------
	*/
	/**
	 */
	_LB_TabssetRootChanged( $Event )
	{
		$data	:= this._getGuiData()
		;Dump($data, "data", 1)
		
		this._LB_set( "LB_Folder", this.Tabset($data.tabset)._getTabsRootFolders($data.tabsetroot), 1 )


		;this._editTabsgroupListBox($data)
		;this._updateTabNamesLookUp()
	}
	/**
	 */
	_LB_TabsGroupChanged( $Event )
	{
		this._R_replaceUnselect()

		$data	:= this._getGuiData()
		
		this._LB_set( "LB_Tabfile", this.TabsGroup($data.tabset, $data.tabsgroup ).getTabFilenames() , 1 )
		
		this._editTabsgroupListBox($data)
		this._updateTabNamesLookUp()
	}
	/**
	 */
	_LB_FolderChanged( $Event )
	{
		if( $Event.type=="DoubleClick" )
			this.Parent().loadTabs()
	}
	/**
	 */
	_LB_TabfileChanged( $Event )
	{
		$data	:= this._getGuiData()
		$control_key	:= GetKeyState("control", "P")
		
		if( $Event.type=="DoubleClick" ){
			if( $control_key )
				this.Parent().openTabs()			
			else
				this.Parent().loadTabs()
		}
		else		
			this._updateTabNamesLookUp()
	}
	

}

