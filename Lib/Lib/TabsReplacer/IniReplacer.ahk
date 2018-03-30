/** Class IniReplacer
*/
Class IniReplacer
{
	_path_tab_file	:= "" ; path to folder with *.tab files
	_path_target	:= ""
	_folder_name	:= "" 	
	;_tab_files	:= {}		

	/**
	 */
	pathTabFile( $path )
	{
		this._path := $path
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
		;Dump($data, "data", 1)
		this._folder_name	:= $folder_name
		Dump(this, "this.", 1)
		;IniRead, $sections, % this._path_tab_file
		;	Loop Parse, $sections, `n
		;		this._parseSection( A_LoopField )	
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
		RegExMatch( $key_value[1], "i)^\d+_path", $key_match )
		
		if( RegExMatch( $key_value[1], "^\d+_path" ) )
			this._replaceInPath( $key_value[1], $key_value[2] )
	}
	/**
	  
	 */
	_replaceInPath( $key, $full_path )
	{
		$path_Tabset	:= RegExReplace( this._data.Tabset_path, "\\+$", "" ) ;;; remove last  slash\'
		$replace_path	= %$path_Tabset%\
		
		$path_Tabset_rx	:= RegExReplace( $path_Tabset, "[\\\/]+", "\\")

		$path_new	:= RegExReplace( $full_path, "i)" $path_Tabset_rx  "[\\]+[^\\\/]+", $replace_path this._data.folder )
		
		Dump($path_Tabset_rx, "path_Tabset_rx", 1)
		Dump($path_new, "path_new", 1)
		;Dump("-----------------------------", "", 1)				
		
		;IniWrite, %$path_new%, % this._path, % this._section, %$key% 

	} 


	
}