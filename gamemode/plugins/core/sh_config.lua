if PP then return end
PP = {}

PP["Version"] = "1.1.0"

PP["StateManager"] = {
	["States"] = {}	
}

PP["DamageBlacklist"] = {
	"pp_platform",
	"prop_dynamic",
	"prop_physics",
	"pp_lever",
	"pp_loot_parachute",
	"pp_recipe",
	"pp_loot_cube",
	"pp_structure_block",
	"pp_workbench",
	"pp_ent_component"
}

PP["End_Floor_ACT_Chance"] = 0.4
PP["End_Floor_ACT"] = {
	"cheer",
	"agree",
	"bow",
	"act group"
}

PP["End_Scene_Chutes"] = 8

PP["Player_Textures_Amount"] = 10
PP["Platform_Material"] = "rubber" -- Changes clientside collision sounds.

PP["Max_Enemies"] = 10
PP["Enemy_Lifespan"] = 90 -- How long until they self-remove.

PP["Disable_Enemies_FirstFloor"] = true -- This disables all enemy spawning for the first floor.
PP["EndGame_Duration"] = 25 -- End game sequence.

PP["Stars"] = {
	["Size"] = function() return math.random( 1, 10 ) end,
	["Amount"] = 700,
	["Radius"] = 3000, -- vector units
}

PP["Floors"] = {

	["First_Floor_Platforms"] = 20,

	["Beginning_State_Duration"] = 10, -- How long should players be on the beginning platform?

	["Per_Game"] = 5, -- How many floors there should be per game.

	["Platforms_Per_Player"] = 2, -- How many platforms should be added to a floor sequence per player.

	["Minimum_Platforms"] = 10, -- Minimum number of platforms per floor.

	["Max_Platforms"] = 20, -- Maximum number of platforms per floor.

}


PP["Server_Commands"] = {
	["sv_gravity"] = 300,
	["sv_accelerate"] = 10,
	["sv_airaccelerate"] = 1000,
	["sv_friction"] = 15,

	["sv_tickrate"] = 60,
	["sv_minrate"] = 5000,
	["sv_maxrate"] = 20000,
	["sv_maxupdaterate"] = 66,
	["sv_minupdaterate"] = 13,

	["decalfrequency"] = 1, -- Not sure what unit this is in.
	
	["sv_autojump"] = 0,
	["sv_show_crosshair_target"] = 0,

	["sv_crazyphysics_defuse"] = 0,
	["sv_crazyphysics_remove"] = 0,
	["sv_crazyphysics_warning"] = 0,
	["sv_sticktoground"] = 0,
}

PP["Start_Dialouge"] = { -- What the player says at the beginning of a new game
	"That's a looong way down.",
	"Better look out for flying platforms.",
	"It's dangerous up here..",
	"Where are we?",
	"The floor here doesn't seem very stable.",
	"Something tells me we should get moving!",
	"Mind the gap!",
	"What is this place?",
	"Protecting the sky from monsters!",
}

PP["Chest_Decay_AfterUse"] = true
PP["Chest_Start_Decay"] = 5 -- seconds to begin decaying after opened
PP["Chest_Decay"] = 5 -- seconds after use.

PP["Ritual_HP_Cost"] = 50 -- This keeps adding up.

PP["Spawn_MinVolume"] = 15000

PP["Dialouge_Overhead_Length"] = 5
PP["Parachute_RemoveTime"] = 30

PP["Max_Health"] = 250 -- How much health players start with.
PP["Health_Potion_HP"] = 60 -- This gets increased by quality.
PP["Medkit_Base_Heal"] = 120 -- This gets increased by quality.

-- ENEMIES --
PP["Boss_Stage_MaxTime"] = 4 * (60) -- Max time a boss battle can go for.

PP["Enemy_MinArea"] = 4 -- The platform most have a surface area of this for npc to spawn.
PP["Enemy_MaxPerPlatform"] = 1

