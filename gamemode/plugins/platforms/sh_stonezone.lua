Platform_Manager["Types"]["Stone_Zone"] = {
	
	["Rarity"] = 0.5, -- 0.1 - 1. Spawn rarity
	
	["Angle"] = Angle(0,0,0),
	
	--["Size"] = "1x1x1",
	
	--["Material"] = "Models/effects/vol_light001",
	
	--["Mass"] = 100, -- If mass is left blank, it will be materialized by mass.
	
	["Life"] = 5, -- How long to get to it's end point.
	
	["Decay"] = 20, -- Decay Time.
	
	["Loot"] = true,

	["Delete_Last"] = true, -- Should the platform delete the last one.
	["Auto_Spawn_Next"] = false, -- Should it automaticall spawn the next one after time.
	["Next_Spawn"] = 0, -- How long until auto spawn next platform.

	[1] = function( Platform ) -- Everything controlled here.
		Platform["Info"] = Platform["Info"] or {}
		Platform["Info"]["Reached_Destination"] = true -- If set to true, the platform won't activate on arrival. Risky to do that.


		Platform["Events"] = {
			
			["pp_event_tower"] = {

				["Angles"] = function() return Angle(0,0,90) end,

				["Pos"] = function() return Platform:GetPos()+Platform:GetAngles():Up()*465 end

			},

			["pp_event_beacon"] = {

				["Angles"] = function() return Angle(0,-90,0) end,

				["Pos"] = function() return Platform:GetPos()-Platform:GetAngles():Right()*160-Platform:GetAngles():Forward()*240+Platform:GetAngles():Up()*56 end
				
			},

			["pp_event_bomb"] = {

				["Angles"] = function() return Angle(0,0,0) end,

				["Pos"] = function() return Platform:GetPos()-Platform:GetAngles():Right()*900-Platform:GetAngles():Forward()*160+Platform:GetAngles():Up()*110 end
				
			},
			
		}

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
			
			if SERVER then
				PP_SpawnLandPiecesAround( Platform )
				PP_DecidePlatformEvent( Platform )
			end

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
			--[[local bats = #team.GetPlayers(1)*math.random(1,3)
			for i=1, bats do
				timer.Simple(0.1*i, function()
					if not IsValid(Platform) then return end
					
					PP_NPCSpawn( 
						Platform:GetPos()+Vector(math.random(-200,200),math.random(-200,200),math.random(200,300)), 
						"pp_enemy_stukabat"
					)

				end )
			end]]
			
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