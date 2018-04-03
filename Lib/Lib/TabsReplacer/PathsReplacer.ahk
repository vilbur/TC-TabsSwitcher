/** Class PathsReplacer
*/
Class PathsReplacer
{
	_path_tab_file	:= "" ; path to folder with *.tab files
	_path_target	:= ""
	_folder_name	:= ""
	
	_path_target_rx	:= ""
	_old_folder_name	:= ""
	;_tab_files	:= {}		
	_tabset_folders	:= ""
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
		
		;this._setPathTargetRegex()
		this.setTabsetFolder()		
		
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
			this._replacePathByFolderName( $key_value[1], $key_value[2] )
	}
	/**
	 */
	setTabsetFolders($tabset_folders)
	{
		;Dump($tabset_folders, "tabset_folders", 1)
		
		For $i, $folder in $tabset_folders
			this._tabset_folders .= $folder "|" 
		
		this._tabset_folders :=  SubStr(this._tabset_folders, 1, StrLen(this._tabset_folders)-1) 
		return this
	} 
	/** replace key 1_path in *.tab
	  
	 */
	_replacePathByFolderName( $key, $full_path )
	{
		$path_new	:= RegExReplace( $full_path, "([\\\/])(" this._tabset_folders ")([\\\/])" , "$1" this._folder_name "$3" )
		;Dump($full_path, "full_path", 1)
		;Dump(this._tabset_folders, "this._tabset_folders", 1)
		;Dump(this._folder_name, "this._folder_name", 1)
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
		
		IniRead, $caption_old, % this._path_tab_file, % this._section, %$key_captions%
			
		$caption_new	:= RegExReplace( $caption_old, "(" this._tabset_folders ")([\\\/]+)" , this._folder_name "$2" )

		;Dump($caption_old, "caption_old", 1)
		;Dump($caption_new, "caption_new", 1)		
		
		;Dump($caption_new, $caption_old, 1)
		;if( $caption_new!="ERROR" && $caption_old != $caption_new )
		
		if( $caption_old!="ERROR" &&  $caption_old!=$caption_new )
			IniWrite, %$caption_new%, % this._path_tab_file, % this._section, %$key_captions% 
		
	} 
	/** FOR _replacePathByRoot()
		CURRENTLY UNUSED
	 */
	_setPathTargetRegex()
	{
		;$path_tabset	:= RegExReplace( this._path_target, "\\+$", "" ) ;;; remove last  slash\'
		;this._path_target_rx	:= RegExReplace( $path_tabset, "[\\\/]+", "\\")
	} 
	/** replace key 1_path in *.tab
		CURRENTLY UNUSED
			  
	 */
	_replacePathByRoot( $key, $full_path )
	{
	;;	$path_tabset	:= RegExReplace( this._path_target, "\\+$", "" ) ;;; remove last  slash\'
	;;	$path_tabset	= %$path_tabset%\
	;;	
	;;	$path_new	:= RegExReplace( $full_path, "i)" this._path_target_rx "[\\]+([^\\\/]+)", $path_tabset this._folder_name )
	;;
	;;	;Dump($path_new, "path_new", 1)
	;;	;Dump("-----------------------------", "", 1)				
	;;	
	;;	IniWrite, %$path_new%, % this._path_tab_file, % this._section, %$key% 
	;;
	;;	this._replaceCaptions( $key, $search_folder_match1 )
	}



	
}

























