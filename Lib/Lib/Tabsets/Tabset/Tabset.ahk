/** Class Tabset
*/
Class Tabset
{
	_TabsGroups	:= {}
	_TabsRoots	:= {}
	
	_name	:= ""
	_path_target	:= ""
	_path_tabset	:= "" 	
	
	_last	:= {}

	/**
		@param string $path to Tabset folder
	 */
	pathTarget( $path_target:="" )
	{
		if( $path_target )
			this._path_target	:= $path_target
			
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
		this._setIniValue( "roots", this._path_target )
		return this 
	}
	/** create new TabsGroups
	 */
	createTabsRoot( $path )
	{
		if( ! $path || _TabsRoots.hasKey($path) )
			return
		
		new TabsRoot().setRootFolders( $path )
		
		this._setIniValue( "roots", $path )

		return this 
	}
	/** create new TabsGroups
	 */
	removeTabsRoot( $path )
	{
		this._TabsRoots.delete($path)
		
		this._deleteIniValue( "roots", $path )
		
		return this 
	}
	/** create new TabsGroups
	 */
	createTabsGroup( $name )
	{
		if( ! $name || _TabsGroups.hasKey($name) )
			return
			
		return % new TabsGroup( this._path_tabset "\\" $name ).create()
	}
	/** delete Tabset folder
	 */
	delete()
	{
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
		;Dump(this, this._name, 0)
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
		$value := this._last[$property]
		
		if( ! $value )
		{
			if( $property=="tabsgroup" )
				return % "_shared"
				
			else if( $property=="root" )
				return % this.getFirstTabsRoot()
			
		}
		
		return % $value ? $value : 1
	}
	/*
	 */
	getLastFolder($root)
	{
		;$value := this.get( "last_" $property )
		$last_folder := this.getLast( "folder" )
		
		return % findInAray( this._TabsRoots[$root].folders(), $last_folder ) ? $last_folder : 1
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
		$roots := this._getIniValue( "roots" )
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
	getFirstTabsRoot()
	{
		For $root, $v in this._TabsRoots
			return $root
	}	
	/**
	 */
	getTabsRootsPaths()
	{
		return % getObjectKeys(this._TabsRoots)
	}
	/**
	 */
	getTabsRootFoldersAll()
	{
		$all_folders	:= []
		For $tabsroot_name, $TabsRoot in this._TabsRoots
			$all_folders.push(this._getTabsRootFolders($tabsroot_name))

		return % flatternObject($all_folders)
	}
	/**
	 */
	_getTabsRootFolders($tabsroot)
	{
		return % getObjectValues(this._TabsRoots[$tabsroot].folders())
	}

	/*---------------------------------------
		GET TabsGroups DATA
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
	_getTabsGroupsNames()
	{
		return % getObjectKeys(this._TabsGroups, "_shared")		
	}
	/*---------------------------------------
		INI METHODS
	-----------------------------------------
	*/
	/**
	 */
	_loadIniLastUsed()
	{
		$last := this._getIniValue( "last" )
		Loop, Parse, % $last, `n
		{
			$key_value	:= StrSplit( A_LoopField, "=")
			this._last[$key_value[1]] := $key_value[2]
		}
	}
	/** save last loaded items to *.ini
	 */
	saveLastToIni( $tabsroot,  $tabgroup, $tabfolder, $tabfile )
	{
		this._setIniValue( "last", "root",	$tabsroot )
		this._setIniValue( "last", "tabsgroup",	$tabgroup )		
		this._setIniValue( "last", "folder",	$tabfolder )
		this._setIniValue( "last", "tabfile",	$tabfile )				
		return this
	}
	/**
	 */
	_setIniValue( $section, $key, $value:="" )
	{
		IniWrite, %$value%, % $tabs_path "\\" this._name "\Tabset.ini", %$section%, %$key% 
	}
	/**
	 */
	_getIniValue( $section, $key:="" )
	{
		IniRead, $value,	% $tabs_path "\\" this._name "\Tabset.ini", %$section%, %$key%, 
		return % $value != "ERROR" ? $value : ""
	}
	/**
	 */
	_deleteIniValue( $section, $key:="" )
	{
		IniDelete, % $tabs_path "\\" this._name "\Tabset.ini", %$section%, %$key%
	}
}

