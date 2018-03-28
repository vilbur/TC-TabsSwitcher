#SingleInstance force

#Include %A_LineFile%\..\Lib\TabsSwitcher.ahk


$target_path	= %1%


$TabsSwitcher := new TabsSwitcher($target_path)


If ( ! FileExist( $ini_path ))
	$TabsSwitcher.install()

$TabsSwitcher.tabsetLoaderGui()


