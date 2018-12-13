#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Enable warnings to assist with detecting common errors.
#SingleInstance force  ; Replace Old Instances Automatically
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#Include <JSON>
#Include <Deck>
#Include <Card>

Global Cards := []
Global bonuslist := []
Global names := []
Global bonusType := []
Global initialBonus := []
Global finalBonus := []
Global zonelist := ["Grasslands", "Desert", "Mountains", "The Mist", "Dungeon", "Raid", "Special", "Event"]
Global positions := []

bonuslist.Push("Accuracy")
bonuslist.Push("Critical Chance")
bonuslist.Push("Idle Attack Speed")
bonuslist.Push("Base Damage")
bonuslist.Push("CLAW Skill Damage")
bonuslist.Push("Critical Damage")
bonuslist.Push("Trinket Efficiency")
bonuslist.Push("Idle Attack DMG")
bonuslist.Push("Total Damage")
bonuslist.Push("ATT Exp Chance")
bonuslist.Push("END Exp Chance")
bonuslist.Push("MIN Exp Chance")
bonuslist.Push("SPI Exp Chance")
bonuslist.Push("STR Exp Chance")
bonuslist.Push("SUM Exp Chance")
bonuslist.Push("MIN Exp Gained")
bonuslist.Push("Rift Exp")
bonuslist.Push("SMT Exp from Crafting")
bonuslist.Push("Acolyte Efficiency")
bonuslist.Push("Cultist Efficiency")
bonuslist.Push("Healing from Food")
bonuslist.Push("Healing from Heal Skill")
bonuslist.Push("Monster DMG Reduction")
bonuslist.Push("Total Health")
bonuslist.Push("Card Drop Chance")
bonuslist.Push("Monster Cash")
bonuslist.Push("Ores from Mining")
bonuslist.Push("Raid Drop Luck")
bonuslist.Push("Gains on All Screens")
bonuslist.Push("Souls Kept After Ascending")

names.Push("Mushroom")
names.Push("Slime")
names.Push("Stumpo")
names.Push("Rogue Rock")
names.Push("Shrubbery")
names.Push("Snail")
names.Push("Flowey")
names.Push("Relic Squid")
names.Push("Wormie")
names.Push("Monkey")
names.Push("Strawby")
names.Push("Bored Bean")
names.Push("Plain")
names.Push("Disciple Y")
names.Push("Keymaster Y")
names.Push("Grasslands Glitch")
names.Push("Potted Sand")
names.Push("Cacto")
names.Push("Potted Pot")
names.Push("Dung Ball")
names.Push("Dung Beetle")
names.Push("Yellow PHat")
names.Push("Quicksand")
names.Push("Tornado")
names.Push("Coco")
names.Push("Nutto")
names.Push("Wurm")
names.Push("Sand Jelly")
names.Push("Bandit Bob")
names.Push("Deadly Trap")
names.Push("Dryic Relic")
names.Push("Mirage Slime")
names.Push("Mappy")
names.Push("Spade")
names.Push("Treasure")
names.Push("Mimic")
names.Push("Desert Drink")
names.Push("Zombie Bob")
names.Push("Sand Rattler")
names.Push("A Monster")
names.Push("Stripe")
names.Push("Unacceptable")
names.Push("Desert Baron")
names.Push("Disciple B")
names.Push("Keymaster B")
names.Push("Desert Glitch")
names.Push("Flakey")
names.Push("Snow Pot")
names.Push("Ice Cream")
names.Push("Ice Rock")
names.Push("Baby Goat")
names.Push("Snowballs")
names.Push("Flakissimo")
names.Push("Sickle")
names.Push("Yeti")
names.Push("Glouwey")
names.Push("Ice Jelly")
names.Push("Cool Drink")
names.Push("Grow Goat")
names.Push("Blue PHat")
names.Push("Snaps")
names.Push("Sea Monster")
names.Push("Cylic Relic")
names.Push("Bloque")
names.Push("Elder Goat")
names.Push("Cold Slime")
names.Push("Crystalline")
names.Push("Frozen Bob")
names.Push("Twostrip")
names.Push("Disciple R")
names.Push("Keymaster R")
names.Push("Mountains Glitch")
names.Push("Soda")
names.Push("Sweetz")
names.Push("Verm")
names.Push("Mist Mytes")
names.Push("Piglo")
names.Push("Catsup")
names.Push("Edgy Rock")
names.Push("Gordy")
names.Push("Spinail")
names.Push("Spectre Bob")
names.Push("Octogon")
names.Push("A Sea Monster")
names.Push("Evil Dandy")
names.Push("Squode")
names.Push("Hyper Jelly")
names.Push("Totem Goop")
names.Push("Mystism")
names.Push("Horizon")
names.Push("Disciple Z")
names.Push("Keymaster Z")
names.Push("The Mist Glitch")
names.Push("Agent")
names.Push("Pot O Gold")
names.Push("Skelebob")
names.Push("Lockhart")
names.Push("Jelly Cube")
names.Push("Chaineran")
names.Push("Chalice")
names.Push("Unlucky Lad")
names.Push("Mimicridon")
names.Push("Skaul")
names.Push("Rich Snake")
names.Push("Trap Mach")
names.Push("Munnies")
names.Push("Holy Relic")
names.Push("Thx")
names.Push("Noob")
names.Push("King X")
names.Push("King Y")
names.Push("King Z")
names.Push("Entertainer X")
names.Push("Entertainer Y")
names.Push("Entertainer Z")
names.Push("Sentinel X")
names.Push("Sentinel Y")
names.Push("Sentinel Z")
names.Push("Demon X")
names.Push("Demon Y")
names.Push("Demon Z")
names.Push("Secretkeeper")
names.Push("Spooktober")
names.Push("Golden Turkey")

