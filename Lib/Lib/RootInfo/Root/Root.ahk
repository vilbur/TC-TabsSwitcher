/** Class Root
*/
Class Root
{
	_tabs_path	:= ""
	_tabssets_path	:= "" 	
	_name	:= ""
	_root	:= ""
	;_unique_file	:= ""
	_last_Tabfiles	:= ""
	_last_tabs	:= ""	
	_Tabfiless	:= {}
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
	/** create new Tabfiles
	 */
	createTabfiles( $name )
	{
		;MsgBox,262144,, createTabfiles,2 
		new Tabfiles(this._tabssets_path "\\" $name ).create()
		return this 
	}
	/**
	 */
	init()
	{
		this._loadIniData()
		this._setTabfiless()
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
	getTabfiles( $Tabfiles )
	{
		return % this._Tabfiless[$Tabfiles]
	}
	/**
	 */
	getLastTabfiles()
	{
		;MsgBox,262144,, getLastTabs,2
		return % this._last_Tabfiles ? this._last_Tabfiles : 1
	}
	
	/**
	 */
	_loadIniData()
	{
		this._root	:= this._getIniValue("root")
		;this._unique_file	:= this._getIniValue("unique_file")
		this._last_Tabfiles	:= this._getIniValue("last_Tabfiles")
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
	_setTabfiless()
	{
		loop, % this._tabssets_path  "\*", 2
			this._Tabfiless[A_LoopFileName] := new Tabfiles(A_LoopFileFullPath).getTabFiles()
	}
	/**
	 */
	_setRootFolders()
	{
		loop, % this._root "\*", 2
			this._root_folders.push(A_LoopFileName)
	}
	/*---------------------------------------
		GET Tabfiles  DATA
	-----------------------------------------
	*/
	/**
	 */
	_getRootFolders()
	{
		return % getObjectValues(this._root_folders)
	}
	/** ??? RENAME THIS METHOD TO: getTabfilessNames
	  
	 */
	_getFolderNames()
	{
		return % getObjectKeys(this._Tabfiless)
	}

}

