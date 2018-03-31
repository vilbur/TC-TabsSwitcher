/** Create controls
 *
 *
 */
Class GuiControls Extends GuiControlsMethods
{
	/**
	 */
	_addTabsetControls()
	{
		this._gui.controls
			.GroupBox("Tabsets").add("GB_Tabsets")
			.Text("Current: " this._TargetInfo().get("folder_current") )
				.options("w148")
				.add()
			
			.Dropdown( "New||Rename|Delete" )
				.checked( this._Tabset($tab_name).get("last_tabfiles") )					
				.add("DD_TabsetsAction")
		;.section()
	}
	/**
	 */
	_addTabs()
	{
		$Tabfiles_names	:= this._Tabsets()._getTabfilesNames()
		this._Tabs	:= this._gui.Tabs( $Tabfiles_names ).add("Tabs_Tabsets").get()
		For $i, $Tabfiles_name in $Tabfiles_names
			this._addTab( $i, $Tabfiles_name )

	}
	/**
	 */
	_addTab( $index, $tab_name )
	{
		this._addTabfilesSection( $index, $tab_name )		
		this._addFoldersSection( $index, $tab_name )
		this._addTabsSection($index, $tab_name)
	}
	/**
	 */
	_addTabfilesSection( $index, $tab_name )
	{
		this._Tabs.Tabs[$index].Controls.layout("row")
			
			.GroupBox("Tabfiles")
				.layout("column")
				.add("GB_Tabfiles")

			.ListBox( this._Tabset($tab_name)._getFolderNames() )
				.checked( this._Tabset($tab_name).getLastTabfiles() )					
				.callback( &this "._tabfilesChanged" )
				.options("w128 h256 -Multi")
				.add("LB_Tabfiles")
				
			.Dropdown( "New||Rename|Copy|Delete" )
				.add("LB_TabfilesAction")
	}
	
	/**
	 */
	_addFoldersSection( $index, $tab_name )
	{
		this._Tabs.Tabs[$index].Controls
			.GroupBox("Folders")
					.layout("column")
					.add("GB_Tabs")
			
				.ListBox( this._Tabset($tab_name)._getTabsetFolders() )
					.checked( 1 )					
					.callback( &this "._tablistChanged" )
					.options("w128 h256 -Multi")
					.add("LB_FoldersList")
			;.section()
	} 

	/** Add Listbox and other controls
	 */
	_addTabsSection( $index, $tab_name )
	{
		this._Tabs.Tabs[$index].Controls
			.GroupBox("Tabs").layout("column").add("GBTabs")

					
				.ListBox( this._Tabfiles($tab_name, "_shared" ).getTabFilenames() )
					.checked( this._Tabset($tab_name).get("last_tabs") )
					.callback( &this "._tablistChanged" )
					.options("w128 h256 -Multi")
					.add("LB_TabsList")
					
				.Dropdown("New||Rename|Copy|Delete" )
					.options("w128 h246")
					;.checked( this._Tabset($tab_name).get("last_Tabfiles") )
					.add("DD_TabsAction")
				.section()
			

					
				.Text()
					.options("w128 h220 top")
					.add("TabNamesLookUp")
	}
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
	}



	

}

