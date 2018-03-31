
/** Class Parent
*/
Class Parent
{
	/** set\get parent class
	 * @return object parent class
	*/
	Parent($Parent:=""){
		if($Parent)
			this._Parent	:= &$Parent
		return % $Parent ? this : Object(this._Parent)
	}
	
	/**
	 */
	_Tabsets()
	{
		;MsgBox,262144,, _Tabsets,2 
		return % this.Parent()._Tabsets
	}
	/**
	 */
	_Tabset($Tabset)
	{
		;MsgBox,262144,, _Tabset,2 
		return % this._Tabsets().getTabset($Tabset)
	}
	/**
	 */
	_TabsGroup($Tabset, $tabsgroup)
	{
		return % this._Tabset($Tabset).getTabsGroup($tabsgroup)
	}
	/**
	 */
	_TargetInfo()
	{
		return % this.parent()._TargetInfo 
	}

	
}



