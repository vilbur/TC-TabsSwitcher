/** Control controls in Gui
 *
 */
Class GuiControl Extends GuiCallback
{
	_last_selected_folders	:= {}
	_last_focused_listbox	:= {root_tabset:"", folder_tabfile:""}

	/*---------------------------------------
		TAB
	-----------------------------------------
	*/
	/**
	 */
	_getActiveTab()
	{
		return % this._gui.Tabs_Tabsets.getActive()		
	}
	/*---------------------------------------
		RADIO
	-----------------------------------------
	*/
	/**
	 */
	_R_replaceUnselect( )
	{
		$Radios := this._getActiveTab().Controls.get("R_replace")
		
		For $name, $addr in $Radios._buttons
			$Radios.get($name).edit(0)
	}
	
	/*---------------------------------------
		LISTBOX
	-----------------------------------------
	*/
	_LB_set( $listbox_name, $data:="", $select:=0 )
	{
		$listbox := this._getActiveTab().Controls.get( $listbox_name )
		
		$listbox.clear()
		
		if( $data )
			$listbox.edit( $data )
			
		if( $select )
			$listbox.select( $select )
	}
	/**
	 */
	_LB_add( $listbox_name, $data:="", $select:=0 )
	{
		$listbox := this._getActiveTab().Controls.get( $listbox_name )
				
		if( $data )
			$listbox.edit( $data )
			
		;if( $select )
		;	$listbox.select( $select )
	}
	/**
	 */
	_LB_focus( $listbox_name, $select:="" )
	{
		$listbox := this._getActiveTab().Controls.get($listbox_name)
		
		$listbox.focus()
		
		if( $select )
			$listbox.select($select)
			
		;if( $listbox_name=="LB_TabsetRoot" || $listbox_name=="LB_TabsGroup"  )
		this._last_focused_listbox[this._getListBoxType( $listbox_name )] := $listbox_name
		
		;$listbox.guiControl("Font","Red")
		;$listbox.color("d0e3f4")
		
		;MsgBox,262144,, % $listbox.hwnd,2
		;MsgBox,262144,, % this._gui._hwnd,2 		
		;GuiHwnd := WinExist()

		;ControlCol( $listbox.hwnd, GuiHwnd, 0x00FF00)

		;MsgBox,262144, _LB_focus , %$listbox_name%,5
		
		;Dump(this._last_focused_listbox, "this._last_focused_listbox", 1)

	}
	/**
	 */
	_LB_unselect($listbox_name )
	{
		this._getActiveTab().Controls.get($listbox_name).select(0)	
	}
	
	/*---------------------------------------
		HELPERS
	-----------------------------------------
	*/
	/**
	 */
	_getControlValue($control_name)
	{
		return % this._gui.Controls.get($control_name).value()
	}
	/** get type of listbox for toogling by keyboard
	 */
	_getListBoxType( $listbox_name )
	{
		return % $listbox_name=="LB_TabsetRoot" || $listbox_name=="LB_TabsGroup" ? "root_tabset" : "folder_tabfile"
	} 

	/*---------------------------------------
		UNUSED
	-----------------------------------------
	*/
	/**
	 */
	;;_setDropdownItems($control_name, $items, $selected:="")
	;;{
	;;	this._gui.Controls.get($control_name)
	;;						.clear()
	;;						.edit($items)
	;;}
	
	

}

