
;===========================
;=== AHK Script Settings ===
;===========================

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Enable warnings to assist with detecting common errors.
#SingleInstance force  ; Replace Old Instances Automatically
SendMode Event  ; Recommended for new scripts due to its superior speed and reliability.
SetMouseDelay, 25
SetDefaultMouseSpeed, 0
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

;=====================================
;=== Force Run As Admin (Optional) ===
;=====================================
If not A_IsAdmin ;force the script to run as admin
{
    Run *RunAs "%A_ScriptFullPath%"
    ExitApp
}

;=========================
;=== Include Libraries ===
;=========================

#Include <JSON>
#Include <Deck>
#Include <Card>

;========================
;=== Global Variables ===
;========================

Global DebugMode := false

; Search & Offset
Global ImageSearchVariance := 0
Global TopLeftX := 0
Global TopLeftY := 0

; Game Player
Global Browser := true
Global GameWindowTitle := "Play Idle Skilling"

; Script Run-Time Data
Global CurrentFunction
Global OverallTimerStart

; GUI Control Variables
Global TabList := 1
Global DeckListBox
Global DeckCreatorDeckName
Global DeckCreatorDeckCard1
Global DeckCreatorDeckCard2
Global DeckCreatorDeckCard3
Global DeckCreatorDeckCard4
Global DeckCreatorDeckCard5
Global DeckCreatorDeckCard6
Global DeckCreatorDeckCard7
Global DeckCreatorDeckCard8
Global DeckCreatorDeckCard9
Global DeckCreatorDeckCard10
Global tbaButton1
Global tbaButton2
Global tbaButton3
Global tbaButton4

; Data
Global Cards := []
Global Decks := []
Global CardList := ""
Global DeckList := ""

Global Running := "None"

;=============
;=== Start ===
;=============

Initialise()

Initialise() {
	LoadCards()
	LoadDecks()
	CardList := JoinArray(Cards, "|", "name")
	DeckList := JoinArray(Decks, "|", "name")
	LoadINI()
	SetTimer, GUICheck, 500
}

GUICheck()
{
	if (Running = "None")
		RunStart()
}

RunStart()
{
	CreateGUI()
	WinWait,Idle Skripter
	WinWaitClose, Idle Skripter
	
	CheckGameWindow()
	
	WinActivate, %GameWindowTitle%
	InitialiseScript()
	while(Running != "None") {
		if (Running = "Test")
			TestFunc()
		else if (Running = "Auto Advance")
			AutoAdvance()
		else if (Running = "Collect Drops")
			CollectDrops()
		else if (Running = "Unequip Cards")
			UnequipCards()
		else if (Running = "Equip Deck")
			EquipDeck()
	}
}

CheckGameWindow()
{
	if WinExist("Adobe Flash Player")
	{
		Browser := false
		GameWindowTitle := "Adobe Flash Player"
	}
}

InitialiseScript()
{
	CurrentFunction := A_ThisFunc
	SetupOffsets()
	OverallTimerStart := A_TickCount
	SleepStatus = Active
	;SetTimer, Timer, 750
}

SetupOffsets() ; Defines TopLeftX and TopLeftY to be the top-left corner of the game, based on an image search. Run everytime you run a script.
{
	WinActivate, %GameWindowTitle%
	IfWinNotActive, %GameWindowTitle%
	{
		MsgBox, Idle Skilling Not Found. Please run the game before running the script.
		ExitApp
	}
	
	WinGetPos,,,WinW,WinH
	SearchFileName = Swap.png
	ImageSearch, SearchX, SearchY, 0, 0, %WinW%, %WinH%, *%ImageSearchVariance% *TransBlack %SearchFileName%
		
	If SearchX
	{
		TopLeftX := SearchX - 10
		TopLeftY := SearchY - 10
	}
	else
	{
		MsgBox, Could Not Find Swap Menu Button, please make sure the Swap Menu Button is visible.
		ExitApp
	}
	
}

;===========
;=== GUI ===
;===========