-- KEY CONFIGURATION --

PP["Inventory_Key"] = KEY_Q

PP["Fist_Key"] = KEY_F

PP["Weapon_Slots"] = {
	[1] = {"Primary", KEY_1},
	[2] = {"Secondary", KEY_2},
	[3] = {"Gear", KEY_3},
	[4] = {"Special", KEY_4}
}

-- INTERGRAL MAP CONFIG --

PP["Start_Point"] = Vector( 661, 4323, 599 ) -- The position of the spawn platform. 
PP["End_Point"] = Vector(-2830, -919, 9477) -- The position of the safe zone. (NOW DEFUNCT)

PP["Map_Bounds"] = { -- The bounds of the map,which a route will generate within.
	[1] = Vector(15360, -15360, -1920), -- Minimum bounds
	[2] = Vector(15360,15360,15360), -- Maxium
}

PP["Win_Zone"] = {
	Vector(-2307, -1956, 3167),
	Angle(0, -90, 0),
	["First_Place"] = function() return
		PP["Win_Zone"][1] + PP["Win_Zone"][2]:Forward() * 300
	end,

	["Second_Place"] = function() return
		PP["Win_Zone"][1] - PP["Win_Zone"][2]:Right() * 200 - (PP["Win_Zone"][2]:Up() * 50)
	end,

	["Third_Place"] = function() return
		PP["Win_Zone"][1] + PP["Win_Zone"][2]:Right() * 200 - (PP["Win_Zone"][2]:Up() * 50)
	end,
}

-- COLORS --

PP["Color_Pallete"] = {
	
	["Main"] = Color(255,255,255,255),
	
	["Secondary"] = Color(255,255,255,255),
	
	["Dark_Lightish"] = Color(0,0,0,100),
	
	["Dark_Light"] = Color(0,0,0,65),
	
	["Dark"] = Color(0,0,0,130),
	
	["White"] = Color(255,255,255,255),

	["Floor_Indicator"] = Color(0,0,0,200),

	["Tower_Health"] = Color(102, 0, 204, 200),
	
	["Craft_Recipe_Block"] = Color(112, 0, 214, 210),
	
	["Bomb_Bar"] = Color(204, 51, 0, 200),

	["ViewModelArms"] = Color(255, 203, 164),

	["End_Floor"] = Color(100, 100, 100, 255),
	
	["Inv_Selected"] = Color(212,175,55, 130),

	["Grass"] = Color(31, 86, 13),
	
	["Dirt"] = Color(155,118,83),

	["NPC_Low_Health"] = Color(255,0,0,130),
	
	["NPC_BOSS_Health"] = Color(138,3,3,200),

	["Recipe"] = Color(0,0,255),

	["Recipe_Book"] = Color(127,120,230),

	["Inventory_Highlight"] = Color(212,175,55, 130),

	["Inventory_Selected"] = Color(255, 223, 127, 130),

	["Chest_Inside"] = Color(28,16,2,255),
	
	["WorkBench_Darkish"] = Color(0,0,0,70),
	
	["WorkBench_Dark"] = Color(0,0,0,130),
	
	["Overhead_Box"] = Color(0,0,0,130),
	
	["Overhead_Text"] = Color(255, 255, 255, 255),

	["Dialouge_Box"] = Color(0, 0, 0, 130),
	
	["Dialouge_Text"] = Color(255, 255, 255, 255),

	["Neutral"] = Color(255,255,255,255),
	
	["Danger"] = Color(255,0,0,255),
	
	["Negative"] = Color(255,255,255,255),
	
	["Positive"] = Color(255,255,255,255),
	
	["Health"] = Color( 138,3,3,200 ),

	["First Place"] = Color( 255, 223, 127 ),
	
	["Second Place"] = Color( 128, 128, 128 ),
	
	["Third Place"] = Color( 160, 82, 45 ),

	["Bronze"] = Color(205, 127, 50),
	
	["Iron"] = Color( 60, 60, 60 ),
	
	["Gold"] = Color(212,175,55),
	
	["Diamond"] = Color(17, 141, 163 ),

}

