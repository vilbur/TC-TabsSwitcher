/** Class Gui
 *
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
		this._addPaneLookUp()		
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
		
		this._gui.Events.Gui
				.onEscape("exit")
				.onEnter("submit")			
		
		this._gui.Menus.Tray
				.icon("\Icons\TabsSwitcher.ico")	; file in working dir subdir
		
		this._gui.create()
				.alwaysOnTop()
				.center("window")
	}
	
	/**
	 */
	_getGuiData()
	{
		$tab	:= this._getActiveTab()
		$Controls	:= $tab.Controls
		$form_data	:= {"tabset":	$tab.name()
			   ,"tabsgroup":	"_shared"}
		
		
		For $control_name, $value in $Controls.values()
			if( $value && ! InStr($control_name, "DD_" ) )
				 $form_data[RegExReplace( $control_name, "^[^_]+_", "" )] :=  $value
		
		return $form_data
		;return %	{"tabset":	$tab.name()
		;	,"tabsetroot":	$Controls.get("LB_TabssetRoot").value()
		;	,"tabsgroup":	$Controls.get("LB_TabsGroup").value()			
		;	,"replace":	$Controls.get("R_replace").value()
		;	,"folder":	$Controls.get("LB_FoldersList").value()			
		;	,"tabfile":	$Controls.get("LB_Tabfile").value()}
	}
	
}

