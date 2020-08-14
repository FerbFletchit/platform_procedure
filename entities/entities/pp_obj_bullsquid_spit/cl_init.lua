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

local Acid_particle = Material("materials/pp_assets/particle_".."acid"..math.random(1,3)..".png")

function ENT:Think()
	local particle = self.emitter:Add(Acid_particle, self:GetPos())
 	if particle then
 		particle:SetVelocity(VectorRand() *math.random(0, 200))
 		particle:SetLifeTime(0)
 		particle:SetDieTime(math.Rand(0.3, 0.5))
 		particle:SetStartAlpha(math.random(100, 255))
 		particle:SetEndAlpha(0)
 		particle:SetStartSize(10)
 		particle:SetEndSize(5)
 		particle:SetRoll(math.random(0, 360))
 		particle:SetAirResistance(400)
 		particle:SetGravity(Vector(0, 0, -200))
 	end
 	self:NextThink(CurTime()+0.2)
 	return true
end