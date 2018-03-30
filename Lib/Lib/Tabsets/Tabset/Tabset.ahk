/** Class Tabset
*/
Class Tabset
{
	_tabs_path	:= ""
	_tabssets_path	:= "" 	
	_name	:= ""
	_Tabset	:= ""
	;_unique_file	:= ""
	_last_Tabfiles	:= ""
	_last_tabs	:= ""	
	_Tabfiles	:= {}
	_Tabset_folders	:= []	


	__New( $tabs_path ){
		this._tabs_path	:= $tabs_path 
	}
	/**
		@param string $Tabset to Tabset folder
	 */
	Tabset( $Tabset )
	{
		this._Tabset	:= $Tabset
		return this 
	}
	/**
	 */
	name( $name )
	{
		this._name	:= $name
		this._tabssets_path	:= this._tabs_path "\\" this._name
		this._ini_path	:= this._tabssets_path "\Tabset.ini"		
		return this 
	}
	/** create new Tabset
	 */
	create()
	{
		FileCreateDir, % this._tabssets_path
		this._setIniValue( "Tabset", this._Tabset )
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
		this._setTabfiles()
		this._setTabsetFolders()
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
		return % this._Tabfiles[$Tabfiles]
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
		this._Tabset	:= this._getIniValue("Tabset")
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
	_setTabfiles()
	{
		loop, % this._tabssets_path  "\*", 2
			this._Tabfiles[A_LoopFileName] := new Tabfiles(A_LoopFileFullPath).getTabFiles()
	}
	/**
	 */
	_setTabsetFolders()
	{
		loop, % this._Tabset "\*", 2
			this._Tabset_folders.push(A_LoopFileName)
	}
	/*---------------------------------------
		GET Tabfiles  DATA
	-----------------------------------------
	*/
	/**
	 */
	_getTabsetFolders()
	{
		return % getObjectValues(this._Tabset_folders)
	}
	/** ??? RENAME THIS METHOD TO: getTabfilesNames
	  
	 */
	_getFolderNames()
	{
		return % getObjectKeys(this._Tabfiles)
	}

}

