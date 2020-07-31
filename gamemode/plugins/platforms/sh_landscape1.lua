Platform_Manager["Types"]["Landscape01"] = {
	
	["Rarity"] = 0.5, -- 0.1 - 1. Spawn rarity
	
	["Angle"] = Angle(0,0,0),
	
	--["Size"] = "1x1x1",
	
	["Material"] = "Models/effects/vol_light001",
	
	--["Mass"] = 100, -- If mass is left blank, it will be materialized by mass.
	
	["Life"] = 5, -- How long to get to it's end point.
	
	["Decay"] = 20, -- Decay Time.
	
	["Loot"] = false,

	["Delete_Last"] = true, -- Should the platform delete the last one.
	["Auto_Spawn_Next"] = true, -- Should it automaticall spawn the next one after time.
	["Next_Spawn"] = PP["Time_Per_Special"], -- How long until auto spawn next platform.

	[1] = function( Platform ) -- Everything controlled here.
		Platform["Info"] = Platform["Info"] or {}
		Platform["Info"]["Reached_Destination"] = true -- If set to true, the platform won't activate on arrival. Risky to do that.
		
		--Platform["Min_Time"] = 40 -- In seconds.
		--Platform["Max_Time"] = 120 -- In seconds.
		
		--Platform["Last_Time"] = math.Clamp(#team.GetPlayers(1)*15, Platform["Min_Time"],Platform["Max_Time"])
		--------------------------------------------------------------------------------------
		-- Timing fail-safe.
		Platform["Info"]["Reached_Destination"] = true -- This is necessary so the callback doesn't activate right away.

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
			
			--PP_DecayBeforeLastPlatform(10)

			Platform:SetCollisionGroup(COLLISION_GROUP_IN_VEHICLE)
			local PhysicsObj = Platform:GetPhysicsObject()
			if IsValid(PhysicsObj) then
				PhysicsObj:EnableMotion( false )
			end
			
			for key, value in pairs(Platform:GetChildren()) do
				local PhysicsObj = value:GetPhysicsObject()
				if IsValid(PhysicsObj) then
					PhysicsObj:EnableMotion( false )
				end
			end
			-------------------------------------------------------------------------------------------------
			-- Call back functions below:
			
			Platform:SetNW2Bool("Activated")
			--[[local bat_frequency = (PP["Bat_Spawner_Frequency"]) / #team.GetPlayers(1)

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


			--Platform:PhysicsInit(SOLID_VPHYSICS)
			--Platform:SetMoveType(MOVETYPE_NONE)
			
			-------------------------------------------------------------------------------------------------
			-- This acts as a good next spawn function. 
		
			-------------------------------------------------------------------------------------------------
		end

		-----------------------------------------------------------------------------------------------
		
		if SERVER then
			-- Here place the functionality of the platform. Spawning entities, ect.

		end
	end
}