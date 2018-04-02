#SingleInstance force
;#NoTrayIcon

#Include %A_LineFile%\..\Lib\TabsSwitcher.ahk

$tabset	= %1%
$tabsgroup	= %2%
$tabfile	= %3% 

$TabsSwitcher 	:= new TabsSwitcher()


if( $tabset && $tabsgroup && $tabfile )
	$TabsSwitcher.openTabs( $tabset, $tabsgroup, $tabfile )
	
else
	$TabsSwitcher.createGui()