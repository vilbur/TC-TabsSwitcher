/** Methods called by callbacks
 *
 * Orchestrate controls for current state of gui
 */
Class GuiCallbackMethods Extends Parent
{
	
	_last_state := {}
	
	/**
	 */
	_initLastStateStore()
	{
		For $i, $tabset in this.Tabsets()._getTabfilesNames()
			this._last_state[$tabset] := {}
	} 
	
	/*---------------------------------------
		TABSET
	-----------------------------------------
	*/
	/** reate New tabset
	 */
	_tabSetAdd()
	{
		$new_root 	:= this._askPathToRoot()

		if( ! $new_root )
			return
			
		SplitPath, $new_root, $dir_name
			
		$tabset_name := this._MsgBox.Input("SET TABSET NAME", "Name of new tabset" , {"default":$dir_name})
		
		if( $tabset_name )
			this.Tabsets()
				.createTabset( $new_root, $tabset_name )
				.createTabsRoot( $new_root )
				
		Reload
	}
	/**
	 */
	_tabSetRemove()
	{
		$data	:= this._getGuiData()
		
		if( this._MsgBox.confirm("REMOVE TABSET", "Remove tabset: " $data.tabset, "no") )
			this.Tabset($data.tabset).delete()
			
		Reload
	}
	/*---------------------------------------
		TABSROOT
	-----------------------------------------
	*/
	/**
	 */
	_tabsetRootAdd( $data )
	{
		this.Tabset( $data.tabset )
			.createTabsRoot( this._askPathToRoot() )
	} 
	/**
	 */
	_tabsetRootRemove( $data )
	{
		if( this._MsgBox.confirm("REMOVE ROOT", "Remove root ?`n`n" $data.tabsetroot ) )
			this.Tabset( $data.tabset ).removeTabsRoot( $data.tabsetroot )
	}
	
	/*---------------------------------------
		TABSGROUP
	-----------------------------------------
	*/
	/**
	 */
	_tabsGroupAdd($data)
	{				
		$name := $data.folder ? $data.folder : this.TotalCmd().getDir()
		
		$tabsgroup := this.Tabset( $data.tabset )
						.createTabsGroup( this._MsgBox.Input("ADD NEW TABSGROUP", "New tabsgroup name" , {"w":320, "default":$name} ) )
		
		if( $tabsgroup )
			this._LB_add( "LB_TabsGroup", $name )
		
	}
	/**
	 */
	_tabsGroupRemove($data)
	{
		if( this._MsgBox.confirm("REMOVE GROUP", "Remove group ?`n`n" $data.tabsgroup ) )
			this.TabsGroup( $data.tabset , $data.tabsgroup).delete()

		reload
		
	} 
	/**
	 */
	_tabsGroupUnselect($data)
	{
		this._LB_unselect("LB_TabsGroup")
		this._LB_set( "LB_Folder", this._getTabsRootFolders( $data ), this._getLastSeletedFolder($data) )
		
		$data.tabsgroup := "_shared" 
		this._updateTabfile( $data )
	}
	/**
	 */
	_tabsGroupUpdateGui( $data )
	{
		this._R_replaceUnselect()
		
		this._updateTabfile( $data )
		
		this._LB_set( "LB_Folder" )
		
		this._TEXT_update()
	} 
	
	/*---------------------------------------
		TABS FOLDERS
	-----------------------------------------
	*/
	_updateFolderList( $data )
	{
		this._LB_set( "LB_Folder", this._getTabsRootFolders( $data ), this._getLastSeletedFolder($data) )		
	}
	/**
	 */
	_folderChanged($Event)
	{
		$data	:= this._getGuiData()

		this._last_state[$data.tabset][$data.tabsetroot] := $Event.value

	}
	/**
	 */
	_getLastSeletedFolder( $data )
	{
		$last_folder := this._last_state[$data.tabset][$data.tabsetroot]
		
		return % $last_folder ? $last_folder : 1
	} 
	/*---------------------------------------
		TAB FILE
	-----------------------------------------
	*/
	/**
	 */
	_tabFileAdd( $data )
	{
		$active_pane	:= this.TotalCmd().activePane()

		this.new_tabs	:= new VilGUI("AddNewTabs")
		
		this.new_tabs.Controls
		.options("button", "h", 48 )
		.options("Checkbox", "h", 48 ) 		
		.Layout("row")
			.Edit().label("Name of tabs").options("w128").add("tabfile")
				.section()
			.GroupBox("Save Tabs on side").add()
				.Checkbox("Left").options("x+24 w96").checked(InStr($active_pane, "Left" )? 1 : 0).add()
				.Checkbox("Right").options("x+24 w96").checked(InStr($active_pane, "Right")? 1 : 0).add()						
			.section()
				.Button().Submit("Ok")
				.Button().close("Cancel")			
		
		this.new_tabs.Events.Gui
		    .onSubmit( &this ".GUI_AddNewTabsSubmit", $data.tabset, $data.tabsgroup ) 
		    ;.onSubmit("close")
		    .onEscape("close")			
		    .onEnter("submit")
			
		this.new_tabs.create()
	}
	/**
	 */
	_tabFileRename( $data )
	{		
		$new_name := this._MsgBox.Input("RENAME TABS", "New name of tabs" , {"w":256, "default":$data.tabfile})
		
		if( $new_name )
			this.Tabfile($data.tabset, $data.tabsgroup, $data.tabfile ).rename($new_name)

		;$Tabfile	:= this.Tabfile($data.tabset, $data.tabsgroup, $data.tabfile )
	} 
	/**
	 */
	_tabFileRemove()
	{
		$data	:= this._getGuiData()

		$tabs_name := $data.tabset " \ " ($data.tabsgroup=="_shared" ? "" : $data.tabsgroup " \ ") $data.tabfile

		if( this._MsgBox.confirm("REMOVE TABS", "Remove tabs ?`n`n" $tabs_name ) )
			this.Tabfile($data.tabset, $data.tabsgroup, $data.tabfile ).delete()
		
	} 
	/**
	 */
	_tabFileSelected($Event)
	{
		$data	:= this._getGuiData()

		this._last_state[$data.tabset][$data.tabsgroup] := $Event.value
	
		this._TEXT_update()

	} 
	/**
	 */
	_updateTabfile( $data )
	{
		$tab_filenames := this.TabsGroup($data.tabset, $data.tabsgroup ).getTabFilenames()
		
		$last_tabfile	:= this._last_state[$data.tabset][$data.tabsgroup]
		
		this._LB_set( "LB_Tabfile", $tab_filenames, ($last_tabfile ? $last_tabfile : 1) )
	}
	/*---------------------------------------
		TEXT
	-----------------------------------------
	*/
	/**
	 */
	_guiFocus()
	{
		;MsgBox,262144,_TEXT_update, FOCUS,3
		;MsgBox,262144,_TEXT_update, % this.TotalCmd().activePane(),3		
		this._TEXT_update()
	}  
	/**
	 */
	_TEXT_update()
	{
		$data	:= this._getGuiData()
		$Tabfile	:= this.Tabfile($data.tabset, $data.tabsgroup, $data.tabfile )

		if( $Tabfile )
		{
			$active_pane	:= this.TotalCmd().activePane()
			
			$tabs	:= $Tabfile.getTabsCaptions()
			
			this._gui.Controls.get("TEXT_pane_" $active_pane).edit( $tabs.activetabs )
			this._gui.Controls.get("TEXT_pane_" ($active_pane	== "right" ? "left" : "right")).edit( $tabs.inactivetabs )
		}
	}
	
	/*---------------------------------------
		HELPERS
	-----------------------------------------
	*/

	/**
	 */
	_askPathToRoot()
	{
		$path := this._MsgBox.Input("ADD NEW ROOT FOLDER", "Set path to new root" , {"w":720, "default": this.TotalCmd()._TcPane.getSourcePath()})
		
		if( InStr( FileExist($path), "D" )==0 ) ; get dir path, if path to file 
			SplitPath, $path,, $path
		
		return % FileExist($path) ? $path : false
	} 
	/**
	 */
	_getTabsRootFolders( $data )
	{
		return % this.Tabset($data.tabset)._getTabsRootFolders($data.tabsetroot)
	}
	/**
	 */
	_getLastFolder( $data )
	{
		return % this.Tabset($data.tabset).getLastFolder($data.tabsetroot)
	}
	
	
	
	
}

