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
		
		this._LB_focus("LB_TabsetRoot")
	}
	
	/**
	 */
	_createGui()
	{
		this._gui.Margin.x(5).y(10) ; set margin for all - UI, CONTAINERS & CONTROLS
				
		this._bindKeyEvents()
		this._bindGuiEvents()		
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
				;.on( "space", this._Parent ".loadTabs")				
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

; ------------------------
; http://www.autohotkey.com/board/topic/104539-controlcol-set-background-and-text-color-gui-controls/
; v1.0.2
; ------------------------
ControlCol(Control, Window, bc="", tc="", redraw=1) {
        ; msgbox
    a := {}
    a["c"]  := Control
    a["g"]  := Window
    a["bc"] := (bc="")?"":(((bc&255)<<16)+(((bc>>8)&255)<<8)+(bc>>16))
    a["tc"] := (tc="")?"":((tc&255)<<16)+(((tc>>8)&255)<<8)+(tc>>16)
    WindowProc("Set", a, "", "")
    If redraw
    {
        SizeOfWINDOWINFO := 60
        VarSetCapacity(WINDOWINFO, SizeOfWINDOWINFO, 0)
        NumPut(SizeOfWINDOWINFO, WINDOWINFO, "UInt")
        DllCall("GetWindowInfo",  "Ptr", Control, "Ptr", &WINDOWINFO)
        DllCall("ScreenToClient", "Ptr", Window,  "Ptr", &WINDOWINFO+20) ; x1,y1 of Client area
        DllCall("ScreenToClient", "Ptr", Window,  "Ptr", &WINDOWINFO+28) ; x2,y2 of Client area
        DllCall("RedrawWindow"
        , "Ptr",  Window             ; A handle to the window to be redrawn. If this parameter is NULL, the desktop window is updated.
        , "UInt", &WINDOWINFO+20    ; A pointer to a RECT structure containing the coordinates, in device units, of the update rectangle. This parameter is ignored if the hrgnUpdate parameter identifies a region.
        , "UInt", 0                    ; A handle to the update region. If both the hrgnUpdate and lprcUpdate parameters are NULL, the entire client area is added to the update region.
        , "UInt", 0x101)            ; One or more redraw flags. This parameter can be used to invalidate or validate a window, control repainting, and control which windows are affected by RedrawWindow.
    }
    
}


WindowProc(hwnd, uMsg, wParam, lParam)
{
    Static Win := {}
    Critical
    If uMsg between 0x132 and 0x138
    If  Win[hwnd].HasKey(lparam)
    {
        If tc := Win[hwnd, lparam, "tc"]
        DllCall("SetTextColor", "UInt", wParam, "UInt", tc)
        If bc := Win[hwnd, lparam, "bc"]
        DllCall("SetBkColor",   "UInt", wParam, "UInt", bc)
        
        return Win[hwnd, lparam, "Brush"]  ; Return the HBRUSH to notify the OS that we altered the HDC.
    }
    If (hwnd = "Set")
    {
        a := uMsg
        Win[a.g, a.c] := a
        If (Win[a.g, a.c, "tc"] = "") and (Win[a.g, a.c, "bc"] = "")
            Win[a.g].Remove(a.c, "")
        If not Win[a.g, "WindowProcOld"]
            Win[a.g,"WindowProcOld"] := DllCall("SetWindowLong", "Ptr", a.g, "Int", -4, "Int", RegisterCallback("WindowProc", "", 4), "UInt")
        If Win[a.g, a.c, "Brush"]
            DllCall("DeleteObject", "Ptr", Brush)
        If (Win[a.g, a.c, "bc"] != "")
            Win[a.g, a.c, "Brush"] := DllCall("CreateSolidBrush", "UInt", a.bc)
        ; array_list(a)
        return
    }
    return DllCall("CallWindowProcA", "UInt", Win[hwnd, "WindowProcOld"], "UInt", hwnd, "UInt", uMsg, "UInt", wParam, "UInt", lParam)
}


