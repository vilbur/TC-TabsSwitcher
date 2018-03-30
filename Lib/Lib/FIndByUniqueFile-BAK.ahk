/** Class TargetInfo
*/
Class TargetInfo
{
	_unique_files	:= {}
	_unique_file	:= ""	
	_current_path	:= ""
	;_uniquefile_path	:= ""		
	_Tabfiles_current	:= ""
	_folder_current	:= ""
	_tabs	:= []	
	_Tabset_path	:= ""
	
	__New(){

	}
	/**
	 */
	get( $key )
	{
		return % this["_" $key]
	}
	/** findTabsetPath
	 */
	findTabsetPath($current_path, $unique_files){
		;Dump($unique_files, "unique_files", 1)
		this._current_path := RegExReplace( $current_path, "[\\\/]+$", "" )
		this._unique_files := $unique_files 		
		this._setUniqueFilePath($current_path)		
		this._setTabsetPath()
		this._fillObjectByTabsetPath()								
		return this
	}
	/**
	 */
	_fillObjectByTabsetPath()
	{
		this._setFolders()
		this._setFolderCurrent()		
		this._setTabssetCurrent()
	} 

	/**
	 */
	_setFolders()
	{
		loop, % this._Tabset_path "\*", 2
			this._tabs.insert(A_LoopFileName)
	}
	/* Go revers on path and search for one of unique files
	*/
	_setUniqueFilePath($current_path)
	{
		$search_path :=  this._current_path
		
		While $search_path != $drive 
		{
			if( this._findUniqueFile($search_path) )
				break					
			SplitPath, $search_path,, $search_path,,, $drive
		}
		this._unique_path := $search_path
	}
	/** Find one of unique files in dir
	 */
	_findUniqueFile($search_path)
	{
		For $f, $unique_file in % this._unique_files
			if( FileExist($search_path "\\" $unique_file ) ){
				this._unique_file := $unique_file
				return true
			}
	} 
	/**
	 */
	_setFolderCurrent()
	{
		SplitPath, % this._unique_path, $folderName
		this._folder_current := $folderName
	}
	/**
	 */
	_setTabssetCurrent()
	{
		SplitPath, % this._Tabset_path, $Tabfiles_name
		this._Tabfiles_current := $Tabfiles_name
	}
	/**
	 */
	_setTabsetPath()
	{
		SplitPath, % this._unique_path,, $Tabset_path
		this._Tabset_path := $Tabset_path		
	}
	
	
}

