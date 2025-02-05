#Requires AutoHotkey >=2.0
#SingleInstance

DetectHiddenWindows true
WIN_TITLE := "ahk_exe Spotify.exe"
DISCORD_TITLE := "ahk_exe Discord.exe"

sleep(300)

; Launch and set up Spotify
if not (WinExist(WIN_TITLE))
{
	; Add "Start Menu/Programs" to PATH beforehand
	RunWait("Spotify", ,"Max")
}
PID := WinGetPID(WIN_TITLE)
HWND := WinExist(WIN_TITLE)

; Make Spotify full screen on second monitor
MonitorGetWorkArea(1, &PrimaryLeft, &PrimaryTop, &PrimaryRight, &PrimaryBottom)
MonitorGetWorkArea(2, &SecondLeft, &SecondTop, &SecondRight, &SecondBottom)

; There is a random gap between monitors. 2560 -> 3200 = 640px gap
WinMove(SecondLeft, SecondTop, SecondRight - PrimaryRight - 640, SecondBottom, WIN_TITLE)
WinMaximize(WIN_TITLE) ; Makes it fit better as WinMove isnt precise

; Next song
+F1::
{
	Send("{Media_Next}")
}

; Previous song
+F2::
{
	Send("{Media_Prev}")
}

; Play/pause
+F3::
{
	Send("{Media_Play_Pause}")
}

; Stop
+F4::
{
	Send("{Media_Stop}")
}

; Volume Down
LCtrl & F5::
{
	CurrentWindow := WinGetTitle("A")
	WinActivate(WIN_TITLE)
	ControlSend("^{Down}", HWND, WIN_TITLE)
	if (WinExist(DISCORD_TITLE))
	{
		WinActivate(DISCORD_TITLE)
	}
	WinActivate(CurrentWindow)
}

; Volume Up
LCtrl & F6::
{
	CurrentWindow := WinGetTitle("A")
	WinActivate(WIN_TITLE)
	ControlSend("^{Up}", HWND, WIN_TITLE)
	if (WinExist(DISCORD_TITLE))
	{
		WinActivate(DISCORD_TITLE)
	}
	WinActivate(CurrentWindow)
}