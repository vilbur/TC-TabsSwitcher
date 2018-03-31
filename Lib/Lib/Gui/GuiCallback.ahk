/** Callbacks for controls
 *
 *
 */
Class GuiCallback Extends Parent
{

	/**
	 */
	_LB_TabfilesSetChanged( $Event )
	{
		$data	:= this._getGuiData()
		;Dump($data, "data", 1)
		
		this._updateTabNamesLookUp( $data )
		
		
		this._getActiveTab().Controls
							.get("LB_Tabfile")
								.clear()
								.edit( this._TabfilesSet( $data.tabset, $data.tabfilesset ).getTabFilenames() )
								;.edit( "TEST" )								
								.select( 1 )
	}
	/**
	 */
	_LB_TabfileChanged( $Event )
	{
		$data	:= this._getGuiData()
		this._updateTabNamesLookUp( $data )
	}
	

}