bonusType.Push(14)
bonusType.Push(11)
bonusType.Push(22)
bonusType.Push(12)
bonusType.Push(1)
bonusType.Push(23)
bonusType.Push(10)
bonusType.Push(5)
bonusType.Push(18)
bonusType.Push(25)
bonusType.Push(21)
bonusType.Push(24)
bonusType.Push(3)
bonusType.Push(8)
bonusType.Push(27)
bonusType.Push(17)
bonusType.Push(13)
bonusType.Push(2)
bonusType.Push(15)
bonusType.Push(1)
bonusType.Push(23)
bonusType.Push(26)
bonusType.Push(10)
bonusType.Push(3)
bonusType.Push(20)
bonusType.Push(19)
bonusType.Push(11)
bonusType.Push(16)
bonusType.Push(28)
bonusType.Push(5)
bonusType.Push(25)
bonusType.Push(14)
bonusType.Push(12)
bonusType.Push(27)
bonusType.Push(30)
bonusType.Push(7)
bonusType.Push(21)
bonusType.Push(18)
bonusType.Push(17)
bonusType.Push(6)
bonusType.Push(8)
bonusType.Push(7)
bonusType.Push(26)
bonusType.Push(13)
bonusType.Push(4)
bonusType.Push(30)
bonusType.Push(20)
bonusType.Push(15)
bonusType.Push(22)
bonusType.Push(16)
bonusType.Push(1)
bonusType.Push(19)
bonusType.Push(10)
bonusType.Push(11)
bonusType.Push(13)
bonusType.Push(18)
bonusType.Push(6)
bonusType.Push(21)
bonusType.Push(15)
bonusType.Push(26)
bonusType.Push(28)
bonusType.Push(5)
bonusType.Push(27)
bonusType.Push(23)
bonusType.Push(4)
bonusType.Push(12)
bonusType.Push(8)
bonusType.Push(18)
bonusType.Push(16)
bonusType.Push(2)
bonusType.Push(24)
bonusType.Push(10)
bonusType.Push(17)
bonusType.Push(19)
bonusType.Push(14)
bonusType.Push(3)
bonusType.Push(22)
bonusType.Push(20)
bonusType.Push(12)
bonusType.Push(2)
bonusType.Push(10)
bonusType.Push(28)
bonusType.Push(13)
bonusType.Push(7)
bonusType.Push(15)
bonusType.Push(4)
bonusType.Push(6)
bonusType.Push(27)
bonusType.Push(1)
bonusType.Push(24)
bonusType.Push(14)
bonusType.Push(25)
bonusType.Push(16)
bonusType.Push(5)
bonusType.Push(7)
bonusType.Push(20)
bonusType.Push(23)
bonusType.Push(19)
bonusType.Push(27)
bonusType.Push(21)
bonusType.Push(18)
bonusType.Push(28)
bonusType.Push(4)
bonusType.Push(6)
bonusType.Push(30)
bonusType.Push(3)
bonusType.Push(8)
bonusType.Push(2)
bonusType.Push(9)
bonusType.Push(7)
bonusType.Push(24)
bonusType.Push(9)
bonusType.Push(6)
bonusType.Push(4)
bonusType.Push(26)
bonusType.Push(23)
bonusType.Push(8)
bonusType.Push(29)
bonusType.Push(4)
bonusType.Push(9)
bonusType.Push(29)
bonusType.Push(30)
bonusType.Push(28)
bonusType.Push(25)

