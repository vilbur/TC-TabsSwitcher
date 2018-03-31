/** Callbacks for controls
 *
 *
 */
Class GuiCallback Extends Parent
{

	/**
	 */
	_TabfilesChanged( $Event )
	{
		$data	:= this._getGuiData()
			
		this.updateTabNamesLookUp( $data )
		
		this._getActiveTab().Controls
							.get("TabsList")
								.clear()
								.edit( this._Tabfiles( $data.tabset, $data.tabfiles ).getTabFilenames() )
								.select( 1 )
	}
	/**
	 */
	_tablistChanged( $Event )
	{
		$data	:= this._getGuiData()
		this.updateTabNamesLookUp( $data )
	}
	

}

