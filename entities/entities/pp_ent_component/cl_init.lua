include('shared.lua')

function ENT:DrawTranslucent()
	self:DrawModel()
	--if not self["Component_Table"]["Draw"] then return end
	--self["Component_Table"]["Draw"]( self )
end 