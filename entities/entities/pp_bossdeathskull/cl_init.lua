include('shared.lua')

local Skull = Material("materials/pp_assets/skull.png")
local Skull_Size_W = 422
local Skull_Size_H = Skull_Size_W * 1.08

function ENT:DrawTranslucent()
	--self:DrawModel()
	local Pos = self:GetPos()
    
    local Eye_Position = EyePos()
    local Normalized_Angle = Angle(0,0,0):Up()

    local Altered_Eye_Position = Eye_Position - Pos
    local Altered_Eye_PositionOnPlane = Altered_Eye_Position - Normalized_Angle * Altered_Eye_Position:Dot(Normalized_Angle)
    local DisplayAngle = Altered_Eye_PositionOnPlane:AngleEx(Normalized_Angle)

    DisplayAngle:RotateAroundAxis(DisplayAngle:Up(), 90)
    DisplayAngle:RotateAroundAxis(DisplayAngle:Forward(), 90)

	cam.Start3D2D(Pos , DisplayAngle, 0.5)
		
			surface.SetDrawColor( 255, 255, 255, 200 )

			surface.SetMaterial( Skull ) -- If you use Material, cache it!
			
			surface.DrawTexturedRectRotatedPoint( 0, -Skull_Size_H+math.sin(CurTime()*8)%100, Skull_Size_W, Skull_Size_H, 0, 0, 0 )

		local Display_Text = self:GetDeathString() --"LVL. 99 BAT SLAIN BY" -- Creating a main title with our plant name.
	    
	    local Display_Text2 = self:GetKillerName() --"THE NOODLER"

        PP_DrawShadowedTxt(Display_Text,"PP_Regular",2,2,TEXT_ALIGN_CENTER,color_white)
        
        PP_DrawShadowedTxt(Display_Text2,"PP_Regular",2,84,TEXT_ALIGN_CENTER,color_white)

    cam.End3D2D()
end 