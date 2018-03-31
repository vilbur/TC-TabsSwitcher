/** Class TabfilesSet
*/
Class TabfilesSet
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
	/** get *.tab files in folder
	 */
	getTabFiles()
	{
		loop, % this._path_tabs_folder "\*.tab", 0
			this._tabfiles[this._getTabFileName(A_LoopFileName)] := new Tabfile(A_LoopFileFullPath).getTabFiles()
		return this
	}
	/**
	 */
	getTabFilePath( $tab_filename )
	{
		return % this._tabfiles[$tab_filename]._path_tabs_folder
	}
	/** get filenames of *.tab files
	 */
	getTabFilenames()
	{
		return % getObjectKeys(this._tabfiles)
	}
	/** get values of keys "caption" in *.tab file
	 */
	getTabsCaptions( $tab_filename )
	{
		return % this._tabfiles[$tab_filename].getTabsCaptions()
	}
	/**
	 */
	_getTabFileName($tabs_filename)
	{
		SplitPath, $tabs_filename,,,, $file_noext
		return %$file_noext%
	}


	
}

