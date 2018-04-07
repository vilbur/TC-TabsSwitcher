/** methods for controls
 *
 *
 */
Class GuiControlsMethods Extends GuiCallback
{
	_last_selected_folders	:= {}
	
	/**
	 */
	_EDIT_TabsetTypeEdit( $tabset_type, $path)
	{
		$text_control := this._getActiveTab().Controls.get("EDIT_TabsetType")
		
		if( $tabset_type!="root folder" ){
			SplitPath, $path, $name
			$text_control.edit($name)
		}else if( $tabset_type=="" )
			$text_control.edit($path)
			
	}
	/*---------------------------------------
		TAB
	-----------------------------------------
	*/
	/**
	 */
	_getActiveTab()
	{
		return % this._gui.Tabs_Tabsets.getActive()		
	}
	/*---------------------------------------
		RADIO
	-----------------------------------------
	*/
	/**
	 */
	_R_replaceUnselect( )
	{
		$Radios := this._getActiveTab().Controls.get("R_replace")
		
		For $name, $addr in $Radios._buttons
			$Radios.get($name).edit(0)
	}
	
	/*---------------------------------------
		LISTBOX
	-----------------------------------------
	*/
	_LB_set( $listbox_name, $data:="", $select:=0 )
	{
		;MsgBox,262144,, _LB_fill,2
		$listbox := this._getActiveTab().Controls.get( $listbox_name )
		
		$listbox.clear()
		
		if( $data )
			$listbox.edit( $data )
			
		if( $select )
			$listbox.select( $select )
	}
	/**
	 */
	_LB_focus( $listbox_name, $select )
	{
		$listbox := this._getActiveTab().Controls.get($listbox_name)
		
		$listbox.focus()
		
		if( $select )
			$listbox.select($select)	
	}
	/**
	 */
	_LB_unselect($listbox_name )
	{
		this._getActiveTab().Controls.get($listbox_name).select(0)	
	}
	
	/*---------------------------------------
		DROPDOWN
	-----------------------------------------
	*/
	/**
	 */
	_setDropdownItems($control_name, $items, $selected:="")
	{
		this._gui.Controls.get($control_name)
							.clear()
							.edit($items)
	}
	
	/*---------------------------------------
		TEXT
	-----------------------------------------
	*/
	/**
	 */
	_TEXT_update()
	{
		$data	:= this._getGuiData()
		;MsgBox,262144,, Test,2 
		$Tabfile := this.Tabfile($data.tabset, $data.tabsgroup, $data.tabfile )

		;Dump($Tabfile.getTabsCaptions(), "Tabfile.getTabsCaptions()", 1)

		
		if( $Tabfile ){
			
			$TcPane	:= new TcPane()
			$tabs	:= $Tabfile.getTabsCaptions()
			;Dump($tabs, "tabs", 1)
			
			this._gui.Controls.get("TEXT_pane_" $TcPane.getPaneSide("source")).edit( $tabs.activetabs )
			this._gui.Controls.get("TEXT_pane_" $TcPane.getPaneSide("target")).edit( $tabs.inactivetabs )									
			
			
			;this._gui.Controls.get("TEXT_pane_left").edit()
			
		}
	}
	
	
	/*---------------------------------------
		HELPERS
	-----------------------------------------
	*/
	/**
	 */
	_getControlValue($control_name)
	{
		return % this._gui.Controls.get($control_name).value()
	}


	

}

