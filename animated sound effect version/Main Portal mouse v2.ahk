#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#Persistent
#Singleinstance Force
SetKeyDelay, -100
SetMouseDelay, -100
SetWinDelay, -100
Coordmode, Mouse, Screen
Process, Priority,, R
SetBatchLines, -1
SetTitleMatchMode, 3
Listlines, off
IniRead, TPSOUND, Settings.ini, SOUNDEFFECT, Sound
Menu, Tray, NoStandard
Menu, Tray, Add, Sound effect, TPSTOGGLE
Menu, Tray, Add, Exit Mouse Portals, ExitApp

If (TPSOUND = true) {
Menu, tray, check, Sound effect
}
If (TPSOUND = false) {
Menu, tray, uncheck, Sound effect
}
; GET INITIAL MOUSE SPEED:
DllCall("SystemParametersInfo", UInt, 0x70, UInt, 0, UIntP, Mouse_Speed_Orig, UInt, 0)


;
;;
;;;
;;;; Create portal spawning window
;;;
;;
;
;Get Work area-----------------------------------------------------------
SysGet, DeskTop_Width, 78
SysGet, DeskTop_Height, 79
;------------------------------------------------------------------------
;Get TaskBar area--------------------------------------------------------
WinGetPos, TaskbarX, TaskbarY, TaskbarW, TaskbarH, ahk_class Shell_TrayWnd
;------------------------------------------------------------------------

;Calculate were the taskbar is, Use this script snippet for stuff like Gui's that need to know were the taskbar is so you don't over lap with it.
If (TaskbarY >= 225 && TaskbarX = 0) {
;TaskBar is on bottom of screen
;Msgbox, TaskBar is on the Bottom of the Desktop.
GUI_X := 0
GUI_Y := 0
GUI_W := DeskTop_Width
GUI_H := DeskTop_Height
GUI_H -= TaskbarH
Goto, CPE
}
;------------------------------------------------------------------------
If (TaskbarY = 0 && TaskbarX = 0 && TaskbarH >= 419) {
;TaskBar is on left side of screen
;Msgbox, TaskBar is on the Left side of the Desktop.
GUI_X := TaskbarW
GUI_Y := 0
GUI_W := DeskTop_Width
GUI_W -= TaskbarW
GUI_H := DeskTop_Height
Goto, CPE
}
;------------------------------------------------------------------------
If (TaskbarY = 0 && TaskbarX > 400) {
;TaskBar is on right side of screen
;Msgbox, TaskBar is on the Right side of the Desktop.
GUI_X := 0
GUI_Y := 0
GUI_W := DeskTop_Width
GUI_W -= TaskbarW
GUI_H := DeskTop_Height
Goto, CPE
}
;------------------------------------------------------------------------
If (TaskbarY = 0 && TaskbarX = 0 && TaskbarW >= 800) {
;TaskBar is on top of screen
;Msgbox, TaskBar is on the Top of the Desktop.
GUI_X := 0
GUI_Y := TaskbarH
GUI_W := DeskTop_Width
GUI_H := DeskTop_Height
GUI_H -= TaskbarH
Goto, CPE
}
;------------------------------------------------------------------------


CPE:
Gui, +LastFound -Caption -Border +ToolWindow +AlwaysOnTop +E0x20 
Gui, Add, Picture, vBP, Nothing.png
Gui, Add, Picture, vOP, Nothing.png


Gui, Show, x0 y0 w0 h0, PORTAL
WinSet, TransColor, f0f0f0, PORTAL
sleep, 2 ;this stops the flash you see when the window is loaded
Gui, Show, x%GUI_X% y%GUI_Y% w%GUI_W% h%GUI_H%, PORTAL
;
;;
;;;
;;;;----------------------------------------------------------------------
;;;
;;
;Check Mouse to move it
warpwidth := DeskTop_Width -3
warpheight := DeskTop_Height -3

