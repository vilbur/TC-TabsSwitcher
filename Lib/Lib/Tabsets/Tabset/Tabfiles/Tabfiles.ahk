/** Class Tabfiles
  
  
*/
Class Tabfiles
{
	_path	:= ""
	_tabfiles	:= {}		

	/* 
		@param string $path to folder with *.tab files
	 */
	__New($path){
		this._path	:= $path
	}
	/** create new Tabfiles
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
			this._tabfiles[this._getTabFileName(A_LoopFileName)] := new Tabfile(A_LoopFileFullPath).getTabFiles()
		return this
	}
	/**
	 */
	getTabFilePath( $tab_filename )
	{
		return % this._tabfiles[$tab_filename]._path
	}
	/**
	 */
	getTabFilenames()
	{
		return % getObjectKeys(this._tabfiles)
	}
	/**
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

