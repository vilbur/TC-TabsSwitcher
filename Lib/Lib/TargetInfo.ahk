/** Class TargetInfo
*/
Class TargetInfo
{
	_tabsets	:= {}
	
	
	/**
	 */
	findCurrentTabset( $Tabsets )
	{
		For $tabset_name, $Tabset in $Tabsets._Tabsets
			if( InStr(A_WorkingDir, $Tabset.get("path_target")) )
				this._setCurrentTabset($Tabset)
	} 
	/**
	 */
	_setCurrentTabset( $Tabset )
	{
		$rx_path	:= RegExReplace( $Tabset.get("path_target"), "[\\\/]+", "\\" ) "([^\\\/]+)"
		
		RegExMatch( A_WorkingDir, $rx_path, $current_folder )
		
		$Tabset._folder_current := $current_folder1
	}

	
}

