;#SingleInstance force
#Include %A_LineFile%\..\includes.ahk


/** Class TabsSwitcher
*/
Class TabsSwitcher
{
	_Tabsets	:= new Tabsets().parent(this)
	_TargetInfo	:= new TargetInfo()	
	_Gui	:= new Gui().parent(this)
	_Install 	:= new Install()
	;_ini_path	:=

	__New()
	{
		$TabsSwitcher := this
		
		If ( ! FileExist( $ini_path ))
			this.install()

		this._Tabsets.loadTabsets()
		;this._TargetInfo.findTabsetPath($current_path, this._getAllUniqueFiles())
		
		;Dump( this._Tabsets, "_Tabsets", 1)
		;Dump( this._TargetInfo, "_TargetInfo", 0)		
		;this._getTabs()
	}
	/** managerGui
	*/	
	managerGui()
	{
		this._Gui.managerGui()
	}
	/** createGui
	*/	
	createGui()
	{
		;MsgBox,262144,, createGui,2 
		if( ! this._Tabsets.isAnyTabsetExists())
			 new Example().parent(this).createExample()
			
		;Dump( this._Tabsets, "_Tabsets", 1)
		this._Gui.createGui()
	}
	/**
	 */
	install()
	{
		;new TCcommand().createCommandRunTabSwitcher( $path )
		this._Install
				.createIniFile()		
				.createTabsFolder()
	}
	/** get all unique files from all ini files
	 */
	_getAllUniqueFiles()
	{
		$unique_files := []
		For $i, $Tabfiles in this._Tabsets._Tabsets
			$unique_files.insert($Tabfiles.get("unique_file"))
		;Dump($unique_files, "unique_files", 1)
		return % $unique_files 
	} 
	;/** createGui
	;*/
	;onSubmit($Event)
	;{
	;	$Event.message(50)
	;}
	/** loadTabs
	*/
	loadTabs($Event)
	{
		$data	:= this._gui._getGuiData()
		$path := this._Tabsets.getTabset($data.Tabset).getTabfiles( $data.Tabfiles ).getTabFilePath( $data.tabs )
		
		if( $data.Tabfiles=="_shared" )
			new IniReplacer($path, $data ).replaceFolderName()
			
		;MsgBox,262144,path, %$path%,3 
		;$Event.message(50)
		$TCcommand 	:= new TCcommand().loadTabs( $path )
	}	
	/**
	 */
	_getPathToTabfiles()
	{
		
	} 
	
}


/** 
*/
loadTabsCallback($Event)
{
	$TabsSwitcher.loadTabs($Event)
}	