CreateGUI()
{
	Gui, Main: New
	Gui, Main: Font, s10
	Gui, Main: Add, Tab3, vTabList AltSubmit Choose%TabList%, Main|Decks|Settings|About
	
	Gui, Main: Font, s14
	Gui, Main: Add, GroupBox, w220 h100 Section, Common Scripts
	
	Gui, Main: Font, s8
	Gui, Main: Add, Button, xs+20 ys+30 w80 h25 gCollectDropsLab, Collect Drops
	Gui, Main: Add, Button, xs+20 ys+60 w80 h25 gAutoAdvanceLab, Auto Advance
	Gui, Main: Add, Button, xs+120 ys+30 w80 h25 gUnequipCardsLab, Unequip Cards
	Gui, Main: Add, Button, xs+120 ys+60 w80 h25 vtbaButton1, ???
	
	Gui, Main: Font, s14
	Gui, Main: Add, GroupBox, xp-120 y+30 w220 h100 Section, Other
	
	Gui, Main: Font, s8
	Gui, Main: Add, Button, xs+20 ys+30 w80 h25 vtbaButton2, ???
	Gui, Main: Add, Button, xs+20 ys+60 w80 h25 vtbaButton3, ???
	Gui, Main: Add, Button, xs+120 ys+30 w80 h25 vtbaButton4, ???
	if (DebugMode) {
		Gui, Main: Add, Button, xs+120 ys+60 w35 h25 gTestLab, T
		Gui, Main: Add, Button, xs+165 ys+60 w35 h25 Default, Exit
	} else {
		Gui, Main: Add, Button, xs+120 ys+60 w80 h25 Default, Exit
	}
	
	GuiControl, Disable, tbaButton1
	GuiControl, Disable, tbaButton2
	GuiControl, Disable, tbaButton3
	GuiControl, Disable, tbaButton4
	
	Gui, Main: Tab, Decks
	Gui, Main: Add, ListBox, x+10 y+10 R16 vDeckListBox gEquipDeckLab Section AltSubmit, %DeckList%
	Gui, Main: Add, Button, x+16 yp-1 w80 h25 gCreateDeck, Create Deck
	Gui, Main: Add, Button, xp yp+30 w80 h25 gEditDeck, Edit Deck
	Gui, Main: Add, Button, xp yp+30 w80 h25 gDeleteDeck, Delete Deck
	Gui, Main: Add, Button, xp yp+129 w80 h25 gEquipDeckLab, Equip Deck
	
	Gui, Main: Tab, Settings
	
	
	Gui, Main: Tab, About
	Gui, Main: Add, Text, +Wrap w220, Idle Skripter is an AHK Script for Idle Skilling
	Gui, Main: Add, Link, +Wrap w220, Created by: Natsulus`nDiscord: Natsulus#0001`nGithub: <a href="https://github.com/Natsulus">https://github.com/Natsulus</a>
	Gui, Main: Add, Link, +Wrap w220, <a href="https://discord.gg/YkcmBxb">Discord</a>`n<a href="https://idle-skilling.wikia.com/wiki/Idle_Skilling_Wiki">Wikia</a>
	Gui, Main: Add, Text, +Wrap w220, 
	Gui, Main: Add, Text, +Wrap w220, 
	Gui, Main: Add, Text, +Wrap w220, 
	Gui, Main: Add, Text, +Wrap w220, Current Version: v0.1.1
	
	
	Gui, Main: Show, Center, Idle Skripter
	return
	
	TestLab:
	Running := "Test"
	GuiControlGet, TabList
	Gui, Main: Destroy
	return
	
	CollectDropsLab:
	GuiControlGet, TabList
	Running := "Collect Drops"
	Gui, Main: Destroy
	return
	
	AutoAdvanceLab:
	GuiControlGet, TabList
	Running := "Auto Advance"
	Gui, Main: Destroy
	return
	
	UnequipCardsLab:
	GuiControlGet, TabList
	Running := "Unequip Cards"
	Gui, Main: Destroy
	return
	
	ReloadScript:
	Reload
	return
	
	EquipDeckLab:
	if (A_GuiControl = "DeckListBox") {
		if (A_GuiEvent != "DoubleClick") {
			return
		}
	}
	GuiControlGet, DeckListBox
	GuiControlGet, TabList
	Running := "Equip Deck"
	Gui, Main: Destroy
	return
	
	CreateDeck:
	OpenDeckCreator("Create")
	return
	
	MainButtonExit:
	MainGuiClose:
	MainGuiEscape:
	Gui Main: Destroy
	Tooltip, Aw  :(
	Sleep, 1000
	ExitApp
	
	DeckCreatorButtonCancel:
	DeckCreatorGuiClose:
	DeckCreatorGuiEscape:
	Gui, Main: -Disabled
	Gui DeckCreator: Destroy
	return
}

OpenDeckCreator(Option, DeckNo = 0) {
	CreatorDeckName := ""
	SelectedDeckCard1 := "1"
	SelectedDeckCard2 := "0"
	SelectedDeckCard3 := "0"
	SelectedDeckCard4 := "0"
	SelectedDeckCard5 := "0"
	SelectedDeckCard6 := "0"
	SelectedDeckCard7 := "0"
	SelectedDeckCard8 := "0"
	SelectedDeckCard9 := "0"
	SelectedDeckCard10 := "0"
	
	if (Option = "Edit") {
		SelectedDeck := Decks[DeckNo]
		CreatorDeckName := SelectedDeck.name
		SelectedDeckCard1 := SelectedDeck.cards[1]
		SelectedDeckCard2 := SelectedDeck.cards[2]
		SelectedDeckCard3 := SelectedDeck.cards[3]
		SelectedDeckCard4 := SelectedDeck.cards[4]
		SelectedDeckCard5 := SelectedDeck.cards[5]
		SelectedDeckCard6 := SelectedDeck.cards[6]
		SelectedDeckCard7 := SelectedDeck.cards[7]
		SelectedDeckCard8 := SelectedDeck.cards[8]
		SelectedDeckCard9 := SelectedDeck.cards[9]
		SelectedDeckCard10 := SelectedDeck.cards[10]
	}

	Gui, DeckCreator: New
	Gui, DeckCreator: +ToolWindow +OwnerMain
	Gui, Main: +Disabled
	Gui, DeckCreator: Font, s12
	Gui, DeckCreator: Add, Text,, Deck Name
	Gui, DeckCreator: Font, s8
	Gui, DeckCreator: Add, Edit, w120 R1 vDeckCreatorDeckName Limit20, %CreatorDeckName%

	Gui, DeckCreator: Font, s10
	Gui, DeckCreator: Add, Text, xp+1 yp+40 w50, Card 1
	Gui, DeckCreator: Add, Text, xp+110 yp w50, Card 2
	Gui, DeckCreator: Add, Text, xp+110 yp w50, Card 3
	Gui, DeckCreator: Add, Text, xp+110 yp w50, Card 4
	Gui, DeckCreator: Add, Text, xp+110 yp w50, Card 5
	Gui, DeckCreator: Font, s8
	
	
	Gui, DeckCreator: Add, DropDownList, xp-441 yp+20 w100 vDeckCreatorDeckCard1 AltSubmit Choose%SelectedDeckCard1%, %CardList%
	Gui, DeckCreator: Add, DropDownList, xp+110 yp w100 vDeckCreatorDeckCard2 AltSubmit Choose%SelectedDeckCard2%, %CardList%
	Gui, DeckCreator: Add, DropDownList, xp+110 yp w100 vDeckCreatorDeckCard3 AltSubmit Choose%SelectedDeckCard3%, %CardList%
	Gui, DeckCreator: Add, DropDownList, xp+110 yp w100 vDeckCreatorDeckCard4 AltSubmit Choose%SelectedDeckCard4%, %CardList%
	Gui, DeckCreator: Add, DropDownList, xp+110 yp w100 vDeckCreatorDeckCard5 AltSubmit Choose%SelectedDeckCard5%, %CardList%
	
	Gui, DeckCreator: Font, s10
	Gui, DeckCreator: Add, Text, xp-439 yp+30 w50, Card 6
	Gui, DeckCreator: Add, Text, xp+110 yp w50, Card 7
	Gui, DeckCreator: Add, Text, xp+110 yp w50, Card 8
	Gui, DeckCreator: Add, Text, xp+110 yp w50, Card 9
	Gui, DeckCreator: Add, Text, xp+110 yp w50, Card 10
	Gui, DeckCreator: Font, s8
	Gui, DeckCreator: Add, DropDownList, xp-441 yp+20 w100 vDeckCreatorDeckCard6 AltSubmit Choose%SelectedDeckCard6%, %CardList%
	Gui, DeckCreator: Add, DropDownList, xp+110 yp w100 vDeckCreatorDeckCard7 AltSubmit Choose%SelectedDeckCard7%, %CardList%
	Gui, DeckCreator: Add, DropDownList, xp+110 yp w100 vDeckCreatorDeckCard8 AltSubmit Choose%SelectedDeckCard8%, %CardList%
	Gui, DeckCreator: Add, DropDownList, xp+110 yp w100 vDeckCreatorDeckCard9 AltSubmit Choose%SelectedDeckCard9%, %CardList%
	Gui, DeckCreator: Add, DropDownList, xp+110 yp w100 vDeckCreatorDeckCard10 AltSubmit Choose%SelectedDeckCard10%, %CardList%
	
	
	Gui, DeckCreator: Add, Button, xm+185 ym+195 w80 h25, Cancel
	if (Option = "Edit") {
		Gui, DeckCreator: Add, Button, xp+90 yp w80 h25 Default gUpdateDeck, %Option%
	} else {
		Gui, DeckCreator: Add, Button, xp+90 yp w80 h25 Default gCreateNewDeck, %Option%
	}
	Gui, DeckCreator: Show, Center w570 h240, %Option% Deck
}

CreateNewDeck() {
	CreateDeck("Create")
}

UpdateDeck() {
	CreateDeck("Edit")
}

CreateDeck(Option) {
	Gui, DeckCreator:Submit, NoHide
	DeckCreatorDeckCards := []
	DeckCreatorDeckCards.Push(DeckCreatorDeckCard1)
	DeckCreatorDeckCards.Push(DeckCreatorDeckCard2)
	DeckCreatorDeckCards.Push(DeckCreatorDeckCard3)
	DeckCreatorDeckCards.Push(DeckCreatorDeckCard4)
	DeckCreatorDeckCards.Push(DeckCreatorDeckCard5)
	DeckCreatorDeckCards.Push(DeckCreatorDeckCard6)
	DeckCreatorDeckCards.Push(DeckCreatorDeckCard7)
	DeckCreatorDeckCards.Push(DeckCreatorDeckCard8)
	DeckCreatorDeckCards.Push(DeckCreatorDeckCard9)
	DeckCreatorDeckCards.Push(DeckCreatorDeckCard10)
	check := ContainsDuplicate(DeckCreatorDeckCards)
	if (check) {
		MsgBox,, Duplicate Detected, % "Duplicate " . Cards[check].name . " Card Detected`nPlease Change Duplicate Cards"
	} else {
		NewDeck := new Deck(DeckCreatorDeckName, DeckCreatorDeckCards)
		if (Option = "Create") {
			Decks.Push(NewDeck)
		} else {
			Decks[DeckListBox] := NewDeck
		}
		DeckList := JoinArray(Decks, "|", "name")
		GuiControl, Main:, DeckListBox, |%DeckList%
		SaveDecks()
		Gui, Main: -Disabled
		Gui DeckCreator: Destroy
	}
}

