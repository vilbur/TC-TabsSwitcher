;#SingleInstance force
#Include %A_LineFile%\..\includes.ahk


/** Class TabsSwitcher
*/
Class TabsSwitcher
{
	_RootInfo	:= new RootInfo().parent(this)
	_TargetInfo	:= new TargetInfo()	
	_Gui	:= new Gui().parent(this)
	_Install 	:= new Install()
	;_ini_path	:=

	__New($current_path)
	{
		$TabsSwitcher := this
		;this._Gui.parent(this)
		;this._Gui.parent(this)		
		;Dump(this._ini_path, "this._ini_path", 1)
		;this._current_path	:= $current_path
		;Dump($current_path, "current_path", 1)
		this._setTabsPath()		
		this._setTabsetsIni()
		this._TargetInfo.findRootPath($current_path, this._getAllUniqueFiles())
		;Dump( this._RootInfo, "_RootInfo", 0)
		;Dump( this._TargetInfo, "_TargetInfo", 0)		
		this._getTabs()
	}
	/** managerGui
	*/	
	managerGui()
	{
		this._Gui.managerGui()
	}
	/** tabsetLoaderGui
	*/	
	tabsetLoaderGui()
	{
		if( ! this._RootInfo.isAnyRootExists())
			 new Example().parent(this).createExample()
			
		;Dump( this._RootInfo, "_RootInfo", 1)
		this._Gui.tabsetLoaderGui()
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
		For $i, $tabset in this._RootInfo._Roots
			$unique_files.insert($tabset.get("unique_file"))
		;Dump($unique_files, "unique_files", 1)
		return % $unique_files 
	} 
	;/** tabsetLoaderGui
	;*/
	;onSubmit($Event)
	;{
	;	$Event.message(50)
	;}
	/** tabsetLoaderGui
	*/
	loadTabs($Event)
	{
		$data	:= this._gui._getGuiData()
		$path := this._RootInfo.getRoot($data.root).getTabset( $data.tabset ).getTabFilePath( $data.tabs )
		
		if( $data.tabset=="_shared" )
			new IniReplacer($path, $data ).replaceFolderName()
			
		;MsgBox,262144,path, %$path%,3 
		;$Event.message(50)
		$TCcommand 	:= new TCcommand().loadTabs( $path )
	}	
	/**
	 */
	_getPathToTabset()
	{
		
	} 
	
}


/** tabsetLoaderGui
*/
loadTabsCallback($Event)
{
	$TabsSwitcher.loadTabs($Event)
}	










