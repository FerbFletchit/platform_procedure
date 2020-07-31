PP["ENEMY_NPC"] = {

	-------------------------------
	-- Baby Voltigore Variations --
	-------------------------------

	["pp_enemy_babyvoltigore"] = {

		["Names"] = {"Claw", "Clawful", "Clawble"},
		["Health"] = 10,
		["Damage"] = 5,
		["Sizes"] = {1, 1.5, 2},
		["Head_Y"] = 25,

		["Death_Loot_Amount"] = 3, -- inf.
		["Loot_From_Shot_Chance"] = 1, -- 0.1/10

		["Level_Range"] = {1,10}, -- Minimum and maximum level
	},


	["pp_enemy_stukabat"] = {

		["Names"] = {"Alicanto"},
		["Health"] = 1,
		["Damage"] = 10,
		["Blast_Damage"] = 30,
		["Sizes"] = {1},
		["Head_Y"] = 0,

		["Death_Loot_Amount"] = 3, -- inf.
		["Loot_From_Shot_Chance"] = 1, -- 0.1/10

		["Level_Range"] = {1,10}, -- Minimum and maximum level

		["Custom_Spawn"] = function( enemy )
			if IsValid(enemy) then
				enemy:SetPos(enemy:GetPos()+enemy:GetUp()*200)
			end
		end
	},

	["pp_enemy_bullsquid"] = {

		["Names"] = {"Bonnacon"},
		["Health"] = 50,
		["Damage"] = 10,
		["Sizes"] = {1,1.5},
		["Spit_Damage"] = 1, -- X6
		["Head_Y"] = 10,

		["Death_Loot_Amount"] = 3, -- inf.
		["Loot_From_Shot_Chance"] = 1, -- 0.1/10

		["Level_Range"] = {1,10} -- Minimum and maximum level
	},

}

PP["BOSS_NPC"] = {

	["pp_boss_worm"] = {

		["Name"] = "Worm God",

		["Color"] = Color(113, 0, 12),

		["Min_Health"] = 700,

		["Health_PerPlayer"] = 100,

		["Max_Health"]  = 1000,

		["Damage"] = 35, -- Melee.

		["Beam Damage"] = 2, -- Beam.

		["Death_Loot_Amount"] = 25, -- inf.

		["Loot_From_Shot_Chance"] = 6, -- 0.1/10

	},
}