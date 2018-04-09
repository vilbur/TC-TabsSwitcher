/** Class TabsetsCallback
*/
Class TabsetsCallback
{
	_MsgBox 	:= new MsgBox()

	/**
	 */
	new( )
	{
		MsgBox,262144,, DELETE CLASS TabsetsCallback ? 
		SplitPath, A_WorkingDir, $dir_name
		if( this._MsgBox.confirm( "CREATE NEW ROOT", "Create new tabset in path:`n`n" A_WorkingDir ) )
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
	delete( $Tabset )
	{
		MsgBox,262144,, DELETE CLASS TabsetsCallback ? 
		if( this._MsgBox.confirm( "DELETE ROOT", "Delete tabset: " $data.tabset , "no") ){
			$Tabset.delete()
			Reload			
		}
	}
	
}