EditDeck() {
	GuiControlGet, DeckListBox
	if (!DeckListBox) {
		MsgBox,, No Deck Selected, You must select a Deck to edit it.
		return
	}
	OpenDeckCreator("Edit", DeckListBox)
}

DeleteDeck() {
	GuiControlGet, DeckListBox
	if (!DeckListBox) {
		MsgBox,, No Deck Selected, You must select a Deck to delete it.
		return
	}
	Decks.RemoveAt(DeckListBox)
	DeckList := JoinArray(Decks, "|", "name")
	DeckListBox = ""
	GuiControl, Main:, DeckListBox, |%DeckList%
	SaveDecks()
}

;===Script Functions===

TestFunc() {
	Running := "None"
	return
}

AutoAdvance()
{	
	WinActivate, %GameWindowTitle%
	WinGetPos,,,WinW,WinH, %GameWindowTitle%
	SearchFileName := "Right.png"
	ImageSearch, SearchX, SearchY, 0, 0, %WinW%, %WinH%, *%ImageSearchVariance% *TransBlack %SearchFileName%
	
	if (SearchX) {
		SearchX += 20
		SearchY += 20
		Click, %SearchX%, %SearchY%
	} else {
		SearchFileName := "Right Lock.png"
		ImageSearch, SearchX, SearchY, 0, 0, %WinW%, %WinH%, *%ImageSearchVariance% *TransBlack %SearchFileName%
		if (!SearchX) {
			MsgBox, Reached End of Zone
			Running := "None"
		}
	}
	Sleep 500
}

