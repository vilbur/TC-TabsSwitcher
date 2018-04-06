/** Create controls
 *
 *
 */
Class GuiControls Extends GuiControlsMethods
{
	/*---------------------------------------
		TABS
	-----------------------------------------
	*/
	/**
	 */
	_addTabsetControls()
	{
		this._gui.controls
			.GroupBox("Tabsets").add("GB_Tabsets")
			.Text("Current: " this.TargetInfo().get("folder_current") )
				.options("w148")
				.add()
			
			.Dropdown( "Action||New|Rename|Delete" )
				.checked( this.Tabset($tab_name).get("last_tabsgroup") )
				.callback( &this "._DD_TabsetsChanged" ) 
				.add("DD_Tabsets")
		;.section()
	}
	/**
	 */
	_addTabs()
	{
		IniRead, $active_tab, %$ini_path%, tabset, last 
		
		$Tabfiles_names	:= this.Tabsets()._getTabfilesNames()

		this._Tabs	:= this._gui.Tabs( $Tabfiles_names )
						.checked($active_tab)
						;.checked(2)
						.add("Tabs_Tabsets")
						.get()
		
		;Dump($Tabfiles_names, "Tabfiles_names", 1)		
		For $i, $Tabfiles_name in $Tabfiles_names
			this._addTab( $i, $Tabfiles_name )
		;Dump($Tabfiles_name, "Tabfiles_name", 1)
	}
	/**
	 */
	_addTab( $index, $tab_name )
	{
		;Dump($tab_name, "tab_name", 1)
		this._addTargetRoot( $index, $tab_name )
		this._addTabsGroupSection( $index, $tab_name )				
		this._addFoldersSection( $index, $tab_name )
		this._addTabsSection($index, $tab_name)
	}
	/*---------------------------------------
		TABS CONTENT
	-----------------------------------------
	*/
	/**
	 */
	_addTargetRoot( $index, $tab_name )
	{
		if( $tab_name=="_Tabs" )
			return 
		
		this._Tabs.Tabs[$index].Controls.layout("row")
			.GroupBox("Type of tabset")
				.layout("row")
				.add("GB_TabsGroup")
				
			;.File( this.Tabset($tab_name).get("path_target") )
			;.label(false)
			;	.options("w545")
			;	.callback("callBackTestX")
			;	.add()
			;.Text()
			;	.options("w320")
			;	.value(this.Tabset($tab_name).get("path_target"))
			;	.add("EDIT_TabsetType")	
			.ListBox( this.Tabset($tab_name).getTabsRootsPaths() )
				.checked( this.Tabset($tab_name).getLast("root") )					
				.callback( &this "._LB_TabsetRootChanged" )
				.options("w400 h64 -Multi")
				.add("LB_TabsetRoot")
			
			.Dropdown("root folder||unique folder|unique file")
				.callback( &this "._DD_TabsetTypeChanged")

				.add("DD_TabsetType")			
			
		.section()
	}
	/*---------------------------------------
		TABSGROUP
	-----------------------------------------
	*/
	/**
	 */
	_addTabsGroupSection( $index, $tab_name )
	{
		;Dump($tab_name, "tab_name", 1)
		this._Tabs.Tabs[$index].Controls.layout("row")
			.GroupBox("TabsGroup")
				.layout("row")
				.add("GB_TabsGroup")
				
				.Radio()
					.items(["Root","Folder"])
					.callback( &this "._R_replaceChanged" )
					.options("w64")
					.checked(1)
					.add("R_replace")	
			.section()
			
				.ListBox( this.Tabset($tab_name)._getTabsGroupsNames() )
					.checked( this.Tabset($tab_name).getLast("tabsgroup") )					
					.callback( &this "._LB_TabsGroupChanged" )
					.options("w128 h228 -Multi")
					.add("LB_TabsGroup")
			.section()
					
				.Dropdown( "New||Rename|Copy|Delete" )
					.add("DD_TabsGroup")
	}
	/*---------------------------------------
		ROOT FOLDERS
	-----------------------------------------
	*/
	/** Add folders in target root
	  * not showed if unique tabs
	 */
	_addFoldersSection( $index, $tab_name )
	{
		;$tab_folders := this.Tabset($tab_name)._getTabsRootFolders("C:\Git\Laravel-Packages")
		$tab_folders := this.Tabset($tab_name)._getTabsRootFolders(this.Tabset($tab_name).getLast("root"))
		
		;if( $tab_folders.length()>0 )
			this._Tabs.Tabs[$index].Controls
				.GroupBox("Folders")
						.layout("column")
						.add("GB_FoldersList")
				
					.ListBox( $tab_folders )
						.checked( this.Tabset($tab_name).getLast("folder") )					
						.callback( &this "._LB_FolderChanged" )
						.options("w128 h256 -Multi")
						.add("LB_Folder")
				;.section()
	} 
	/*---------------------------------------
		TABS FILES
	-----------------------------------------
	*/
	/** Add Listbox and other controls
	 */
	_addTabsSection( $index, $tab_name )
	{
		this._Tabs.Tabs[$index].Controls
			.GroupBox("Tabs").layout("column").add("GB_Tabfile")
					
				.ListBox( this.TabsGroup($tab_name, "_shared" ).getTabFilenames() )
					;.checked( this.Tabset($tab_name).get("last_tabs") )
					.checked( this.Tabset($tab_name).getLast("tabfile") )					
					.callback( &this "._LB_TabfileChanged" )
					.options("w128 h256 -Multi")
					.add("LB_Tabfile")
					
				.Dropdown("New||Create command|Rename|Copy|Delete" )
					.options("w128 h246")
					;.checked( this.Tabset($tab_name).get("last_Tabfiles") )
					.callback( &this "._DD_TabfileChanged" )
					.add("DD_Tabfile")
				.section()
					
				.Text()
					.options("w128 h220 top")
					.add("TabsNameLookUp")
	}
	/*---------------------------------------
		MAIN CONTROLS BELLOW TABS
	-----------------------------------------
	*/
	/** 
	 */
	_addMainButtons()
	{
		this._gui.Controls
		;.section()
			.GroupBox().layout("row").add("MainButtons")

			.Button()
				.callback( this._Parent ".loadTabs" )
				.options("h48 w320")
				.submit("Load")
			.Button()
				.callback( this._Parent ".loadTabs" )
				.options("w96 h48")
				.exit("Exit")
				
			.Button()
				.callback( &this "._BTN_TEST" )
				.options("w96 h48")
				.add("TEST")		
	}

}


