^K:: ; Hotkey: Ctrl + K
{	
	;Loops 25 times
	Loop, 25{
		; Loop 5 times for the full attack cycle
		Loop, 6 {
			AttackingLoop()
        	Sleep, 5000 ; Wait 5 seconds before running again
    	}
		GetBuilderElixer()
	}
	MsgBox, Script Has ran its course, LOOT UP!
    return
}

GetBuilderElixer()
{
    ; Start up Clash of Clans
    FileRead, clashLocation, clashOfClansFileLocation.txt
    Run, %clashLocation%

    ImagePath := "PurpleCart.png"
    ImagePathCollect := "GreenColor.png"
    
    Sleep, 15000 ; Wait 20 seconds for Clash of Clans to load up

    ; Get the window's position and size
    WinGetPos, WindowX, WindowY, WindowWidth, WindowHeight, ahk_exe crosvm.exe

	MouseMove, WindowWidth/2, WindowHeight/2 ;moves to a standardized position to scroll out correctly

	; Scroll down 5 times
    Loop, 10 {
        Send, {WheelDown}
        Sleep, 500 ; Sleep for half a second between scrolls
    }

	ImageSearch, FoundXPath, FoundYPath, WindowWidth * (5/8) , 0, WindowWidth, WindowHeight/4, *50 %ImagePath%
    ClickMouse(FoundXPath, FoundYPath)

	Sleep, 1000 ;wait for loot to be collected

    ImageSearch, FoundXPathCollect, FoundYPathCollect, WindowWidth /2 , WindowHeight * (3/4), WindowWidth, WindowHeight, *50 %ImagePathCollect%
    ClickMouse(FoundXPathCollect, FoundYPathCollect)

    Sleep, 1000

	; Close Clash of Clans using process name
    WinKill, ahk_exe crosvm.exe ; Replace with the actual process name if different
}

AttackingLoop()
{
    ; Start up Clash of Clans
    FileRead, clashLocation, clashOfClansFileLocation.txt
    Run, %clashLocation%
    
    Sleep, 20000 ; Wait 20 seconds for Clash of Clans to load up

    ; Call the Attack function
    Attack()
    Sleep, 5000 ; Wait 5 seconds to enter attack screen
    SpamTroops()
    Sleep, 1000 ; Wait after spamming troops

    ; Close Clash of Clans using process name
    WinKill, ahk_exe crosvm.exe ; Replace with the actual process name if different
}

SpamTroops()
{    
    ; Get the window's position and size
    WinGetPos, WindowX, WindowY, WindowWidth, WindowHeight, ahk_exe crosvm.exe

    ; Scroll down 5 times
    Loop, 5 {
        Send, {WheelDown}
        Sleep, 500 ; Sleep for half a second between scrolls
    }
    
    ; Initial troop drop hero 
    Send, q ; q is what the hero bind is default
    Sleep, 1000 ; Wait 1 second before placing more troops
    ; Drop additional troops at random locations
    Loop, 5 {
        Random, randX, WindowWidth * (3/16), WindowWidth * (7/8) ; Get a random x-coordinate
        Random, randY, WindowHeight/4, WindowHeight * (3/4) ; Get a random y-coordinate
        ClickMouse(randX, randY)
        Sleep, 100 ; Wait 0.1 seconds between clicks
    }

	; Initial troop drop hero 
	;commented out for now as dont have hero on this account
    Send, 1 ; the default keybind for the troops
    Sleep, 1000 ; Wait 1 second before placing more troops
    ; Drop additional troops at random locations
    Loop, 15 {
        Random, randX, WindowWidth * (3/16), WindowWidth * (7/8) ; Get a random x-coordinate
        Random, randY, WindowHeight/4, WindowHeight * (3/4)  ; Get a random y-coordinate
        ClickMouse(randX, randY)
        Sleep, 100 ; Wait 0.1 seconds between clicks
    }
}

Attack()
{
    ;Path to my image
	ImagePathAttack := "greyToStartAttack.png"
    ImagePathFindNow := "GreenColor.png"

    ; Get the window's position and size
    WinGetPos, WindowX, WindowY, WindowWidth, WindowHeight, ahk_exe crosvm.exe

	; preform a image search
	ImageSearch, FoundX, FoundY, 0, WindowHeight - 250, 250, WindowHeight, *50 %ImagePathAttack%
    ClickMouse(FoundX, FoundY)

    Sleep, 1000

    ImageSearch, FoundXPath, FoundYPath, (WindowWidth/3)*2 , 0, WindowWidth, WindowHeight, *50 %ImagePathFindNow%
    ClickMouse(FoundXPath, FoundYPath)
}

ClickMouse(x, y)
{
    MouseMove, %x%, %y% ; Move the mouse to (x, y)
    Sleep, 100 ; Wait for the mouse to get in position
    Click, left ; Left-click at that position
}

; Define the function to exit the script early
^E::EndScript() ; Ctrl+E to end the script

EndScript()
{
    MsgBox, Script is ending now. Goodbye!
    ExitApp
}
