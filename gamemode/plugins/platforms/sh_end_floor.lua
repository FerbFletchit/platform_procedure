Platform_Manager["Types"]["End_Floor"] = {
	
	["Structure"] = "End_Floor", 
	
	["Rarity"] = 0, -- 0.1 - 1.
	
	["Material"] = "!Tile", -- Material can be set on the structure as well, but this overrides.

	["Color"] = PP["Color_Pallete"]["End_Floor"],
	
	["Size"] = "8x8x1",
	
	["Mass"] = 50000,
	
	["Life"] = 1, -- How long to get to it's end point.
	
	["Decay"] = 20, -- Decay Time.
	
	["Loot"] = false,

	["Delete_Last"] = false, -- Should the platform delete the last one.
	["Auto_Spawn_Next"] = false, -- Should it automaticall spawn the next one after time.
	["Next_Spawn"] = 0, -- How long until auto spawn next platform.


	[1] = function( Platform ) -- Everything controlled here.
		
		
		AddEffectBlock(Platform, "generic")

		Platform["Activators"] = {} -- The table containg all players touching the transport.
		Platform["Info"] = Platform["Info"] or {}
		Platform["Info"]["Reached_Destination"] = true -- This is necessary so an event doesn't happen on our first path completion.
		Platform["Activated"] = false


		Platform["PlayLoop"] = function()
			
			if IsValid( Platform ) then
				
				if not Platform:GetNW2Bool("Activated") then
					
					Platform:EmitSound("pp_sound_effects/Ticking.mp3", 55, 100, 1.1, CHAN_AUTO )
					
					timer.Simple(1, function()

						if IsValid(Platform) then

							Platform["PlayLoop"]()

						end

					end )

				end

			end

		end
		Platform["PlayLoop"]()

		for key, value in pairs( team.GetPlayers(1) ) do

			if IsValid( value ) then
				
				local Should_Emote = math.Rand(0.1, 1)

				if Should_Emote <= PP["End_Floor_ACT_Chance"] then
					
					value:ConCommand("act "..table.Random( PP["End_Floor_ACT"] ) )

				end
			end

		end

		if SERVER then

			Platform["Travel"]["maxspeed"] = 10000
			Platform["Travel"]["maxspeeddamp"] = 3000
			Platform["Travel"]["dampfactor"] = 0.5

			local WB = ents.Create("pp_workbench")
			if IsValid(WB) then
				WB:SetPos(Platform:GetPos()+
					Platform:GetUp()*35+
					Platform:GetRight()*100+
					Platform:GetForward()*200
				)
				local ang = Platform:GetAngles()
				ang:RotateAroundAxis(ang:Right(),90)

				WB:Spawn()
				WB:SetAngles(Platform:GetAngles() + Angle(90,180,0))
				WB:SetParent(Platform)
			end

			timer.Simple(0.1, function() -- Necessary.
				local WB2 = ents.Create("pp_workbench")
				if IsValid(WB2) then
					WB2:SetPos(Platform:GetPos()+
						Platform:GetUp()*35-
						Platform:GetRight()*100-
						Platform:GetForward()*100
					)

					WB2:Spawn()
					WB2:SetAngles(Platform:GetAngles() + Angle(90,0,0))
					WB2:SetParent(Platform)
				end
			end )

			local HS = ents.Create("pp_healstation")
			if IsValid(HS) then
				HS:SetPos(Platform:GetPos()+
					Platform:GetUp()*40-
					Platform:GetRight()*80
				)
				
				local ang = Platform:GetAngles() + Angle(0,0,0)

				HS:SetAngles(ang)
				HS:Spawn()
				HS:SetParent(Platform)
			end

			local Hint = ents.Create("pp_hintcube")

			if IsValid(Hint) then
				Hint:SetPos(Platform:GetPos() + Vector(
							math.random(-200,200),
							math.random(-200,200),
							math.random(30,60)
					)
				)

				Hint:SetParent(Platform)

				Hint:Spawn()

				Hint["Hints"] = PP["Hints"]
				Hint["Delay"] = 3
			end

		end

		function Platform:StartTouch( ent ) -- When the player touches the platform.
			if IsValid(ent) and ent:IsPlayer() then -- Verifying. 				
				if not self["Activators"] then return end				
				if not table.HasValue(self["Activators"], ent) then -- Making sure they aren't already an activator.
					
					table.insert(self["Activators"], ent ) -- Add the player.
					self:PlayerJoinTransport( ent )

					if tonumber( table.Count(self["Activators"]) / math.Round(#team.GetPlayers(1) * PP["TransportPercentage"] ) ) >= PP["TransportPercentage"] then -- If there are enough players.						
						if self:GetNW2Bool("Activated") then return end
						self:Activated()
					end

				end

			end
		end

		function Platform:EndTouch( ent )
			timer.Simple(0, function()
				if IsValid(self) and IsValid(ent) and ent:IsPlayer() and self["Activators"] then
					if table.HasValue(self["Activators"], ent) then
						table.RemoveByValue(self["Activators"], ent )
						self:PlayerLeaveTransport( ent )
					end
				end
			end )
		end 

		function Platform:PlayerJoinTransport( ent )
			self:SetNW2Int("Activators", self:GetNW2Int("Activators") + 1)
		end

		function Platform:PlayerLeaveTransport( ent )
			self:SetNW2Int("Activators", self:GetNW2Int("Activators") - 1)
		end
		
		function Platform:Activated() -- Once all players are on the platform.

			PP_RemoveAllOtherPlatforms( Platform, 5 )
			PP_ClearMobs()

			local Travel_Time = math.Clamp(PP["End_Platform_Time_Min"] + #team.GetPlayers(1)*PP["End_Platform_SecsPerPly"], 
				PP["End_Platform_Time_Min"], 
				PP["End_Platform_Time_Max"]
			)
			
			self:SetNW2Bool("Activated", true)
			
			Platform["Info"]["Reached_Destination"] = true

			if SERVER then

				PP_RemoveAllOtherPlatforms( Platform, 5 )

				Platform["UpArrow"] = ents.Create("pp_goingup")
				
				if IsValid( Platform["UpArrow"] ) then
					Platform["UpArrow"]:SetPos(self:GetPos()+self:GetUp()*50)
					Platform["UpArrow"]:Spawn()
					Platform["UpArrow"]:SetParent( Platform )
				end

				timer.Simple( Travel_Time + 3, function()
					if IsValid( Platform["UpArrow"] ) then
						Platform["UpArrow"]:SetArrived(true)
					end
				end )

			end
			
			self["Travel"]["secondstoarrive"] = Travel_Time
			
			self["Travel"]["maxspeeddamp"] = 500
			
			self["Travel"]["dampfactor"] = 0.7
			
			self["Travel"]["maxspeed"] = 500
			
			self["Travel"]["pos"] = self:GetPos() + Vector(0,0,600)

			timer.Simple((Travel_Time+5), function()
				if IsValid( self ) then
					self["Callback"]( self )
					self["Travel"]["pos"] = self:GetPos() + Vector(0,0,500)
				end

				timer.Simple(5, function()
					if IsValid(Platform) then
						Platform:StartDecay((PP["End_Platform_Decay"]))
					end

				end )
			end )
			
			--PP_GotoNextRoutePoint() -- This is IMPORTANT to put after any platform spawn that is going to the next route point.
			-- This isn't automatically used because some platform types don't go to the next point. 

		end

		Platform["Callback"] = function( Platform ) -- What happens when we reach our destination.
			
			PP_RespawnAllPlayersOnPlatform( Platform )
			
			table.insert( Platform_Manager["Platforms"], Platform ) -- Ensure this is the last platform in the table.
			PP_NextGameState()

			if IsValid( Platform["UpArrow"] ) then
				Platform["UpArrow"]:EmitSound( "pp_sound_effects/Ding.mp3", 75, 100, 1, CHAN_AUTO )
			end

		end

		if SERVER then
			timer.Simple(PP["End_Platform_Waiting"], function() -- Here is the wait function, automatically activating.
				
				if IsValid(Platform) then

					if not Platform:GetNW2Bool("Activated") then

						PP_RespawnAllPlayersOnPlatform( Platform )

						Platform:Activated()
					end
				end

			end )
		end


		if CLIENT then

			function Platform:DrawTranslucent()

				self:DrawModel()

				if self:GetNW2Bool("Activated") then return end
				
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

				cam.Start3D2D(Pos , DisplayAngle, 0.1)
				
					local Display_Text = "Waiting for players ..."
				    local Display_Text2 = self:GetNW2Int("Activators") .. " / "..math.Round(#team.GetPlayers(1) * PP["TransportPercentage"] )-- This will be used for harvest display.

			        PP_DrawShadowedTxt(Display_Text,"PP_Regular",2,2,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER,PP["Color_Pallete"]["White"])
			        --PP_DrawShadowedTxt(Display_Text2,"PP_Regular",2,100,TEXT_ALIGN_CENTER,TEXT_ALIGN_BOTTOM,PP["Color_Pallete"]["White"])

			    cam.End3D2D()

			end

		end

	end
}