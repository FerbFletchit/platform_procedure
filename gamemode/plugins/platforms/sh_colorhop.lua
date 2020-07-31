Platform_Manager["Types"]["Color Match Puzzle"] = {
	["Rarity"] = 0.3, -- 0.1 - 1.
	["Mass"] = 20000,
	["Life"] = 0.1, -- How long to get to it's end point.
	["Loot"] = false,
	["Size"] = "1x1x1",
	["Callback_Time"] = 5,
	["Decay"] = 20, -- Decay Time.

	["Delete_Last"] = true, -- Should the platform delete the last one.
	["Auto_Spawn_Next"] = false, -- Should it automaticall spawn the next one after time.
	["Next_Spawn"] = 0, -- How long until auto spawn next platform.

	[1] = function( Platform ) -- Everything controlled here.

		SetGlobalBool("PP_OngoingEvent", true)

		Platform["Info"] = Platform["Info"] or {}
		Platform["Callback_Time"] = 5

		Platform["Current_StartTime"] = 25 -- How long til it starts up
		
		Platform["Time_Color_Last"] = 5 -- How long does the non-solid death stage last
		Platform["Time_Solid"] = math.Clamp(#team.GetPlayers(1) * 2, 15, 40) -- how long before non-solid activates after picking new color
		Platform["Color_Rounds"] = 3

		Platform["Current_Color_Round"] = 0

		Platform["Color_Plates"] = {}

		Platform:SetCollisionGroup(COLLISION_GROUP_IN_VEHICLE)

		--Platform["Info"]["Reached_Destination"] = false -- This is necessary so the callback doesn't activate right away.

		timer.Simple((Platform["Callback_Time"] or 0), function() -- This acts a fail-safe for platform callback.
			if IsValid( Platform ) then
				if not Platform:GetNW2Bool("Activated") then
					Platform["Callback"]( Platform )
				end
			end
		end )

		if CLIENT then
			local PP_ColorBlind = {
				["$pp_colour_addr"] = 0,
				["$pp_colour_addg"] = 0,
				["$pp_colour_addb"] = 0,
				["$pp_colour_brightness"] = -0.04,
				["$pp_colour_contrast"] = 1.35,
				["$pp_colour_colour"] = 0,
				["$pp_colour_mulr"] = 0,
				["$pp_colour_mulg"] = 0,
				["$pp_colour_mulb"] = 0
			}

			local PP_Normal = {
				["$pp_colour_addr"] = 0,
				["$pp_colour_addg"] = 0,
				["$pp_colour_addb"] = 0,
				["$pp_colour_brightness"] = 0,
				["$pp_colour_contrast"] = 1,
				["$pp_colour_colour"] = 1,
				["$pp_colour_mulr"] = 0,
				["$pp_colour_mulg"] = 0,
				["$pp_colour_mulb"] = 0
			}

			hook.Add( "RenderScreenspaceEffects", "PP_Color_Blind", function()
				if LocalPlayer():GetNW2Bool("PP_Color_Blinded") then
					DrawColorModify( PP_ColorBlind )
				else

					DrawColorModify( PP_Normal )
					return false
				end
			end )
		end

		if SERVER then

			--Platform:SetNoDraw( true )

			function Platform:OnRemove()
				SetGlobalBool("PP_OngoingEvent", false)
				if IsValid( self:GetNW2Entity("PP_Blinded_Player") ) then
					self:GetNW2Entity("PP_Blinded_Player"):SetNW2Bool("PP_Color_Blinded", false)
				end
			end
			
			Platform["Reset_Colors"] = function()

				for key, value in pairs( Platform["Color_Plates"] ) do
					
					if IsValid( value[1] ) then
						value[1]:SetMaterial("")
						value[1]:SetCollisionGroup(COLLISION_GROUP_NONE)
						
					end

				end

				if Platform["Current_Color_Round"] >= Platform["Color_Rounds"] then
				
					for i=1, math.random(10,16) do
						timer.Simple((0.5*i), function()

							if IsValid( Platform ) then

								local loot_ent = ents.Create("pp_loot_cube")

								if IsValid(loot_ent) then
									loot_ent:SetPos(Platform:GetPos())
									loot_ent:SetModel( PP_SizeToModelString( table.Random( PP_Loot["Cubes"] ) ) )
									
									loot_ent:Spawn()
									loot_ent:ApplyIngotQuality()

									loot_ent:EmitSound("PP_Sound_Effects/Pop"..math.random(1,2)..".mp3",55,math.random(100,200),1,CHAN_AUTO)

									local Phys = loot_ent:GetPhysicsObject()

									if IsValid(Phys) then
										Phys:SetVelocity( ( Platform:GetUp() * 500) + ( Platform:GetForward() * math.random(-200,200) ) + ( Platform:GetRight() * math.random(-200,200) ) )
									end

								end

							end

						end )
					end

					Platform["End_ColorStage"]()
					Platform:SetNW2Vector("Current_Color", Vector(0, 0, 0))

				else

					Platform["Select_New_Color"]()

				end
			end

			Platform["Select_New_Color"] = function()
				
				Platform["Current_Color_Round"] = Platform["Current_Color_Round"] + 1
				
				Platform["New_Color"] = table.Random( Platform["Color_Plates"] )
				local coly = Platform["New_Color"][1]:GetColor()

				Platform:SetNW2Vector("Current_Color", Vector(coly.r/255, coly.g/255, coly.b/255))

				Platform:SetNWFloat("Color_Start_Time", CurTime())

				Platform:EmitSound("PP_Sound_Effects/Button2.mp3",75,100,1,CHAN_AUTO)

				-- Select player for color blind --
				if #team.GetPlayers(1) > 1 then
					local PP_Blinded_Player = PP_GetRandomAlivePlayer()

					if IsValid(PP_Blinded_Player) then
						Platform:SetNW2Entity("PP_Blinded_Player", PP_Blinded_Player)
						PP_Blinded_Player:SetNW2Bool("PP_Color_Blinded", true)
						PP_Blinded_Player:SendNotification("Dialouge", {"I'm colorblind! I need your guys' help!", "I'm color blind!", "I can't see!", "Where's the colors??!", "Everything is grey!"})
					end
				end

				timer.Simple((Platform["Time_Solid"] or 0), function()

					if IsValid(Platform) and IsValid(Platform["New_Color"][1]) then

						-- Giving sight back to blinded player  --
						if #team.GetPlayers(1) > 1 then
							local PP_Blinded_Player = Platform:GetNW2Entity("PP_Blinded_Player")
							if IsValid( PP_Blinded_Player ) then
								PP_Blinded_Player:SetNW2Bool("PP_Color_Blinded", false)
								Platform:SetNW2Entity("PP_Color_Blinded", nil)
							end
						end

						Platform:EmitSound("PP_Sound_Effects/Ticking.mp3",75,100,1,CHAN_AUTO)
						timer.Simple(1, function()
							if IsValid(Platform) then
								for key, value in pairs( Platform["Color_Plates"] ) do
									
									if IsValid( value[1] ) then

										if value[2] != Platform["New_Color"][2] then

											value[1]:EmitSound("PP_Sound_Effects/Death.mp3",65,math.random(90,110),1,CHAN_AUTO)

											PP_ActionEffect(value[1], "pp_impact", 1)

											value[1]:SetMaterial("Models/effects/vol_light001")

											value[1]:SetCollisionGroup(COLLISION_GROUP_IN_VEHICLE)

										end
									end
								end
								Platform:SetNW2Vector("Current_Color", Vector(0, 0, 0))
							end
						end )
					end

					timer.Simple((Platform["Time_Color_Last"] or 0), function()
						if IsValid(Platform) then
							Platform["Reset_Colors"]()
						end
					end )

				end )

			end

			Platform["End_ColorStage"] = function()
				Platform:SetNW2Bool("GameDone", true)
				
				SetGlobalBool("PP_OngoingEvent", false)

				PP_SpawnTheNextOrderedPlatform()

			end

			Platform["Make_Colors"] = function()

				local Number_Of_Colors = math.random(5,10)
				
				local Color_Plate_Bounds = function() return Platform:GetPos() + Vector(
					math.random(-300,300),
					math.random(-300,300),
					0
				)
				end

				for i=1, Number_Of_Colors do
					local Color_Plate = ents.Create("prop_dynamic")
					
					if IsValid(Color_Plate) then

						Color_Plate:SetModel("models/aceofspades/prefabs/caltrop.mdl")

						Color_Plate:SetPos(Color_Plate_Bounds())

						Color_Plate:SetAngles( Angle(math.random(0,180),math.random(0,180),0) )

						Color_Plate:SetParent( Platform, 1 )

						constraint.Weld( Color_Plate, Platform, 1, 1, 10000000, true, true )

						Color_Plate:SetMoveType(MOVETYPE_NONE)

						Color_Plate:SetSolid(SOLID_VPHYSICS)

						Color_Plate:Spawn()

						Color_Plate:SetColor( Color( math.random(1,255), math.random(1,255), math.random(1,255) ) )

						local PhysicsObject = Color_Plate:GetPhysicsObject()
						if IsValid( PhysicsObject ) then
							PhysicsObject:SetMass(1000)
						end

						table.insert(Platform["Color_Plates"], {Color_Plate, Color_Plate:GetColor()})

					end

				end

			end


		end

		Platform["Callback"] = function( Platform ) -- What happens when we reach our destination.
			Platform["Info"]["Reached_Destination"] = true
			Platform:SetNW2Bool("Activated", true)

			if SERVER then

				PP_RemoveAllOtherPlatforms( Platform, 10 )

				Platform["Make_Colors"]()

				BroadcastNotification({"Better pick the right color!", "Picking the right color is key!"}, "Dialouge")
				
				timer.Simple(Platform["Current_StartTime"], function()

					if IsValid( Platform ) then

						Platform["Select_New_Color"]()

					end

				end )

			end

		end

		if CLIENT then

			function Platform:DrawTranslucent()

				--self:DrawModel()

				if self:GetNW2Bool("GameDone") then return end

				local Pos = nil
	    		
	    		if not Pos then

			   		local Bound_Origin_Min, Bound_Origin_Max = self:GetModelBounds()
			    	Pos = self:GetPos()+Vector(0,0,Bound_Origin_Max[3]+80) -- Adjusting vertical postiioning of display.

			    end
			    
			    local Eye_Position = EyePos()
			    local Normalized_Angle = Angle(0,0,0):Up()

			    local Altered_Eye_Position = Eye_Position - Pos
			    local Altered_Eye_PositionOnPlane = Altered_Eye_Position - Normalized_Angle * Altered_Eye_Position:Dot(Normalized_Angle)
			    local DisplayAngle = Altered_Eye_PositionOnPlane:AngleEx(Normalized_Angle)

			    DisplayAngle:RotateAroundAxis(DisplayAngle:Up(), 90)
			    DisplayAngle:RotateAroundAxis(DisplayAngle:Forward(), 90)

			    local PP_Blinded_Player = Platform:GetNW2Entity("PP_Blinded_Player")

			    local ColGame_Txt = ""
				if IsValid(PP_Blinded_Player) then
					ColGame_Txt = (PP_Blinded_Player:Nick() or "???").." has been color blinded!"
				end

				cam.Start3D2D(Pos , DisplayAngle, 0.2)
					draw.SimpleText(ColGame_Txt,"PP_GameEndBig",0,-200,PP["Color_Pallete"]["White"],TEXT_ALIGN_CENTER,TEXT_ALIGN_BOTTOM)
					draw.RoundedBox(0,-100,-100,200,200,PP["Color_Pallete"]["Dark"])

					draw.RoundedBox(0,-90,-90,180,180,self:GetNW2Vector("Current_Color"):ToColor())
			    cam.End3D2D()

			end

		end
	end
}