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
		
		$Tabset := new Tabset()
						.pathTarget( $path_target )
						.name( $name )
						.create()
						.createTabsGroup( "_shared" )

									
		this._Tabsets[$name] := $Tabset
		
		return $Tabset
	}
	/**
	 */
	getTabset($Tabset)
	{
		return % this._Tabsets[$Tabset]
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

