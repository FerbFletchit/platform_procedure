local Platform_Name = "Lever"

Platform_Manager["Structures"][Platform_Name] = { -- The platform ID.
	--["FX"] = 1,
	["Size"] = "2x2x1",
	["Angles"] = Angle(0,90,0),
	["Mass"] = 500, -- (In Kilograms)
	--["Color"] = Color(255,0,0, 200),
	["Material"] = "models/debug/debugwhite",

	["Child_Blocks"] = {
	
	}
}

Platform_Manager["Types"][Platform_Name] = {
	["Rarity"] = 0.5, -- 0.1 - 1.
	["Angle"] = Angle(0,90*math.random(0,4),0),
	["Mass"] = 1,
	["Life"] = 5, -- How long to get to it's end point.
	["Decay"] = 20, -- Decay Time.
	["Loot"] = false,

	["Delete_Last"] = false, -- Should the platform delete the last one.
	["Auto_Spawn_Next"] = true, -- Should it automaticall spawn the next one after time.
	["Next_Spawn"] = 5, -- How long until auto spawn next platform.

	[1] = function( Platform ) -- Everything controlled here.
		Platform["Info"] = Platform["Info"] or {}
		Platform["Info"]["Reached_Destination"] = true -- This is necessary so the callback doesn't activate right away.
		
		if SERVER then

			Platform:SetColor(table.Random(PP["Block_Themes"])[1])

			local LeverFunctions = {

				[1] = function()
					local loot_dropAmt = 5
					for i=1, loot_dropAmt do
						local Lever_Loot_Entity = ents.Create("pp_loot_cube")

						if IsValid(Lever_Loot_Entity) then
							Lever_Loot_Entity:SetPos( Platform:GetPos()+Vector(
									math.random(-50,50),
									math.random(-50,50),
									math.random(500,600)
								) 
							)

							Lever_Loot_Entity:Spawn()

							Lever_Loot_Entity:ApplyIngotQuality( PP_ProduceRandomIngot(NPC_Ingot_Quality) )

							Lever_Loot_Entity:EmitSound("PP_Sound_Effects/Pop"..math.random(1,2)..".mp3",55,math.random(100,200),1,CHAN_AUTO)

							local Phys = Lever_Loot_Entity:GetPhysicsObject()

							if IsValid(Phys) then

								--Phys:SetVelocity( Vector( math.random(-500, 500), math.random(-500, 500), math.random(-500, 500) ) )

							end

						end
					end
				end,

				[2] = function()
					PP_NPCSpawn( 
						Platform:GetPos()+Vector(0,0,400), 
						"pp_enemy_stukabat"
					)
				end,

				[3] = function()
					for key, value in pairs(ents.FindInSphere(Platform:GetPos(), 300)) do
						if value:IsPlayer() and value:Alive() then
							value:SendNotification("Dialouge", {"Health!", "Healing up!", "Got some health!"})
							PP_AddHealth( value, math.random(50,60) )
							value:EmitSound("PP_Sound_Effects/Sparkle.mp3",65,100,1,CHAN_AUTO)
						end
					end
				end,

				[4] = function()
					Platform["Travel"]["pos"] = Platform:GetPos() + Vector(0,0,300)
				end,

				[5] = function()
					BroadcastNotification({"Someone switched the gravity off!", "The lever turned off the gravity!?", "Things are going up!"}, "Dialouge")
					
					RunConsoleCommand("sv_gravity",PP["Server_Commands"]["sv_gravity"]/2)
					
					timer.Simple(5, function()

						RunConsoleCommand("sv_gravity",PP["Server_Commands"]["sv_gravity"])

					end )

				end,

				[6] = function()
					Platform["Travel"]["pos"] = Platform:GetPos() - Vector(0,0,50)
				end,

			}

			timer.Simple(0.1, function()

				if IsValid(Platform) then

					Platform["Lever"] = ents.Create("pp_lever")
					
					if IsValid( Platform["Lever"] ) then
						
						Platform["Lever"]:SetPos(Platform:GetPos()+Platform:GetUp()*25)
						
						local angy = Platform:GetAngles()

						Platform["Lever"]:SetAngles( Angle( 0, 0, 0 ) )
						
						Platform["Lever"]:Spawn()
						
						Platform["Lever"]:SetParent( Platform )


						Platform["Lever"].LeverPulled = function()
							table.Random(LeverFunctions)()
						end
						
						local PhysicsObject = Platform["Lever"]:GetPhysicsObject()
						
						if IsValid( PhysicsObject ) then
							
							PhysicsObject:EnableGravity( false )

						end

					end
				end

			end )
		end

	end
}