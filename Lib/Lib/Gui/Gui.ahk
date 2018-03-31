
/** Class Gui
*/
Class Gui Extends GuiControls
{
	_gui := new VilGUI("TabsSwitcher")
	
	/*---------------------------------------
		CREATE GUI
	-----------------------------------------
	*/
	/** createGui
	 */
	createGui()
	{
		this._addTabsetControls()
		this._addTabs()
		this._addMainButtons()
		
		this._createGui()
		
		this._setFocusOnListbox("LB_TabsGroup")
		this._setFocusOnListbox("LB_FoldersList")
		this._setFocusOnListbox("LB_Tabfile")				
		
		this._updateTabNamesLookUp()		
	}
	
	/**
	 */
	_createGui()
	{
		this._gui.Margin.x(5).y(10) ; set margin for all - UI, CONTAINERS & CONTROLS
		;this._gui.Margin.ui.x( 30 ).y(20)	; set margin around window
		;this._gui.Margin.container.x( 0 ).y(15)	; set margin between groupboxes
		;this._gui.Margin.control.x( 30 ).y(5)	; set margin between controls
		
		this._gui.Events.Gui.onEscape("exit")
		
		this._gui.create()
				.center("window")
	}
	
	/**
	 */
	_getGuiData()
	{
		;MsgBox,262144,, _getGuiData,2 
		$tab := this._getActiveTab()
		;Dump($tab, "tab", 1)
		return %	{"tabset":	$tab.name()
			,"tabsgroup":	$tab.Controls.get("LB_TabsGroup").value()			
			,"folder":	$tab.Controls.get("LB_FoldersList").value()			
			,"tabs":	$tab.Controls.get("LB_Tabfile").value()}
	}
	
}

