/** methods for controls
 *
 *
 */
Class GuiControlsMethods Extends GuiCallback
{
	_last_selected_folders	:= {}
	
	/**
	 */
	_EDIT_TabsetTypeEdit( $tabset_type, $path)
	{
		$text_control := this._getActiveTab().Controls.get("EDIT_TabsetType")
		
		if( $tabset_type!="root folder" ){
			SplitPath, $path, $name
			$text_control.edit($name)
		}else if( $tabset_type=="" )
			$text_control.edit($path)
			
	}
	/*---------------------------------------
		TAB
	-----------------------------------------
	*/
	
	/**
	 */
	_getActiveTab()
	{
		return % this._gui.Tabs_Tabsets.getActive()		
	}
	/*---------------------------------------
		RADIO
	-----------------------------------------
	*/
	/**
	 */
	_R_SharedUnselect( )
	{
		$Tab := this._getActiveTab().Controls
		$Tab.get("R_Shared.Root").edit(0)
		$Tab.get("R_Shared.Folder").edit(0)		
	}
	
	/*---------------------------------------
		LISTBOX
	-----------------------------------------
	*/
	_LB_set( $listbox_name, $data:="", $select:=0 )
	{
		;MsgBox,262144,, _LB_fill,2
		$listbox := this._getActiveTab().Controls.get( $listbox_name )
		
		$listbox.clear()
		
		if( $data )
			$listbox.edit( $data )
			
		if( $select )
			$listbox.select( 1 )
			
	}
	
	/** fill listbox if tabsgroup changed to "_shared"
	    clear listbox if tabsgroup not "_shared"
		
		temporary save selection to _last_selected_folders
	 */
	_editTabsgroupListBox( $data )
	{
		$Tab 	:= this._getActiveTab()
		$LB_FoldersList	:= $Tab.Controls.get("LB_FoldersList")
		
		if ($data.tabsgroup=="_shared"){
			
			$LB_FoldersList.clear()
							.edit( this.Tabset($data.tabset)._getTabsetFolders() )
							.select( this._last_selected_folders[$data.tabset] )				
		} else {
			this._last_selected_folders[$data.tabset] := $LB_FoldersList.value()
			$LB_FoldersList.clear()
		}
	}
	/**
	 */
	_setFocusOnListbox( $listbox_name )
	{
		this._getActiveTab().Controls.get($listbox_name).focus()		
	}
	/**
	 */
	_LB_unselect($listbox_name )
	{
		this._getActiveTab().Controls.get($listbox_name).select(0)	
	}
		
	/*---------------------------------------
		DROPDOWN
	-----------------------------------------
	*/
	/**
	 */
	_setDropdownItems($control_name, $items, $selected:="")
	{
		this._gui.Controls.get($control_name)
							.clear()
							.edit($items)
	}
	
	/*---------------------------------------
		TEXT
	-----------------------------------------
	*/
	/**
	 */
	_updateTabNamesLookUp()
	{
		$data	:= this._getGuiData()
		
		$Tabfile := this.Tabfile($data.tabset, $data.tabsgroup, $data.tabfile )

		if( $Tabfile )
			this._getActiveTab().Controls.get("TabsNameLookUp").edit( $Tabfile.getTabsCaptions() )			
	}
	
	
	/**
	 */
	_getControlValue($control_name)
	{
		return % this._gui.Controls.get($control_name).value()
	}


	

}