initialBonus.Push(2)
initialBonus.Push(2)
initialBonus.Push(5)
initialBonus.Push(2)
initialBonus.Push(3)
initialBonus.Push(0.4)
initialBonus.Push(2)
initialBonus.Push(5)
initialBonus.Push(2)
initialBonus.Push(2)
initialBonus.Push(5)
initialBonus.Push(4)
initialBonus.Push(5)
initialBonus.Push(5)
initialBonus.Push(4)
initialBonus.Push(5)
initialBonus.Push(3)
initialBonus.Push(0.5)
initialBonus.Push(3)
initialBonus.Push(4)
initialBonus.Push(0.6)
initialBonus.Push(10)
initialBonus.Push(3)
initialBonus.Push(5)
initialBonus.Push(5)
initialBonus.Push(5)
initialBonus.Push(3)
initialBonus.Push(3)
initialBonus.Push(5)
initialBonus.Push(7)
initialBonus.Push(3)
initialBonus.Push(3)
initialBonus.Push(3)
initialBonus.Push(5)
initialBonus.Push(1)
initialBonus.Push(5)
initialBonus.Push(6)
initialBonus.Push(3)
initialBonus.Push(7)
initialBonus.Push(8)
initialBonus.Push(6)
initialBonus.Push(5)
initialBonus.Push(12)
initialBonus.Push(3)
initialBonus.Push(5)
initialBonus.Push(1)
initialBonus.Push(6)
initialBonus.Push(4)
initialBonus.Push(10)
initialBonus.Push(4)
initialBonus.Push(5)
initialBonus.Push(7)
initialBonus.Push(4)
initialBonus.Push(4)
initialBonus.Push(4)
initialBonus.Push(4)
initialBonus.Push(9)
initialBonus.Push(8)
initialBonus.Push(4)
initialBonus.Push(15)
initialBonus.Push(7)
initialBonus.Push(9)
initialBonus.Push(7)
initialBonus.Push(0.8)
initialBonus.Push(6)
initialBonus.Push(4)
initialBonus.Push(7)
initialBonus.Push(4)
initialBonus.Push(4)
initialBonus.Push(1)
initialBonus.Push(8)
initialBonus.Push(7)
initialBonus.Push(10)
initialBonus.Push(7)
initialBonus.Push(5)
initialBonus.Push(10)
initialBonus.Push(15)
initialBonus.Push(7)
initialBonus.Push(5)
initialBonus.Push(1.4)
initialBonus.Push(5)
initialBonus.Push(9)
initialBonus.Push(5)
initialBonus.Push(8)
initialBonus.Push(5)
initialBonus.Push(8)
initialBonus.Push(10)
initialBonus.Push(9)
initialBonus.Push(7)
initialBonus.Push(12)
initialBonus.Push(5)
initialBonus.Push(5)
initialBonus.Push(5)
initialBonus.Push(20)
initialBonus.Push(10)
initialBonus.Push(8)
initialBonus.Push(1)
initialBonus.Push(8)
initialBonus.Push(12)
initialBonus.Push(12)
initialBonus.Push(7)
initialBonus.Push(12)
initialBonus.Push(10)
initialBonus.Push(15)
initialBonus.Push(2)
initialBonus.Push(15)
initialBonus.Push(15)
initialBonus.Push(2)
initialBonus.Push(10)
initialBonus.Push(15)
initialBonus.Push(25)
initialBonus.Push(20)
initialBonus.Push(20)
initialBonus.Push(20)
initialBonus.Push(60)
initialBonus.Push(3)
initialBonus.Push(25)
initialBonus.Push(0.5)
initialBonus.Push(30)
initialBonus.Push(35)
initialBonus.Push(1)
initialBonus.Push(1)
initialBonus.Push(2)
initialBonus.Push(2)

