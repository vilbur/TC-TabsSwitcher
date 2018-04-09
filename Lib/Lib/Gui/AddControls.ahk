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
			.Dropdown( "Add||Rename|Remove" )
				.checked( this.Tabset(this._tab.name).get("last_tabsgroup") )
				.callback( &this "._DD_Changed", "tabSet" ) 
				.add("DD_tabset")
	}
	/**
	 */
	_addTabs()
	{
		IniRead, $active_tab, %$ini_path%, tabset, last 
		
		$tabsets_names	:= this.Tabsets()._getTabfilesNames()

		this._Tabs	:= this._gui.Tabs( $tabsets_names )
						.checked($active_tab)
						.callback( &this "._TabsChanged" ) 
						.add("Tabs_Tabsets")
						.get()
		
		For $i, $Tabfiles_name in $tabsets_names
			this._addTab( $i, $Tabfiles_name )
	}
	/**
	 */
	_addTab( $tab_index, $tab_name )
	{
		this._tab := {"index":	$tab_index, "name": $tab_name}
		
		this._addTargetRoot()
		this._addTabsGroupSection()				
		this._addFoldersSection()
		this._addTabfileSection()
	}
	/*---------------------------------------
		TABS CONTENT
	-----------------------------------------
	*/
	/**
	 */
	_addTargetRoot()
	{
		if( $tab_name=="_Tabs" )
			return
			
		$Tabset := this.Tabset(this._tab.name)
		
		this._GroupBox( "TabsetRoot" )
			.ListBox( $Tabset.getTabsRootsPaths() )
				.checked( $Tabset.getLast("root") )					
				.callback( &this "._LB_TabsetRootChanged" )
				.options("w520 h64 -Multi")
				.add("LB_TabsetRoot")
			
			this._addDropdown("TabsetRoot", "Add||Remove", "x-92 y-24")
		.section()
	}
	


	/*---------------------------------------
		TABSGROUP
	-----------------------------------------
	*/
	/**
	 */
	_addTabsGroupSection()
	{
		$Tabset	:= this.Tabset(this._tab.name)
		$tabsgroup_last	:= $Tabset.getLast("tabsgroup")
		
		this._tabControls().layout("row")
				
		this._GroupBox("TabsGroup" )
			this._addDropdown("TabsGroup")
			
		.section()

			.Radio()
				.items(["Root","Folder"])
				.callback( &this "._R_replaceChanged" )
				.options("x+8 w72 h30")
				.checked( $tabsgroup_last=="_shared"?1:0 )
				;.checked( $tabsgroup_last )				
				.add("R_replace")
				
		.section()
		
			.ListBox( $Tabset._getTabsGroupsNames() )
				;.checked( $tabsgroup_last!="_shared" ? $tabsgroup_last : 0 )					
				.checked( $tabsgroup_last )				
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
	_addFoldersSection()
	{
		$Tabset	:= this.Tabset(this._tab.name)
		$tab_folders	:= $Tabset._getTabsRootFolders($Tabset.getLast("root"))
		
		this._GroupBox("Folders", "Folders in root")
				.ListBox( $tab_folders )
					.checked( $Tabset.getLastFolder($Tabset.getLast("root")) )					
					.callback( &this "._LB_FolderChanged" )
					.options("h252 y+8 -Multi " this._LB_WIDTH)
					.add("LB_Folder")
	} 
	/*---------------------------------------
		TABS FILES
	-----------------------------------------
	*/
	/** Add Listbox and other controls
	 */
	_addTabfileSection()
	{
		$Tabset	:= this.Tabset(this._tab.name)
		$tabsgroup_last	:= $Tabset.getLast("tabsgroup")

		this._GroupBox("Tabfile", "*.tab files", "column" )
			this._addDropdown("TabFile")

			.ListBox( this.TabsGroup(this._tab.name, $tabsgroup_last!=1 ? $tabsgroup_last : "_shared" ).getTabFilenames() )
				;.checked( this.Tabset(this._tab.name).get("last_tabs") )
				.checked( this.Tabset(this._tab.name).getLast("tabfile") )					
				.callback( &this "._LB_TabfileChanged" )
				.options("x-78 h256 -Multi " this._LB_WIDTH)
				.add("LB_Tabfile")
				
			;.section()
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
	}

	/*---------------------------------------
		HELPERS
	-----------------------------------------
	*/
	/** Add styled groupbox
	 */
	_GroupBox( $name, $label:="", $layout:="row")
	{
		this._setFont()
		
		$GroupBox	:= this._tabControls()
					 .GroupBox( $label ? $label : $name )
						.layout($layout)
						.add("GB_" $name)

		this._resetFont()
		
		return $GroupBox
	}
	/**
	 */
	_addDropdown( $name, $items:="Add||Rename|Remove", $options:="x+78" )
	{
		return % this._tabControls()
						.Dropdown( $items )
							;.options("x+78 y-24 w72 " $options)
							.options("y-24 w72 " $options)							
							;.options($options)							
							.callback( &this "._DD_Changed", $name ) 
							.add("DD_" $name)
	}
	/**
	 */
	_tabControls()
	{
		return this._Tabs.Tabs[this._tab.index].Controls
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


