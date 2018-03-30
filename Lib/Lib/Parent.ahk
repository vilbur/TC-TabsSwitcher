
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
	_RootInfo()
	{
		;MsgBox,262144,, _RootInfo,2 
		return % this.Parent()._RootInfo
	}
	/**
	 */
	_Root($root)
	{
		;MsgBox,262144,, _Root,2 
		return % this._RootInfo().getRoot($root)
	}
	/**
	 */
	_Tabfiles($root, $Tabfiles)
	{
		return % this._Root($root).getTabfiles($Tabfiles)
	}
	/**
	 */
	_TargetInfo()
	{
		return % this.parent()._TargetInfo 
	}
	/**
	 */
	shit()
	{
		MsgBox,262144,, shit,2 
	}
	
}



