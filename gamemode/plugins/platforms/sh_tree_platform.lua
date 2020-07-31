Platform_Manager["Types"]["Tree Platform"] = {
	
	["Rarity"] = 0.5, -- 0.1 - 1. Spawn rarity
	
	["Angle"] = Angle(0,90,0),
	
	--["Size"] = "1x1x1",
	
	["Material"] = "models/debug/debugwhite",
	
	--["Mass"] = 100, -- If mass is left blank, it will be materialized by mass.
	
	["Life"] = 5, -- How long to get to it's end point.
	
	["Decay"] = 20, -- Decay Time.

	["Delete_Last"] = true, -- Should the platform delete the last one.
	["Auto_Spawn_Next"] = true, -- Should it automaticall spawn the next one after time.
	["Next_Spawn"] = PP["Time_Per_Special"], -- How long until auto spawn next platform.

	
	["Loot"] = true,
	[1] = function( Platform ) -- Everything controlled here.
		Platform["Info"] = Platform["Info"] or {}
		Platform["Info"]["Reached_Destination"] = true -- If set to true, the platform won't activate on arrival. Risky to do that.
		Platform["Min_Time"] = 40 -- In seconds.
		Platform["Max_Time"] = 120 -- In seconds.
		
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

			if SERVER then
				PP_SpawnLandPiecesAround( Platform )
			end
			
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
			
			PP_NPCSpawn( 
				Platform:GetPos()+Vector(75,75,85), 
				"pp_enemy_bullsquid"
			)

			PP_NPCSpawn( 
				Platform:GetPos()+Vector(-75,-75,85), 
				"pp_enemy_bullsquid"
			)

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