CheckMousePos:
{
    MouseGetPos, X, Y
	
    If (X > DeskTop_Width -2) {
        Goto, right_through_left
    }
	
    If (X = 0) {
		Goto, left_through_right
    }
	
	
	

     If (Y >= DeskTop_Height -2) {
        Goto, bottom_through_top
    }
	
    
	 If (Y = 0) {

	  Goto, top_through_bottom
    }
}
Return



right_through_left:
WinSet, AlwaysOnTop, on, PORTAL
MouseGetPos, Xpor, Ypor
Portal_right := GUI_W
Portal_right -= 12
Portal_left := 0
Ypor -= 13
If (TPSOUND) {
soundplay, TP.wav
}
GuiControl, Move, BP, x%Portal_right% y%Ypor%
GuiControl, Move, OP, x%Portal_left% y%Ypor%
GuiControl, , BP, BR1.png
GuiControl, , OP, OL1.png
;sleep, 0.1
GuiControl, , BP, BR2.png
GuiControl, , OP, OL2.png
;sleep, 0.1
GuiControl, , BP, BR3.png
GuiControl, , OP, OL3.png
;sleep, 0.1
GuiControl, , BP, BR4.png
GuiControl, , OP, OL4.png
;sleep, 0.1
GuiControl, , BP, BR5.png
GuiControl, , OP, OL5.png

MouseMove, 2, %Y%
MouseGetPos, X, Y
X += 30
MouseMove, %X%, %Y%
Mouse_Speed_Current := Mouse_Speed_Orig + 15
DllCall("SystemParametersInfo", UInt, 0x71, UInt, 0, UInt, Mouse_Speed_Current, UInt, 0)
GuiControl, , BP, BR4.png
GuiControl, , OP, OL4.png
MouseGetPos, X, Y
X += 25
MouseMove, %X%, %Y%
sleep, 0.1
GuiControl, , BP, BR3.png
GuiControl, , OP, OL3.png
MouseGetPos, X, Y
X += 20
MouseMove, %X%, %Y%
sleep, 0.1
Mouse_Speed_Current := Mouse_Speed_Orig + 15
DllCall("SystemParametersInfo", UInt, 0x71, UInt, 0, UInt, Mouse_Speed_Current, UInt, 0)
GuiControl, , BP, BR2.png
GuiControl, , OP, OL2.png
MouseGetPos, X, Y
X += 15
MouseMove, %X%, %Y%
sleep, 0.1
GuiControl, , BP, BR1.png
GuiControl, , OP, OL1.png
MouseGetPos, X, Y
X += 10
MouseMove, %X%, %Y%
sleep, 0.1
Mouse_Speed_Current := Mouse_Speed_Orig + 15
DllCall("SystemParametersInfo", UInt, 0x71, UInt, 0, UInt, Mouse_Speed_Current, UInt, 0)
GuiControl, , BP, nothing.png
GuiControl, , OP, nothing.png
sleep, 30
Mouse_Speed_Current := Mouse_Speed_Orig - 5
DllCall("SystemParametersInfo", UInt, 0x71, UInt, 0, UInt, Mouse_Speed_Current, UInt, 0)
sleep, 30
Mouse_Speed_Current := Mouse_Speed_Orig - 5
DllCall("SystemParametersInfo", UInt, 0x71, UInt, 0, UInt, Mouse_Speed_Current, UInt, 0)
sleep, 30
Mouse_Speed_Current := Mouse_Speed_Orig - 10
DllCall("SystemParametersInfo", UInt, 0x71, UInt, 0, UInt, Mouse_Speed_Current, UInt, 0)
sleep, 20
Mouse_Speed_Current := Mouse_Speed_Orig - 10
DllCall("SystemParametersInfo", UInt, 0x71, UInt, 0, UInt, Mouse_Speed_Current, UInt, 0)
sleep, 10
Mouse_Speed_Current := Mouse_Speed_Orig - 15
DllCall("SystemParametersInfo", UInt, 0x71, UInt, 0, UInt, Mouse_Speed_Current, UInt, 0)
sleep, 5
DllCall("SystemParametersInfo", UInt, 0x71, UInt, 0, UInt, Mouse_Speed_Orig, UInt, 0)
WinSet, AlwaysOnTop, off, PORTAL
return




