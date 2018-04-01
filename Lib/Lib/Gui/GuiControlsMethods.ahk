/** methods for controls
 *
 *
 */
Class GuiControlsMethods Extends GuiCallback
{
	_last_selected_folders	:= {}
	
	/** fill listbox if tabsgroup changed to "_shared"
	    clear listbox if tabsgroup not "_shared"
		
		temporary save selection to _last_selected_folders
	 */
	_editTabsgroupListBox( $data )
	{
		$Tab 	:= this._getActiveTab()
		$LB_FoldersList	:= $Tab.Controls.get("LB_FoldersList")
		
		if ($data.tabsgroup=="_shared"){
			
			$LB_FoldersList.edit( this.Tabset($data.tabset)._getTabsetFolders() )
							.select( this._last_selected_folders[$data.tabset] )				
		} else {
			this._last_selected_folders[$data.tabset] := $LB_FoldersList.value()
			$LB_FoldersList.clear()
		}
	}

	/**
	 */
	_getActiveTab()
	{
		return % this._gui.Tabs_Tabsets.getActive()		
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
	_updateTabNamesLookUp()
	{
		$data	:= this._getGuiData()
		
		$Tabfile := this.Tabfile($data.tabset, $data.tabsgroup, $data.tabs )

		if( $Tabfile )
			this._getActiveTab().Controls.get("TabsNameLookUp").edit( $Tabfile.getTabsCaptions() )			
	}

	/**
	 */
	_setFocusOnListbox($listbox_name )
	{
		this._getActiveTab().Controls.get($listbox_name).focus()		
	}
	

	

}

