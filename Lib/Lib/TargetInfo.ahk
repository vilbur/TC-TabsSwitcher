/** Class TargetInfo
*/
Class TargetInfo
{	
	_folder_current	:= "" ; current target folder found by TargetInfo

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
	get( $property )
	{
		return % this["_" $property ]
	}
	/**
	 */
	_setCurrentTabset( $Tabset )
	{
		$rx_path	:= RegExReplace( $Tabset.get("path_target"), "[\\\/]+", "\\" ) "([^\\\/]+)"
		
		RegExMatch( A_WorkingDir, $rx_path, $current_folder )
		
		this._folder_current := $current_folder1
	}

	
}

