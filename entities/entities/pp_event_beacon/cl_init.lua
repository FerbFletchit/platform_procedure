include('shared.lua')

--[[
local Laser = Material( "cable/redlaser" )
 
function ENT:Draw()
 
	self:DrawModel() 
 
	local Vector1 = self:LocalToWorld( Vector( 0, 0, -200 ) )
	local Vector2 = self:LocalToWorld( Vector( 0, 0, 200 ) )
 
	render.SetMaterial( Laser )
	render.DrawBeam( Vector1, Vector2, 5, 1, 1, Color( 255, 255, 255, 255 ) ) 
 
end 
]]

CreateMaterial("PP_Beacon", "VertexLitGeneric", {
  	["$basetexture"] = "models/shiny",
  	["$color2"] = "[ 255 0 0 ]",
} )

local BeaconMat = Material("!PP_Beacon")
local Beancon_Render_Bounds = Vector(500,500,500)
local Beancon_Render_BoundsMin = Vector(-500,-500,-500)
function ENT:DrawTranslucent()
	self:SetRenderBounds( Beancon_Render_Bounds, Beancon_Render_BoundsMin )
	self:DrawModel()

	if self:GetNW2Bool("Beacon_Activated") then

		render.StartBeam( 1 )

			render.SetMaterial( BeaconMat )

			render.DrawBeam( 
				self:GetPos(), 
				self:GetPos()*self:GetUp()*1000, 
				5, 
				0, 0, 
				Color( 255, 0, 0 ) 
			)

		render.EndBeam()
	end
end 