finalBonus.Push(40)
finalBonus.Push(40)
finalBonus.Push(100)
finalBonus.Push(40)
finalBonus.Push(60)
finalBonus.Push(8)
finalBonus.Push(40)
finalBonus.Push(100)
finalBonus.Push(40)
finalBonus.Push(40)
finalBonus.Push(100)
finalBonus.Push(80)
finalBonus.Push(100)
finalBonus.Push(100)
finalBonus.Push(80)
finalBonus.Push(100)
finalBonus.Push(60)
finalBonus.Push(10)
finalBonus.Push(60)
finalBonus.Push(80)
finalBonus.Push(12)
finalBonus.Push(200)
finalBonus.Push(60)
finalBonus.Push(100)
finalBonus.Push(100)
finalBonus.Push(100)
finalBonus.Push(60)
finalBonus.Push(60)
finalBonus.Push(100)
finalBonus.Push(140)
finalBonus.Push(60)
finalBonus.Push(60)
finalBonus.Push(60)
finalBonus.Push(100)
finalBonus.Push(20)
finalBonus.Push(100)
finalBonus.Push(120)
finalBonus.Push(60)
finalBonus.Push(140)
finalBonus.Push(160)
finalBonus.Push(120)
finalBonus.Push(100)
finalBonus.Push(240)
finalBonus.Push(60)
finalBonus.Push(100)
finalBonus.Push(20)
finalBonus.Push(120)
finalBonus.Push(80)
finalBonus.Push(200)
finalBonus.Push(80)
finalBonus.Push(100)
finalBonus.Push(140)
finalBonus.Push(80)
finalBonus.Push(80)
finalBonus.Push(80)
finalBonus.Push(80)
finalBonus.Push(180)
finalBonus.Push(160)
finalBonus.Push(80)
finalBonus.Push(300)
finalBonus.Push(140)
finalBonus.Push(180)
finalBonus.Push(140)
finalBonus.Push(16)
finalBonus.Push(120)
finalBonus.Push(80)
finalBonus.Push(140)
finalBonus.Push(80)
finalBonus.Push(80)
finalBonus.Push(20)
finalBonus.Push(160)
finalBonus.Push(140)
finalBonus.Push(200)
finalBonus.Push(140)
finalBonus.Push(100)
finalBonus.Push(200)
finalBonus.Push(300)
finalBonus.Push(140)
finalBonus.Push(100)
finalBonus.Push(28)
finalBonus.Push(100)
finalBonus.Push(180)
finalBonus.Push(100)
finalBonus.Push(160)
finalBonus.Push(100)
finalBonus.Push(160)
finalBonus.Push(200)
finalBonus.Push(180)
finalBonus.Push(140)
finalBonus.Push(240)
finalBonus.Push(100)
finalBonus.Push(100)
finalBonus.Push(100)
finalBonus.Push(400)
finalBonus.Push(200)
finalBonus.Push(160)
finalBonus.Push(20)
finalBonus.Push(160)
finalBonus.Push(240)
finalBonus.Push(240)
finalBonus.Push(140)
finalBonus.Push(240)
finalBonus.Push(200)
finalBonus.Push(300)
finalBonus.Push(40)
finalBonus.Push(300)
finalBonus.Push(300)
finalBonus.Push(40)
finalBonus.Push(200)
finalBonus.Push(300)
finalBonus.Push(500)
finalBonus.Push(400)
finalBonus.Push(400)
finalBonus.Push(400)
finalBonus.Push(1200)
finalBonus.Push(60)
finalBonus.Push(500)
finalBonus.Push(10)
finalBonus.Push(600)
finalBonus.Push(700)
finalBonus.Push(20)
finalBonus.Push(20)
finalBonus.Push(40)
finalBonus.Push(40)

