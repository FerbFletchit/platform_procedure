--[[Platform_Manager["Types"]["Distinguishable_Name"] = {
	
	["Rarity"] = 0.5, -- 0.1 - 1. Spawn rarity
	
	["Angle"] = Angle(0,0,0),
	
	["Size"] = "1x1x1",
	
	--["Material"] = "Models/effects/vol_light001",
	
	["Mass"] = 100, -- If mass is left blank, it will be materialized by mass.
	
	["Life"] = 0.1, -- How long to get to it's end point.
	
	["Decay"] = 20, -- Decay Time.

	["Delete_Last"] = false, -- Should the platform delete the last one.
	["Auto_Spawn_Next"] = false, -- Should it automaticall spawn the next one after time.
	["Next_Spawn"] = 0, -- How long until auto spawn next platform.

	
	["Loot"] = false,
	[1] = function( Platform ) -- Everything controlled here.
		Platform["Info"] = Platform["Info"] or {}
		Platform["Info"]["Reached_Destination"] = false -- If set to true, the platform won't activate on arrival. Risky to do that.
		
		--------------------------------------------------------------------------------------
		-- Timing fail-safe.

		Platform["Callback_Time"] = 5

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
			
			Platform:SetNW2Bool("Activated")
			
			-------------------------------------------------------------------------------------------------
			-- This acts as a good next spawn function. 
			if not PP["Floors"]["Current_Platform_Order"] the return end
			if PP["Floors"]["Current_Platform"] >= (#PP["Floors"]["Current_Platform_Order"] or 0) then
				return
			end

			PP["Floors"]["Current_Platform"] = PP["Floors"]["Current_Platform"] + 1
			PP_ReachedEvent( nil, PP["Floors"]["Current_Platform_Order"][ PP["Floors"]["Current_Platform"] ] )
			-------------------------------------------------------------------------------------------------
		end

		-----------------------------------------------------------------------------------------------
		
		if SERVER then
			-- Here place the functionality of the platform. Spawning entities, ect.

		end
	end
}]]