/** Create Gui
 *
 */
Class Gui Extends AddControls
{
	_gui	:= new VilGUI("TabsSwitcher")
	_MsgBox 	:= new MsgBox()

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
		
		this._TEXT_update()
		
		this._initLastStateStore()
		
		this._LB_focus("LB_Folder")
	}
	
	/**
	 */
	_createGui()
	{
		this._gui.Margin.x(5).y(10) ; set margin for all - UI, CONTAINERS & CONTROLS
				
		this._bindKeyEvents()
		this._bindGuiEvents()
		this._bindControlEvents()				
		this._bindWindowEvents()		
		
		this._gui.Menus.Main
				;.menu("Window")
				.item("Center window", &this "._centerrWindow")
				
		this._gui.Menus.Tray
				.icon("\TabsSwitcher.ico")	; file in working dir subdir
				.item("Center window", &this "._centerrWindow")
				.item("Exit")
				;.defaults()
				.show()
				
		this._gui.create()
				;.minSize(500,500)
				.autosize()	; autoresize gui by content

				.alwaysOnTop()
				
		this._setWindowPosition()
	}
	/**
	 */
	_bindKeyEvents()
	{
		this._gui.Events.Key
				.onEscape("exit")
				.onEnter( this._Parent ".loadTabs")
				;.on( "space", this "._TEST")				
				.on( "number", &this "._TAB_SelectByNumber")
				.on( "space", &this "._LB_FoldersAndTabfile", "LB_Folder")
				.on( ["control", "space"], &this "._LB_ToggleRootsAndTabset", "LB_Folder")																
	
	} 
	/**
	 */
	_bindGuiEvents()
	{
		this._gui.Events.Gui
				.onClose("exit")
				
		this._gui.Events.Gui
				.onExit( &this ".saveWindowPosition")				
	} 
	/**
	 */
	_bindControlEvents()
	{
	;$items := ["item A|", "item B", "item C"]
	;
	;this._gui.Controls
	;	.Dropdown().items($items).add()	
	;	.Radio().items($items).add()
	;	.ListBox().items($items).add()
		
		this._gui.Style.Color
				.focus( 0x00FF00, 0xFF0080)
				.focus( "d0e3f4", "", "listbox")
						
	} 
	/**
	 */
	_bindWindowEvents()
	{
		this._gui.Events.Window
		    .on("focus",	&this.Parent()._TotalCmd ".tabsSwitcherHasFocus")
		    .on("blur",	&this.Parent()._TotalCmd ".totalCommanderHasFocus")
		    .on("sizedmoved",	&this ".saveWindowPosition")
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
	
	/**
	 */
	saveWindowPosition($Event, $params*)
	{
		if( ! $Event.x )
			return 
		
		IniWrite, % $Event.x, %$ini_path%, window, x
		IniWrite, % $Event.y, %$ini_path%, window, y
		
		IniWrite, % $Event.width, 	%$ini_path%, window, width
		IniWrite, % $Event.height,	%$ini_path%, window, height						
		
	}
	/**
	 */
	_setWindowPosition()
	{
		IniRead, $x, %$ini_path%, window, x
		IniRead, $y, %$ini_path%, window, y
		
		if( $x!="ERROR" && $y!="ERROR" )
			this._gui.move($x, $y)
		else
			this._gui.center("window")
	}
	/**
	 */
	_centerrWindow()
	{
		IniDelete, %$ini_path%, window 
		this._gui._centerToWindow()
	} 

	
}


