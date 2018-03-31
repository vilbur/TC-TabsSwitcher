/** Class Tabset
*/
Class Tabset
{
	_path_target	:= ""
	_path_tabset	:= "" 	
	
	_name	:= ""
	_unique_file	:= ""
	_last_tabsgroup	:= ""
	_last_tabs	:= ""
	
	_TabsGroups	:= {}
	_folders	:= [] ; folderes in target path

	/**
		@param string $path to Tabset folder
	 */
	pathTarget( $path_target )
	{
		;Dump($path_target, "path_target", 1)
		this._path_target	:= $path_target
		return this 
	}
	/**
	 */
	name( $name )
	{
		this._name	:= $name
		this._path_tabset	:= $tabs_path "\\" this._name
		;this._ini_path	:= this._path_tabset "\Tabset.ini"		
		return this 
	}
	/** create new Tabset
	 */
	create()
	{
		FileCreateDir, % this._path_tabset
		this._setIniValue( "path-target", this._path_target )
		return this 
	}
	/** create new TabsGroups
	 */
	createTabsGroup( $name )
	{
		;MsgBox,262144,, createTabsGroups,2 
		new TabsGroup(this._path_tabset "\\" $name ).create()
		return this 
	}
	/** delete Tabset folder
	 */
	delete()
	{
		;MsgBox,262144,delete , % this._path_tabset,2   
		;FileRemoveDir, % this._path_tabset, 1
		return this 
	}
	/**
	 */
	load()
	{
		this._loadIniData()
		this._setTabsGroups()
		this._setTabsetFolders()
		return this 
	}

	/**
	 */
	get( $property )
	{
		;Dump(this["_" $property ], "this.", 1)
		return % this["_" $property ]
	}
	/**
	 */
	getTabsGroup( $TabsGroup )
	{
		;Dump($TabsGroup, "getTabsGroup", 1)
		;MsgBox,262144,, getTabsGroup,2 
		return % this._TabsGroups[$TabsGroup]
	}
	/**
	 */
	getLastTabsGroup()
	{
		;return 1
		;Dump(this._last_tabsgroup, "this._last_tabsgroup", 1)
		return % this._last_tabsgroup ? this._last_tabsgroup : 1
	}
	
	/*---------------------------------------
		GET FOLDERS AND FILES DATA
	-----------------------------------------
	*/
	/** get folders in target root
	  *
	  * @example target\root
	  *				\project_1
	  *				\project_2	  
	 */
	_setTabsetFolders()
	{
		if( this._path_target )
			loop, % this._path_target "\*", 2
				this._folders.push(A_LoopFileName)
	}
	/** get *.tab files available for tabset
	 */
	_setTabsGroups()
	{
		loop, % this._path_tabset  "\*", 2
			this._TabsGroups[A_LoopFileName] := new TabsGroup(A_LoopFileFullPath).getTabFiles()
	}
	/*---------------------------------------
		GET TabsGroups  DATA
	-----------------------------------------
	*/
	/**
	 */
	_getTabsetFolders()
	{
		return % getObjectValues(this._folders)
	}
	/** ??? RENAME THIS METHOD TO: getTabsGroupsNames
	  
	 */
	_getFolderNames()
	{
		return % getObjectKeys(this._TabsGroups)
	}
	/*---------------------------------------
		INI METHODS
	-----------------------------------------
	*/
	/**
	 */
	_loadIniData()
	{
		this._path_target	:= this._getIniValue("path-target")
		this._unique_file	:= this._getIniValue("unique-file")
		this._last_tabsgroup	:= this._getIniValue("last-tabsgroup")
		this._last_tabs	:= this._getIniValue("last-tabs")		
	}

	/**
	 */
	_setIniValue( $key, $value )
	{
		IniWrite, %$value%, % $tabs_path "\\" this._name "\Tabset.ini", config, %$key% 
	}
	/**
	 */
	_getIniValue( $key )
	{
		IniRead, $value,	% $tabs_path "\\" this._name "\Tabset.ini", config, %$key%, 
		;return $value
		return % $value != "ERROR" ? $value : ""
	}
}

