
/** Class Gui
*/
Class Gui Extends Parent
{
	_gui := new VilGUI("TabsSwitcher")
	
	/*---------------------------------------
		CREATE GUI
	-----------------------------------------
	*/
	/** createGui
	 */
	createGui()
	{
		this._addTabsetControls()
		this._addTabs()
		this._addMainButtons()
		this._createGui()
		this.updateTabNamesLookUp()		
		this._focusTablist()
	}
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
		this._addTabfiles( $index, $tab_name )		
		this._addTabsetFolders( $index, $tab_name )
		this._addTabsListControls($index, $tab_name)
	}
	/**
	 */
	_addTabfiles( $index, $tab_name )
	{
		this._Tabs.Tabs[$index].Controls.layout("row")
			.GroupBox("Tabfiles").add("GB_Tabfiles")
			
			.Dropdown( this._Tabset($tab_name)._getFolderNames() )
				.checked( this._Tabset($tab_name).getLastTabfiles() )
				;.checked(1)
				.callback( &this "._TabfilesChanged" )
				.add("DD_Tabfiles")
				
			.Dropdown( "New||Rename|Copy|Delete" )
				;.checked( this._Tabset($tab_name).get("last_Tabfiles") )					
				.add("DD_TabfilesAction")
			;.groupEnd()
			.section()			
	}
	
	/**
	 */
	_addTabsetFolders( $index, $tab_name )
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
	_addTabsListControls( $index, $tab_name )
	{
		this._Tabs.Tabs[$index].Controls
			.GroupBox("Tabs").layout("column").add("GBTabs")
			
				.ListBox( this._Tabfiles($tab_name, "_shared" ).getTabFilenames() )
					.checked( this._Tabset($tab_name).get("last_tabs") )
					.callback( &this "._tablistChanged" )
					.options("w128 h256 -Multi")
					.add("LB_TabsList")
				.section()
			
				.Dropdown("New||Rename|Copy|Delete" )
					.options("w128 h246")
					;.checked( this._Tabset($tab_name).get("last_Tabfiles") )
					.add("DD_TabsAction")
					
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
		
		this._gui.Events.Gui.onEscape("exit")
		
		this._gui.create()
				 .center("window")
	} 
	/*---------------------------------------
		ACTIONS
	-----------------------------------------
	*/
	/**
	 */
	_getActiveTab()
	{
		return % this._gui.Tabs_Tabsets.getActive()		
	}
	/**
	 */
	_getGuiData()
	{
		;MsgBox,262144,, _getGuiData,2 
		$tab := this._getActiveTab()
		;Dump($tab, "tab", 1)
		return %	{"tabset":	$tab.name()
			,"tabfiles":	$tab.Controls.get("DD_Tabfiles").value()			
			,"folder":	$tab.Controls.get("LB_FoldersList").value()			
			,"tabs":	$tab.Controls.get("LB_TabsList").value()}
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
		;MsgBox,262144,, updateTabNamesLookUp,2 
		if( !$data )
			$data	:= this._getGuiData()
		;Dump($data, "data", 1)
		$tabs_names := this._Tabfiles($data.tabset, $data.tabfiles ).getTabsCaptions($data.tabs)
		;Dump($tabs_names, "tabs_names", 1)
		this._getActiveTab().Controls.get("TabNamesLookUp").edit( $tabs_names )
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
		
		this._getActiveTab().Controls
							.get("TabsList")
								.clear()
								.edit( this._Tabfiles( $data.tabset, $data.tabfiles ).getTabFilenames() )
								.select( 1 )
	}
	/**
	 */
	_tablistChanged( $Event )
	{
		$data	:= this._getGuiData()
		this.updateTabNamesLookUp( $data )
	}
	

}

