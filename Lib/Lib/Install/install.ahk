/** Class Install
*/
Class Install
{
	__New(){
		
	}
	/**
	 */
	createIniFile()
	{
		this._setPathToTabsFolder()
		return this
	}
	/**
	 */
	_setPathToTabsFolder()
	{
		$tabs_path := A_ScriptDir "\_tabsets"
		IniWrite, %$tabs_path%, %$ini_path%, paths, tabs
	} 
	/**
	 */
	createTabsFolder()
	{
		FileCreateDir, %$tabs_path%
		return this				
	}
	
	
	
}
