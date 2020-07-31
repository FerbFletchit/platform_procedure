Platform_Manager["Types"]["End_Game"] = {
		
	["Rarity"] = 0, -- 0.1 - 1.
	
	["Material"] = "models/shiny", -- Material can be set on the structure as well, but this overrides.
	
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

		function Platform:StartTouch( ent ) -- When the player touches the platform.
			if IsValid(ent) and ent:IsPlayer() then -- Verifying. 				
				if not Platform["Activators"] then return end				
				if not table.HasValue(Platform["Activators"], ent) then -- Making sure they aren't already an activator.

					table.insert(Platform["Activators"], ent ) -- Add the player.
					Platform:PlayerJoinTransport( ent )

					if tonumber( table.Count(Platform["Activators"]) / math.Round(#team.GetPlayers(1) * PP["TransportPercentage"] ) ) >= PP["TransportPercentage"] then -- If there are enough players.						
						
						--if Platform:GetNW2Bool("Activated") or Platform["Activated"] then return end

						Platform:Activated()

					end

				end

			end
		end

		function Platform:PlayerJoinTransport( ent )
			self:SetNW2Int("Activators", self:GetNW2Int("Activators") + 1)
		end

		function Platform:PlayerLeaveTransport( ent )
			self:SetNW2Int("Activators", self:GetNW2Int("Activators") - 1)
		end
		
		Platform["Callback"] = function( Platform ) -- What happens when we reach our destination.
			PP_EndGameWin()
		end

		function Platform:Activated() -- Once all players are on the platform.
			self["Callback"]()
			Platform:SetNW2Bool("Activated", true)
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