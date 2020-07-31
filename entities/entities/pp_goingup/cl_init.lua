include('shared.lua')

local Up_Arrow = Material("materials/pp_assets/up_arrow.png")
local Up_Arrow_Size_W = ScreenScale( 322 )
local Up_Arrow_Size_H = Up_Arrow_Size_W * 1.43

local GU_Display_Text = "GOING UP"
local GU_Display_Text2 = "Floor: 0"


surface.SetFont("PP_GoingUp1")
local GU_Text_H = select(2, surface.GetTextSize(GU_Display_Text) )


local Up_Render_Bounds = Vector(500,500,500)
local Up_Render_BoundsMin = Vector(-500,-500,-500)
function ENT:DrawTranslucent()
	self:SetRenderBounds( Up_Render_Bounds, Up_Render_BoundsMin )

	local Pos = self:GetPos()
    
    local Eye_Position = EyePos()
    local Normalized_Angle = Angle(0,0,0):Up()

    local Altered_Eye_Position = Eye_Position - Pos
    local Altered_Eye_PositionOnPlane = Altered_Eye_Position - Normalized_Angle * Altered_Eye_Position:Dot(Normalized_Angle)
    local DisplayAngle = Altered_Eye_PositionOnPlane:AngleEx(Normalized_Angle)

    DisplayAngle:RotateAroundAxis(DisplayAngle:Up(), 90)
    DisplayAngle:RotateAroundAxis(DisplayAngle:Forward(), 90)

    local Display_Text = "GOING UP"
	    
	local Display_Text2 = "Floor "..tostring( PP["CurrentState"] - 1 )

	cam.Start3D2D(Pos , DisplayAngle, 0.1)


	    if not self:GetArrived() then
	    	surface.SetDrawColor( 255, 255, 255, 200 )

			surface.SetMaterial( Up_Arrow ) -- If you use Material, cache it!
			
			surface.DrawTexturedRectRotatedPoint( 0, -Up_Arrow_Size_H/2-GU_Text_H+math.sin(CurTime()*8)%100, Up_Arrow_Size_W, Up_Arrow_Size_H, 0, 0, 0 )

			PP_DrawShadowedTxt(Display_Text,"PP_GoingUp1",0,0,TEXT_ALIGN_CENTER,TEXT_ALIGN_TOP,PP["Color_Pallete"]["White"])
	   	 	PP_DrawShadowedTxt(Display_Text2,"PP_GoingUp1",0,GU_Text_H+5,TEXT_ALIGN_CENTER,TEXT_ALIGN_TOP,PP["Color_Pallete"]["White"])

	   
	   	else
	   		PP_DrawShadowedTxt("Welcome To Floor "..tostring( PP["CurrentState"] - 1 ),"PP_GoingUp1",0,GU_Text_H+5,TEXT_ALIGN_CENTER,TEXT_ALIGN_TOP,PP["Color_Pallete"]["White"])
	   	end
        
    cam.End3D2D()
end 