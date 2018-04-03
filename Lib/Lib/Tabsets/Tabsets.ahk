/** Class Tabsets
*/
Class Tabsets Extends Parent
{
	_Callback	:= new TabsetsCallback()

	_tabs_path	:= ""
	_Tabsets	:= {}		

	/**
	 */
	loadTabsets()
	{
		loop, % $tabs_path "\*.*", 2
			this._Tabsets[A_LoopFileName] := new Tabset()
													.name(A_LoopFileName)
													.load()
	}
	/**
	 */
	isAnyTabsetExists()
	{
		return % this._Tabsets.GetCapacity() != 0
	}
	/**
	 */
	createTabset( $path_target, $name:="" )
	{
		if( ! $name )
			SplitPath, $path_target, $name
		
		this._Tabsets[$name] := new Tabset()
									.pathTarget( $path_target )
									.name( $name )
									.create()
									.createTabsGroup( "_shared" )
	}
	/**
	 */
	getTabset($Tabset)
	{
		return % this._Tabsets[$Tabset]
	}
	/**
	 */
	Callback($Event, $data)
	{
		if( $Event.value == "New" )
			this._Callback.new()
				
		else if( $Event.value == "Delete" )
			this._Callback.delete( this.Tabset($data.tabset) )

	}
	 
	/*---------------------------------------
		GET TABSTES DATA
	-----------------------------------------
	*/
	/**
	 */
	_getTabfilesNames()
	{
		return % getObjectKeys(this._Tabsets) 
	}

	
}

