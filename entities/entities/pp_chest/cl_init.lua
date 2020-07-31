include('shared.lua')

function ENT:DrawTranslucent()
	self:DrawModel()
	local Pos = nil
	if not Pos then
		Pos = self:GetPos()+self:GetAngles():Up()*12-self:GetAngles():Right()*22-self:GetAngles():Forward()*10
	end
	local Ang = self:GetAngles()

	cam.Start3D2D(Pos , Ang, 1)
		draw.RoundedBox(0,0,0,20,44,PP["Color_Pallete"]["Chest_Inside"])
		draw.RoundedBox(0,0,0,5,44,PP["Color_Pallete"]["Dark"])
    cam.End3D2D()

    

    --[[
	Though not a set rule, in art humans tend to perceive bright, warm colors like red, orange and yellow as being close, and dark, cool colors like blue and dark purple as being further away. The is particularly true for abstract art.
    ]]--
end 