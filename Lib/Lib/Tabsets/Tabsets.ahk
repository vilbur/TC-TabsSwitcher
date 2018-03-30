/** Class Tabsets
*/
Class Tabsets Extends Parent
{
	_tabs_path	:= ""
	_Tabsets	:= {}		
	;_Example 	:= new Example()	

	loadTabsets()
	{
		;MsgBox,262144,, loadTabsets,2 
		this._tabs_path	:= getTabsPath()	
		;this._setTabsPath()
		this._setTabfiles()
	}
	/**
	 */
	isAnyTabsetExists()
	{
		return % this._Tabsets.GetCapacity() != 0
	}
	/**
	 */
	createTabset( $path, $name )
	{
		this._Tabsets[$name] := new Tabset(this._tabs_path).path( $path ).name( $name ).create()
		;MsgBox,262144,, createTabset,2 
	}
	/**
	 */
	getTabset($Tabset)
	{
		return % this._Tabsets[$Tabset]
	}

	;/** _setTabsPath
	; */
	;_setTabsPath()
	;{
	;	IniRead, $tabs_path, %$ini_path%, paths, tabs 
	;	this._tabs_path	:= $tabs_path
	;}
	 
	/**
	 */
	_setTabfiles()
	{
		;Dump(this._tabs_path, "this._tabs_path", 1)
		
		loop, % this._tabs_path "\*.*", 2
			this._Tabsets[A_LoopFileName] := new Tabset(this._tabs_path).name(A_LoopFileName).init()

			;this._setTabfilesData(A_LoopFileName)
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