Global pos := {}
;Grasslands
pos := {}
pos.X := 1
pos.Y := 1
pos.Page := 1
positions.Push(pos)
pos := {}
pos.X := 2
pos.Y := 1
pos.Page := 1
positions.Push(pos)
pos := {}
pos.X := 3
pos.Y := 1
pos.Page := 1
positions.Push(pos)
pos := {}
pos.X := 4
pos.Y := 1
pos.Page := 1
positions.Push(pos)
pos := {}
pos.X := 5
pos.Y := 1
pos.Page := 1
positions.Push(pos)
pos := {}
pos.X := 6
pos.Y := 1
pos.Page := 1
positions.Push(pos)
pos := {}
pos.X := 7
pos.Y := 1
pos.Page := 1
positions.Push(pos)
pos := {}
pos.X := 8
pos.Y := 1
pos.Page := 1
positions.Push(pos)
pos := {}
pos.X := 9
pos.Y := 1
pos.Page := 1
positions.Push(pos)
pos := {}
pos.X := 10
pos.Y := 1
pos.Page := 1
positions.Push(pos)
pos := {}
pos.X := 11
pos.Y := 1
pos.Page := 1
positions.Push(pos)
pos := {}
pos.X := 12
pos.Y := 1
pos.Page := 1
positions.Push(pos)
pos := {}
pos.X := 13
pos.Y := 1
pos.Page := 1
positions.Push(pos)
pos := {}
pos.X := 14
pos.Y := 1
pos.Page := 1
positions.Push(pos)
pos := {}
pos.X := 15
pos.Y := 1
pos.Page := 1
positions.Push(pos)

pos := {}
pos.X := 1
pos.Y := 2
pos.Page := 1
positions.Push(pos)

;Desert
pos := {}
pos.X := 1
pos.Y := 3
pos.Page := 1
positions.Push(pos)
pos := {}
pos.X := 2
pos.Y := 3
pos.Page := 1
positions.Push(pos)
pos := {}
pos.X := 3
pos.Y := 3
pos.Page := 1
positions.Push(pos)
pos := {}
pos.X := 4
pos.Y := 3
pos.Page := 1
positions.Push(pos)
pos := {}
pos.X := 5
pos.Y := 3
pos.Page := 1
positions.Push(pos)
pos := {}
pos.X := 6
pos.Y := 3
pos.Page := 1
positions.Push(pos)
pos := {}
pos.X := 7
pos.Y := 3
pos.Page := 1
positions.Push(pos)
pos := {}
pos.X := 8
pos.Y := 3
pos.Page := 1
positions.Push(pos)
pos := {}
pos.X := 9
pos.Y := 3
pos.Page := 1
positions.Push(pos)
pos := {}
pos.X := 10
pos.Y := 3
pos.Page := 1
positions.Push(pos)
pos := {}
pos.X := 11
pos.Y := 3
pos.Page := 1
positions.Push(pos)
pos := {}
pos.X := 12
pos.Y := 3
pos.Page := 1
positions.Push(pos)
pos := {}
pos.X := 13
pos.Y := 3
pos.Page := 1
positions.Push(pos)
pos := {}
pos.X := 14
pos.Y := 3
pos.Page := 1
positions.Push(pos)
pos := {}
pos.X := 15
pos.Y := 3
pos.Page := 1
positions.Push(pos)