left_through_right:
WinSet, AlwaysOnTop, on, PORTAL
MouseGetPos, Xpor, Ypor
Portal_right := GUI_W
Portal_right -= 12
Portal_left := 0
Ypor -= 13
If (TPSOUND) {
Soundplay, TP.wav
}
GuiControl, Move, OP, x%Portal_right% y%Ypor%
GuiControl, Move, BP, x%Portal_left% y%Ypor%
GuiControl, , BP, BL1.png
GuiControl, , OP, OR1.png
;sleep, 0.1
GuiControl, , BP, BL2.png
GuiControl, , OP, OR2.png
;sleep, 0.1
GuiControl, , BP, BL3.png
GuiControl, , OP, OR3.png
;sleep, 0.1
GuiControl, , BP, BL4.png
GuiControl, , OP, OR4.png
;sleep, 0.1
GuiControl, , BP, BL5.png
GuiControl, , OP, OR5.png

MouseMove, %warpwidth%, %Y%
MouseGetPos, X, Y
X -= 30
MouseMove, %X%, %Y%
Mouse_Speed_Current := Mouse_Speed_Orig + 15
DllCall("SystemParametersInfo", UInt, 0x71, UInt, 0, UInt, Mouse_Speed_Current, UInt, 0)
GuiControl, , BP, BL4.png
GuiControl, , OP, OR4.png
MouseGetPos, X, Y
X -= 25
MouseMove, %X%, %Y%
sleep, 0.1
GuiControl, , BP, BL3.png
GuiControl, , OP, OR3.png
MouseGetPos, X, Y
X -= 20
MouseMove, %X%, %Y%
sleep, 0.1
Mouse_Speed_Current := Mouse_Speed_Orig + 15
DllCall("SystemParametersInfo", UInt, 0x71, UInt, 0, UInt, Mouse_Speed_Current, UInt, 0)
GuiControl, , BP, BL2.png
GuiControl, , OP, OR2.png
MouseGetPos, X, Y
X -= 15
MouseMove, %X%, %Y%
sleep, 0.1
GuiControl, , BP, BL1.png
GuiControl, , OP, OR1.png
MouseGetPos, X, Y
X -= 10
MouseMove, %X%, %Y%
sleep, 0.1
Mouse_Speed_Current := Mouse_Speed_Orig + 15
DllCall("SystemParametersInfo", UInt, 0x71, UInt, 0, UInt, Mouse_Speed_Current, UInt, 0)
GuiControl, , BP, nothing.png
GuiControl, , OP, nothing.png
sleep, 30
Mouse_Speed_Current := Mouse_Speed_Orig - 5
DllCall("SystemParametersInfo", UInt, 0x71, UInt, 0, UInt, Mouse_Speed_Current, UInt, 0)
sleep, 30
Mouse_Speed_Current := Mouse_Speed_Orig - 5
DllCall("SystemParametersInfo", UInt, 0x71, UInt, 0, UInt, Mouse_Speed_Current, UInt, 0)
sleep, 30
Mouse_Speed_Current := Mouse_Speed_Orig - 10
DllCall("SystemParametersInfo", UInt, 0x71, UInt, 0, UInt, Mouse_Speed_Current, UInt, 0)
sleep, 20
Mouse_Speed_Current := Mouse_Speed_Orig - 10
DllCall("SystemParametersInfo", UInt, 0x71, UInt, 0, UInt, Mouse_Speed_Current, UInt, 0)
sleep, 10
Mouse_Speed_Current := Mouse_Speed_Orig - 15
DllCall("SystemParametersInfo", UInt, 0x71, UInt, 0, UInt, Mouse_Speed_Current, UInt, 0)
sleep, 5
DllCall("SystemParametersInfo", UInt, 0x71, UInt, 0, UInt, Mouse_Speed_Orig, UInt, 0)
WinSet, AlwaysOnTop, off, PORTAL
return






