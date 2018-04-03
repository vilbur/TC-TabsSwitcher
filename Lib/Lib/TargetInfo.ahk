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
		$path_target	:= RegExReplace( $Tabset.get("path_target"), "[\\\/]+", "\" ) ; "
										
		if( ! $path_target )
			return 

		$path_relative	:= SubStr( A_WorkingDir,  StrLen($path_target)+2 )
		
		RegExMatch( $path_relative, "([^\\]+)", $current_folder )
		
		;Dump(A_WorkingDir, "A_WorkingDir", 1)
		;Dump($path_target, "path_target", 1)
		;Dump($path_relative, "path_relative", 1)
		;Dump($current_folder, "current_folder1", 1)
		
		;if( $path_target )
		this._folder_current := $current_folder1
	}

	
}

