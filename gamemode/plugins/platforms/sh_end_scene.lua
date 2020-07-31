Platform_Manager["Types"]["End Loss Platform"] = {
	["Rarity"] = 0, -- 0.1 - 1.
	["Angle"] = Angle(0,0,0),
	["Size"] = "6x6x05",
	["Material"] = "Models/effects/vol_light001",
	["Mass"] = 50000,
	["Life"] = 0.1, -- How long to get to it's end point.
	["Decay"] = 20, -- Decay Time.
	["Loot"] = false,
	[1] = function( Platform ) -- Everything controlled here.
		Platform["Info"] = Platform["Info"] or {}
		Platform["Info"]["Reached_Destination"] = true -- This is necessary so the callback doesn't activate right away.

		Platform["Callback"] = function( Platform ) -- What happens when we reach our destination.
		end
		
		if SERVER then
			
			timer.Simple(0.1, function()
				if IsValid(Platform) then
					Platform["Skull"] = ents.Create("pp_platform_prop")
					
					if IsValid( Platform["Skull"] ) then
						Platform["Skull"]:SetModel("models/aceofspades/prefabs/zombie_skull_new.mdl")
						Platform["Skull"]:SetPos(Platform:GetPos()+Platform:GetUp()*130)
						Platform["Skull"]:SetAngles( Angle( 0, 180, 0 ) )

						Platform["Skull"]:Spawn()
						Platform["Skull"]:SetParent( Platform )

						Platform["Skull"]:SetMaterial("models/shiny")
						Platform["Skull"]:SetColor(PP["Color_Pallete"]["NPC_Low_Health"])
					end
				end

				for i=1, PP["End_Scene_Chutes"] do
					timer.Simple(2*i, function()
						if IsValid(Platform) then
							local Scene_Chute = ents.Create("pp_loot_parachute")
							if IsValid( Scene_Chute ) then
								Scene_Chute:SetPos(Platform:GetPos()+Vector(
									math.random(-500,500),
									math.random(-500,500),
									math.random(800,1500)
									)
								)
								Scene_Chute:Spawn()
							end
						end
					end )
				end

			end )

		end
	end
}

Platform_Manager["Types"]["First Place Platform"] = {
	["Rarity"] = 0, -- 0.1 - 1.
	["Angle"] = Angle(0,0,0),
	["Size"] = "6x6x05",
	["Material"] = "Models/effects/vol_light001",
	["Mass"] = 50000,
	["Life"] = 0.1, -- How long to get to it's end point.
	["Decay"] = 0, -- Decay Time.
	["Loot"] = false,
	[1] = function( Platform ) -- Everything controlled here.
		Platform["Info"] = Platform["Info"] or {}
		Platform["Info"]["Reached_Destination"] = true -- This is necessary so the callback doesn't activate right away.

		Platform["Callback"] = function( Platform ) -- What happens when we reach our destination.
		end
		
		if SERVER then
			
			timer.Simple(0.1, function()
				if IsValid(Platform) then
					Platform["Skull"] = ents.Create("pp_platform_prop")
					
					if IsValid( Platform["Skull"] ) then
						Platform["Skull"]:SetModel("models/aceofspades/prefabs/zombie_skull_new.mdl")
						--models/aceofspades/prefabs/zombie_hand_new.mdl
						--models/aceofspades/prefabs/zombie_hand.mdl
						Platform["Skull"]:SetPos(Platform:GetPos()+Platform:GetUp()*130)
						Platform["Skull"]:SetAngles( Angle( 0, 180, 0 ) )

						Platform["Skull"]:Spawn()
						Platform["Skull"]:SetParent( Platform )

						Platform["Skull"]:SetMaterial("models/shiny")
						Platform["Skull"]:SetColor(PP["Color_Pallete"]["Gold"])
					end
				end

			end )

			for i=1, PP["End_Scene_Chutes"] do
				timer.Simple(2*i, function()
					if IsValid(Platform) then
						local Scene_Chute = ents.Create("pp_loot_parachute")
						if IsValid( Scene_Chute ) then
							Scene_Chute:SetPos(Platform:GetPos()+Vector(
								math.random(-500,500),
								math.random(-500,500),
								math.random(800,1500)
								)
							)
							Scene_Chute:Spawn()
						end
					end
				end )
			end

		end
	end
}

