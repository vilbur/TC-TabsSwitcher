/** t for controls
 *
 *
 */
Class GuiControlsMethods Extends GuiCallback
{

	/**
	 */
	_getActiveTab()
	{
		return % this._gui.Tabs_Tabsets.getActive()		
	}
	/**
	 */
	_setDropdownItems($control_name, $items, $selected:="")
	{
		this._gui.Controls.get($control_name)
							.clear()
							.edit($items)
	} 
	/**
	 */
	_getControlValue($control_name)
	{
		return % this._gui.Controls.get($control_name).value()
	}
	/**
	 */
	_updateTabNamesLookUp( $data:="" )
	{
		;MsgBox,262144,, _updateTabNamesLookUp,2 
		if( !$data )
			$data	:= this._getGuiData()
		;Dump($data, "data", 1)
		$tabs_names := this._Tabfiles($data.tabset, $data.tabfilesset ).getTabsCaptions($data.tabs)
		;Dump($tabs_names, "tabs_names", 1)
		this._getActiveTab().Controls.get("TabNamesLookUp").edit( $tabs_names )
	}
	/**
	 */
	_focusTablist()
	{
		this._getActiveTab().Controls.get("LB_Tabfile").focus()		
	}
 

	

}

