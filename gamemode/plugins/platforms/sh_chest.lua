Platform_Manager["Types"]["Single_Chest"] = {
	["Rarity"] = 0.3, -- 0.1 - 1.
	["Angle"] = Angle(0,90*math.random(1,4),0),
	["Size"] = "2x2x025",
	["Material"] = "!Rusty",
	["Mass"] = 200,
	["Life"] = 0.1, -- How long to get to it's end point.
	["Decay"] = 20, -- Decay Time.
	["Loot"] = false,

	["Delete_Last"] = true, -- Should the platform delete the last one.

	["Auto_Spawn_Next"] = true, -- Should it automaticall spawn the next one after time.

	["Next_Spawn"] = 3, -- How long until auto spawn next platform.

	[1] = function( Platform ) -- Everything controlled here.
		Platform["Info"] = Platform["Info"] or {}
		Platform["Info"]["Reached_Destination"] = false -- This is necessary so the callback doesn't activate right away.
		Platform["Callback_Time"] = 5

		Platform["Callback"] = function( Platform ) -- What happens when we reach our destination.
			Platform:SetNW2Bool("Activated", true)
		end

		timer.Simple( Platform["Callback_Time"], function() -- This acts a fail-safe for platform callback.
			if IsValid( Platform ) then
				if not Platform:GetNW2Bool("Activated") then
					Platform["Callback"]( Platform )
				end
			end
		end )
		
		if SERVER then
			
			timer.Simple(0.1, function()
				if IsValid(Platform) then
					Platform["Chest"] = ents.Create("pp_chest")
					
					if IsValid( Platform["Chest"] ) then
						
						Platform["Chest"]:SetPos(Platform:GetPos()+Platform:GetUp()*15)
												
						Platform["Chest"]:Spawn()

						Platform["Chest"]:SetAngles( Angle(0,90*math.random(0,4),0) )
						
						Platform["Chest"]:SetParent( Platform )
						
						local PhysicsObject = Platform["Chest"]:GetPhysicsObject()
						
						if IsValid(PhysicsObject) then
							
							PhysicsObject:EnableGravity( false )

						end

					end
				end

			end )

		end
	end
}