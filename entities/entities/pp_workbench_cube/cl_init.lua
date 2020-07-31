include('shared.lua')

function ENT:DrawTranslucent()

	if not IsValid(self:GetCrafter()) then return end
	
	if LocalPlayer() == self:GetCrafter() then
		self:DrawModel()
	end
	
end 