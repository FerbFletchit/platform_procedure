--[[
	---------
	Item Type: Item Type can be anything, however there are set types that perform a certain action in the game.
	
	"Primary": Item's with this type can be placed into the primary weapon slot. It must be a weapon.
	"Secondary": Item's with this type can be placed into the secondary weapon slot. It must be a weapon.
	"Gear": Item's with this type can be placed into the gear weapon slot. It must be a weapon.
	"Special": Item's with this type can be placed into the gear weapon slot. It must be a weapon.

	---------
	Item Class: This is the entity name, make sure this exists!

	---------
	Rarity: This is 0.1 - 1. 
	0.1 acts as a 1% chance of spawning if the item is being considered to spawn by the loot function. 
	The loot spawner works by randomly looping through all possible loot items and then deciding if it should be the item to spawn based on rarity.

	---------
	Sound: I've yet to inegrate this (7/12/20), Likely will be an noise used when crafted.

	---------
	Standard Recipe Formation. (1) indicates that a block is required in that position.
	
	{

		[1] = 1, [2] = 0, [3] = 1,
		[4] = 0, [5] = 0, [6] = 0,	[10] = 1, [11] = 1,
		[7] = 1, [8] = 0, [9] = 1, 

	}
]]

PP["Items"] = {

	[1] = {
		["Name"] = "Ingot",
		
		["Type"] = "Building",
		
		["Description"] = "This ingot can be used to construct stuff!",

		["FOV"] = 65, -- Custom zoom of model in inventory display, this is not needed. More is less.

		["Class"] = "pp_loot_cube",

		["Loot"] = true, -- If this item should appear as randomized loot.
		
		["Rarity"] = 1, -- 0.1 - 1 %

		["Sound"] = "kek.mp3",

		["Craftable"] = false,

		["Recipe"] = nil, -- Leave nil if not craftable, or random recipe desired.

		["Block_Amount"] = 1, -- How many blocks in recipe, only used if Recipe table is left blank.
		
	},

	-- PISTOLS --

	[2] = {
		["Name"] = "Bolt Pistol",
		
		["Type"] = "Secondary",
		
		["Description"] = "Basic bolt pistol.",

		["Class"] = "pp_weapon_boltpistol",

		["Loot"] = true, -- If this item should appear as randomized loot.
		
		["Rarity"] = 0.15, -- 0.1 - 1 %

		["Sound"] = "kek.mp3",

		["Craftable"] = true,

		["Recipe"] = nil, -- Leave nil if not craftable, or random recipe desired.

		["Block_Amount"] = 3, -- How many blocks in recipe, only used if Recipe table is left blank.

	},

	[3] = {
		["Name"] = "Chaos Pistol",
		
		["Type"] = "Secondary",
		
		["Description"] = "Basic chaos pistol.",

		["Class"] = "pp_weapon_chaospistol",

		["Loot"] = true, -- If this item should appear as randomized loot.
		
		["Rarity"] = 0.15, -- 0.1 - 1 %

		["Sound"] = "kek.mp3",

		["Craftable"] = true,

		["Recipe"] = nil, -- Leave nil if not craftable, or random recipe desired.

		["Block_Amount"] = 3, -- How many blocks in recipe, only used if Recipe table is left blank.

		["FOV"] = 55, -- Custom zoom of model in inventory display, this is not needed. More is less.

	},

	[4] = {
		["Name"] = "Laser Pistol",
		
		["Type"] = "Secondary",
		
		["Description"] = "Basic laser pistol.",

		["Class"] = "pp_weapon_laserpistol",

		["Loot"] = true, -- If this item should appear as randomized loot.
		
		["Rarity"] = 0.15, -- 0.1 - 1 %

		["Sound"] = "kek.mp3",

		["Craftable"] = true,

		["Recipe"] = nil, -- Leave nil if not craftable, or random recipe desired.

		["Block_Amount"] = 3, -- How many blocks in recipe, only used if Recipe table is left blank.

		["FOV"] = 55, -- Custom zoom of model in inventory display, this is not needed. More is less.

	},

	[5] = {
		["Name"] = "Plasma Pistol",
		
		["Type"] = "Secondary",
		
		["Description"] = "Basic plasma pistol.",

		["Class"] = "pp_weapon_plasmapistol",

		["Loot"] = true, -- If this item should appear as randomized loot.
		
		["Rarity"] = 0.15, -- 0.1 - 1 %

		["Sound"] = "kek.mp3",

		["Craftable"] = true,

		["Recipe"] = nil, -- Leave nil if not craftable, or random recipe desired.

		["Block_Amount"] = 3, -- How many blocks in recipe, only used if Recipe table is left blank.

		["FOV"] = 55, -- Custom zoom of model in inventory display, this is not needed. More is less.

	},

	-- SMGS --

	[6] = {
		["Name"] = "Bolt SMG",
		
		["Type"] = "Primary",
		
		["Description"] = "Automatic bolt smg.",

		["Class"] = "pp_weapon_boltsmg",

		["Loot"] = false, -- If this item should appear as randomized loot.
		
		["Rarity"] = 0, -- 0.1 - 1 %

		["Sound"] = "kek.mp3",

		["Craftable"] = true,

		["Recipe"] = nil, -- Leave nil if not craftable, or random recipe desired.

		["Block_Amount"] = 5, -- How many blocks in recipe, only used if Recipe table is left blank.

	},

	-- SHOTGUNS --

	[7] = {
		["Name"] = "Plasma Pulser",
		
		["Type"] = "Primary",
		
		["Description"] = "Pulses a plasma burst.",

		["Class"] = "pp_weapon_pulser",

		["Loot"] = false, -- If this item should appear as randomized loot.
		
		["Rarity"] = 0, -- 0.1 - 1 %

		["Sound"] = "kek.mp3",

		["Craftable"] = true,

		["Recipe"] = nil, -- Leave nil if not craftable, or random recipe desired.

		["Block_Amount"] = 5, -- How many blocks in recipe, only used if Recipe table is left blank.

		["FOV"] = 65, -- Custom zoom of model in inventory display, this is not needed. More is less.

	},

	[8] = {
		["Name"] = "Shotgun",
		
		["Type"] = "Primary",
		
		["Description"] = "Pump shotgun, shoots a wide burst.",

		["Class"] = "pp_weapon_shotgun",

		["Loot"] = false, -- If this item should appear as randomized loot.
		
		["Rarity"] = 0, -- 0.1 - 1 %

		["Sound"] = "kek.mp3",

		["Craftable"] = true,

		["Recipe"] = nil, -- Leave nil if not craftable, or random recipe desired.

		["Block_Amount"] = 5, -- How many blocks in recipe, only used if Recipe table is left blank.

	},

	-- Rifles --

	[9] = {
		["Name"] = "Bolt Rifle",
		
		["Type"] = "Primary",
		
		["Description"] = "Shoots a bolt.",

		["Class"] = "pp_weapon_boltrifle",

		["Loot"] = false, -- If this item should appear as randomized loot.
		
		["Rarity"] = 0, -- 0.1 - 1 %

		["Sound"] = "kek.mp3",

		["Craftable"] = true,

		["Recipe"] = nil, -- Leave nil if not craftable, or random recipe desired.

		["Block_Amount"] = 7, -- How many blocks in recipe, only used if Recipe table is left blank.

	},

	[10] = {
		["Name"] = "Chaos Bolt Rifle",
		
		["Type"] = "Primary",
		
		["Description"] = "Shoots a chaos bolt.",

		["Class"] = "pp_weapon_chaosbolter",

		["Loot"] = false, -- If this item should appear as randomized loot.
		
		["Rarity"] = 0, -- 0.1 - 1 %

		["Sound"] = "kek.mp3",

		["Craftable"] = true,

		["Recipe"] = nil, -- Leave nil if not craftable, or random recipe desired.

		["Block_Amount"] = 7, -- How many blocks in recipe, only used if Recipe table is left blank.

	},

	[11] = {
		["Name"] = "Laser Rifle",
		
		["Type"] = "Primary",
		
		["Description"] = "Shoots a long ranged laser.",

		["Class"] = "pp_weapon_laserrifle",

		["Loot"] = false, -- If this item should appear as randomized loot.
		
		["Rarity"] = 0, -- 0.1 - 1 %

		["Sound"] = "kek.mp3",

		["Craftable"] = true,

		["Recipe"] = nil, -- Leave nil if not craftable, or random recipe desired.

		["Block_Amount"] = 7, -- How many blocks in recipe, only used if Recipe table is left blank.

	},

	[12] = {
		["Name"] = "Plasma Rifle",
		
		["Type"] = "Primary",
		
		["Description"] = "Shoots a long ranged plasma.",

		["Class"] = "pp_weapon_plasmarifle",

		["Loot"] = false, -- If this item should appear as randomized loot.
		
		["Rarity"] = 0, -- 0.1 - 1 %

		["Sound"] = "kek.mp3",

		["Craftable"] = true,

		["Recipe"] = nil, -- Leave nil if not craftable, or random recipe desired.

		["Block_Amount"] = 7, -- How many blocks in recipe, only used if Recipe table is left blank.

	},

	-- Heavy Guns --
	
	[13] = {
		["Name"] = "Heavy Gun",
		
		["Type"] = "Primary",
		
		["Description"] = "As heavy as it gets.",

		["Class"] = "pp_weapon_heavy",

		["Loot"] = false, -- If this item should appear as randomized loot.
		
		["Rarity"] = 0, -- 0.1 - 1 %

		["Sound"] = "kek.mp3",

		["Craftable"] = true,

		["Recipe"] = nil, -- Leave nil if not craftable, or random recipe desired.

		["Block_Amount"] = 9, -- How many blocks in recipe, only used if Recipe table is left blank.

	},

	-- Snipers --

	[14] = {
		["Name"] = "Sniper",
		
		["Type"] = "Primary",
		
		["Description"] = "How can you see all the way over there?",

		["Class"] = "pp_weapon_sniper",

		["Loot"] = false, -- If this item should appear as randomized loot.
		
		["Rarity"] = 0, -- 0.1 - 1 %

		["Sound"] = "kek.mp3",

		["Craftable"] = true,

		["Recipe"] = nil, -- Leave nil if not craftable, or random recipe desired.

		["Block_Amount"] = 8, -- How many blocks in recipe, only used if Recipe table is left blank.

	},

	-- Misc. --

	[15] = {
		["Name"] = "Recipe",
		
		["Type"] = "Misc.",
		
		["Description"] = "",

		["Class"] = "pp_recipe",

		["Loot"] = true, -- If this item should appear as randomized loot.
		
		["Rarity"] = 0.55, -- 0.1 - 1 %

		["Sound"] = "kek.mp3",

		["Craftable"] = false,

		["Recipe"] = nil, -- Leave nil if not craftable, or random recipe desired.

		["Block_Amount"] = 0, -- How many blocks in recipe, only used if Recipe table is left blank.

	},

	[16] = {
		["Name"] = "Recipe Book",
		
		["Type"] = "Misc.",
		
		["Description"] = "",

		["Class"] = "pp_recipe_book",

		["Loot"] = false, -- If this item should appear as randomized loot.
		
		["Rarity"] = 0, -- 0.1 - 1 %

		["Sound"] = "kek.mp3",

		["Craftable"] = false,

		["Recipe"] = nil, -- Leave nil if not craftable, or random recipe desired.

		["Block_Amount"] = 0, -- How many blocks in recipe, only used if Recipe table is left blank.

	},

	-- SPECIALS --

	[17] = {
		["Name"] = "Plane",
		
		["Type"] = "Special",
		
		["Description"] = "Throw and watch it boom after 2 seconds.",

		["Class"] = "pp_special_plane",

		["Loot"] = false, -- If this item should appear as randomized loot.
		
		["Rarity"] = 0, -- 0.1 - 1 %

		["Sound"] = "kek.mp3",

		["Craftable"] = true,

		["Recipe"] = nil, -- Leave nil if not craftable, or random recipe desired.

		["Block_Amount"] = 3, -- How many blocks in recipe, only used if Recipe table is left blank.

	},

	-- GEAR --

	[18] = {
		["Name"] = "Medkit",
		
		["Type"] = "Gear",

		["FOV"] = 53,
		
		["Description"] = "Use to heal yourself.",

		["Class"] = "pp_gear_medkit",

		["Loot"] = false, -- If this item should appear as randomized loot.
		
		["Rarity"] = 0, -- 0.1 - 1 %

		["Sound"] = "kek.mp3",

		["Craftable"] = true,

		["Recipe"] = {

			[1] = 0, [2] = 0, [3] = 0,
			[4] = 0, [5] = 1, [6] = 1,	[10] = 0, [11] = 0,
			[7] = 0, [8] = 1, [9] = 1, 

		}, -- Leave nil if not craftable, or random recipe desired.

		["Block_Amount"] = 4, -- How many blocks in recipe, only used if Recipe table is left blank.

	},

	[19] = {
		["Name"] = "Heal Gulp",
		
		["Type"] = "Gear",

		["FOV"] = 53,
		
		["Description"] = "Drink this to heal up!",

		["Class"] = "pp_gear_healgulp",

		["Loot"] = true, -- If this item should appear as randomized loot.
		
		["Rarity"] = 0.2, -- 0.1 - 1 %

		["Sound"] = "kek.mp3",

		["Craftable"] = false,

		["Recipe"] = nil, -- Leave nil if not craftable, or random recipe desired.

		["Block_Amount"] = 0, -- How many blocks in recipe, only used if Recipe table is left blank.

	},

	[20] = {
		["Name"] = "Heal Station",
		
		["Type"] = "Misc.",

		["Description"] = "Heals nearby players",

		["Class"] = "pp_healstation",

		["Loot"] = false, -- If this item should appear as randomized loot.
		
		["Rarity"] = 0, -- 0.1 - 1 %

		["Sound"] = "kek.mp3",

		["Craftable"] = false,

		["Recipe"] = nil, -- Leave nil if not craftable, or random recipe desired.

		["Block_Amount"] = 0, -- How many blocks in recipe, only used if Recipe table is left blank.

	},

	[21] = {
		["Name"] = "Spring Mechanism",
		
		["Type"] = "Misc.",

		["Description"] = "Boing",

		["Class"] = "pp_trampoline",

		["Loot"] = false, -- If this item should appear as randomized loot.
		
		["Rarity"] = 0, -- 0.1 - 1 %

		["Sound"] = "kek.mp3",

		["Craftable"] = false,

		["Recipe"] = nil, -- Leave nil if not craftable, or random recipe desired.

		["Block_Amount"] = 0, -- How many blocks in recipe, only used if Recipe table is left blank.

	},

	[22] = {
		["Name"] = "Grappling Gun", -- This is the weapon version that goes into inventory.
		
		["Type"] = "Special",

		["Description"] = "Shoot and grapple.",

		["Class"] = "pp_weapon_grapplehook",

		["Loot"] = true, -- If this item should appear as randomized loot.
		
		["Rarity"] = 0.10, -- 0.1 - 1 %

		["Sound"] = "kek.mp3",

		["Craftable"] = true,

		["Recipe"] = nil, -- Leave nil if not craftable, or random recipe desired.

		["Block_Amount"] = 6, -- How many blocks in recipe, only used if Recipe table is left blank.

	},

	[23] = {
		["Name"] = "Deployable Platform", -- This is the weapon version that goes into inventory.
		
		["Type"] = "Special",

		["Description"] = "Click and deploy.",

		["Class"] = "pp_special_deployable",

		["Loot"] = true, -- If this item should appear as randomized loot.
		
		["Rarity"] = 0.1, -- 0.1 - 1 %

		["Sound"] = "kek.mp3",

		["Craftable"] = true,

		["Recipe"] = nil, -- Leave nil if not craftable, or random recipe desired.

		["Block_Amount"] = 4, -- How many blocks in recipe, only used if Recipe table is left blank.

	},

	[24] = {
		["Name"] = "Lever Mechanism", -- This is the weapon version that goes into inventory.
		
		["Type"] = "Mechanical",

		["Description"] = "Pull it.",

		["Class"] = "pp_lever",

		["Loot"] = false, -- If this item should appear as randomized loot.
		
		["Rarity"] = 0, -- 0.1 - 1 %

		["Sound"] = "kek.mp3",

		["Craftable"] = false,

		["Recipe"] = nil, -- Leave nil if not craftable, or random recipe desired.

		["Block_Amount"] = 0, -- How many blocks in recipe, only used if Recipe table is left blank.

	},

	[25] = {
		["Name"] = "Hint", -- This is the weapon version that goes into inventory.
		
		["Type"] = "Misc.",

		["Description"] = "Gives hints",

		["Class"] = "pp_hintcube",

		["Loot"] = false, -- If this item should appear as randomized loot.
		
		["Rarity"] = 0, -- 0.1 - 1 %

		["Sound"] = "kek.mp3",

		["Craftable"] = false,

		["Recipe"] = nil, -- Leave nil if not craftable, or random recipe desired.

		["Block_Amount"] = 0, -- How many blocks in recipe, only used if Recipe table is left blank.

	},

}