local Platform_Name = "Chunk_Build"

Platform_Manager["Types"][Platform_Name] = {
	["Rarity"] = 0.6, -- 0.1 - 1.
	["Angle"] = Angle(0,90*math.random(0,4),0),
	["Size"] = "1x1x1",
	["Mass"] = 10000,
	["Life"] = 5, -- How long to get to it's end point.
	["Decay"] = PP["Land_Piece_Decay"], -- Decay Time.
	["Loot"] = true,
	["Material"] = "Models/effects/vol_light001",

	["Delete_Last"] = false, -- Should the platform delete the last one.
	["Auto_Spawn_Next"] = true, -- Should it automaticall spawn the next one after time.
	["Next_Spawn"] = 5, -- How long until auto spawn next platform.

	[1] = function( Platform ) -- Everything controlled here.
		
		Platform["Info"] = Platform["Info"] or {}
		Platform["Info"]["Reached_Destination"] = true -- This is necessary so the callback doesn't activate right away.
		
		if SERVER then
			Platform:SetCollisionGroup(10)
			timer.Simple(5, function()
				if IsValid(Platform) then
					local Chunk_Amount = math.random(2,3)

					for i=1, Chunk_Amount do
						Generate_Platform( { -- Spawing the start platform!

							["Structure"] = nil, -- If nil, a structure won't be built.

							["Type"] = "Land_Piece", -- This should always be a valid type.

							["Size"] = "1x1x1",

							["Angle"] = Angle(0,90*math.random(0,4),0),

							["Start"] = Platform:GetPos() + VectorRand(-200,200), -- Start Point

							["End"] = Platform["Travel"]["pos"] + VectorRand(-200,200), -- End Point.

							["Life"] = 10, -- How long to get to it's end point.

							["Decay"] = PP["Land_Piece_Decay"], -- Decay Time.

						} )
					end
				end
			end )
		end
	end
}