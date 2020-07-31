Platform_Manager["Types"]["Boss_Stage"] = {
	
	["Rarity"] = 0, -- 0.1 - 1. Spawn rarity
	
	["Angle"] = Angle(0,0,0),
	
	["Size"] = "8x8x8",
	
	--["Material"] = "Models/effects/vol_light001",
	
	["Mass"] = 50000, -- If mass is left blank, it will be materialized by mass.
	
	["Life"] = 2, -- How long to get to it's end point.
	
	["Decay"] = 3, -- Decay Time.
	
	["Loot"] = false,
	
	[1] = function( Platform ) -- Everything controlled here.
		Platform["Info"] = Platform["Info"] or {}
		Platform["Info"]["Reached_Destination"] = true -- If set to true, the platform won't activate on arrival. Risky to do that.
		Platform["Loot_Chute_Generator_Time"] = math.random(10,25)

		Platform["RadiusStart"] = 150
		Platform["Radius"] = 1000

		Platform["End_Stage_PlatformAmt"] = math.random(70,70)
		Platform["Platforms"] = { "Trampoline_Cube", "Bridge", "Single_Chest", "Fort_Wall", "Tower", "Land_Piece" }

		--------------------------------------------------------------------------------------
		-- Timing fail-safe.
		Platform["Callback_Time"] = 10

		timer.Simple( Platform["Callback_Time"], function() -- This acts a fail-safe for platform callback.
			if IsValid( Platform ) then
				if not Platform:GetNW2Bool("Activated") then
					Platform["Callback"]( Platform )
				end
			end
		end )

		------------------------------------------------------------------------------------------

		Platform["Callback"] = function( Platform ) -- What happens when we reach our destination.
			
			-------------------------------------------------------------------------------------------------
			-- Call back functions below:
			
			Platform:SetNW2Bool("Activated", true)
			Platform:SetCollisionGroup(0)

			PP_BossSpawn( Platform:GetPos()+Platform:GetUp()*200,
			 	"pp_boss_worm", 
			 	math.random(100,500) -- Level does not affect stats. 
			)

			AddEffectBlock(Platform, "generic")

			local Boss_Camera_Angles = Platform:GetAngles()
			Boss_Camera_Angles:RotateAroundAxis(Boss_Camera_Angles:Up(),180)

			if SERVER then

				--[[local bat_frequency = (PP["Bat_Spawner_Frequency"] + 10) / #team.GetPlayers(1)

				timer.Simple(bat_frequency, function()

					if not IsValid(Platform) then return end
					
					Platform:SpawnBat()

				end )

				function Platform:SpawnBat()
					PP_NPCSpawn( 
						Platform:GetPos()+VectorRand(-400,400), 
						"pp_enemy_stukabat"
					)
				end]]
			end


			-------------------------------------------------------------------------------------------------

		end

		-----------------------------------------------------------------------------------------------
		
		if SERVER then -- Here place the functionality of the platform. Spawning init entities, ect.
			Platform:SetCollisionGroup(10)
			Platform["Travel"]["pos"] = Platform["Travel"]["pos"] - Vector(0,0,1000)
			------------------------
			-- Spawning surrounding platforms
			timer.Simple(5, function()
				if not IsValid(Platform) then return end
				for i=1, Platform["End_Stage_PlatformAmt"] do
					timer.Simple(0.1*i, function()
						if not IsValid(Platform) then return end
						local postab = {1,-1}
						local pos = Platform:GetPos()+Vector(
							
							math.random(Platform["RadiusStart"],Platform["Radius"])*table.Random(postab),

							math.random(Platform["RadiusStart"],Platform["Radius"])*table.Random(postab),

							math.random(300,600)

						)

						Generate_Platform( { -- Spawing the start platform!

							["Type"] = table.Random(Platform["Platforms"]),

							["Angles"] = Angle(0, (90*math.random(1,4))*table.Random({-1,1}), 0),

							["Start"] = pos - Vector( 0, 0, math.random(300,500) ), -- Start Point

							["End"] = pos, -- End Point.

							["Life"] = math.random(1,5), -- How long to get to it's end point.

							--["Size"] = "1x1x1", -- Size.

							["Decay"] = 3, -- Decay Time.

							["Callback"] = function( self ) -- When the spawn platform has fully risen.

							end

						} )
					end )

				end

				local Next_Chute = CurTime() + Platform["Loot_Chute_Generator_Time"]

				Platform["Loot_Chute_Generator"] = function()
					
					if IsValid(Platform) then
						if CurTime() >= Next_Chute then
							local PP_Parachute = ents.Create("pp_loot_parachute")
						
							if IsValid( PP_Parachute ) then

								PP_Parachute:SetPos(Platform:GetPos() + Vector(math.random(-600,600),math.random(-600,600),1000) )
								PP_Parachute:Spawn()

							end

							Next_Chute = CurTime() + Platform["Loot_Chute_Generator_Time"]

						end

					else

						hook.Remove( "Boss_Loot_Chute_Generator" )

					end

				end
				hook.Add("Think", "Boss_Loot_Chute_Generator", Platform["Loot_Chute_Generator"])

			end)

		end
	end
}