PP["Block_Themes"] = {

	["Stone"] = {
		Color(66, 75, 84), -- Top Layer
		Color(45, 52, 57)
	},

	["Stone1"] = {
		Color(75, 75, 75), -- Top Layer
		Color(50, 50, 50)
	},

	["Brown"] = {
		Color(80, 61, 6), -- Top Layer
		Color(50, 38, 4)
	},

	["Idk"] = {
		Color(137, 142, 123), -- Top Layer
		Color(74, 77, 66)
	},

}

-- MATERIALS --
PP["ViewModelTexture"] = "models/debug/debugwhite"-- A default material for blocks in case something fails.
PP["Default_Material"] = "models/shiny"-- A default material for blocks in case something fails.
PP["Ingot_Material"] = "models/shiny" -- typically both the same here.
PP["Weapon_Material"] = "models/shiny"
PP["NPC_Material"] = "models/debug/debugwhite"

-- RECIPES --
PP["Recipe_Model"] = "models/aceofspades/objectives/biggerblueintel.mdl"
PP["Recipe_Book_Model"] = "models/props_lab/bindergreenlabel.mdl"

-- INVENTORY --
PP["Max_Inventory"] = 25
PP["Full_Inventory_Lines"] = {"I can't hold anymore!", "My inventory is full!", "I have no more space left!"}
PP["Default_Inv_FOV"] = 25
PP["Inventory_Row_x"] = 5

-- PLATFORM CONFIGURATION --
PP["Decay_Delay"] = 30 -- Delay before a platform begins to decay by trigger of a next platform, higher number is easier for players. 
PP["End_Platform_Time_Min"] = 30
PP["End_Platform_Time_Max"] = 120
PP["End_Platform_SecsPerPly"] = 16

PP["End_Platform_Waiting"] = 30 -- How long it will wait till transporting players ( both end floor and end game platforms.)

PP["End_Platform_Decay"] = 20 -- How long for the end platform to decay.

PP["Land_Piece_Next"] = 5 -- How long until they spawn the next one (This doesn't activate when they're made as surrounding chunks)

