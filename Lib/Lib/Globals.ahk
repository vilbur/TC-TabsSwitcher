/*---------------------------------------
	VARIABLES
-----------------------------------------
*/
global $TabsSwitcher
global $ini_path
global $tabs_path

$ini_path	:= RegExReplace( A_ScriptFullPath, "\.(ahk|exe)$", ".ini" )
 
/*---------------------------------------
	FUNCTIONS
-----------------------------------------
*/

/**
 */
getObjectKeys($object, $ignore:="")
{
	$keys := []
	For $key, $value in $object
		if( $key!=$ignore )
			$keys.insert( $key )
			
	return %$keys%
}
/**
 */
getObjectValues($object)
{
	$values := []
	For $key, $value in $object
		$values.insert( $value )
	return %$values%
}

/**
 */
joinObject($object, $delimeter:="`n")
{
	For $key, $value in $object
		$string .= $value $delimeter
	return %$string%
}

 /** Combine absolute and relative paths
 */
combine_path( $absolute, $relative)
{
	$absolute := RegExReplace( $absolute, "[\\\/]+$", "" ) ;;; remove last  slash\
	$relative := RegExReplace( $relative, "^[\\\/]+", "" ) ;;; remove last  slash\	
	;$relative := RegExReplace( RegExReplace( $relative, "^\\", "" ), "/", "\" ) ;" ; remove first \slash, flip slashes
	$relative := RegExReplace( $relative, "/", "\" ) ;" ;  flip slashes							  
									   
	VarSetCapacity($dest, (A_IsUnicode ? 2 : 1) * 260, 1) ; MAX_PATH
	DllCall("Shlwapi.dll\PathCombine", "UInt", &$dest, "UInt", &$absolute, "UInt", &$relative)
	return RegExReplace( $dest, "\\+", "\" ) ; "
}
