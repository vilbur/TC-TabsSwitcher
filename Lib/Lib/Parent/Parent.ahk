
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
	_TabfilesSet($Tabset, $tabfilesset)
	{
		return % this._Tabset($Tabset).getTabfilesSet($tabfilesset)
	}
	/**
	 */
	_TargetInfo()
	{
		return % this.parent()._TargetInfo 
	}

	
}



