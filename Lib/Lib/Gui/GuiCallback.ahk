/** Callbacks for controls
 *
 *
 */
Class GuiCallback Extends Parent
{

	/** Add or delete target root
	 */
	_DD_TabsetsChanged( $Event )
	{
		$data	:= this._getGuiData()

		if( $Event.value == "New" )
		{
			SplitPath, A_WorkingDir, $dir_name

			MsgBox, 260, CREATE NEW ROOT, % "Do You want create new tabset in path:`n`n" A_WorkingDir
				IfMsgBox, Yes
				{
					InputBox, $dir_name, SET ROOT NAME, Set name for tabset, , , 128, , , , , %$dir_name%
					this.Tabsets().createTabset( A_WorkingDir, $dir_name )
					Reload
				}
				
		}else if(  $Event.value == "Delete" ){
			MsgBox, 260, DELETE ROOT, % "Do You want delete tabset: " $data.tabset
				IfMsgBox, Yes
					this.Tabset($data.tabset).delete()
		}

	}


	/**
	 */
	_LB_TabsGroupChanged( $Event )
	{
		$data	:= this._getGuiData()
		
		this._getActiveTab().Controls
							.get("LB_Tabfile")
								.clear()
								.edit( this.TabsGroup( $data.tabset, $data.tabsgroup ).getTabFilenames() )
								.select( 1 )
								
		this._updateTabNamesLookUp()
	}
	/**
	 */
	_LB_FoldersListChanged( $Event )
	{
		;$data	:= this._getGuiData()
		if( $Event.type=="DoubleClick" )
			this.Parent().loadTabs()
		;$Event.message()
		;this._updateTabNamesLookUp()
	}
	/**
	 */
	_LB_TabfileChanged( $Event )
	{
		$data	:= this._getGuiData()
		;$Event.message()
		
		this._updateTabNamesLookUp()
	}
	

}

