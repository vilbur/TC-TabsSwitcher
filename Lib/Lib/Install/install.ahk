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
		;Dump($ini_path, "ini_path", 1)
		IniWrite, % $working_path "_tabs", %$ini_path%, paths, tabs
	} 
	/**
	 */
	createTabsFolder()
	{
		IniRead, $tabs_path, %$ini_path%, paths, tabs 
		FileCreateDir, % getTabsPath()
		return this				
	}
	
	
	
}
