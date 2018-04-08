/** Class TabsRoot
*/
Class TabsRoot
{
	;_path	:= "" ; path to root of tabs
	_folders	:= [] ; folderes in target path
	_last_folder	:= ""
	
	;__NEW($path)
	;{
	;	this._path	:= $path
	;}
	
	;/**
	; */
	;create( $path:="" )
	;{
	;	;if( $path )
	;	;	this._path	:= $path
	;	
	;	;return $path ? this : this._path 
	;} 
	/** get folders
	 */
	folders()
	{
		return % this._folders
	} 
	
	/** get folders in target root
	  *
	  * @example target\root
	  *				\project_1
	  *				\project_2	  
	 */
	setRootFolders($path)
	{		
		loop, % $path "\*", 2
			this._folders[A_Index] := A_LoopFileName
			
		return this
	}	
	/**
	 */
	setLastFolder($last_folder)
	{
		this._last_folder := $last_folder
		return this
	}
	
}