Platform_Manager["Types"]["Second Place Platform"] = {
	["Rarity"] = 0, -- 0.1 - 1.
	["Angle"] = Angle(0,0,0),
	["Size"] = "2x2x05",
	["Material"] = "Models/effects/vol_light001",
	["Mass"] = 50000,
	["Life"] = 0.1, -- How long to get to it's end point.
	["Decay"] = 0, -- Decay Time.
	["Loot"] = false,
	[1] = function( Platform ) -- Everything controlled here.
		Platform["Info"] = Platform["Info"] or {}
		Platform["Info"]["Reached_Destination"] = true -- This is necessary so the callback doesn't activate right away.

		Platform["Callback"] = function( Platform ) -- What happens when we reach our destination.
		end
		
		if SERVER then
			
			timer.Simple(0.1, function()
				if IsValid(Platform) then
					Platform["Skull"] = ents.Create("pp_platform_prop")
					
					if IsValid( Platform["Skull"] ) then
						Platform["Skull"]:SetModel("models/aceofspades/prefabs/zombie_hand_new.mdl")
						--models/aceofspades/prefabs/zombie_hand_new.mdl
						--models/aceofspades/prefabs/zombie_hand.mdl
						Platform["Skull"]:SetPos(Platform:GetPos()+Platform:GetUp()*110+Platform:GetRight()*60)
						Platform["Skull"]:SetAngles( Angle( 0, 180, 0 ) )

						Platform["Skull"]:Spawn()
						Platform["Skull"]:SetParent( Platform )

						Platform["Skull"]:SetMaterial("models/shiny")
						Platform["Skull"]:SetColor(PP["Color_Pallete"]["Silver"])
					end
				end

			end )

		end
	end
}

Platform_Manager["Types"]["Third Place Platform"] = {
	["Rarity"] = 0, -- 0.1 - 1.
	["Angle"] = Angle(0,0,0),
	["Size"] = "2x2x05",
	["Material"] = "Models/effects/vol_light001",
	["Mass"] = 50000,
	["Life"] = 0.1, -- How long to get to it's end point.
	["Decay"] = 0, -- Decay Time.
	["Loot"] = false,
	[1] = function( Platform ) -- Everything controlled here.
		Platform["Info"] = Platform["Info"] or {}
		Platform["Info"]["Reached_Destination"] = true -- This is necessary so the callback doesn't activate right away.

		Platform["Callback"] = function( Platform ) -- What happens when we reach our destination.
		end
		
		if SERVER then
			
			timer.Simple(0.1, function()
				if IsValid(Platform) then
					Platform["Skull"] = ents.Create("pp_platform_prop")
					
					if IsValid( Platform["Skull"] ) then
						Platform["Skull"]:SetModel("models/aceofspades/prefabs/zombie_hand.mdl")
						--models/aceofspades/prefabs/zombie_hand_new.mdl
						--models/aceofspades/prefabs/zombie_hand.mdl
						Platform["Skull"]:SetPos(Platform:GetPos()+Platform:GetUp()*60+Platform:GetRight()*30)
						Platform["Skull"]:SetAngles( Angle( 0, 90, 0 ) )

						Platform["Skull"]:Spawn()
						Platform["Skull"]:SetParent( Platform )

						Platform["Skull"]:SetMaterial("models/shiny")
						Platform["Skull"]:SetColor(PP["Color_Pallete"]["Bronze"])
					end
				end
			end )

		end
	end
}