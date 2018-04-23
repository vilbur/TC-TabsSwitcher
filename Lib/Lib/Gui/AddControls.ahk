/** Create controls
 *
 */
Class AddControls Extends GuiControl
{
	/*---------------------------------------
		TABS
	-----------------------------------------
	*/
	static _LB_WIDTH := " w164 "
	
	static _LB_HEIGHT	:= " h164 "
	
	/**
	 */
	_addControls()
	{
		this._gui.controls.layout("row")
		
		this._addTabsetControls()
		this._addOptions()
		
		this._gui.controls.section()
		this._addTabs()
		
		this._gui.controls.section()		
		this._addPaneLookUp()		
		this._addMainButtons()
	}
	
	/**
	 */
	_addTabsetControls()
	{
		this._gui.controls
			.Dropdown( "Add|Rename|Remove" )
				.checked( this.Tabset(this._tab.name).get("last_tabsgroup") )
				.callback( &this "._DD_Changed", "tabSet" ) 
				.add("DD_tabset")
	}
	/**
	 */
	_addOptions()
	{
		this._gui.controls
			.GroupBox( "Options" )
				;.layout($layout)
				.options( "y-12" )
				.add("GB_Options")
			
			.Checkbox("Title")
				.options( "y-8 w48" )
				.checked( this._getOption("title") )
				.callback( &this "._setOption", "title" )
				.add("CBX_option_title")
			.Checkbox("On Top")
				.options( "x-4 w64" )
				.checked( this._getOption("on_top") )
				.callback( &this "._setOption", "on_top" )
				.add("CBX_option_onTop")
			.Checkbox("Center")
				.options( "x-4 w64" )
				.checked( this._getOption("center_window") )
				.callback( &this "._setOption", "center_window" )
				.add("CBX_option_CenterWindow")
				
			.Dropdown( "Active||left|right" )
				.checked( this._getOption("active_pane") )
				.options( "x-4 w64" )
				.callback( &this "._setOption", "active_pane" )
				.add("DD_option_activePane")
				
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
		if(this._tab.name=="_Tabs" )
			return
			
		$Tabset := this.Tabset(this._tab.name)
		
		this._GroupBox( "TabsetRoot" )
			.ListBox( $Tabset.getTabsRootsPaths() )
				.checked( $Tabset.getLast("root") )					
				.callback( &this "._LB_TabsetRootChanged" )
				.options("w520 h64 -Multi")
				.add("LB_TabsetRoot")
			
			this._addDropdown("TabsetRoot", "Add|Remove", "x-92 y-24")
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
				.options("h128 -Multi " this._LB_WIDTH)
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
		if(this._tab.name=="_Tabs" )
			return
		
		$Tabset	:= this.Tabset(this._tab.name)
		$root_last	:= $Tabset.getLast("root")
		$tabsgroup_last	:= $Tabset.getLast("tabsgroup")
		$tab_folders	:= $tabsgroup_last=="_shared" ? $Tabset._getTabsRootFolders($root_last) : ""

		this._GroupBox("Folders", "Folders in root")
				.ListBox( $tab_folders )
					.checked( $Tabset.getLastFolder($root_last) )					
					.callback( &this "._LB_FolderChanged" )
					.options("y+8 -Multi " this._LB_WIDTH this._LB_HEIGHT)
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
				.options("x-78 -Multi red" this._LB_WIDTH this._LB_HEIGHT)
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
			.section()
			;.GroupBox().layout("row").add("MainButtons")
				.Button()
					.callback( this._Parent ".loadTabs" )
					.options("h48 w440")
					.submit("Load")
				.Button()
					.callback( this._Parent ".loadTabs" )
					.options("w96 h48")
					.exit("Exit")
					
				;.Button()
					;.callback( &this "._BTN_TEST" )
					;;.options("w96 h48")
					;.add("TEST")		
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
		
		$options := this._tab.name=="_Tabs"	? ($name=="TabsGroup" ? "y+64 " : "") "x+64" : ""	

		$GroupBox	:= this._tabControls()
					 .GroupBox( $label ? $label : $name )
						.layout($layout)
						.options( $options )
						.add("GB_" $name)

		this._resetFont()
		
		return $GroupBox
	}
	/**
	 */
	_addDropdown( $name, $items:="Add|Rename|Remove", $options:="x+78" )
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


