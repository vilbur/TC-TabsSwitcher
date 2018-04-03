/** Class PathsReplacer
*/
Class PathsReplacer
{
	_path_tab_file	:= "" ; path to folder with *.tab files
	_path_target	:= ""
	_folder_name	:= ""
	
	_path_target_rx	:= "" 		
	;_tab_files	:= {}		

	/**
	 */
	pathTabFile( $path_tab_file )
	{
		this._path_tab_file := $path_tab_file
		return this
	}
	/**
	 */
	pathTarget( $path_target )
	{
		this._path_target := $path_target
		return this
	}
	/**
	 */
	replaceFolder($folder_name)
	{
		this._folder_name	:= $folder_name
		
		this._setPathTargetRegex()
		this._setPathTargetRegex()		
		
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
		$key_value	:= StrSplit($line_content, "=")
		
		if( InStr( $key_value[1], "_path") )
			this._replaceInPath( $key_value[1], $key_value[2] )
	}
	
	/**
	 */
	_setPathTargetRegex()
	{
		$path_tabset	:= RegExReplace( this._path_target, "\\+$", "" ) ;;; remove last  slash\'
		this._path_target_rx	:= RegExReplace( $path_tabset, "[\\\/]+", "\\")
	} 
	/** replace key 1_path in *.tab
	  
	 */
	_replaceInPath( $key, $full_path )
	{
		$path_tabset	:= RegExReplace( this._path_target, "\\+$", "" ) ;;; remove last  slash\'
		$path_tabset	= %$path_tabset%\
		
		RegExMatch( $full_path, this._path_target_rx "[\\]+([^\\\/]+)" , $search_folder_match )
		
		$path_new	:= RegExReplace( $full_path, "i)" this._path_target_rx "[\\]+" $search_folder_match1 , $path_tabset this._folder_name )

		;Dump($path_new, "path_new", 1)
		;Dump("-----------------------------", "", 1)				
		
		IniWrite, %$path_new%, % this._path_tab_file, % this._section, %$key% 

		this._replaceCaptions( $key, $search_folder_match1 )
	}
	
	/** replace key 1_caption in *.tab
	 */
	_replaceCaptions( $key, $old_folder_name )
	{
		$key_captions := RegExReplace( $key, "path", "caption" )
		
		IniRead, $caption, % this._path_tab_file, % this._section, %$key_captions%
		
		$new_caption := RegExReplace( $caption, $old_folder_name, this._folder_name )
		
		if( $caption != $new_caption )
			IniWrite, %$new_caption%, % this._path_tab_file, % this._section, %$key_captions% 
		
	} 


	
}

























