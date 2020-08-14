PP_EndScreen = PP_EndScreen or {}

--net.Receive("PP_EndMenu", function(len, ply)

function PP_formatPoints(n) -- from darkrp :)
    if not n then return "0" end

    if n >= 1e14 then return tostring(n) end
    if n <= -1e14 then return "-" .. tostring(math.abs(n)) end

    local negative = n < 0

    n = tostring(math.abs(n))
    local sep = sep or ","
    local dp = string.find(n, "%.") or #n + 1

    for i = dp - 4, 1, -3 do
        n = n:sub(1, i) .. sep .. n:sub(i + 1)
    end

    return (negative and "-" or "") .. n
end

net.Receive("PP_EndMenu", function(len, ply)
	
	local GameWin = net.ReadBool()

	PP_EndScreen["Size"] = {ScrW()*0.25, ScrH()*0.25}
	
	if IsValid(PP_EndScreen["Frame"]) then

		PP_EndScreen["Frame"]:Remove()

	end

	PP_EndScreen["Time_Per_Item"] = (PP["EndGame_Duration"] / #PP_ReturnUseableStats()) * 0.8
	PP_EndScreen["Item_End_Pause"] = 0.5

	PP_EndScreen["Frame"] = vgui.Create("DFrame")
	PP_EndScreen["Frame"]:SetSize(ScrW(),ScrH())
	PP_EndScreen["Frame"]:SetPos(0,0)
	PP_EndScreen["Frame"]:SetTitle("")						-- Set the title to nothing
	
	PP_EndScreen["Frame"]:ShowCloseButton( false )
	
	PP_EndScreen["Frame"]:SetDraggable(false)				-- Makes it so you carnt drag it
	
	PP_EndScreen["Frame"]:DockPadding( 
		ScrH()*0.00, -- Left
		ScrH()*0.10, -- Top
		ScrH()*0.00, --Right
		ScrH()*0.08 -- Bottom 
	)

	PP_EndScreen["Frame"]:MakePopup()

	local EndScreenFrame = PP_EndScreen["Frame"]


	local Bonus_Number = 0
	local Start_Bonus, Old_Bonus_Number, New_Bonus_Number = 0, 0, 0

	local Stat_Number = 0
	local Stat_Name = ""
	local Start_Stat, Old_Stat_Number, New_Stat_Number = 0, 0, 0

	local EndGame_Stats = PP_ReturnUseableStats()

	local i = 0
	for key, value in pairs(PP_ReturnUseableStats()) do		
		timer.Simple((i*PP_EndScreen["Time_Per_Item"])+( PP_EndScreen["Item_End_Pause"] ), function()
			if not IsValid(PP_EndScreen["Frame"]) then return end
			Stat_Name = value[1]
			
			Stat_Number = GetGlobalInt(value[1])

			timer.Simple(0.5, function()
				LocalPlayer():EmitSound("pp_sound_effects/button.mp3", 75, 100, 1, CHAN_AUTO )
			end )
			
			timer.Simple(PP_EndScreen["Time_Per_Item"]/2, function()
				
				Stat_Name = ""
				--Stat_Number = 0
				
				Stat_Name = value[2]

				Stat_Number = GetGlobalInt(value[2])

				if Stat_Number == 0 then
					LocalPlayer():EmitSound("pp_sound_effects/horny.mp3", 75, 100, 1, CHAN_AUTO )
				else
					LocalPlayer():EmitSound("pp_sound_effects/sparkle.mp3", 75, 100, 1, CHAN_AUTO )
				end

				local points = math.Clamp(100000 * GetGlobalInt(value[2]) / GetGlobalInt(value[1]), 0, 100000)

				Bonus_Number = Bonus_Number + points
			end )

		end )

		i = i +1
	end

	local Top_Text

	if GameWin then

		Top_Text = "GAME WON!"
	else

		Top_Text = "GAME LOST"
	end

	surface.SetFont("PP_GameEndTeamBonusNumber")
	
	local Bonusmessage = Bonus_Number
	local Bonus_width,Bonus_height = surface.GetTextSize(Bonusmessage)

	surface.SetFont("PP_GameEndBig")

	local message = Top_Text
	local Top_width,Top_height = surface.GetTextSize(message)
	
	function EndScreenFrame:Paint(w,h)
		
		if PP["CurrentState"] != #PP["StateManager"]["States"] then

			self:AlphaTo(0,1,0,function() self:Close() end )

		end


		draw.RoundedBox(0,0,select(2,self:GetDockPadding())-Top_height/2-10,w,Top_height+20,PP["Color_Pallete"]["Dark"])
		draw.RoundedBox(0,0,select(2,self:GetDockPadding())-Top_height/2-5,w,Top_height+10,PP["Color_Pallete"]["Dark"])
		
		PP_DrawShadowedTxt(Top_Text,"PP_GameEndBig",w/2,select(2,self:GetDockPadding())+Top_height/2+ScreenScale(1),TEXT_ALIGN_CENTER,TEXT_ALIGN_BOTTOM,PP["Color_Pallete"]["White"])
		
		if New_Stat_Number ~= Stat_Number then

			Start_Stat = SysTime()

			New_Stat_Number = Stat_Number

		elseif SysTime() - Start_Stat > 0.5 then

			Old_Stat_Number = Stat_Number

		end
		PP_DrawShadowedTxt(Stat_Name,"PP_GameEndStatName",w/2,h/2.5,TEXT_ALIGN_CENTER,TEXT_ALIGN_BOTTOM,PP["Color_Pallete"]["White"])
		
		PP_DrawShadowedTxt(math.Round(Lerp( (SysTime() - Start_Stat) / 0.5, Old_Stat_Number, New_Stat_Number)),"PP_GameEndStatNumber",w/2,h/2,TEXT_ALIGN_CENTER,TEXT_ALIGN_TOP,PP["Color_Pallete"]["White"])

		if New_Bonus_Number ~= Bonus_Number then

			Start_Bonus = SysTime()

			New_Bonus_Number = Bonus_Number

		elseif SysTime() - Start_Bonus > 0.5 then

			Old_Bonus_Number = Bonus_Number

		end

		PP_DrawShadowedTxt("TEAM BONUS","PP_GameEndTeamBonusTitle",w/2,ScrH() - select(4,self:GetDockPadding())*1.5,TEXT_ALIGN_CENTER,TEXT_ALIGN_BOTTOM,PP["Color_Pallete"]["White"])
		
		draw.RoundedBox(0,w/2-w/4,ScrH() - select(4,self:GetDockPadding())-Bonus_height/2,w/2,100,PP["Color_Pallete"]["Dark"])
		draw.RoundedBox(0,w/2-w/4+5,ScrH() - select(4,self:GetDockPadding())-Bonus_height/2+5,w/2-10,90,PP["Color_Pallete"]["Dark_Light"])
		PP_DrawShadowedTxt(PP_formatPoints(math.Round(Lerp( (SysTime() - Start_Bonus) / 0.5, Old_Bonus_Number, New_Bonus_Number))),"PP_GameEndTeamBonusNumber",w/2,ScrH() - select(4,self:GetDockPadding())+ScreenScale(4),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER,PP["Color_Pallete"]["White"])
	end

	-- Creation -- 

end )