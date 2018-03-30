/** Class TabSet
  
  
*/
Class TabSet
{
	_path	:= ""
	_tab_files	:= {}		

	/* 
		@param string $path to folder with *.tab files
	 */
	__New($path){
		this._path	:= $path
	}
	/** create new tabset
	 */
	create()
	{
		FileCreateDir, % this._path

	}
	/**
	 */
	getTabFiles()
	{
		loop, % this._path "\*.tab", 0
			this._tab_files[this._getTabFileName(A_LoopFileName)] := new Tabfile(A_LoopFileFullPath).getTabFiles()
		return this
	}
	/**
	 */
	getTabFilePath( $tab_filename )
	{
		return % this._tab_files[$tab_filename]._path
	}
	/**
	 */
	getTabFilenames()
	{
		return % getObjectKeys(this._tab_files)
	}
	/**
	 */
	getTabsCaptions( $tab_filename )
	{
	
		return % this._tab_files[$tab_filename].getTabsCaptions()
	}
	
	/**
	 */
	_getTabFileName($tabs_filename)
	{
		SplitPath, $tabs_filename,,,, $file_noext
		return %$file_noext%
	}


	
}

