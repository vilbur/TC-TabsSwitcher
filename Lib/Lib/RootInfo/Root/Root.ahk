/** Class Root
*/
Class Root
{
	_tabs_path	:= ""
	_tabssets_path	:= "" 	
	_name	:= ""
	_root	:= ""
	;_unique_file	:= ""
	_last_tabset	:= ""
	_last_tabs	:= ""	
	_tabsets	:= {}
	_root_folders	:= []	


	__New( $tabs_path ){
		this._tabs_path	:= $tabs_path 
	}
	/**
		@param string $root to root folder
	 */
	root( $root )
	{
		this._root	:= $root
		return this 
	}
	/**
	 */
	name( $name )
	{
		this._name	:= $name
		this._tabssets_path	:= this._tabs_path "\\" this._name
		this._ini_path	:= this._tabssets_path "\root.ini"		
		return this 
	}
	/** create new root
	 */
	create()
	{
		FileCreateDir, % this._tabssets_path
		this._setIniValue( "root", this._root )
		return this 
	}
	/** create new tabset
	 */
	createTabset( $name )
	{
		;MsgBox,262144,, createTabset,2 
		new TabSet(this._tabssets_path "\\" $name ).create()
		return this 
	}
	/**
	 */
	init()
	{
		this._loadIniData()
		this._setTabsets()
		this._setRootFolders()
		return this 
	}

	/**
	 */
	get( $key )
	{
		;Dump(this["_" $key], "this.", 1)
		return % this["_" $key]
	}
	/**
	 */
	getTabset( $tabset )
	{
		return % this._tabsets[$tabset]
	}
	/**
	 */
	getLastTabSet()
	{
		;MsgBox,262144,, getLastTabs,2
		return % this._last_tabset ? this._last_tabset : 1
	}
	
	/**
	 */
	_loadIniData()
	{
		this._root	:= this._getIniValue("root")
		;this._unique_file	:= this._getIniValue("unique_file")
		this._last_tabset	:= this._getIniValue("last_tabset")
		this._last_tabs	:= this._getIniValue("last_tabs")		
	}
	/**
	 */
	_setIniValue( $key, $value )
	{
		IniWrite, %$value%, % this._ini_path, config, %$key% 
	}
	/**
	 */
	_getIniValue( $key )
	{
		IniRead, $value,	% this._ini_path, config, %$key%
		return % $value != "ERROR" ? $value : ""
	}
	/*---------------------------------------
		GET FOLDERS AND FILES DATA
	-----------------------------------------
	*/
	/**
	 */
	_setTabsets()
	{
		loop, % this._tabssets_path  "\*", 2
			this._tabsets[A_LoopFileName] := new TabSet(A_LoopFileFullPath).getTabFiles()
	}
	/**
	 */
	_setRootFolders()
	{
		loop, % this._root "\*", 2
			this._root_folders.push(A_LoopFileName)
	}
	/*---------------------------------------
		GET TABSET  DATA
	-----------------------------------------
	*/
	/**
	 */
	_getRootFolders()
	{
		return % getObjectValues(this._root_folders)
	}
	/** ??? RENAME THIS METHOD TO: getTabsetsNames
	  
	 */
	_getFolderNames()
	{
		return % getObjectKeys(this._tabsets)
	}

}