CollectDrops()
{	
	SetMouseDelay, 5
	RelClick(305, 340)
	RelClick(320, 340)
	RelClick(335, 340)
	RelClick(350, 340)
	RelClick(365, 340)
	RelClick(380, 340)
	RelClick(395, 340)
	RelClick(410, 340)
	RelClick(425, 340)
	RelClick(440, 340)
	RelClick(455, 340)
	RelClick(470, 340)
	RelClick(485, 340)
	RelClick(500, 340)
	RelClick(515, 340)
	RelClick(530, 340)
	RelClick(545, 340)
	RelClick(560, 340)
	RelClick(575, 340)
	RelClick(590, 340)
	RelClick(605, 340)
	RelClick(620, 340)
	RelClick(635, 340)
	RelClick(650, 340)
	RelClick(665, 340)
	Sleep 50
}

UnequipCards()
{	
	;WinActivate, %GameWindowTitle%
	ClickEquippedCard(1)
	ClickRemoveCard()
	ClickEquippedCard(2)
	ClickRemoveCard()
	ClickEquippedCard(3)
	ClickRemoveCard()
	ClickEquippedCard(4)
	ClickRemoveCard()
	ClickEquippedCard(5)
	ClickRemoveCard()
	ClickEquippedCard(6)
	ClickRemoveCard()
	ClickEquippedCard(7)
	ClickRemoveCard()
	ClickEquippedCard(8)
	ClickRemoveCard()
	ClickEquippedCard(9)
	ClickRemoveCard()
	ClickEquippedCard(10)
	ClickRemoveCard()
	Running := "None"
	return
}

