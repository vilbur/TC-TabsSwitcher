#SingleInstance force



$test_path := "c:\GoogleDrive\TotalComander\_TC-commands\tabs\TabsSwitcher\Test\testRoot\Project_A\subfolder"
$test_path := "c:\wamp64\www\laravel-fresh"

$test_path := "c:\GoogleDrive"
$test_path = %USERPROFILE%\..\

Run, % A_LineFile "\..\..\TabsSwitcher.ahk " $test_path


		
		