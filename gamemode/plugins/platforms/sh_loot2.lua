local Platform_Name = "Loot_Platform2"

Platform_Manager["Structures"][Platform_Name] = { -- The platform ID.
	--["FX"] = 1,
	["Size"] = "6x6x2",
	["Angles"] = Angle(0,90,0),
	["Mass"] = 10000, -- (In Kilograms)
	["Color"] = Color(109,109,109),
	["Material"] = "models/debug/debugwhite",

	["Child_Blocks"] = {
		{
			"2x2x1",
			function(Base)
				return Base:GetPos() + Vector( -85, 81, 50)
			end,
			Angle(0,90,0),
			Color(145,145,145),
			"models/debug/debugwhite",
			"tile",
		},
		{
			"2x2x1",
			function(Base)
				return Base:GetPos() + Vector( 87, -86, 50)
			end,
			Angle(0,90,0),
			Color(145,145,145),
			"models/debug/debugwhite",
			"tile",
		},
		{
			"2x2x1",
			function(Base)
				return Base:GetPos() + Vector( -84, -83, 50)
			end,
			Angle(0,90,0),
			Color(145,145,145),
			"models/debug/debugwhite",
			"tile",
		},
		{
			"2x2x1",
			function(Base)
				return Base:GetPos() + Vector( 82, 81, 50)
			end,
			Angle(0,-90,0),
			Color(145,145,145),
			"models/debug/debugwhite",
			"tile",
		},

	}
}

Platform_Manager["Types"][Platform_Name] = {
	["Rarity"] = 0.4, -- 0.1 - 1.
	["Mass"] = 1000,
	["Life"] = 5, -- How long to get to it's end point.
	["Decay"] = 20, -- Decay Time.
	["Loot"] = true,

	["Delete_Last"] = false, -- Should the platform delete the last one.
	["Auto_Spawn_Next"] = true, -- Should it automaticall spawn the next one after time.
	["Next_Spawn"] = 10, -- How long until auto spawn next platform.

	[1] = function( Platform ) -- Everything controlled here.
		Platform:SetAngles( Angle(0,90*math.random(0,4)) )
		Platform["Info"] = Platform["Info"] or {}
		Platform["Info"]["Reached_Destination"] = true -- This is necessary so the callback doesn't activate right away.
		
		AddEffectBlock(Platform, "generic")
	end
}