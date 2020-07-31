include('shared.lua')

function ENT:DrawTranslucent()
	self:DrawModel()

	local Pos = self:GetPos()+Vector(0,0,55)
    
    local Eye_Position = EyePos()
    local Normalized_Angle = Angle(0,0,0):Up()

    local Altered_Eye_Position = Eye_Position - Pos
    local Altered_Eye_PositionOnPlane = Altered_Eye_Position - Normalized_Angle * Altered_Eye_Position:Dot(Normalized_Angle)
    local DisplayAngle = Altered_Eye_PositionOnPlane:AngleEx(Normalized_Angle)

    DisplayAngle:RotateAroundAxis(DisplayAngle:Up(), 90)
    DisplayAngle:RotateAroundAxis(DisplayAngle:Forward(), 90)
    
    local Display_Text 

    local Display_Text2

    local TimeSpent = ( CurTime() - self:GetNW2Int("Start_Time") )

	local Bar_Width = math.Clamp((760)*(TimeSpent/PP["Bomb_Round_Length"]),0,760)


    if self:GetNW2Bool("Bomb_Defused") then
        Display_Text = "BOMB DEFUSED" --"LVL. 99 BAT SLAIN BY" -- Creating a main title with our plant name.
    
        Display_Text2 = ""
    else
        if self:GetNW2String("Bomb_Defuser") == "" then
            Display_Text = "DEFUSE THE BOMB" --"LVL. 99 BAT SLAIN BY" -- Creating a main title with our plant name.
        else
            Display_Text = self:GetNW2String("Bomb_Defuser").." is defusing!"
        end
    
        local TimeLeft = math.Round(PP["Bomb_Round_Length"] - (CurTime() - self:GetNW2Int("Start_Time") ) )
        Display_Text2 = TimeLeft.." Seconds Remaining" 

    end

	cam.Start3D2D(Pos , DisplayAngle, 0.07)
		
        PP_DrawShadowedTxt(Display_Text,"PP_Regular",2,-50,TEXT_ALIGN_CENTER,TEXT_ALIGN_BOTTOM,color_white)
        if !self:GetNW2Bool("Bomb_Defused") then
	        PP_DrawShadowedTxt(Display_Text2,"PP_Regular",2,100,TEXT_ALIGN_CENTER,TEXT_ALIGN_TOP,color_white)
	        draw.RoundedBox(0,-400,0,800,92,PP["Color_Pallete"]["Dark"])
	        draw.RoundedBox(0,-390,10,780,72,PP["Color_Pallete"]["Dark"])

	      
	        draw.RoundedBox(0,-380,20,Bar_Width,52,PP["Color_Pallete"]["Bomb_Bar"])
	    end

    cam.End3D2D()

end 