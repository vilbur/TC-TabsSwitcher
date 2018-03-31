/** Callbacks for controls
 *
 *
 */
Class GuiCallback Extends Parent
{

	/**
	 */
	_tabfilesChanged( $Event )
	{
		$data	:= this._getGuiData()
			
		this._updateTabNamesLookUp( $data )
		
		this._getActiveTab().Controls
							.get("LB_TabsList")
								.clear()
								.edit( this._Tabfiles( $data.tabset, $data.tabfiles ).getTabFilenames() )
								.select( 1 )
	}
	/**
	 */
	_tablistChanged( $Event )
	{
		$data	:= this._getGuiData()
		this._updateTabNamesLookUp( $data )
	}
	

}

