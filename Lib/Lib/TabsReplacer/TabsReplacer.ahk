/** Class TabsReplacer
*/
Class TabsReplacer
{
	_path	:= ""
	
	/**
	 */
	path( $path )
	{
		this._path := $path
		
		return this
	}
	/**
	 */
	replacePaths()
	{
		
	}
	
	/** loadTabs
	*/
	loadTabs($Event)
	{

	
	
		;if( $data.Tabfiles=="_shared" )
		;	new IniReplacer($path, $data ).replaceFolderName()
		;	
		;;MsgBox,262144,path, %$path%,3 
		;;$Event.message(50)
		;$TCcommand 	:= new TCcommand().loadTabs( $path )
	}
	
}