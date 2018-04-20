/** Class PathsReplacer
*/
Class PathsReplacer
{
	_path_tab_file	:= "" ; path to folder with *.tab files

	_search_folders	:= ""
	_replace_folder	:= ""	

	_search_roots	:= ""
	_replace_root	:= ""	

	_replace	:= "" ; "root|folder"

	/**
	 */
	pathTabFile( $path_tab_file )
	{
		this._path_tab_file := $path_tab_file
		return this
	}
	/**
	 */
	searchRoots( $search_roots )
	{
		this._search_roots := this._escapePathRegex( joinObject( $search_roots, "|" ) )
		return this
	}
	/**
	 */
	replaceRoot( $replace_root )
	{
		this._replace_root := $replace_root
		return this
	}
	/**
	 */
	searchFolders( $search_folders )
	{
		;Dump($search_folders, "search_folders", 1)
		this._search_folders :=  joinObject( $search_folders, "|" )

		return this
	}
	/**
	 */
	replaceFolder($folder_name)
	{
		this._replace_folder	:= $folder_name
		return this
		;this._setPathTargetRegex()
	}
	/**
	 */
	replace($replace)
	{
		this._replace	:= $replace
		;Dump(this, "this.", 1)
		this._loopSections()
	}
	/*---------------------------------------
		PARSE *.tab FILE
	-----------------------------------------
	*/
	/**
	 */
	_loopSections(  )
	{
		IniRead, $sections, % this._path_tab_file
			Loop Parse, $sections, `n
				this._parseSection( A_LoopField )
	}
	/**
	 */
	_parseSection( $section )
	{
		this._section := $section
		IniRead, $sections, % this._path_tab_file, %$section%
			Loop Parse, $sections, `n
				this._parseLine( A_LoopField )
	}
	
	/**
	 */
	_parseLine( $line_content )
	{
		if( RegExMatch( $line_content, "i)\d+_path" ) )
			this._replacePathAndCaptions( StrSplit($line_content, "=") )
	}
	
	/*---------------------------------------
		REPLACE IN *.tab FILE
	-----------------------------------------
	*/
	/** replace key 1_path in *.tab

	 */
	_replacePathAndCaptions( $key_path )
	{
		$path_new	:= $key_path[2]
		
		if( InStr( this._replace, "root" )  )
			$path_new	:= this._replaceRoot( $path_new )
			
		;$Old	:= $path_new
		;MsgBox,262144,_replaceRoot, % "_search_roots:`n" this._search_roots "`n---------`n_replace_root:`n" this._replace_root "`n---------`n$Old:`n" $Old "`n---------`n$path_new:`n" $path_new
	
		$path_new	:= this._replaceFolder( $path_new )
		
		this._setToIni( $key_path[1], $path_new )
		
		this._replaceCaptions( RegExReplace( $key_path[1], "i)path", "caption" ) )
	}

	/*---------------------------------------
		REPLACE VALUES
	-----------------------------------------
	*/
	/** Replace root in path
	  * @example "C:\search\root\foo\bar" >>> "C:\replaced\path\foo\bar"
	  *
	 */
	_replaceRoot( $path_old )
	{
		return % RegExReplace( $path_old, "i)^(" this._search_roots ")", this._replace_root  )
	}
	/**
	  *	@example	"C:\foo\bar\search-folder"	>>> "C:\foo\bar\replaced-folder"
	  *		"C:\foo\search-folder\bar"	>>> "C:\foo\replaced-folder\bar"
	 */
	_replaceFolder( $path_old )
	{
		return % RegExReplace( $path_old, "i)([\\\/])(?:" this._search_folders ")(?:([\\\/])|$)" , "$1" this._replace_folder "$2" )
	}
	
	/** replace key 1_caption in *.tab
	 */
	_replaceCaptions( $key )
	{
		IniRead, $caption_old, % this._path_tab_file, % this._section, %$key%

		$caption_new	:= RegExReplace( $caption_old, "^(" this._search_folders ")([\\\/]+)*" , this._replace_folder "$2" )

		if( $caption_old!="ERROR" &&  $caption_old!=$caption_new )
			this._setToIni( $key, $caption_new )
	}

	/*---------------------------------------
		HELPERS
	-----------------------------------------
	*/
	/**
	 */
	_setToIni( $key, $value )
	{
		IniWrite, %$value%, % this._path_tab_file, % this._section, %$key%
	} 
	/**
	 */
	_escapePathRegex($path)
	{
		;$path_tabset	:= RegExReplace( this._replace_root, "\\+$", "" ) ;;; remove last  slash\'
		return % RegExReplace( $path, "[\\\/]+", "\\")
	}

}

























