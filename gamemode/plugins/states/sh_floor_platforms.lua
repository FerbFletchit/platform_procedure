function PP_RandomPlatformType(amount, exclusions_table)

	exclusions_table = exclusions_table or {}

	local Type_Selections = Platform_Manager["Types"]
	
	local Last_Type = ""

	local PP_PlatformReturn = {}
	
	for i=1, amount do
	
		local Selected = nil
		local Platform_Rarity_Selector = math.Rand(0.1, 1) -- Selecting a random chance number.

		for key, value in RandomPairs(Type_Selections) do -- Randomly selecting our next platform type with rarity.
			if Platform_Rarity_Selector <= value["Rarity"] and not table.HasValue( exclusions_table, key ) and key != Last_Type then
				Selected = true
				Last_Type = key

				table.insert(PP_PlatformReturn, i, key)
				break

			end

		end

		if not Selected then
			table.insert(PP_PlatformReturn, i, "Land_Piece") -- This shouldn't normally happen, but as a fail-safe.
		end

	end

	return PP_PlatformReturn

end

function PP_LayoutFloorPlatforms()
	local PP_Platforms_PerFloor = math.Clamp( PP["Floors"]["Platforms_Per_Player"] * #player.GetAll(), PP["Floors"]["Minimum_Platforms"], PP["Floors"]["Max_Platforms"] )

	if PP_GetGameState() == 2 then

		local Floors_Platforms = PP_RandomPlatformType( PP["Floors"]["First_Floor_Platforms"], 
			{
				"Abstract_Danger",
				"Lame_Zone",
				"Landscape01",
				"Stone_Place",
				"Stone_Zone",
				"Tree Platform",
				"End_Floor",
				"Two_Level",
				"Ritual"
			} 
		)

		table.insert( Floors_Platforms, "End_Floor" )

		return Floors_Platforms

	else
		
		local Floors_Platforms = PP_RandomPlatformType( PP_Platforms_PerFloor, 
			{
				"End_Floor",
				"Land_Piece",
				"Chunk_Build",
				"Obstacle_1",
			} 
		)

		table.insert( Floors_Platforms, "End_Floor" )

		return Floors_Platforms

	end
end