pos := {}
pos.X := 1
pos.Y := 4
pos.Page := 1
positions.Push(pos)
pos := {}
pos.X := 2
pos.Y := 4
pos.Page := 1
positions.Push(pos)
pos := {}
pos.X := 3
pos.Y := 4
pos.Page := 1
positions.Push(pos)
pos := {}
pos.X := 4
pos.Y := 4
pos.Page := 1
positions.Push(pos)
pos := {}
pos.X := 5
pos.Y := 4
pos.Page := 1
positions.Push(pos)
pos := {}
pos.X := 6
pos.Y := 4
pos.Page := 1
positions.Push(pos)
pos := {}
pos.X := 7
pos.Y := 4
pos.Page := 1
positions.Push(pos)
pos := {}
pos.X := 8
pos.Y := 4
pos.Page := 1
positions.Push(pos)
pos := {}
pos.X := 9
pos.Y := 4
pos.Page := 1
positions.Push(pos)
pos := {}
pos.X := 10
pos.Y := 4
pos.Page := 1
positions.Push(pos)
pos := {}
pos.X := 11
pos.Y := 4
pos.Page := 1
positions.Push(pos)
pos := {}
pos.X := 12
pos.Y := 4
pos.Page := 1
positions.Push(pos)
pos := {}
pos.X := 13
pos.Y := 4
pos.Page := 1
positions.Push(pos)
pos := {}
pos.X := 14
pos.Y := 4
pos.Page := 1
positions.Push(pos)
pos := {}
pos.X := 15
pos.Y := 4
pos.Page := 1
positions.Push(pos)

;Mountains
pos := {}
pos.X := 1
pos.Y := 1
pos.Page := 2
positions.Push(pos)
pos := {}
pos.X := 2
pos.Y := 1
pos.Page := 2
positions.Push(pos)
pos := {}
pos.X := 3
pos.Y := 1
pos.Page := 2
positions.Push(pos)
pos := {}
pos.X := 4
pos.Y := 1
pos.Page := 2
positions.Push(pos)
pos := {}
pos.X := 5
pos.Y := 1
pos.Page := 2
positions.Push(pos)
pos := {}
pos.X := 6
pos.Y := 1
pos.Page := 2
positions.Push(pos)
pos := {}
pos.X := 7
pos.Y := 1
pos.Page := 2
positions.Push(pos)
pos := {}
pos.X := 8
pos.Y := 1
pos.Page := 2
positions.Push(pos)
pos := {}
pos.X := 9
pos.Y := 1
pos.Page := 2
positions.Push(pos)
pos := {}
pos.X := 10
pos.Y := 1
pos.Page := 2
positions.Push(pos)
pos := {}
pos.X := 11
pos.Y := 1
pos.Page := 2
positions.Push(pos)
pos := {}
pos.X := 12
pos.Y := 1
pos.Page := 2
positions.Push(pos)
pos := {}
pos.X := 13
pos.Y := 1
pos.Page := 2
positions.Push(pos)
pos := {}
pos.X := 14
pos.Y := 1
pos.Page := 2
positions.Push(pos)
pos := {}
pos.X := 15
pos.Y := 1
pos.Page := 2
positions.Push(pos)

