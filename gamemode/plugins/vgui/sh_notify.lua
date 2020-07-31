PP_NotifyTypes = {
	["General"] = {
		["Color"] = Color( 255, 255, 255, 255),
		["Sound"] = "",
		["Create"] = function(ply, Text, Col)
			chat.AddText(Color(255,255,255), "[ ", PP["Color_Pallete"]["Main"],"Platform Procedure", Color(255,255,255), " ] ", Color(255,255,255), Text)
		end
	},
	["Game"] = {
		["Color"] = Color( 255, 255, 255, 255),
		["Sound"] = "",
		["Create"] = function(ply, Text, Col)
			chat.AddText(Color(255,255,255), "[ ", PP["Color_Pallete"]["Main"],"Platform Procedure", Color(255,255,255), " ] ", Color(255,255,255), Text)
		end
	},


	["Game_Entered"] = {
		["Color"] = Color( 255, 255, 255, 255),
		["Sound"] = "",
		["Create"] = function(ply, Text, Col)
			
			if not Col then
				Col = PP["Color_Pallete"]["Dialouge_Text"]
			end

			local Hint_Duration = string.len(Text)*0.15

			if IsValid(PP_GameEnter) then
				PP_GameEnter:Remove()
			end

			PP_GameEnter = vgui.Create("DPanel")
			PP_GameEnter:SetAlpha(0)
			PP_GameEnter:AlphaTo( 255, 0.5, 0, function()

				if IsValid(PP_GameEnter) then

					PP_GameEnter:AlphaTo( 0, 0.2, 5, function()

						if IsValid(PP_GameEnter) then

							PP_GameEnter:Remove()
						end

					end )

				end

			end )

			PP_GameEnter["Manipulated_Text"] = ""

			timer.Create( "PP_Dialouge_Writer", 0.05, string.len(Text), function()
				PP_GameEnter["Manipulated_Text"] = string.sub( Text, 1, string.len(Text) - timer.RepsLeft("PP_Dialouge_Writer") )
				sound.Play( "PP_Sound_Effects/pp_dialouge.mp3", LocalPlayer():GetPos(), 50, math.random(100,200), 1 )
			end )

			surface.SetFont("PP_Dialouge")
			local PP_HintSize_W,PP_HintSize_H = surface.GetTextSize(Text)

			local PP_HintBox_W, PP_HintBox_H = ScrW(), PP_HintSize_H+24
			local PP_HintBox_BtmSpacing = ScrH()*0.15
			PP_GameEnter:SetSize(PP_HintBox_W+50, PP_HintBox_H)

			PP_GameEnter:SetPos(ScrW() / 2 - PP_HintBox_W / 2, ScrH()*0.35)


			function PP_GameEnter:Paint(w,h)
				PP_DrawShadowedTxt(PP_GameEnter["Manipulated_Text"],"PP_Dialouge",w/2,h/2,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER,Col) 
			end
		end
	},

	["Hint"] = {
		["Color"] = Color( 255, 255, 255, 255),
		["Sound"] = "",
		["Create"] = function(ply, Text, Col)
			sound.Play( "PP_Sound_Effects/pop"..math.random(1,2)..".mp3", LocalPlayer():GetPos(), 50, math.random(100,200), 1 )
			if not Col then
				Col = PP["Color_Pallete"]["Dialouge_Text"]
			end

			local Hint_Duration = string.len(Text)*0.15

			if IsValid(PP_HintBox) then
				PP_HintBox:Remove()
			end

			PP_HintBox = vgui.Create("DPanel")
			PP_HintBox:SetAlpha(0)
			PP_HintBox:AlphaTo( 255, 0.2, 0, function()

				if IsValid(PP_HintBox) then

					PP_HintBox:AlphaTo( 0, 0.2, Hint_Duration, function()

						if IsValid(PP_HintBox) then

							PP_HintBox:Remove()
						end

					end )

				end

			end )

			surface.SetFont("PP_Hint")
			local PP_HintSize_W,PP_HintSize_H = surface.GetTextSize(Text)

			local PP_HintBox_W, PP_HintBox_H = ScrW(), PP_HintSize_H+24
			local PP_HintBox_BtmSpacing = ScrH()*0.15
			PP_HintBox:SetSize(PP_HintBox_W+50, PP_HintBox_H)

			PP_HintBox:SetPos(ScrW() / 2 - PP_HintBox_W / 2, ScrH()*0.25)


			function PP_HintBox:Paint(w,h)
				draw.SimpleText(Text,"PP_Hint",w/2,h/2,Col,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			end
		end
	},

	["Dialouge"] = {
		["Color"] = Color( 255, 255, 255, 255),
		["Sound"] = "",
		["Create"] = function(ply, Text, Col)
			
			if not Col then
				Col = PP["Color_Pallete"]["Dialouge_Text"]
			end

			Text = '"'..Text..'"'

			local Dialouge_Duration = string.len(Text)*0.15

			if IsValid(PP_DialougeBox) then
				PP_DialougeBox:Remove()
			end

			PP_DialougeBox = vgui.Create("DPanel")
			PP_DialougeBox:SetAlpha(0)
			PP_DialougeBox:AlphaTo( 255, 0.2, 0, function()
				if IsValid(PP_DialougeBox) then
					PP_DialougeBox:AlphaTo( 0, 0.2, Dialouge_Duration, function()
						if IsValid(PP_DialougeBox) then

							if IsValid( ply ) then

								ply:SetNW2String("PP_Dialouge", "")

							end

							PP_DialougeBox:Remove()
						end
					end )
				end
			end )

			PP_DialougeBox["Manipulated_Text"] = ""

			timer.Create( "PP_Dialouge_Writer", 0.05, string.len(Text), function()
				PP_DialougeBox["Manipulated_Text"] = string.sub( Text, 1, string.len(Text) - timer.RepsLeft("PP_Dialouge_Writer") )
				
				if string.Right( PP_DialougeBox["Manipulated_Text"], 1 ) != " " then
					sound.Play( "PP_Sound_Effects/pp_dialouge.mp3", LocalPlayer():GetPos(), 50, math.random(100,200), 1 )
				end
			end )

			surface.SetFont("PP_Dialouge")
			local PP_DialougeSize_W,PP_DialougeSize_H = surface.GetTextSize(Text)

			local PP_DialougeBox_W, PP_DialougeBox_H = ScrW(), PP_DialougeSize_H+24
			local PP_DialougeBox_BtmSpacing = ScrH()*0.15
			PP_DialougeBox:SetSize(PP_DialougeBox_W+50, PP_DialougeBox_H)
			PP_DialougeBox:SetPos(ScrW() / 2 - PP_DialougeBox_W / 2, ScrH() - PP_DialougeBox_H - PP_DialougeBox_BtmSpacing)

			function PP_DialougeBox:Paint(w,h)
				draw.RoundedBox(0,0,0,w,h,PP["Color_Pallete"]["Dialouge_Box"])
				draw.SimpleText(PP_DialougeBox["Manipulated_Text"],"PP_Dialouge",w/2,h/2,Col,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			end
		end
	},
}

local Player = FindMetaTable("Player")

function BroadcastNotification(Text, Type)

	if istable(Text) then

		Text = table.Random(Text)
	end

	if SERVER then
		net.Start("PP_Notify")
			net.WriteString(Type)
			net.WriteString( Text )
			net.WriteColor( PP["Color_Pallete"]["Neutral"])
		net.Broadcast()
	end
end

function Player:SendNotification(Type, Text, Col)
	if istable(Text) then

		Text = table.Random(Text)
	end
	
	if Type == "Dialouge" then
		self.BroadcastDialougeCooldown = self.BroadcastDialougeCooldown or CurTime()
		self:SetNW2String("PP_Dialouge", '"'..Text..'"')

		timer.Simple( (PP["Dialouge_Overhead_Length"] or 3), function()

			if IsValid( self ) then

				self:SetNW2String("PP_Dialouge", "")

			end

		end)
		if CurTime() > (self.BroadcastDialougeCooldown or 0) then
			if SERVER then
				net.Start("PP_PlayerDialouge")
					net.WriteEntity(self)
					net.WriteString(Text)
				net.Broadcast()
			end
			self.BroadcastDialougeCooldown = CurTime() + 5
		end
	end

	if SERVER then
		net.Start("PP_Notify")
			net.WriteString( Type )
			net.WriteString( Text )
			net.WriteColor( PP["Color_Pallete"]["Neutral"])
		net.Send(self)

	end

end

if SERVER then

	util.AddNetworkString("PP_Notify")
	util.AddNetworkString("PP_PlayerDialouge")

end

if CLIENT then
	net.Receive("PP_PlayerDialouge", function()
		local talker = net.ReadEntity()
		local Text = net.ReadString()
		if not IsValid(talker) then return end
		if talker:IsPlayer() then
			chat.AddText(Color(255,255,255), "[ ", talker:GetPlayerColor():ToColor(),talker:Nick() or "???", Color(255,255,255), " ] ", Color(255,255,255), '"'..Text..'"')
		end
	end )
end


net.Receive("PP_Notify", function(len,ply)

	local ply = LocalPlayer()
	local Type = net.ReadString()
	local Text = net.ReadString()
	local Col = net.ReadColor()

	if not PP_NotifyTypes[Type] then
		Type = "General"
	end

	if not IsValid(ply) then return end
	
	if PP_NotifyTypes[Type] then

		if PP_NotifyTypes[Type]["Create"] then

			if PP_NotifyTypes[Type]["Sound"] then

				ply:EmitSound( PP_NotifyTypes[Type]["Sound"], 50, 100, 1, CHAN_AUTO )

			end

			
			PP_NotifyTypes[Type]["Create"]( ply, Text or "", Col )

		end

	end

end )
