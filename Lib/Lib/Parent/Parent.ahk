
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
	_Tabset($tabset_name)
	{
		;MsgBox,262144,, _Tabset,2 
		return % this._Tabsets().getTabset($tabset_name)
	}
	/**
	 */
	_TabsGroup($tabset_name, $tabsgroup_name)
	{
		return % this._Tabset($tabset_name).getTabsGroup($tabsgroup_name)
	}
	/**
	 */
	_Tabfile($tabset_name, $tabsgroup_name, $tabfile_name)
	{		
		return % this._TabsGroup($tabset_name, $tabsgroup_name).getTabFile($tabfile_name)
	}
	
	/**
	 */
	_TargetInfo()
	{
		return % this.parent()._TargetInfo 
	}

	
}



