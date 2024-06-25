#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#Persistent
#Singleinstance force
SetKeyDelay, -100
SetMouseDelay, -100
Coordmode, Mouse, Screen
Process, Priority,, N
SetBatchLines, -1
Listlines, off
Menu, Tray, NoStandard
Menu, Tray, Add, Exit Mouse Teleporter, ExitApp

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
Gui, Add, Picture, vBPR, Nothing.png
Gui, Add, Picture, vBPL, Nothing.png
Gui, Add, Picture, vBPT, Nothing.png
Gui, Add, Picture, vBPB, Nothing.png
Gui, Add, Picture, vRPR, Nothing.png
Gui, Add, Picture, vRPL, Nothing.png
Gui, Add, Picture, vRPT, Nothing.png
Gui, Add, Picture, vRPB, Nothing.png
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
        MouseMove, 2,%Y%,
    }
	
    If (X = 0) {
        MouseMove, %warpwidth%,%Y%,
    }
	
	
	

     If (Y >= DeskTop_Height -2) {
        MouseMove, %X%, 2,
    }
	
    
	 If (Y = 0) {
       MouseMove, %X%,%warpheight%,
    }
}
Return



~MButton::
SetTimer, CheckMousePos, 5
Return

~MButton up::
SetTimer, CheckMousePos, Off
Return









ExitApp:
	ExitApp