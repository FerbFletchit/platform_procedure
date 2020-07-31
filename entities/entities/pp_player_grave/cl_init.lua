include('shared.lua')

local Skull = Material("materials/pp_assets/skull.png")
local Skull_Size_W = 222
local Skull_Size_H = Skull_Size_W * 1.08

function ENT:DrawTranslucent()
	self:DrawModel()

	local Pos = self:GetPos()+self:GetUp()*0+self:GetForward()*5
    
    local Angle = self:GetAngles()
    Angle:RotateAroundAxis(Angle:Forward(),90)
     Angle:RotateAroundAxis(Angle:Right(),-90)

	cam.Start3D2D(Pos , Angle, 0.04*self:GetModelScale())
		
		surface.SetDrawColor( 255, 255, 255, 220 )

			surface.SetMaterial( Skull ) -- If you use Material, cache it!
			
		surface.DrawTexturedRectRotatedPoint( 0, -Skull_Size_H, Skull_Size_W, Skull_Size_H, 0, 0, 0 )

		local Display_Text = self:GetDeathString() -- Player Has Died
	    
	    local Display_Text2 = self:GetKillerName() -- From Causes

        PP_DrawShadowedTxt(Display_Text,"PP_Regular",2,2,TEXT_ALIGN_CENTER,color_white)
        
        PP_DrawShadowedTxt(Display_Text2,"PP_Regular",2,150,TEXT_ALIGN_CENTER,color_white)

    cam.End3D2D()
end 