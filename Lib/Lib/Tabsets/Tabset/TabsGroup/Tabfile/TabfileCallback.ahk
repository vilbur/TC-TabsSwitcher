/** Class TabfileCallback
*/
Class TabfileCallback
{
	_MsgBox 	:= new MsgBox()

	/**
	 */
	new( )
	{
		SplitPath, A_WorkingDir, $dir_name
		if( this._MsgBox.confirm( "CREATE NEW TABS", "Create new tabs for path:`n`n" A_WorkingDir ) )
		{
			InputBox, $dir_name, SET ROOT NAME, Set name for tabset, , , 128, , , , , %$dir_name%
			
			new Tabset()
					.pathTarget( A_WorkingDir )
					.name( $dir_name )
					.create()
					.createTabsGroup( "_shared" )			
			Reload
		}
	}
	/**
	 */
	delete( $Tabfile, $data )
	{
		;MsgBox,262144,, TabfileCallback.delete(),2 		
		if( this._MsgBox.confirm( "DELETE TAB FILE", "Delete tabs ? `n`n"  $data.tabset " \ " $data.tabsgroup " \ " $data.tabfile , "no") ) 
		{
			$Tabfile.delete()
			Reload			
		}
	}
	/**
	 */
	createCommand( $Tabfile, $data )
	{
		;MsgBox,262144,, TabfileCallback.delete(),2 		
		if( this._MsgBox.confirm( "CREATE COMMAND TAB FILE", "Create command for loading tabs ? `n`n"  $data.tabset " \ " $data.tabsgroup " \ " $data.tabfile , "no") ) 
			$Tabfile.createCommand($data)
	
	}
}

