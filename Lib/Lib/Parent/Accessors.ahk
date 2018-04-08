/** Accessors via Parent class
*/
Class Accessors
{

	/**
	 */
	Tabsets()
	{
		;MsgBox,262144,, _Tabsets,2 
		return % this.Parent()._Tabsets
	}
	/**
	 */
	Tabset($tabset_name)
	{
		return % this.Tabsets().getTabset($tabset_name)
	}
	/**
	 */
	TabsGroup($tabset_name, $tabsgroup_name)
	{
		return % this.Tabset($tabset_name).getTabsGroup($tabsgroup_name)
	}
	/**
	 */
	Tabfile($tabset_name, $tabsgroup_name, $tabfile_name)
	{		
		return % this.TabsGroup($tabset_name, $tabsgroup_name).getTabFile($tabfile_name)
	}
	
	/**
	 */
	TargetInfo()
	{
		return % this.parent()._TargetInfo 
	}
	/**
	 */
	TotalCmd()
	{
		return % this.Parent()._TotalCmd
	}
	

}
