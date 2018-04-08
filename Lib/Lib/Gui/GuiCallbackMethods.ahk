/** Methods called by callbacks
 *
 */
Class GuiCallbackMethods Extends Parent
{
	/*---------------------------------------
		TABSET
	-----------------------------------------
	*/
	/** reate New tabset
	 */
	_tabsetAddNew()
	{
		$new_root 	:= this._askPathToRoot()

		if( ! $new_root )
			return
			
		SplitPath, $new_root, $dir_name
			
		$tabset_name := this._MsgBox.Input("SET TABSET NAME", "Name of new tabset" , {"default":$dir_name})
		
		if( $tabset_name )
			this.Tabsets().createTabset( $new_root, $new_root )
			
		Reload
	}
	/**
	 */
	_tabsetAddRemove()
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
	_tabsRootCreate( $data )
	{
		this.Tabset( $data.tabset )
			.createTabsRoot( this._askPathToRoot() )
	} 
	/**
	 */
	_tabsRootRemove( $data )
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
	_tabsGroupUnselect($data)
	{
		this._LB_unselect("LB_TabsGroup")
		this._LB_set( "LB_Folder", this._getTabsRootFolders( $data ), this._getLastFolder($data) )
		
		$data.tabsgroup := "_shared" 
		this._LB_set( "LB_Tabfile", this._getTabFilenames( $data ) , 1 )
	}
	/**
	 */
	_tabsGroupUpdateGui( $data )
	{
		this._R_replaceUnselect()
		
		this._LB_set( "LB_Tabfile", this._getTabFilenames( $data ) , 1 )
		
		this._LB_set( "LB_Folder" )
		
		this._TEXT_update()
	} 
	
	/*---------------------------------------
		TABS FOLDERS
	-----------------------------------------
	*/
	_updateFolderList( $data )
	{
		this._LB_set( "LB_Folder", this._getTabsRootFolders( $data ), this._getLastFolder($data) )
	}
	
	/*---------------------------------------
		HELPERS
	-----------------------------------------
	*/

	/**
	 */
	_askPathToRoot()
	{
		$path := this._MsgBox.Input("ADD NEW ROOT FOLDER", "Set path to new root" , {"w":720, "default":A_WorkingDir})
		
		if( InStr( FileExist($path), "D" )==0 ) ; get dir path, if path to file 
			SplitPath, $path,, $path
		
		return % FileExist($path) ? $path : false
	} 
	/**
	 */
	_getTabFilenames( $data )
	{
		return % this.TabsGroup($data.tabset, $data.tabsgroup ).getTabFilenames()
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