top_through_bottom:
WinSet, AlwaysOnTop, on, PORTAL
MouseGetPos, Xpor, Ypor
Portal_bottom := GUI_H
Portal_bottom -= 12
Portal_top := 0
Xpor -= 13
If (TPSOUND) {
Soundplay, TP.wav
}
GuiControl, Move, BP, x%Xpor% y%Portal_top%
GuiControl, Move, OP, x%Xpor% y%Portal_bottom%
GuiControl, , BP, BT1.png
GuiControl, , OP, OB1.png
;sleep, 0.1
GuiControl, , BP, BT2.png
GuiControl, , OP, OB2.png
;sleep, 0.1
GuiControl, , BP, BT3.png
GuiControl, , OP, OB3.png
;sleep, 0.1
GuiControl, , BP, BT4.png
GuiControl, , OP, OB4.png
;sleep, 0.1
GuiControl, , BP, BT5.png
GuiControl, , OP, OB5.png

MouseMove, %X%, %warpheight%
MouseGetPos, X, Y
Y -= 30
MouseMove, %X%, %Y%
Mouse_Speed_Current := Mouse_Speed_Orig + 15
DllCall("SystemParametersInfo", UInt, 0x71, UInt, 0, UInt, Mouse_Speed_Current, UInt, 0)
GuiControl, , BP, BT4.png
GuiControl, , OP, OB4.png
MouseGetPos, X, Y
Y -= 25
MouseMove, %X%, %Y%
sleep, 0.1
GuiControl, , BP, BT3.png
GuiControl, , OP, OB3.png
MouseGetPos, X, Y
Y -= 20
MouseMove, %X%, %Y%
sleep, 0.1
Mouse_Speed_Current := Mouse_Speed_Orig + 15
DllCall("SystemParametersInfo", UInt, 0x71, UInt, 0, UInt, Mouse_Speed_Current, UInt, 0)
GuiControl, , BP, BT2.png
GuiControl, , OP, OB2.png
MouseGetPos, X, Y
Y -= 15
MouseMove, %X%, %Y%
sleep, 0.1
GuiControl, , BP, BT1.png
GuiControl, , OP, OB1.png
MouseGetPos, X, Y
Y -= 10
MouseMove, %X%, %Y%
sleep, 0.1
Mouse_Speed_Current := Mouse_Speed_Orig + 15
DllCall("SystemParametersInfo", UInt, 0x71, UInt, 0, UInt, Mouse_Speed_Current, UInt, 0)
GuiControl, , BP, nothing.png
GuiControl, , OP, nothing.png
sleep, 30
Mouse_Speed_Current := Mouse_Speed_Orig - 5
DllCall("SystemParametersInfo", UInt, 0x71, UInt, 0, UInt, Mouse_Speed_Current, UInt, 0)
sleep, 30
Mouse_Speed_Current := Mouse_Speed_Orig - 5
DllCall("SystemParametersInfo", UInt, 0x71, UInt, 0, UInt, Mouse_Speed_Current, UInt, 0)
sleep, 30
Mouse_Speed_Current := Mouse_Speed_Orig - 10
DllCall("SystemParametersInfo", UInt, 0x71, UInt, 0, UInt, Mouse_Speed_Current, UInt, 0)
sleep, 20
Mouse_Speed_Current := Mouse_Speed_Orig - 10
DllCall("SystemParametersInfo", UInt, 0x71, UInt, 0, UInt, Mouse_Speed_Current, UInt, 0)
sleep, 10
Mouse_Speed_Current := Mouse_Speed_Orig - 15
DllCall("SystemParametersInfo", UInt, 0x71, UInt, 0, UInt, Mouse_Speed_Current, UInt, 0)
sleep, 5
DllCall("SystemParametersInfo", UInt, 0x71, UInt, 0, UInt, Mouse_Speed_Orig, UInt, 0)
WinSet, AlwaysOnTop, off, PORTAL
return





