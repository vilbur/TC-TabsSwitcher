﻿/** Class Example
*/
Class Example Extends Parent
{
	_users_path	:= ""
	_username	:= ""
	_Tabset_name	:= "Users"
	_tabs_path	:= getTabsPath()
		
	__New(){
		$users_path	= %USERPROFILE%
		$username	= %USERNAME%
		
		this._users_path	:= $users_path
		this._username	:= $username
		this._users_path	:= combine_path( this._users_path, "\..\\" )
		
	}
	/**
	 */
	create()
	{
		
	}
	/**
	 */ 
	createExample()
	{
		this.createFolders()
		this.createSharedTabFile()
		this.createUserTabFile()				
	}
	/**
	 */
	createFolders()
	{

		this._Tabsets().createTabset( this._users_path, this._Tabset_name )
		;Dump(this._Tabsets(), "this._Tabsets", 1)
		;MsgBox,262144,,% this._Tabset_name,2
		
		this._Tabset(this._Tabset_name).createTabfiles("_shared")
		this._Tabset(this._Tabset_name).createTabfiles(this._username)		
		
	}

	/**
	 */
	createSharedTabFile()
	{
		$tabsfile_path := getTabsPath() "\\" this._Tabset_name "\\_shared\\Users-Tabs.tab"
		FileDelete, %$tabsfile_path%
		
		FileAppend,
		(
[activetabs]
0_path=C:\Users\Default\
0_caption=User
0_options=1|0|0|0|0|2|0
1_path=C:\Users\Default\Documents\
1_options=1|0|0|0|0|2|0
2_path=C:\Users\Default\Desktop\
2_options=1|0|0|0|0|2|0
3_path=C:\Users\Default\Downloads\
3_options=1|0|0|0|0|2|0
activetab=0
		), %$tabsfile_path%
		
	}
	/**
	 */
	createUserTabFile()
	{
		$tabsfile_path := getTabsPath() "\\" this._Tabset_name "\\" this._username "\\" this._username "-Tabs.tab"
		FileDelete, %$tabsfile_path%
		
		FileAppend,
		(
[activetabs]
0_path=C:\Users\Default\Documents\
0_options=1|0|0|0|0|2|0
1_path=C:\Users\Default\Downloads\
1_options=1|0|0|0|0|2|0
activetab=0
		), %$tabsfile_path%
		
	}	
	
}
 