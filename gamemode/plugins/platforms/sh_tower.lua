Platform_Manager["Types"]["Tower"] = {
	
	["Rarity"] = 0, -- 0.1 - 1. Spawn rarity
	
	["Angle"] = Angle(0,0,0),
	
	["Size"] = "05x05x025",
	
	["Material"] = "Models/effects/vol_light001",
	
	["Mass"] = 25000, -- If mass is left blank, it will be materialized by mass.
	
	["Life"] = 1, -- How long to get to it's end point.
	
	["Decay"] = 20, -- Decay Time.
	
	["Loot"] = false,

	[1] = function( Platform ) -- Everything controlled here.
		Platform["Info"] = Platform["Info"] or {}
		Platform["Info"]["Reached_Destination"] = false -- If set to true, the platform won't activate on arrival. Risky to do that.
		
		--------------------------------------------------------------------------------------
		-- Timing fail-safe.

		Platform["Callback_Time"] = 1

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
			

			Platform:PhysicsInit(SOLID_VPHYSICS)
			Platform:SetMoveType(MOVETYPE_NONE)
			--Platform:Activate()

			--Platform:EmitSound("physics/metal/metal_solid_strain"..math.random(1,2)..".wav",75,math.random(90,100),1,CHAN_AUTO)

			if SERVER then
				if IsValid(Platform) then
					Platform["Bridge"] = ents.Create("prop_dynamic")
					
					if IsValid( Platform["Bridge"] ) then
						Platform["Bridge"]:SetModel("models/aceofspades/prefabs/crowsnest.mdl")
						
						Platform["Bridge"]:SetPos(Platform:GetPos()+Platform:GetUp()*5)
						
						local angy = Platform:GetAngles()
						Platform["Bridge"]:SetAngles( Angle(0,angy.y,0) )
						
						Platform["Bridge"]:SetSolid(SOLID_VPHYSICS)
						
						Platform["Bridge"]:Spawn()
						
						Platform["Bridge"]:SetParent( Platform )
						
						Platform["Bridge"]:SetParent( Platform )
						local grey_scale = math.random(20,110)
						Platform["Bridge"]:SetColor(Color(1*grey_scale,1*grey_scale,1*grey_scale))

						Platform["Bridge"]:SetMaterial("!Bridge")

						local PhysicsObject = Platform["Bridge"]:GetPhysicsObject()
						
						if IsValid(PhysicsObject) then
							
							PhysicsObject:EnableGravity( false )

							PhysicsObject:SetMass(1)

						end

						--Platform["Tunnel1"]:SetColor(PP["Color_Pallete"]["NPC_Low_Health"])
					end
				end
			end
			
			-------------------------------------------------------------------------------------------------
			-- This acts as a good next spawn function. 
			--[[if not PP["Floors"]["Current_Platform_Order"] the return end
			if PP["Floors"]["Current_Platform"] >= (#PP["Floors"]["Current_Platform_Order"] or 0) then
				return
			end

			PP["Floors"]["Current_Platform"] = PP["Floors"]["Current_Platform"] + 1
			PP_ReachedEvent( nil, PP["Floors"]["Current_Platform_Order"][ PP["Floors"]["Current_Platform"] ] )]]
			-------------------------------------------------------------------------------------------------
		end

		-----------------------------------------------------------------------------------------------
		
		if SERVER then
			-- Here place the functionality of the platform. Spawning entities, ect.

		end
	end
}