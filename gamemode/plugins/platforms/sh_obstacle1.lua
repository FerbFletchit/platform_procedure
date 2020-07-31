local Platform_Name = "Obstacle_1"

Platform_Manager["Structures"][Platform_Name] = { -- The platform ID.
	["FX"] = 1,
	["Size"] = "4x4x025",
	["Angles"] = Angle(0,-45,0),
	["Mass"] = 50000, -- (In Kilograms)
	--["Color"] = Color(255,0,0, 200),
	["Material"] = "Models/effects/vol_light001",

	["Child_Blocks"] = {
		{
			"05x05x025",
			function(Base)
				return Base:GetPos() + Vector( 182, -178, 70)
			end,
			Angle(0,0,0),
			Color(182,182,182),
			"models/debug/debugwhite",
			"tile",
		},
		{
			"05x05x025",
			function(Base)
				return Base:GetPos() + Vector( 118, -115, 70)
			end,
			Angle(0,0,0),
			Color(109,109,109),
			"models/debug/debugwhite",
			"tile",
		},
		{
			"05x05x025",
			function(Base)
				return Base:GetPos() + Vector( 55, -51, 70)
			end,
			Angle(0,0,0),
			Color(182,182,182),
			"models/debug/debugwhite",
			"tile",
		},
		{
			"05x05x025",
			function(Base)
				return Base:GetPos() + Vector( -9, 12, 70)
			end,
			Angle(0,0,0),
			Color(109,109,109),
			"models/debug/debugwhite",
			"tile",
		},
		{
			"05x05x025",
			function(Base)
				return Base:GetPos() + Vector( -72, 76, 70)
			end,
			Angle(0,0,0),
			Color(182,182,182),
			"models/debug/debugwhite",
			"tile",
		},
		{
			"05x05x025",
			function(Base)
				return Base:GetPos() + Vector( -136, 139, 70)
			end,
			Angle(0,0,0),
			Color(109,109,109),
			"models/debug/debugwhite",
			"tile",
		},
		{
			"05x05x025",
			function(Base)
				return Base:GetPos() + Vector( -199, 203, 70)
			end,
			Angle(0,0,0),
			Color(182,182,182),
			"models/debug/debugwhite",
			"tile",
		},

	}
}

Platform_Manager["Types"][Platform_Name] = {
	["Rarity"] = 0.4, -- 0.1 - 1.
	["Angle"] = Angle(0,90*math.random(0,4),0),
	["Mass"] = 1,
	["Life"] = 5, -- How long to get to it's end point.
	["Decay"] = 20, -- Decay Time.
	["Loot"] = false,

	["Delete_Last"] = false, -- Should the platform delete the last one.
	["Auto_Spawn_Next"] = true, -- Should it automaticall spawn the next one after time.
	["Next_Spawn"] = 5, -- How long until auto spawn next platform.

	[1] = function( Platform ) -- Everything controlled here.
		Platform["Info"] = Platform["Info"] or {}
		Platform["Info"]["Reached_Destination"] = true -- This is necessary so the callback doesn't activate right away.
		
		Platform:SetCollisionGroup(10)
		if SERVER then
			

			function Platform:Wave()
				for i=1, #Platform:GetChildren() do
					local child = Platform:GetChildren()[i]
					timer.Simple(0.5*i, function()
						
						if IsValid(child) then
							
							PP_ActionEffect(child, "pp_impact", 1)
							
							self:EmitSound("pp_sound_effects/neutral.mp3",45,70 + (i*3),1,CHAN_AUTO)
							
							child:SetAngles( child:GetAngles() + Angle(0,90*i, 0) )
							
							if i==#Platform:GetChildren() then

								Platform:Wave()

							end
						end

					end )
					

				end
			end
			Platform:Wave()
		end
	end
}