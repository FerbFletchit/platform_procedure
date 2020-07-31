function PP_EstablishCraftEntities()
	PP_WB_Recipes = {}
	
	for key, value in ipairs(PP["Items"]) do
		if value["Craftable"] then
			table.insert(PP_WB_Recipes, value)
		end
	end
end

function PP_MatchCubesWithRecipe(Table)
	for key, value in ipairs(PP_WB_Recipes) do
		for key2,value2 in ipairs(value["Recipe"]) do
			if tobool(value2) != tobool(Table[key2]) then
				break
			end

			if key2 == table.Count(value["Recipe"]) then
				return value
			end
		end 
	end 

	return {} -- Could return a default item here or something.
end

function PP_CreateNewRecipes()

	PP_EstablishCraftEntities()

	for key, value in pairs(PP_WB_Recipes) do -- Going through all weapons and entites,

		if not value["Recipe"] then -- If we haven't pre-configured a recipe, 
			
			local BlockAmount = value["Block_Amount"] or math.random(3,11) -- How many blocks required to craft, using a fallback if not configured of 3-11
			
			value["Recipe"] = {}

			for index=1, 11 do
				value["Recipe"][index] = 0
			end

			local interator = 0
			for key2, value2 in RandomPairs(value["Recipe"]) do
				value["Recipe"][key2] = 1

				interator = interator + 1
				if interator == BlockAmount then
					break
				end
			end
			
		end

	end

end

if SERVER then -- make sure this is server PLEASE
	PP_CreateNewRecipes() -- PUT THIS AT NEW GAME HOLY FUCK PLEASE
end