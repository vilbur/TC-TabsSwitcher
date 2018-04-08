/** Create controls
 *
 */
Class AddControls Extends GuiControl
{
	/*---------------------------------------
		TABS
	-----------------------------------------
	*/
	
	static _LB_WIDTH := "w164"
	
	/**
	 */
	_addTabsetControls()
	{
		this._gui.controls
			;.GroupBox("Tabsets").add("GB_Tabsets")
			;.Text("Current: " this.TargetInfo().get("folder_current") )
			;	.options("w148")
			;	.add()
			
			.Dropdown( "Add||Rename|Remove" )
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
		
		$tabsets_names	:= this.Tabsets()._getTabfilesNames()

		this._Tabs	:= this._gui.Tabs( $tabsets_names )
						.checked($active_tab)
						;.checked(2)
						.add("Tabs_Tabsets")
						.get()
		
		For $i, $Tabfiles_name in $tabsets_names
			this._addTab( $i, $Tabfiles_name )
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
			
		$Tabset := this.Tabset($tab_name)
		
		this._GroupBox($index, "TabsetRoot" )
			.ListBox( $Tabset.getTabsRootsPaths() )
				.checked( $Tabset.getLast("root") )					
				.callback( &this "._LB_TabsetRootChanged" )
				.options("w520 h64 -Multi")
				.add("LB_TabsetRoot")
			
			.Dropdown("Add||Remove")
				.options("w72 x-92 y-24")
				.callback( &this "._DD_TabsetRootChanged")
				.add("DD_TabsetRoot")
				
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
		$Tabset := this.Tabset($tab_name)
		
		this._Tabs.Tabs[$index].Controls.layout("row")
				
		this._GroupBox($index, "TabsGroup" )
			.Dropdown( "Add||Rename|Remove" )
				.options("x+78 y-24 w72")
				.callback( &this "._DD_TabsGroupChanged" )
				.add("DD_TabsGroup")
			.section()

			.Radio()
				.items(["Root","Folder"])
				.callback( &this "._R_replaceChanged" )
				.options("x+8 w72 h30")
				.checked(1)
				.add("R_replace")	
		.section()
		
			.ListBox( $Tabset._getTabsGroupsNames() )
				.checked( $Tabset.getLast("tabsgroup") )					
				.callback( &this "._LB_TabsGroupChanged" )
				.options("h220 -Multi " this._LB_WIDTH)
				.add("LB_TabsGroup")
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
		$Tabset	:= this.Tabset($tab_name)
		$tab_folders	:= $Tabset._getTabsRootFolders($Tabset.getLast("root"))
		
		;if( $tab_folders.length()>0 )
			;this._Tabs.Tabs[$index].Controls
			;	.GroupBox("Folders")
			;			.layout("column")
			;			.add("GB_FoldersList")
		this._GroupBox($index, "Folders", "Folders in root")
			.ListBox( $tab_folders )
				.checked( $Tabset.getLastFolder($Tabset.getLast("root")) )					
				.callback( &this "._LB_FolderChanged" )
				.options("h252 y+8 -Multi " this._LB_WIDTH)
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

		this._GroupBox($index, "Tabfile", "*.tab files", "column" )
					.Dropdown("New||Command|Rename|Copy|Delete" )
				;.options("w128 h246")
						.options("x+78 y-24 w72")
				;.checked( this.Tabset($tab_name).get("last_Tabfiles") )
				.callback( &this "._DD_TabfileChanged" )
				.add("DD_Tabfile")

			.ListBox( this.TabsGroup($tab_name, "_shared" ).getTabFilenames() )
				;.checked( this.Tabset($tab_name).get("last_tabs") )
				.checked( this.Tabset($tab_name).getLast("tabfile") )					
				.callback( &this "._LB_TabfileChanged" )
				.options("x-78 h256 -Multi " this._LB_WIDTH)
				.add("LB_Tabfile")
			.section()
		.GroupEnd()
	}
	
	/*---------------------------------------
		LOOKUP
	-----------------------------------------
	*/
	/**
	 */
	_addPaneLookUp()
	{
		this._gui.Controls.GroupBox().options("y-18").add("MainButtons")
		
		For $pane, $style in {"left":"cGreen", "right":"cBlue"}
		{
			this._setFont( "s8", $style  )
			this._gui.Controls.Text()
								.options(" w268 h40 top " ($i==1?"y-10":"")  )
								.add("TEXT_pane_" $pane )
		}
								
		this._resetFont()
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
			.GroupBox().layout("row").add("MainButtons")

				.Button()
					.callback( this._Parent ".loadTabs" )
					.options("h48 w320")
					.submit("Load")
				.Button()
					.callback( this._Parent ".loadTabs" )
					.options("w96 h48")
					.exit("Exit")
				;.Button()
				;	.callback( &this "._BTN_TEST" )
				;	.options("w96 h48")
				;	.add("TEST")		
	}

	/*---------------------------------------
		HELPERS
	-----------------------------------------
	*/
	/** Add styled groupbox
	 */
	_GroupBox( $index, $name, $label:="", $layout:="row")
	{
		this._setFont()
		
		$GroupBox	:= this._Tabs.Tabs[$index].Controls
					 .GroupBox( $label ? $label : $name )
						.layout($layout)
						.add("GB_" $name)

		this._resetFont()
		
		return $GroupBox
	}
	/**
	 */
	_setFont( $size:="s8", $color:="cBlue bold" )
	{
		this._gui.gui("Font",  $size " " $color )
	}
	/**
	 */
	_resetFont()
	{
		this._gui.gui("Font")
	}
	
	

}