pos := {}
pos.X := 1
pos.Y := 2
pos.Page := 2
positions.Push(pos)
pos := {}
pos.X := 2
pos.Y := 2
pos.Page := 2
positions.Push(pos)
pos := {}
pos.X := 3
pos.Y := 2
pos.Page := 2
positions.Push(pos)
pos := {}
pos.X := 4
pos.Y := 2
pos.Page := 2
positions.Push(pos)
pos := {}
pos.X := 5
pos.Y := 2
pos.Page := 2
positions.Push(pos)
pos := {}
pos.X := 6
pos.Y := 2
pos.Page := 2
positions.Push(pos)
pos := {}
pos.X := 7
pos.Y := 2
pos.Page := 2
positions.Push(pos)
pos := {}
pos.X := 8
pos.Y := 2
pos.Page := 2
positions.Push(pos)
pos := {}
pos.X := 9
pos.Y := 2
pos.Page := 2
positions.Push(pos)
pos := {}
pos.X := 10
pos.Y := 2
pos.Page := 2
positions.Push(pos)
pos := {}
pos.X := 11
pos.Y := 2
pos.Page := 2
positions.Push(pos)

;The Mist
pos := {}
pos.X := 1
pos.Y := 3
pos.Page := 2
positions.Push(pos)
pos := {}
pos.X := 2
pos.Y := 3
pos.Page := 2
positions.Push(pos)
pos := {}
pos.X := 3
pos.Y := 3
pos.Page := 2
positions.Push(pos)
pos := {}
pos.X := 4
pos.Y := 3
pos.Page := 2
positions.Push(pos)
pos := {}
pos.X := 5
pos.Y := 3
pos.Page := 2
positions.Push(pos)
pos := {}
pos.X := 6
pos.Y := 3
pos.Page := 2
positions.Push(pos)
pos := {}
pos.X := 7
pos.Y := 3
pos.Page := 2
positions.Push(pos)
pos := {}
pos.X := 8
pos.Y := 3
pos.Page := 2
positions.Push(pos)
pos := {}
pos.X := 9
pos.Y := 3
pos.Page := 2
positions.Push(pos)
pos := {}
pos.X := 10
pos.Y := 3
pos.Page := 2
positions.Push(pos)
pos := {}
pos.X := 11
pos.Y := 3
pos.Page := 2
positions.Push(pos)
pos := {}
pos.X := 12
pos.Y := 3
pos.Page := 2
positions.Push(pos)
pos := {}
pos.X := 13
pos.Y := 3
pos.Page := 2
positions.Push(pos)
pos := {}
pos.X := 14
pos.Y := 3
pos.Page := 2
positions.Push(pos)
pos := {}
pos.X := 15
pos.Y := 3
pos.Page := 2
positions.Push(pos)

pos := {}
pos.X := 1
pos.Y := 4
pos.Page := 2
positions.Push(pos)
pos := {}
pos.X := 2
pos.Y := 4
pos.Page := 2
positions.Push(pos)
pos := {}
pos.X := 3
pos.Y := 4 
pos.Page := 2
positions.Push(pos)
pos := {}
pos.X := 4
pos.Y := 4
pos.Page := 2
positions.Push(pos)
pos := {}
pos.X := 5
pos.Y := 4
pos.Page := 2
positions.Push(pos)
pos := {}
pos.X := 6
pos.Y := 4
pos.Page := 2
positions.Push(pos)

