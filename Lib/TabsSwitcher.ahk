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
	_IniReplacer 	:= new IniReplacer()
	_TCcommand 	:= new TCcommand()	
	;_ini_path	:=

	__New()
	{
		$TabsSwitcher := this
		
		If ( ! FileExist( $ini_path ))
			this.install()
			
		this.setTabsPath()
		this._Tabsets.loadTabsets()
		this._TargetInfo.findCurrentTabset( this._Tabsets )
		
		Dump(this._Tabsets, "this._Tabsets", 1)
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

	/** loadTabs
	*/
	loadTabs($Event)
	{
		$data	:= this._gui._getGuiData()
		$path_tab_file	:= this._Tabsets.getTabset($data.Tabset).getTabfiles( $data.Tabfiles ).getTabFilePath( $data.tabs )
		;Dump($data, "data", 1)
		if( $data.Tabfiles=="_shared" )
			this._IniReplacer.clone()
					.pathTabFile($path_tab_file)
					.pathTarget($data.Tabset_path)
					.replaceFolder($data.folder)
			
		;$Event.message(50)
		;this._TCcommand.loadTabs( $path )
	}
	/**
	 */
	setTabsPath()
	{
		IniRead, $tabs_path, %$ini_path%, paths, tabs 
		;return %$tabs_path% 
	}

}


/** 
*/
loadTabsCallback($Event)
{
	$TabsSwitcher.loadTabs($Event)
}	