bottom_through_top:
WinSet, AlwaysOnTop, on, PORTAL
MouseGetPos, Xpor, Ypor
Portal_bottom := GUI_H
Portal_bottom -= 12
Portal_top := 0
Xpor -= 13
If (TPSOUND) {
Soundplay, TP.wav
}
GuiControl, Move, OP, x%Xpor% y%Portal_top%
GuiControl, Move, BP, x%Xpor% y%Portal_bottom%
GuiControl, , BP, BB1.png
GuiControl, , OP, OT1.png
;sleep, 0.1
GuiControl, , BP, BB2.png
GuiControl, , OP, OT2.png
;sleep, 0.1
GuiControl, , BP, BB3.png
GuiControl, , OP, OT3.png
;sleep, 0.1
GuiControl, , BP, BB4.png
GuiControl, , OP, OT4.png
;sleep, 0.1
GuiControl, , BP, BB5.png
GuiControl, , OP, OT5.png

MouseMove, %X%, 2,
MouseGetPos, X, Y
Y += 30
MouseMove, %X%, %Y%
Mouse_Speed_Current := Mouse_Speed_Orig + 15
DllCall("SystemParametersInfo", UInt, 0x71, UInt, 0, UInt, Mouse_Speed_Current, UInt, 0)
GuiControl, , BP, BB4.png
GuiControl, , OP, OT4.png
MouseGetPos, X, Y
Y += 25
MouseMove, %X%, %Y%
sleep, 0.1
GuiControl, , BP, BB3.png
GuiControl, , OP, OT3.png
MouseGetPos, X, Y
Y += 20
MouseMove, %X%, %Y%
sleep, 0.1
Mouse_Speed_Current := Mouse_Speed_Orig + 15
DllCall("SystemParametersInfo", UInt, 0x71, UInt, 0, UInt, Mouse_Speed_Current, UInt, 0)
GuiControl, , BP, BB2.png
GuiControl, , OP, OT2.png
MouseGetPos, X, Y
Y += 15
MouseMove, %X%, %Y%
sleep, 0.1
GuiControl, , BP, BB1.png
GuiControl, , OP, OT1.png
MouseGetPos, X, Y
Y += 10
MouseMove, %X%, %Y%
sleep, 0.1
Mouse_Speed_Current := Mouse_Speed_Orig + 15
DllCall("SystemParametersInfo", UInt, 0x71, UInt, 0, UInt, Mouse_Speed_Current, UInt, 0)
GuiControl, , BP, nothing.png
GuiControl, , OP, nothing.png
sleep, 30
Mouse_Speed_Current := Mouse_Speed_Orig - 5
DllCall("SystemParametersInfo", UInt, 0x71, UInt, 0, UInt, Mouse_Speed_Current, UInt, 0)
sleep, 30
Mouse_Speed_Current := Mouse_Speed_Orig - 5
DllCall("SystemParametersInfo", UInt, 0x71, UInt, 0, UInt, Mouse_Speed_Current, UInt, 0)
sleep, 30
Mouse_Speed_Current := Mouse_Speed_Orig - 10
DllCall("SystemParametersInfo", UInt, 0x71, UInt, 0, UInt, Mouse_Speed_Current, UInt, 0)
sleep, 20
Mouse_Speed_Current := Mouse_Speed_Orig - 10
DllCall("SystemParametersInfo", UInt, 0x71, UInt, 0, UInt, Mouse_Speed_Current, UInt, 0)
sleep, 10
Mouse_Speed_Current := Mouse_Speed_Orig - 15
DllCall("SystemParametersInfo", UInt, 0x71, UInt, 0, UInt, Mouse_Speed_Current, UInt, 0)
sleep, 5
DllCall("SystemParametersInfo", UInt, 0x71, UInt, 0, UInt, Mouse_Speed_Orig, UInt, 0)
WinSet, AlwaysOnTop, off, PORTAL
return





~MButton::
SetTimer, CheckMousePos, 5
Return

~MButton up::
SetTimer, CheckMousePos, Off
Return

TPSTOGGLE:
TPSOUND := !TPSOUND
IniWrite, %TPSOUND%, Settings.ini, SOUNDEFFECT, Sound
If (TPSOUND = true) {
Menu, tray, check, Sound effect
}
If (TPSOUND = false) {
Menu, tray, uncheck, Sound effect
}
Return





ExitApp:
	ExitApp