;Dungeon
pos := {}
pos.X := 1
pos.Y := 1
pos.Page := 3
positions.Push(pos)
pos := {}
pos.X := 2
pos.Y := 1
pos.Page := 3
positions.Push(pos)
pos := {}
pos.X := 3
pos.Y := 1
pos.Page := 3
positions.Push(pos)
pos := {}
pos.X := 4
pos.Y := 1
pos.Page := 3
positions.Push(pos)
pos := {}
pos.X := 5
pos.Y := 1
pos.Page := 3
positions.Push(pos)
pos := {}
pos.X := 6
pos.Y := 1
pos.Page := 3
positions.Push(pos)
pos := {}
pos.X := 7
pos.Y := 1
pos.Page := 3
positions.Push(pos)
pos := {}
pos.X := 8
pos.Y := 1
pos.Page := 3
positions.Push(pos)
pos := {}
pos.X := 9
pos.Y := 1
pos.Page := 3
positions.Push(pos)
pos := {}
pos.X := 10
pos.Y := 1
pos.Page := 3
positions.Push(pos)
pos := {}
pos.X := 11
pos.Y := 1
pos.Page := 3
positions.Push(pos)
pos := {}
pos.X := 12
pos.Y := 1
pos.Page := 3
positions.Push(pos)
pos := {}
pos.X := 13
pos.Y := 1
pos.Page := 3
positions.Push(pos)
pos := {}
pos.X := 14
pos.Y := 1
pos.Page := 3
positions.Push(pos)
pos := {}
pos.X := 15
pos.Y := 1
pos.Page := 3
positions.Push(pos)

pos := {}
pos.X := 1
pos.Y := 2
pos.Page := 3
positions.Push(pos)

;Raids
pos := {}
pos.X := 1
pos.Y := 3
pos.Page := 3
positions.Push(pos)
pos := {}
pos.X := 2
pos.Y := 3
pos.Page := 3
positions.Push(pos)
pos := {}
pos.X := 3
pos.Y := 3
pos.Page := 3
positions.Push(pos)
pos := {}
pos.X := 4
pos.Y := 3
pos.Page := 3
positions.Push(pos)
pos := {}
pos.X := 5
pos.Y := 3
pos.Page := 3
positions.Push(pos)
pos := {}
pos.X := 6
pos.Y := 3
pos.Page := 3
positions.Push(pos)
pos := {}
pos.X := 7
pos.Y := 3
pos.Page := 3
positions.Push(pos)
pos := {}
pos.X := 8
pos.Y := 3
pos.Page := 3
positions.Push(pos)
pos := {}
pos.X := 9
pos.Y := 3
pos.Page := 3
positions.Push(pos)
pos := {}
pos.X := 10
pos.Y := 3
pos.Page := 3
positions.Push(pos)
pos := {}
pos.X := 11
pos.Y := 3
pos.Page := 3
positions.Push(pos)
pos := {}
pos.X := 12
pos.Y := 3
pos.Page := 3
positions.Push(pos)

;Special & Event
pos := {}
pos.X := 1
pos.Y := 4
pos.Page := 3
positions.Push(pos)
pos := {}
pos.X := 2
pos.Y := 4
pos.Page := 3
positions.Push(pos)
pos := {}
pos.X := 3
pos.Y := 4
pos.Page := 3
positions.Push(pos)


CreateCards()
{
	Loop, % names.Length() {
		if (A_Index <= 16)
			zone := zonelist[1]
		else if (A_Index <= 46)
			zone := zonelist[2]
		else if (A_Index <= 72)
			zone := zonelist[3]
		else if (A_Index <= 93)
			zone := zonelist[4]
		else if (A_Index <= 109)
			zone := zonelist[5]
		else if (A_Index <= 121)
			zone := zonelist[6]
		else if (A_Index <= 122)
			zone := zonelist[7]
		else
			zone := zonelist[8]

		aCard := new Card(names[A_Index], zone, bonuslist[bonusType[A_Index]], initialBonus[A_Index], finalBonus[A_Index], positions[A_Index])
		Cards.Push(aCard)
	}
	SaveCards()
}

SaveCards()
{
	str := JSON.Dump(Cards,,4)
	file := FileOpen("Cards.json", "w")
	file.Write(str)
	file.Close()
}

CreateCards()