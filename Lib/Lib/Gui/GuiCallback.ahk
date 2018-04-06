/** Callbacks for controls
 *
 *
 */
Class GuiCallback Extends Parent
{
	_MsgBox 	:= new MsgBox()
	
	/*---------------------------------------
		DROPDOWNS
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
	_LB_TabsGroupChanged( $Event )
	{
		$data	:= this._getGuiData()
		
		this._getActiveTab().Controls
							.get("LB_Tabfile")
								.clear()
								.edit( this.TabsGroup($data.tabset, $data.tabsgroup ).getTabFilenames() )
								;.checked( this.Tabset($data.tabset).getLast("tabfile") )					
								.select( 1 )
		
		this._editTabsgroupListBox($data)
		this._updateTabNamesLookUp()
	}
	/**
	 */
	_LB_FoldersListChanged( $Event )
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

