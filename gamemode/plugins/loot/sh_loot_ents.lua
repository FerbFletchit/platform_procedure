PP["Loot_Ents"] = {

	[1] = {
		
		["Class"] = "pp_chest",

		["Rarity"] = 1,

		["Y_Offset"] = 10 -- In units. 

	},

	[2] = {
		["Class"] = "pp_trampoline",

		["Rarity"] = 0.3,

		["Y_Offset"] = 10 -- In units.

	},

}


-- Why i do this?
function PP_GetLootByEnt( class )

	for key, value in ipairs(PP["Loot_Ents"]) do

		if value["Class"] == class then 

			return value

		end	

	end

end
