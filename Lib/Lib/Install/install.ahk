/** Class Install
*/
Class Install
{
	
	createCommands(){
		new TcCommand()
			.name("Open")
			.prefix("TabsSwitcher")
			.cmd( A_ScriptFullPath )
			.icon( A_ScriptDir "\Icons\tab-switcher.ico" )			
			.create()
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
