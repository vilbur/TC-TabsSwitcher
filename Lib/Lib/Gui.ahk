
/** Class Gui
*/
Class Gui Extends Parent
{

	_gui := new VilGUI("TabsSwitcher")
	
	/*---------------------------------------
		CREATE GUI
	-----------------------------------------
	*/
	/** TabfilesLoaderGui
	 */
	TabfilesLoaderGui()
	{
		this._addRootControls()
		this._addTabs()
		this._addMainButtons()
		this._createGui()
		this.updateTabNamesLookUp()		
		this._focusTablist()
	}
	/**
	 */
	_addRootControls()
	{
		this._gui.controls
			.GroupBox("Tabfiles").add("GBTabfiles")
			.Text("Current: " this._TargetInfo().get("folder_current") )
				.options("w148")
				.add()
			
			.Dropdown( "New||Rename|Delete" )
				;.label("Action")
				;.callback( &this "._TabfilesChanged", $tab_name )
				;.items( "New||Rename|Delete" )
				.checked( this._Root($tab_name).get("last_Tabfiles") )					
				.add("RootAction")
		;.section()
	}
	/**
	 */
	_addTabs()
	{
		$Tabfiles_names	:= this._RootInfo()._getTabfilessNames()
		this._Tabs	:= this._gui.Tabs( $Tabfiles_names ).add("TabfilesTabs").get()
		For $i, $Tabfiles_name in $Tabfiles_names
			this._addTab( $i, $Tabfiles_name )

	}
	/**
	 */
	_addTab( $index, $tab_name )
	{
		this._addTabfiles( $index, $tab_name )		
		this._addRootFolders( $index, $tab_name )
		this._addTabsListControls($index, $tab_name)
	}
	/**
	 */
	_addTabfiles( $index, $tab_name )
	{
		this._Tabs.Tabs[$index].Controls.layout("row")
			.GroupBox("Tabfiles").add("GBTabfiles")
			
			.Dropdown( this._Root($tab_name)._getFolderNames() )
				.checked( this._Root($tab_name).getLastTabfiles() )
				;.checked(1)
				.callback( &this "._TabfilesChanged" )
				.add("ddTabfiles")
				
			.Dropdown( "New||Rename|Copy|Delete" )
				;.checked( this._Root($tab_name).get("last_Tabfiles") )					
				.add("TabfilesAction")
			;.groupEnd()
			.section()			
	}
	
	/**
	 */
	_addRootFolders( $index, $tab_name )
	{
		this._Tabs.Tabs[$index].Controls
			.GroupBox("Folders")
					.layout("column")
					.add("GBTabs")
			
				.ListBox( this._Root($tab_name)._getRootFolders() )
					;.checked( this._Root($tab_name).get("last_tabs") )
					.checked( 1 )					
					.callback( &this "._tablistChanged" )
					.options("w128 h256 -Multi")
					.add("FoldersList")
			;.section()
	} 

	/** Add Listbox and other controls
	 */
	_addTabsListControls( $index, $tab_name )
	{
		this._Tabs.Tabs[$index].Controls
			.GroupBox("Tabs").layout("column").add("GBTabs")
			
				.ListBox( this._Tabfiles($tab_name, "_shared" ).getTabFilenames() )
					.checked( this._Root($tab_name).get("last_tabs") )
					.callback( &this "._tablistChanged" )
					.options("w128 h256 -Multi")
					.add("TabsList")
				.section()
			
				.Dropdown("New||Rename|Copy|Delete" )
					.options("w128 h246")
					;.checked( this._Root($tab_name).get("last_Tabfiles") )
					.add("TabsAction")
					
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
	/**
	 */
	_createGui()
	{
		this._gui.Margin.x(5).y(10) ; set margin for all - UI, CONTAINERS & CONTROLS
		;this._gui.Margin.ui.x( 30 ).y(20)	; set margin around window
		;this._gui.Margin.container.x( 0 ).y(15)	; set margin between groupboxes
		;this._gui.Margin.control.x( 30 ).y(5)	; set margin between controls
		
		this._gui.create()		
	} 
	/*---------------------------------------
		ACTIONS
	-----------------------------------------
	*/
	/**
	 */
	_getActiveTab()
	{
		return % this._gui.TabfilesTabs.getActive()		
	}
	/**
	 */
	_getGuiData()
	{
		$tab := this._getActiveTab()
		return %	{"root":	$tab.name()
			,"root_path":	this._Root( $tab.name() ).get("root")
			,"folder":	$tab.Controls.get("FoldersList").value()			
			,"Tabfiles":	$tab.Controls.get("ddTabfiles").value()			
			,"tabs":	$tab.Controls.get("TabsList").value()}
	} 
	/**
	 */
	_setDropdownItems($control_name, $items, $selected:="")
	{
		this._gui.Controls.get($control_name)
			.clear()
			.edit($items)
	} 
	/**
	 */
	_getControlValue($control_name)
	{
		return % this._gui.Controls.get($control_name).value()
	}
	/**
	 */
	updateTabNamesLookUp( $data:="" )
	{
		if( !$data )
			$data	:= this._getGuiData()
		
		$tabs_names := this._Tabfiles($data.root, $data.Tabfiles ).getTabsCaptions($data.tabs)
		this._getActiveTab().Controls.get("TabNamesLookUp").edit($tabs_names )
	}
	/**
	 */
	_focusTablist()
	{
		this._getActiveTab().Controls.get("TabsList").focus()		
	}
 
	/*---------------------------------------
		CALLBACKS
	-----------------------------------------
	*/
	/**
	 */
	_TabfilesChanged( $Event )
	{
		$data	:= this._getGuiData()
			
		this.updateTabNamesLookUp( $data )
		
		this._getActiveTab().Controls.get("TabsList")
			.clear()
			.edit( this._Tabfiles( $data.root, $data.Tabfiles ).getTabFilenames() )
			.select( 1 )
	}
	/**
	 */
	_tablistChanged( $Event )
	{
		$data	:= this._getGuiData()
		this.updateTabNamesLookUp( $data )
	}
	
	/*---------------------------------------
		PARENT ACCESS
	-----------------------------------------
	*/





	
}

