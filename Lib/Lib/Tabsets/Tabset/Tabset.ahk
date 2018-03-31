/** Class Tabset
*/
Class Tabset
{
	_path_target	:= ""
	_path_tabset	:= "" 	
	
	_name	:= ""
	_unique_file	:= ""
	_last_tabfiles	:= ""
	_last_tabs	:= ""	
	_Tabfiles	:= {}
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
	/** create new Tabfiles
	 */
	createTabfiles( $name )
	{
		;MsgBox,262144,, createTabfiles,2 
		new Tabfiles(this._path_tabset "\\" $name ).create()
		return this 
	}
	/**
	 */
	load()
	{
		this._loadIniData()
		this._setTabsetFolders()
		this._setTabfiles()
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
	getTabfiles( $Tabfiles )
	{
		return % this._Tabfiles[$Tabfiles]
	}
	/**
	 */
	getLastTabfiles()
	{
		;return 1
		;Dump(this._last_tabfiles, "this._last_tabfiles", 1)
		return % this._last_tabfiles ? this._last_tabfiles : 1
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
		loop, % this._path_target "\*", 2
			this._folders.push(A_LoopFileName)
	}
	/** get *.tab files available for tabset
	 */
	_setTabfiles()
	{
		loop, % this._path_tabset  "\*", 2
			this._Tabfiles[A_LoopFileName] := new Tabfiles(A_LoopFileFullPath).getTabFiles()
	}
	/*---------------------------------------
		GET Tabfiles  DATA
	-----------------------------------------
	*/
	/**
	 */
	_getTabsetFolders()
	{
		return % getObjectValues(this._folders)
	}
	/** ??? RENAME THIS METHOD TO: getTabfilesNames
	  
	 */
	_getFolderNames()
	{
		return % getObjectKeys(this._Tabfiles)
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
		this._last_tabfiles	:= this._getIniValue("last-tabfiles")
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

