Platform_Manager["Types"]["Trampoline_Cube"] = {
	["Rarity"] = 0.5, -- 0.1 - 1.
	["Angle"] = Angle(0,0,0),
	["Size"] = "1x1x1",
	--["Material"] = "Models/effects/vol_light001",
	["Mass"] = 1,
	["Life"] = 5, -- How long to get to it's end point.
	["Decay"] = 20, -- Decay Time.
	["Loot"] = false,

	["Delete_Last"] = false, -- Should the platform delete the last one.
	["Auto_Spawn_Next"] = false, -- Should it automaticall spawn the next one after time.
	["Next_Spawn"] = 0, -- How long until auto spawn next platform.

	[1] = function( Platform ) -- Everything controlled here.
		Platform["Info"] = Platform["Info"] or {}
		Platform["Info"]["Reached_Destination"] = false -- This is necessary so the callback doesn't activate right away.
		Platform["Callback_Time"] = 5

		Platform["Callback"] = function( Platform ) -- What happens when we reach our destination.
			Platform:SetNW2Bool("Activated", true)

			--if SERVER then
				if not PP["Floors"]["Current_Platform_Order"] then return end
				if PP["Floors"]["Current_Platform"] >= (#PP["Floors"]["Current_Platform_Order"] or 0) then
					return
				end

				PP["Floors"]["Current_Platform"] = PP["Floors"]["Current_Platform"] + 1
				PP_ReachedEvent( nil, PP["Floors"]["Current_Platform_Order"][ PP["Floors"]["Current_Platform"] ] )
			--end
			
		end

		timer.Simple( Platform["Callback_Time"], function() -- This acts a fail-safe for platform callback.
			if IsValid( Platform ) then
				if not Platform:GetNW2Bool("Activated") then
					Platform["Callback"]( Platform )
				end
			end
		end )
		
		if SERVER then
			Platform:Activate()
			timer.Simple(0.1, function()
				if IsValid(Platform) then
					Platform["Trampoline"] = ents.Create("pp_trampoline")
					
					if IsValid( Platform["Trampoline"] ) then
						
						Platform["Trampoline"]:SetPos(Platform:GetPos()+Platform:GetUp()*25)
						
						local angy = Platform:GetAngles()
						Platform["Trampoline"]:SetAngles( Angle(0,angy.y,0) )
						
						Platform["Trampoline"]:Spawn()
						
						Platform["Trampoline"]:SetParent( Platform )
						
						local PhysicsObject = Platform["Trampoline"]:GetPhysicsObject()
						
						if IsValid(PhysicsObject) then
							
							PhysicsObject:EnableGravity( false )

						end

					end
				end

			end )

		end
	end
}