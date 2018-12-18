# Idle Skripter

Idle Skripter is a WIP AHK Script for the Idle/Incremental Game, Idle Skilling.

Current Version: 0.2.0 (Supports Idle Skilling v1.41)

## Features

- Common Scripts
	- Collect Drops
	- Auto Advance
	- Unequip Cards
- Decks (Card Presets)

## How to Use
- Collect Drops: Must be on Fight screen
- Auto Advance: Must be on Fight screen
- Unequip Cards: Must be on Card screen
- Decks
	- Create a Deck (only choose cards for slots you have)
	- Double Click Deck or Select a Deck and press Equip Deck button to run (Must be on Card screen)
## Hotkeys
- F2: Stop Looping Scripts (e.g. Auto Advance), does not stop non-looping scripts (e.g. Unequip Cards)
- F3: Reloads the Script
- Esc: Exit Script, use for quick close or if script gets you stuck due to a bug.

## FAQs

**Q**: I get a "Could Not Find Swap Menu Button" message, what do I do?

**A**: The script searches for Swap.png on the screen and uses that to find the top left of the game. Image Searching requires relatively precise matching. This issue can be caused by an incompatable aspect ratio or a scaling factor. Please do the following:
- Swap.png is in same folder as the script
- Swap Menu Button in the Game should be visible
- Set Browser Zoom to 100%
- Set (Windows) DPI Scaling to 100%
- Set Game Zoom to 100% (Right-Click the Game)