EquipDeck() {
	if (!DeckListBox) {
		MsgBox,, No Deck Selected, You must select a Deck to equip it.
		Running := "None"
		return
	}
	
	UnequipCards()
	SelectedDeck := Decks[DeckListBox]
	SelectedDeckCards := SelectedDeck.cards
	
	Loop, % SelectedDeckCards.Length() {
		if (SelectedDeckCards[A_Index]) {
			ClickCard(SelectedDeckCards[A_Index])
			ClickEquipCard()
		}
	}
	Running := "None"
	return
}

;=======================
;=== Check Functions ===
;=======================

OnTrainScreen()
{
}

OnGymScreen()
{
}

OnAttackDojoScreen()
{
}

OnStrengthMountainScreen()
{
}

OnEnduranceFieldScreen()
{
}

OnFightScreen()
{
}

OnPerksScreen()
{
}

OnCraftScreen()
{
}

OnPortalScreen()
{
}

OnLimboScreen()
{
}

OnCardScreen()
{
}

;===============================
;=== Screen Change Functions ===
;===============================

MoveToCardScreen()
{
}

;=========================
;=== Utility Functions ===
;=========================

RelClick(X, Y) {
	IfWinNotActive, %GameWindowTitle%
	{
		WinActivate, %GameWindowTitle%
	}
	
	X += TopLeftX
	Y += TopLeftY

	;MouseClick,, %X%, %Y%
	Click, %X%, %Y%
	return
}

CalcEquippedCardPos(Num) {
	Pos := {}
	Pos.Y := 415
	if (Num > 5) {
		Pos.Y := 495
		Num -= 5
	}
	Pos.X := 60 * Num + 622
	return Pos
}

CalcPagePos(Page) {
	Pos := {}
	Pos.X := 15
	Pos.Y := 68 * Page + 97
	return Pos
}

CalcCardPos(X, Y) {
	Pos := {}
	Pos.X := 54 * X + 49
	Pos.Y := 68 * Y + 62
	return Pos
}

ClickEquippedCard(Num) {
	Pos := CalcEquippedCardPos(Num)
	RelClick(Pos.X, Pos.Y)
	RelClick(Pos.X, Pos.Y)
}

ChangeCardPage(Page) {
	Pos := CalcPagePos(Page)
	RelClick(Pos.X, Pos.Y)
	RelClick(Pos.X, Pos.Y)
	return
}

ClickCard(CardNo) {
	GivenCard := Cards[CardNo]
	
	Pos := CalcCardPos(GivenCard.position.X, GivenCard.position.Y)
	ChangeCardPage(GivenCard.position.Page)
	RelClick(Pos.X, Pos.Y)
	RelClick(Pos.X, Pos.Y)
	return
}

ClickEquipCard() {
	RelClick(248, 442)
}

ClickRemoveCard() {
	RelClick(248, 500)
}

;===Saving & Loading Data===

SaveINI()
{
}

LoadINI()
{
}

SaveDecks()
{
	str := JSON.Dump(Decks,,4)
	file := FileOpen("Decks.json", "w")
	file.Write(str)
	file.Close()
}

LoadCards()
{
	file := FileOpen("Cards.json", "r")
	if (file) {
		str := file.Read()
		file.Close()
		Cards := JSON.Load(str)
	} else {
		file.Close()
	}
}

LoadDecks()
{
	file := FileOpen("Decks.json", "r")
	if (file) {
		str := file.Read()
		file.Close()
		Decks := JSON.Load(str)
	} else {
		file.Close()
		SaveDecks()
	}
}

;===Custom Functions===

JoinArray(array, sep="`n", property="") {
	str := ""
	if (property) {
		Loop, % array.Length()
			str .= array[A_Index][property] sep
	} else {
		Loop, % array.Length()
			str .= array[A_Index] sep
	}
	StringTrimRight, str, str, % StrLen(sep)
	return str
}

ContainsDuplicate(array) {
	check := []
	for k, v in array 
	{
		str := JoinArray(check, ",")
		if v in %str%
			return v
		check.Push(v)
	}
	return ""
}

;===Hotkeys===

F2::
{
	Running := "None"
	return
}
F3::
{
	Reload
}
Escape::
{
	ExitApp
}