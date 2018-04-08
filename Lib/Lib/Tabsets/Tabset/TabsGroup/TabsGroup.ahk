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
	}
	
	/** create new Tabfiles
	 */
	createNewTabfile($tabs, $tabs_name)
	{
		$tabs_file := this._path_tabs_folder "\\" $tabs_name ".tab"
		
		For $pane, $tabs_in_pane in $tabs
			$tabs_string .= "[activetabs]`n" $tabs_in_pane
		
		;MsgBox,262144,tabs_string, %$tabs_string%,50 
		FileDelete, %$tabs_file% 
		FileAppend, %$tabs_string%, %$tabs_file% 
		;this._tabfiles[$tabs_name] := new Tabfile(this._path_tabs_folder "\\" $tabs_name ".tab").getTabFiles()
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
		;Dump(this, $tabfile_name, 1)
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
	
	;/** get values of keys "caption" in *.tab file
	; */
	;getTabsCaptions( $tabfile_name )
	;{
	;	return "getTabsCaptions"
	;	return % this._tabfiles[$tabfile_name].getTabsCaptions()
	;}
	/**
	 */
	_getTabFileName($tabs_filename)
	{
		SplitPath, $tabs_filename,,,, $file_noext
		return %$file_noext%
	}


	
}

