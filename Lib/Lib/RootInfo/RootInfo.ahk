/** Class RootInfo
*/
Class RootInfo Extends Parent
{
	_tabs_path	:= ""
	_Roots	:= {}		
	;_Example 	:= new Example()	

	loadRoots(){
		this._tabs_path	:= getTabsPath()	
		;this._setTabsPath()
		this._setTabsets()
	}
	/**
	 */
	isAnyRootExists()
	{
		return % this._Roots.GetCapacity() != 0
	}
	/**
	 */
	createRoot( $path, $name )
	{
		this._Roots[$name] := new Root(this._tabs_path).root( $path ).name( $name ).create()
		;MsgBox,262144,, createRoot,2 
	}
	/**
	 */
	getRoot($root)
	{
		return % this._Roots[$root]
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
	_setTabsets()
	{
		Dump(this._tabs_path, "this._tabs_path", 1)
		
		loop, % this._tabs_path "\*.*", 2
		{
			Dump(A_LoopFileName, "A_LoopFileName", 1)
			this._Roots[A_LoopFileName] := new Root(this._tabs_path).name(A_LoopFileName).init()
		}
			;this._setTabsetData(A_LoopFileName)
	}

	
	/*---------------------------------------
		GET TABSTES DATA
	-----------------------------------------
	*/
	/**
	 */
	_getTabsetsNames()
	{
		return % getObjectKeys(this._Roots) 
	}

	
}

