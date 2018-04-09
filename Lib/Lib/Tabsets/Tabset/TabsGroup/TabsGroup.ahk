/** Class TabsGroup
*/
Class TabsGroup
{
	_path_tabs_folder	:= ""
	_tabfiles	:= {}		

	/* 
		@param string $path to folder with *.tab files
	 */
	__New($path){
		this._path_tabs_folder	:= $path
	}
	/** create new Tabfiles
	 */
	create()
	{
		FileCreateDir, % this._path_tabs_folder
		return this
	}
	
	/** create new Tabfiles
	 */
	createNewTabfile($tabs, $tabs_name)
	{
		$tabs_file := this._path_tabs_folder "\\" $tabs_name ".tab"
		
		For $pane, $tabs_in_pane in $tabs
			$tabs_string .= "[" (A_Index==1?"activetabs":"inactivetabs") "]`n" $tabs_in_pane "`n"
		
		FileDelete, %$tabs_file% 
		FileAppend, %$tabs_string%, %$tabs_file% 
	}
	
	/** get *.tab files in folder
	 */
	getTabFiles()
	{
		loop, % this._path_tabs_folder "\*.tab", 0
			this._tabfiles[this._getTabFileName(A_LoopFileName)] := new Tabfile(A_LoopFileFullPath).getTabFiles()
		return this
	}
	
	/**
	  * @return object Tabfile 
	 */
	getTabFile($tabfile_name)
	{
		return % this._tabfiles[$tabfile_name]
	}
	/**
	 */
	getTabFilePath( $tabfile_name )
	{
		return % this._tabfiles[$tabfile_name]._path_tabs_folder
	}
	
	/** get filenames of *.tab files
	 */
	getTabFilenames()
	{
		return % getObjectKeys(this._tabfiles)
	}

	/**
	 */
	_getTabFileName($tabs_filename)
	{
		SplitPath, $tabs_filename,,,, $file_noext
		return %$file_noext%
	}


	
}

