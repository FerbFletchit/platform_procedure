Platform_Manager["Types"]["Lame_Zone"] = {
	
	["Rarity"] = 0.3, -- 0.1 - 1. Spawn rarity
	
	["Angle"] = Angle(0,0,0),
	
	["Life"] = 5, -- How long to get to it's end point.
	
	["Decay"] = 20, -- Decay Time.
	
	["Loot"] = false,

	["Delete_Last"] = true, -- Should the platform delete the last one.
	["Auto_Spawn_Next"] = true, -- Should it automaticall spawn the next one after time.
	["Next_Spawn"] = PP["Time_Per_Special"], -- How long until auto spawn next platform.

	[1] = function( Platform ) -- Everything controlled here.
		Platform["Info"] = Platform["Info"] or {}
		Platform["Info"]["Reached_Destination"] = true -- If set to true, the platform won't activate on arrival. Risky to do that.
				
		--[[Platform["Events"] = {
			
			["pp_event_tower"] = {

				["Angles"] = function() return Angle(0,0,90) end,

				["Pos"] = function() return Platform:GetPos()+Platform:GetAngles():Up()*480 end

			},

			["pp_event_beacon"] = {

				["Angles"] = function() return Angle(0,-90,0) end,

				["Pos"] = function() return Platform:GetPos()-Platform:GetAngles():Right()*160-Platform:GetAngles():Forward()*240+Platform:GetAngles():Up()*56 end
				
			},

			["pp_event_bomb"] = {

				["Angles"] = function() return Angle(0,0,0) end,

				["Pos"] = function() return Platform:GetPos()-Platform:GetAngles():Right()*900-Platform:GetAngles():Forward()*160+Platform:GetAngles():Up()*110 end
				
			},
			
		}]]

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


		
			-------------------------------------------------------------------------------------------------
		end

		-----------------------------------------------------------------------------------------------
		
		if SERVER then
			timer.Simple(0.1, function()
				if IsValid(Platform) then
					Platform["Trampoline"] = ents.Create("pp_trampoline")
					
					if IsValid( Platform["Trampoline"] ) then
						
						Platform["Trampoline"]:SetPos(Platform:GetPos()+Platform:GetUp()*96-Platform:GetRight()*50)
						
						local angy = Platform:GetAngles()

						Platform["Trampoline"]:SetAngles( Angle(0,0,0) )
						
						Platform["Trampoline"]:SetParent( Platform )
						Platform["Trampoline"]:Spawn()
						
						
						
						local PhysicsObject = Platform["Trampoline"]:GetPhysicsObject()
						
						if IsValid(PhysicsObject) then
							
							PhysicsObject:EnableGravity( false )

						end

					end
				end

				if IsValid(Platform) then
					Platform["WB"] = ents.Create("pp_workbench")
					
					if IsValid( Platform["WB"] ) then
						
						Platform["WB"]:SetPos(Platform:GetPos()+Platform:GetUp()*390-Platform:GetRight()*400+Platform:GetForward()*300)
						
						local angy = Platform:GetAngles()

						Platform["WB"]:SetAngles( Angle(0,0,0) )
						
						Platform["WB"]:SetParent( Platform )
						Platform["WB"]:Spawn()
						
						
						
						local PhysicsObject = Platform["WB"]:GetPhysicsObject()
						
						if IsValid(PhysicsObject) then
							
							PhysicsObject:EnableGravity( false )

						end

					end
				end

			end )
		end
	end
}