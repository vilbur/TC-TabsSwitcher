/** Class Tabset
*/
Class Tabset
{
	_path_target	:= ""
	_path_tabset	:= "" 	
	
	_name	:= ""
	_unique_file	:= ""
	
	_last	:= {}
	
	_last_tabsgroup	:= ""
	_last_folder	:= ""	
	_last_tabfile	:= ""
	
	_TabsGroups	:= {}
	_TabsRoots	:= {}	
	_folders	:= [] ; folderes in target path

	/**
		@param string $path to Tabset folder
	 */
	pathTarget( $path_target:="" )
	{
		if( $path_target )
			this._path_target	:= $path_target
			
		;Dump($path_target, "path_target", 1)
		return  % $path_target ? this : this._path_target
	}
	
	/**
	 */
	name( $name )
	{
		this._name	:= $name
		$path	= %$tabs_path%\%$name%
		;this._path_tabset	:= $tabs_path "\" this._name
		this._path_tabset	:= $path	
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
		new TabsGroup( this._path_tabset "\\" $name ).create()
		return this 
	}
	/** delete Tabset folder
	 */
	delete()
	{
		;MsgBox,262144,delete , % this._path_tabset,2   
		FileRemoveDir, % this._path_tabset, 1
		return this 
	}
	/**
	 */
	load()
	{
		;Dump(this, "load", 1)
		this._loadIniData()
		this._loadIniLastUsed()		
		this._setTabsGroups()
		this._setTabsRoots()		
		this._setTabsetFolders()
		Dump(this, this._name, 0)
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
	/** get last value from ini
	  * @param string $property "tabsgroup|folder|tabfile"
	  * 
	 */
	getLast( $property )
	{
		;$value := this.get( "last_" $property )
		$value := this._last[$property]	
		return % $value ? $value : 1
	}
	
	/** if user is somewhere in path of target
	 */
	isPathInTarget( $path )
	{
		return InStr($path, this._path_target)
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
	/**
	 */
	_setTabsRoots()
	{
		$roots := this._getIniValueNEW( "roots" )
		Loop, Parse, % $roots, `n
		{
			$key_value	:= StrSplit( A_LoopField, "=")
			this._TabsRoots[$key_value[1]] := new TabsRoot().setRootFolders($key_value[1]).setLastFolder($key_value[2])
		}
	} 
	/** get *.tab files available for tabset
	 */
	_setTabsGroups()
	{
		loop, % this._path_tabset  "\*", 2
			this._TabsGroups[A_LoopFileName] := new TabsGroup(A_LoopFileFullPath).getTabFiles()
	}
	/*---------------------------------------
		GET TabRoots  DATA
	-----------------------------------------
	*/
	/**
	 */
	getTabsRootsPaths()
	{
		return % joinObject( getObjectKeys(this._TabsRoots), "|" )
		
	}
	/**
	 */
	_getTabsRootFolders($tabsroot)
	{
		;this._TabsRoots[$tabsroot].getFolders()
		return % getObjectValues(this._TabsRoots[$tabsroot]._folders)
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
	_loadIniLastUsed()
	{
		$last := this._getIniValueNEW( "last" )
		Loop, Parse, % $last, `n
		{
			$key_value	:= StrSplit( A_LoopField, "=")
			this._last[$key_value[1]] := $key_value[2]
		}

	}
	/** save last loaded items to *.ini
	 */
	saveLastToIni( $tabgroup, $tabfolder, $tabfile )
	{
		this._setIniValue( "last-tabsgroup", $tabgroup )
		this._setIniValue( "last-folder", $tabfolder )
		this._setIniValue( "last-tabfile", $tabfile )				
		return this
	}
	/**
	 */
	_loadIniData()
	{
		this._path_target	:= this._getIniValue("path-target")
		this._unique_file	:= this._getIniValue("unique-file")
		this._last_tabsgroup	:= this._getIniValue("last-tabsgroup")
		this._last_folder	:= this._getIniValue("last-folder")		
		this._last_tabfile	:= this._getIniValue("last-tabfile")		
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
	
	/**
	 */
	_getIniValueNEW( $section, $key:="" )
	{
		IniRead, $value,	% $tabs_path "\\" this._name "\Tabset.ini", %$section%, %$key%, 
		return % $value != "ERROR" ? $value : ""
	}
	
}

