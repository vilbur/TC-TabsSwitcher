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

		if(  $data.tabsgroup!="_shared" ) ; do not update if switching between radio buttons
		{
			this._LB_unselect("LB_TabsGroup")
			this._LB_set( "LB_Folder", this._getTabsRootFolders( $data ), this._getLastFolder($data) )
			
			$data.tabsgroup := "_shared" 
			this._LB_set( "LB_Tabfile", this._getTabFilenames( $data ) , 1 )
		}
	}
	/*---------------------------------------
		DROPDOWN
	-----------------------------------------
	*/
	/**
	 */
	_DD_TabsetRootChanged($Event)
	{
		this._gui.alwaysOnTop(false)
		
		$data	:= this._getGuiData()

		if( $Event.value == "Add" )
			this.Tabset( $data.tabset )
					.createTabsRoot( this._MsgBox.Input("ADD NEW ROOT FOLDER", "Set path to new root ?" , {"w":720, "default":A_WorkingDir})  )
		
		else if( $Event.value == "Remove" )
			if( this._MsgBox.confirm("REMOVE ROOT", "Remove root ?`n`n" $data.tabsetroot ) )
				this.Tabset( $data.tabset ).removeTabsRoot( $data.tabsetroot )
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

		this.Tabfile($data.tabset, $data.tabsgroup, $data.tabfile).Callback($Event, $data)
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
		;Dump($data, "data", 1)
		if( $data.tabsgroup!="_shared" )
			return
			
		this._LB_set( "LB_Folder", this._getTabsRootFolders( $data ), this._getLastFolder($data) )
	}
	/**
	 */
	_LB_TabsGroupChanged( $Event )
	{
		$data	:= this._getGuiData()

		if( $data.tabsgroup=="_shared" )
			return
		
		this._R_replaceUnselect()
		
		this._LB_set( "LB_Tabfile", this._getTabFilenames( $data ) , 1 )
		
		this._LB_set( "LB_Folder" )
		
		this._TEXT_update()
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
			this._TEXT_update()
	}
	/*---------------------------------------
		HELPERS
	-----------------------------------------
	*/
	/**
	 */
	_getTabFilenames( $data )
	{
		return % this.TabsGroup($data.tabset, $data.tabsgroup ).getTabFilenames()
	} 
	/**
	 */
	_getTabsRootFolders( $data )
	{
		return % this.Tabset($data.tabset)._getTabsRootFolders($data.tabsetroot)
	}
	/**
	 */
	_getLastFolder( $data )
	{
		return % this.Tabset($data.tabset).getLastFolder($data.tabsetroot)
	}
	
}

