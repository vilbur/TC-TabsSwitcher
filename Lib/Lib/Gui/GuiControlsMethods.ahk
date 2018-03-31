/** methods for controls
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
	_updateTabNamesLookUp()
	{
		$data	:= this._getGuiData()
		
		$Tabfile := this._Tabfile($data.tabset, $data.tabsgroup, $data.tabs )

		if( $Tabfile )
			this._getActiveTab().Controls.get("TabsNameLookUp").edit( $Tabfile.getTabsCaptions() )			
	}
	/**
	 */
	_focusTablist()
	{
		this._getActiveTab().Controls.get("LB_Tabfile").focus()		
	}
 

	

}

