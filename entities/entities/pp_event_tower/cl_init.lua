include('shared.lua')


function ENT:DrawTranslucent()
	self:DrawModel()

	local Pos = self:GetPos()+Vector(0,0,300)
    
    local Eye_Position = EyePos()
    local Normalized_Angle = Angle(0,0,0):Up()

    local Altered_Eye_Position = Eye_Position - Pos
    local Altered_Eye_PositionOnPlane = Altered_Eye_Position - Normalized_Angle * Altered_Eye_Position:Dot(Normalized_Angle)
    local DisplayAngle = Altered_Eye_PositionOnPlane:AngleEx(Normalized_Angle)

    DisplayAngle:RotateAroundAxis(DisplayAngle:Up(), 90)
    DisplayAngle:RotateAroundAxis(DisplayAngle:Forward(), 90)
    
    local Display_Text 
    local Display_Text2
    if self:GetNW2Bool("Tower_Saved") then
        Display_Text = "TOWER SAVED" --"LVL. 99 BAT SLAIN BY" -- Creating a main title with our plant name.
    
        Display_Text2 = ""
    else
        Display_Text = "DEFEND THE TOWER!" --"LVL. 99 BAT SLAIN BY" -- Creating a main title with our plant name.
    
        local TimeLeft = math.Round(PP["Tower_Round_Length"] - (CurTime() - self:GetNW2Int("Start_Time") ) )
        Display_Text2 = TimeLeft.." Seconds Remaining" 
    end

	cam.Start3D2D(Pos , DisplayAngle, 0.2)
		
        PP_DrawShadowedTxt(Display_Text,"PP_Regular",2,-50,TEXT_ALIGN_CENTER,TEXT_ALIGN_BOTTOM,color_white)
        
        PP_DrawShadowedTxt(Display_Text2,"PP_Regular",2,100,TEXT_ALIGN_CENTER,TEXT_ALIGN_TOP,color_white)
        draw.RoundedBox(0,-400,0,800,92,PP["Color_Pallete"]["Dark"])
        draw.RoundedBox(0,-390,10,780,72,PP["Color_Pallete"]["Dark"])

        local Tower_HP = math.Clamp( (760)*( self:GetNW2Int("Tower_Health") / PP["Tower_HP"] ),0,760)
        draw.RoundedBox(0,-380,20,Tower_HP,52,PP["Color_Pallete"]["Tower_Health"])

    cam.End3D2D()
end 