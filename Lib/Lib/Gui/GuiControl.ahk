/** Control controls in Gui
 *
 */
Class GuiControl Extends GuiCallback
{
	_last_selected_folders	:= {}

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
	_LB_focus( $listbox_name, $select )
	{
		$listbox := this._getActiveTab().Controls.get($listbox_name)
		
		$listbox.focus()
		
		if( $select )
			$listbox.select($select)	
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

