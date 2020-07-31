local Platform_Name = "Trampoline_Gen"

Platform_Manager["Structures"][Platform_Name] = { -- The platform ID.
	["FX"] = 1,
	["Size"] = "4x4x025",
	["Angles"] = Angle(0,-45,0),
	["Mass"] = 500, -- (In Kilograms)
	--["Color"] = Color(255,0,0, 200),
	["Material"] = "Models/effects/vol_light001",

	["Child_Blocks"] = {
	}
}

Platform_Manager["Types"][Platform_Name] = {
	["Rarity"] = 0, -- 0.1 - 1.
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
			local Move_Rate = 1
			local Num_Trampolines = math.random(3,5)
			Platform["Trampolines"] = {}
			for i=1, Num_Trampolines do
				Generate_Platform( { -- Spawing the start platform!
					["ID"] = "GeneratedTrampoline"..Platform:GetCreationTime()..i,

					["Structure"] = nil, -- If nil, a structure won't be built.

					["Type"] = "Trampoline_Cube", -- This should always be a valid type.

					["Size"] = nil,

					["Angle"] = Angle(0,90*math.random(0,4),0),

					["Start"] = Platform:GetPos() + VectorRand(-200,200), -- Start Point

					["End"] = Platform["Travel"]["pos"] + Platform:GetPos()+VectorRand(-300,300),

					["Life"] = 1, -- How long to get to it's end point.

					["Decay"] = PP["Land_Piece_Decay"], -- Decay Time.

				} )
				FindPlatform("GeneratedTrampoline"..Platform:GetCreationTime()..i):SetPos(FindPlatform("GeneratedTrampoline"..Platform:GetCreationTime()..i)["Travel"]["pos"])
				FindPlatform("GeneratedTrampoline"..Platform:GetCreationTime()..i):SetCollisionGroup(10)

				table.insert(Platform["Trampolines"], FindPlatform("GeneratedTrampoline"..Platform:GetCreationTime()..i))
			end

			function Platform:MoveTrampoline()

				local Random_Tramp = table.Random( self["Trampolines"] )

				if IsValid( Random_Tramp ) then

					Random_Tramp["Travel"]["pos"] = Platform:GetPos()+VectorRand(-300,300)
					Random_Tramp["Travel"]["maxspeed"] = 100
				end

				timer.Simple(Move_Rate, function()
					if IsValid(Platform) then
						Platform:MoveTrampoline()
					end
				end )
			end

			Platform:MoveTrampoline()

		end
	end
}