/** Read *.tab file and get name of each tab
*/
Class Tabfile
{
	_Callback	:= new TabfileCallback()

	_path	:= "" ; path to *.tab file
	;_name	:= "" ; name of *.tab file	
	_tabs	:= {}

	__New($path){
		this._path	:= $path
		;SplitPath, $path,,,, $noext
		;this._name	:= $noext		
	}
	
	/**
	 */
	getPath()
	{
		return this._path
	}
	/** get multiline string of tab captions
		 
	 */
	getTabsCaptions()
	{
		;return "getTabsCaptions"
		For $pane_name, $tabs in this._tabs ; $pane_name == "activetabs|inactivetabs"
			$captions .= ( $pane_name=="inactivetabs" ? "`n":"") RegExReplace( $pane_name, "(.*)tabs", "------ $U1 ------`n" ) joinObject( $tabs )
		return %$captions%
	}	
	/** Read *.tab file and parse lines
	 */
	getTabFiles()
	{
		IniRead, $sections, % this._path
			Loop Parse, $sections, `n
				this._parseSection( A_LoopField )	
		return this
	}
	/** delete Tabset folder
	 */
	delete()
	{
		MsgBox,262144,DELETE , % this._path,2
		;FileRemoveDir, % this._path_tabset, 1
		;return this 
	}
	/**
	 */
	createCommand($data)
	{
		$path_icon := RegExReplace( this._path, "tab$", "ico" )
		
		new TcCommand()
				.name("LOAD TABS - " $data.tabset "-" $data.tabsgroup "-" $data.tabfile "" )
				.prefix("TabsSwitcher")
				.cmd( A_ScriptFullPath )
				.param($data.tabset, $data.tabsgroup, $data.tabfile)
				.icon( $path_icon  )			
				.create()
				
		$IrfanView := new IrfanView()
		StringUpper, $icon_text, % $data.tabfile
		
		$IrfanView.Icon( $path_icon )
					.color("", "blue")
					.text($icon_text)
					.create()
	
	}
	/**
	 */
	Callback($Event, $data)
	{
		if( $Event.value == "New" )
			this._Callback.new()
				
		else if( $Event.value == "Delete" )
			this._Callback.delete( this, $data )
		
		else if( $Event.value == "Create command" )
			this._Callback.createCommand( this, $data )
	}
	
	/**
	 */
	_parseSection( $section )
	{
		this._section	:= $section
		this._tabs[$section]	:= []
		
		IniRead, $sections, % this._path, %$section%
			Loop Parse, $sections, `n
				this._parseLine($section, A_LoopField )
	} 
	/** prse key=value par in ini
	 */
	_parseLine($section,  $line_content )
	{
		$key_value	:= StrSplit($line_content, "=")
		
		RegExMatch( $key_value[1], "i)^(\d+)_(path|caption)", $key )
		
		if($key)
			this._tabs[$section].push( this._getTabName( $tab_num1, $key2, $key_value[2] ) )
	}
	
	/** Get path folder name from key "path" or key "caption"
	  *	*.tab file contains these keys
	  *		1_path=C:\Foo\Folder\
	  *		1_caption=Renamed Tab
	 */
	_getTabName( $tab_num, $key, $value )
	{
		return $key=="path" ? this._getFolderName( $value ) : $value 
	} 
	/**
	 */
	_getFolderName( $path )
	{
		$path := RegExReplace( $path, "[\\\/]+$", "" ) 
		SplitPath, $path, $folder_name
		return %$folder_name%
	}

	
}