PP["Time_Per_Special"] = 30 -- Time per special platforms (That aren't event controlled)

-- For random land piece chunk generation around things.
PP["Land_Piece_Amount"] = function() return math.random(2,4) end
PP["Land_Piece_Arrival"] = function() return math.random(2,10) end -- In seconds
PP["Land_Piece_Decay"] = 5
PP["Land_Piece_Radius"] = 400 -- Vector units.
PP["Land_Piece_Y"] = 200 -- How much height it can elevate/lower from current position.

PP["Default_Time"] = 25 -- Time to decay.

PP["Beacon_Round_Length"] = 35
PP["Beacon_Chute_Amount"] = 1 -- Amount to spawn each time
PP["Beacon_Chute_Rate"] = 3 -- Seconds interval.


PP["Tower_HP"] = 400
PP["Tower_Win_Loot"] = 15
PP["Tower_Round_Length"] = 60
PP["Tower_Enemy_Amount"] = 1 -- Amount to spawn each time
PP["Tower_Enemy_Rate"] = 15 -- Seconds interval.

PP["Bomb_Round_Length"] = 60
PP["Bomb_TimeToDefuse"] = PP["Bomb_Round_Length"] / 4
PP["Bomb_Enemy_Rate"] = 10

PP["Bomb_Defuse_Distance"] = 75 -- Vector units

PP["Platform_Callback_Distance"] = 1000 -- The vector distance from a platform's destination before activating, a larger number is safer.
PP["TransportPercentage"] = 0.85 -- What majority of players should be on the transport to begin moving? 0-1% ( this is used for end platform too)
PP["Decay_Effect"] = 4 -- What effect the platform takes on when decaying. https://wiki.facepunch.com/gmod/Enums/kRenderFx

PP["Transport_Time_Minimum"] = 30 -- The minimum amount of time a transport can take. ( Current deprecated )
PP["Transport_Time_Maximum"] = 60 -- The maximum amount of time a transport can take. ( Current deprecated )

-- ENEMIES --
PP["Max_NPC_Level"] = 100
PP["NPC_Default_Damage"] = 2 -- Fallback if damage not found.

-- WEAPONS --
PP["Weapon_Decibel"] = 55
PP["Weapon_Recoil"] = 0.2

PP["Pistol_Base_Damage"] = 40
PP["Pistol_Base_Firerate"] = 0.2

PP["Rifle_Base_Damage"] = 60
PP["Rifle_Base_Firerate"] = 0.5

PP["SMG_Base_Damage"] = 15
PP["SMG_Base_Firerate"] = 0.05

PP["Heavy_Base_Damage"] = 6
PP["Heavy_Base_Firerate"] = 0.07

PP["Sniper_Base_Damage"] = 150
PP["Sniper_Base_Firerate"] = 2

PP["Shotgun_Base_Damage"] = 70
PP["Shotgun_Base_Firerate"] = 1

-- PLAYER CONFIGURATION --

PP["ExtraJumps"] = 1 -- How many extra jumps.
PP["Respawn_Time"] = 5 -- Now defunct.
PP["WalkSpeed"] = 400
PP["RunSpeed"] = 500
PP["JumpPower"] = 200
PP["Player_Mass"] = 100
PP["FallDamage_Threshold"] = 800 -- The falling speed must be over this to take damage.

PP["Danger_Lines"] = {
	"WHAT IS THAT GUYS?",
	"WTFF??",
	"OH SH*T",
	"OOOOOPPP",
	"LET'S FKN RUN OH GOD",
	"OH F*CK", 
	"WHAT THE F*CK", 
	"UHH OHHHH", 
	"?????",
	"THE BOSS!!",
}

PP["Enemy_Spawn_Delay"] = 1 -- So they don't spawn in big chunks causing the server to die.
PP["Enemy_Spawn_Chance"] = 0.65 -- 0.1-1
PP["Bat_Spawner_Frequency"] = 15 -- X / NumAlivePlayers

-- LOOTING --
PP["Parachute_Loot"] = true -- Enabling parachute loot
PP["Parachute_Loot_Chance"] = 25 -- 1 / Configured. This chances every platform spawn. 
PP["Loot_Spawn_Chance"] = 0.9 -- 1 = 100% 0.5 = 50%
PP["Loot_MinArea"] = 4 -- The platform most have a surface area of this for loot to spawn.

PP["Loot_MaxPerPlatform"] = 1 -- This is per structure block too.
PP["Loot_Cube_RemoveTime"] = 15 -- How long until a cube removes itself after spawning.
PP["Sound_Loot_Block_Pickup"] = "pp_sound_effects/Inventory_Pickup.mp3"
PP["Chest_Loot_Amount"] = function() 
	return math.random(4,7) 
end

-- CRAFTING CONFIGURATION --

PP["Crafting"] = {

}

PP["Boss_Soundtrack"] = {
	"sound/pp_soundtrack/Beige.mp3",
	"sound/pp_soundtrack/Red.mp3"
}

-- SOUND DESIGN --

PP["Soundtrack"] = {

	"sound/pp_soundtrack/Aqua.mp3",

	"sound/pp_soundtrack/Black.mp3",

	"sound/pp_soundtrack/Blue.mp3",

	"sound/pp_soundtrack/Copper.mp3",

	"sound/pp_soundtrack/Fuligin.mp3",

	"sound/pp_soundtrack/Garrow.mp3",

	"sound/pp_soundtrack/Lavender.mp3",

	"sound/pp_soundtrack/Octarine.mp3",

	"sound/pp_soundtrack/Orange.mp3",

	"sound/pp_soundtrack/Pink.mp3",

	"sound/pp_soundtrack/Silver.mp3",

	"sound/pp_soundtrack/Starry.mp3",

	"sound/pp_soundtrack/Taupe.mp3",

	"sound/pp_soundtrack/Teal.mp3",

	"sound/pp_soundtrack/White.mp3",
	
}


PP["HintChance"] = 0.10
PP["Hints"] = {

	"Hold [E] as chests open to catch more loot!",

	"Press [F] to equip fists!",

	"Holding shift allows you to vault platforms!",

	"Recipe patterns are randomly generated each round, pick them up from chests or loot chutes and check them out at the workbench!",

	"Platforms will blink when they are about to disappear, make sure to keep moving and look out for special platforms!",

	"Alicanto are hostile toward Bonnacon, use this to your advantage!",

	"Not all random events provide positive effects.",

	"Completing challenges on platforms often awards you tons of loot.",

	"Keep an eye out for bombs!",

	"Look up! Valuable loot can parachute down from the sky at any given time.",

	"Don't hesitate to share your loot! You're a team after all.",

	"The boss's health is relative to how many players are alive.",

	"The max level of NPCs is "..PP["Max_NPC_Level"]..".",

	"Players weigh "..PP["Player_Mass"].."Kgs.",

	"Parachutes have a better chance of dropping rare loot!",

	"Make sure to craft before time runs out between floors!",

	"Parachute bombs can be defused by pressing [E]",

	"Bombs take a quarter of their explosive time to defuse.",

	"You only take fall damage at a very tall height threshold.",

	"Decaying platforms will tick right before they vanish!",

	"Land Pieces are generic platforms that help players navigate the floor.",

	"The ritual platform can summon a player back from the dead at a cost.",

	"Chests launch their loot, make sure to catch as much as you can!",

	"When a tower is saved, it will shoot ingots from its highest point.",

}

PP["Workbench_Hints"] = {

	"Press [E] on the 'Recipe Book' to view the recipes you've picked up this game.",

	"Press [E] on a grey ingot plate, and drag a block from your inventory onto it to place it.",

	"The higher quality materials you use, the higher quality item you'll craft.",

	"Be sure to follow recipes, which can be picked up, or else you likely aren't going to build what you want!",

	"The two columns on the right are reserved for long ingots, which only certain recipes use.",

	"Pressing the workbench button with a missing recipe won't craft anything."

}

PP["Fun_Hints"] = {

	"The developer quickly realized that source was not compatible with the idea of movement on floating platforms, but proceeded anyways.",

	"The font used in the gamemode is a fan remake of runescape's classic font!",

	"The enemies were going to be made out of individual blocks, but this proved too difficult in source engine.",
		
	"The Bonnacon was Originally named 'Poop Launcher'",
		
	"Alicanto (The birds enemies), are named after a mythological bird which feeds on gold. That's why they're so eager to kill you!",
		
	"The weapons for the Platform Procedure were originally going to be rounded.",
		
	"The game mode is called 'Platform Procedure' because it's an excuse to name everything 'PP' in code.",

	"All of the particles were made in AE Sprite",

	"The developer cried when proper block guns and models were found.",

	"Source engine is NOT designed for player movement on moving objects!",

	"Each platform trail size is relative to its mass!",

	"All game objects are made from Garry's Mod cubes with a custom tool made for this game!",

	"The dialouge sounds were made using a Korg Volca Keys synthesizer.",

	"The developer refused to rename heal gulps 'slurpers'.",

	"The developer coded nearly 9 hours a day for no f*cking reason.",

	"Double jump was a game addition due to player's finding the game far too difficult.",

	"The boss's health is relative to how many players are alive.",

	"Jelly Blob.",

	"The first beta tester was JoJo, he harassed the dev relentlessly.",
}