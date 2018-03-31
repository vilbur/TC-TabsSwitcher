/** Callbacks for controls
 *
 *
 */
Class GuiCallback Extends Parent
{

	/**
	 */
	_LB_TabsGroupChanged( $Event )
	{
		$data	:= this._getGuiData()
		
		this._getActiveTab().Controls
							.get("LB_Tabfile")
								.clear()
								.edit( this._TabsGroup( $data.tabset, $data.tabsgroup ).getTabFilenames() )
								.select( 1 )
								
		this._updateTabNamesLookUp()
	}
	/**
	 */
	_LB_TabfileChanged( $Event )
	{
		$data	:= this._getGuiData()
		
		this._updateTabNamesLookUp()
	}
	

}

