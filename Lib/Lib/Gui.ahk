
/** Class Gui
*/
Class Gui Extends Parent
{

	_gui := new VilGUI("TabsSwitcher")
	
	/*---------------------------------------
		CREATE GUI
	-----------------------------------------
	*/
	/** tabsetLoaderGui
	 */
	tabsetLoaderGui()
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
			.GroupBox("TabSet").add("GBTabSet")
			.Text("Current: " this._TargetInfo().get("folder_current") )
				.options("w148")
				.add()
			
			.Dropdown( "New||Rename|Delete" )
				;.label("Action")
				;.callback( &this "._tabsetChanged", $tab_name )
				;.items( "New||Rename|Delete" )
				.checked( this._Root($tab_name).get("last_tabset") )					
				.add("RootAction")
		;.section()
	}
	/**
	 */
	_addTabs()
	{
		$tabset_names	:= this._RootInfo()._getTabsetsNames()
		this._Tabs	:= this._gui.Tabs( $tabset_names ).add("TabsetTabs").get()
		For $i, $tabset_name in $tabset_names
			this._addTab( $i, $tabset_name )

	}
	/**
	 */
	_addTab( $index, $tab_name )
	{
		this._addTabset( $index, $tab_name )		
		this._addRootFolders( $index, $tab_name )
		this._addTabsListControls($index, $tab_name)
	}
	/**
	 */
	_addTabset( $index, $tab_name )
	{
		this._Tabs.Tabs[$index].Controls.layout("row")
			.GroupBox("TabSet").add("GBTabSet")
			
			.Dropdown( this._Root($tab_name)._getFolderNames() )
				.checked( this._Root($tab_name).getLastTabSet() )
				;.checked(1)
				.callback( &this "._tabsetChanged" )
				.add("ddTabSet")
				
			.Dropdown( "New||Rename|Copy|Delete" )
				;.checked( this._Root($tab_name).get("last_tabset") )					
				.add("TabsetAction")
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
			
				.ListBox( this._Tabset($tab_name, "_shared" ).getTabFilenames() )
					.checked( this._Root($tab_name).get("last_tabs") )
					.callback( &this "._tablistChanged" )
					.options("w128 h256 -Multi")
					.add("TabsList")
				.section()
			
				.Dropdown("New||Rename|Copy|Delete" )
					.options("w128 h246")
					;.checked( this._Root($tab_name).get("last_tabset") )
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
		return % this._gui.TabsetTabs.getActive()		
	}
	/**
	 */
	_getGuiData()
	{
		$tab := this._getActiveTab()
		return %	{"root":	$tab.name()
			,"root_path":	this._Root( $tab.name() ).get("root")
			,"folder":	$tab.Controls.get("FoldersList").value()			
			,"tabset":	$tab.Controls.get("ddTabSet").value()			
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
		
		$tabs_names := this._Tabset($data.root, $data.tabset ).getTabsCaptions($data.tabs)
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
	_tabsetChanged( $Event )
	{
		$data	:= this._getGuiData()
			
		this.updateTabNamesLookUp( $data )
		
		this._getActiveTab().Controls.get("TabsList")
			.clear()
			.edit( this._Tabset( $data.root, $data.tabset ).getTabFilenames() )
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

