include('shared.lua')

language.Add("obj_bullsquid_spit", "Bullsquid")
function ENT:Draw()
end

function ENT:Initialize()
	self.emitter = ParticleEmitter(self:GetPos())
end
 
function ENT:OnRemove()
	self.emitter:Finish()
end
 
function ENT:Think()
	local particle = self.emitter:Add("toxicsplat", self:GetPos())
 	if particle then
 		particle:SetVelocity(VectorRand() *math.Rand(0, 200))
 		particle:SetLifeTime(0)
 		particle:SetDieTime(math.Rand(0.3, 0.5))
 		particle:SetStartAlpha(math.Rand(100, 255))
 		particle:SetEndAlpha(0)
 		particle:SetStartSize(10)
 		particle:SetEndSize(5)
 		particle:SetRoll(math.Rand(0, 360))
 		particle:SetAirResistance(400)
 		particle:SetGravity(Vector(0, 0, -200))
 	end
end