#Include %A_LineFile%\..\includes.ahk

/** Class TabsSwitcher
*/
Class TabsSwitcher Extends Accessors
{
	_Tabsets	:= new Tabsets().parent(this)
	_TargetInfo	:= new TargetInfo()	
	_Gui	:= new Gui().parent(this)
	_Install 	:= new Install()
	_PathsReplacer 	:= new PathsReplacer()
	_MsgBox 	:= new MsgBox()
	_TotalCmd 	:= new TotalCmd().parent(this)

	__New()
	{
		$TabsSwitcher := this

		If ( ! FileExist( $ini_path ))
			this.install()
			
		this._Tabsets.loadTabsets()
		this._TargetInfo.findCurrentTabset( this._Tabsets )

		;Dump(this._Tabsets, "this._Tabsets", 0)
		;Dump(this._TargetInfo, "this._TargetInfo", 0)		
		;Dump(this._Tabsets._Tabsets.Tabs, "this._Tabsets._Tabsets.Tabs", 1)
		;Dump(this._Tabsets._Tabsets.Users, "this._Tabsets._Tabsets.Users", 1)				
	}

	/** createGui
	*/	
	createGui()
	{
		if( ! this._Tabsets.isAnyTabsetExists())
			 new Example().parent(this).createExample()

		this._Gui.createGui()
	}
	/**
	 */
	install()
	{
		;new TabsLoader().createCommandRunTabSwitcher( $path )
		this._Install
				.createCommands()
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

	/** Load Tabs file or go to target root folder
	  *
	  * Go to target root path if user try to load "_shared" tabs directly and current path is not in target
	  *		E.G.: if A_WorkingDir == "C:\foo\folder" and try to load tabs to "C:\program\files"  then go to "C:\program\files"
	  *
	  */
	loadTabs($tabset:="", $tabsgroup:="", $tabfile:="")
	{
		$data	:= this._getData( $tabset, $tabsgroup, $tabfile )
		$Tabset	:= this.Tabset($data.tabset)
		$path_tab_file	:= this.Tabfile( $data.tabset, $data.tabsgroup, $data.tabfile ).getPath()
		;$target_folder	:= $data.folder ? $data.folder : this.TargetInfo().get( "folder_current" )		
				
		;/* GO TO PATH
		;*/
		if( $tabfile && ! $Tabset.isPathInTarget( A_WorkingDir ) )
			this._goToTargetRoot( $Tabset.pathTarget() )
		
		
		/* REPLACE SHARED TABS
		*/
		if( $data.replace )
			this._PathsReplacer.clone()
					.pathTabFile( $path_tab_file )
					.searchRoots( $Tabset.getTabsRootsPaths() )
					.replaceRoot( $data.tabsetroot )
					.searchFolders( $Tabset.getTabsRootFoldersAll()  )
					.replaceFolder( $data.folder )
					.replace( $data.replace )
		
		IniWrite, % $data.tabset, %$ini_path%, tabset, last
		
		this.Tabset($data.tabset).saveLastToIni( $data.tabsetroot, $data.tabsgroup, $data.folder, $data.tabfile )
		
		/* LOAD TAB FILE
		*/
		this._TotalCmd._TcTabs.load( $path_tab_file, this._Gui._getOption("active_pane") )		
		
		if( this._Gui._getOption("title") )
			this._TotalCmd._setWindowTitleByTabs($data)
	}
	
	/** open *.tab file
	 */
	openTabs( $Event:="" )
	{
		$data	:= this._getData( $tabset, $tabsgroup, $tabfile )
		
		$path_tab_file	:= this.Tabfile( $data.tabset, $data.tabsgroup, $data.tabfile ).getPath()
		
		Run, Notepad++ %$path_tab_file%
	}


	/** get data object from gui or params
	 */
	_getData( $tabset:="", $tabsgroup:="", $tabfile:="" )
	{
		;if( ! $tabset && ! $tabsgroup && ! $tabfile )
			return % this._gui._getGuiData()
	
		;return %	{"tabsetroot":	$tabset
		;	,"tabset":	$tabset
		;	,"tabsgroup":	$tabsgroup
		;	,"tabfile":	$tabfile}
	}
	/**
	 */
	_goToTargetRoot( $path )
	{
		WinGet, $process_name , ProcessName, ahk_class TTOTAL_CMD
		Run, %COMMANDER_PATH%\%$process_name% /O /S /L=%$path%
		exitApp
	}

	/** set\get parent class
	 * @return object parent class
	*/
	Parent(){
		return this
	}

}


/** 
*/
loadTabsCallback($Event)
{
	$TabsSwitcher.loadTabs($Event)
}	










