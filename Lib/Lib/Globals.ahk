/*---------------------------------------
	VARIABLES
-----------------------------------------
*/
global $TabsSwitcher
global $working_path
global $ini_path

$working_path	:= combine_path( A_LineFile, "\..\..\..\\" )
$ini_path	:= $working_path RegExReplace( A_ScriptName, "(ahk|exe)$", "ini" )
 
/*---------------------------------------
	FUNCTIONS
-----------------------------------------
*/
/**
 */
getTabsPath()
{
	IniRead, $tabs_path, %$ini_path%, paths, tabs 
	return %$tabs_path% 
}
/**
 */
getObjectKeys($object)
{
	$keys := []
	For $key, $value in $object
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
	;$values := []
	For $key, $value in $object
		$string .= $value $delimeter
	return %$string%
}

 /** Combine absolute and relative paths
 */
combine_path( $absolute, $relative)
{
	$absolute := RegExReplace( $absolute, "\\$", "" ) ;;; remove last  slash\
	;$relative := RegExReplace( RegExReplace( $relative, "^\\", "" ), "/", "\" ) ;" ; remove first \slash, flip slashes
	$relative := RegExReplace( $relative, "/", "\" ) ;" ;  flip slashes							  
									   
	VarSetCapacity($dest, (A_IsUnicode ? 2 : 1) * 260, 1) ; MAX_PATH
	DllCall("Shlwapi.dll\PathCombine", "UInt", &$dest, "UInt", &$absolute, "UInt", &$relative)
	return RegExReplace( $dest, "\\+", "\" ) ; "
}
