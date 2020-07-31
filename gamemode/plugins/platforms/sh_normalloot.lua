local Platform_Name = "NormalLoot"

Platform_Manager["Structures"][Platform_Name] = { -- The platform ID.
	--["FX"] = 1,
	["Size"] = "6x6x025",
	["Angles"] = Angle(0,-90,0),
	["Mass"] = 200, -- (In Kilograms)
	--["Color"] = Color(109,109,109),
	["Material"] = "models/debug/debugwhite",

	["Child_Blocks"] = {
		{
			"6x6x025",
			function(Base)
				return Base:GetPos() + Vector( -4, -3, 1)
			end,
			Angle(0,-45,0),
			Color(109,109,109),
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
		
		local grey_scale = math.random(20,110)
		Platform:SetColor(Color(1*grey_scale,1*grey_scale,1*grey_scale))

		Platform:SetAngles( Angle(0,90*math.random(0,4)) )
		Platform["Info"] = Platform["Info"] or {}
		Platform["Info"]["Reached_Destination"] = true -- This is necessary so the callback doesn't activate right away.
		
		AddEffectBlock(Platform, "generic")
		
	end
}