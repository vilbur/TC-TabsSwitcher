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
joinObject($object, $delimeter:="`n", $remove:=1)
{
	For $key, $value in $object
		$string .= $value $delimeter
	
	return % SubStr( $string, 1, StrLen($string) - (StrLen($delimeter)) )
}
/**
 */
stringifyObject($object, $key_delimeter:="=", $line_delimeter:="`n")
{
	For $key, $value in $object
		$string .= $key $key_delimeter $value $line_delimeter
	
	return % SubStr( $string, 1, StrLen($string) - (StrLen($line_delimeter)) )
}
/**
 */
flatternObject($object)
{
	if (! isobject($object))
		return $object
   
	$flat := {}
   
	$enum := $object._newenum()
	While $enum[$key, $value]
		if !isobject($value)
			$flat._Insert($value)
		else
		{
			$next := flatternObject($value)
			loop % $next._MaxIndex()
				$flat._Insert($next[A_Index])
		}
	return $flat
}
/*
*/
findInAray($object, $item)
{
	for $i, $value in $object
		if ($value = $item)
			return $i
	return 0
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
