/** Class IniReplacer
*/
Class IniReplacer
{
	_path	:= "" ; path to folder with *.tab files
	_tab_files	:= {}		

	__New($path, $data){
		this._path	:= $path
		this._data	:= $data
		
		;Dump(this._data, "this._data", 1)
	}

	/**
	 */
	replaceFolderName()
	{
		IniRead, $sections, % this._path
			Loop Parse, $sections, `n
				this._parseSection( A_LoopField )	
	}
	/**
	 */
	_parseSection( $section )
	{
		this._section := $section
		IniRead, $sections, % this._path, %$section%
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
			this._replaceInValue( $key_value[1], $key_value[2] )
	}
	/**
	  
	 */
	_replaceInValue( $key, $full_path )
	{
		$path_Tabset	:= RegExReplace( this._data.Tabset_path, "\\+$", "" ) ;;; remove last  slash\'
		$replace_path	= %$path_Tabset%\
		
		$path_Tabset_rx	:= RegExReplace( $path_Tabset, "[\\\/]+", "\\")

		$path_new	:= RegExReplace( $full_path, "i)" $path_Tabset_rx  "[\\]+[^\\\/]+", $replace_path this._data.folder )
		
		;Dump($path_Tabset_rx, "path_Tabset_rx", 1)
		;Dump($path_new, "path_new", 1)
		;Dump("-----------------------------", "", 1)				
		
		IniWrite, %$path_new%, % this._path, % this._section, %$key% 

	} 


	
}