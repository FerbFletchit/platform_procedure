
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( 'shared.lua' )

function ENT:Initialize()
	timer.Simple(8,function() if IsValid(self) then self:Remove() end end)
	self:SetModel("models/hunter/blocks/cube025x025x025.mdl")
	
	self:SetMaterial("models/shiny")
	self:SetColor(Color(51,153,51))

	self:SetMoveCollide(COLLISION_GROUP_PROJECTILE)
	self:SetCollisionGroup(COLLISION_GROUP_PROJECTILE)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_CUSTOM)

	local phys = self:GetPhysicsObject()
	if IsValid(phys) then
		phys:SetMass(1)
		phys:EnableDrag(false)
		phys:SetBuoyancyRatio(0)
	end
	
	ParticleEffectAttach("stukabat_acid_trail", PATTACH_ABSORIGIN_FOLLOW, self, 0)
	--self.cspAcid = CreateSound(self, "npc/antlion/antlion_poisonball" .. math.random(1,2) .. ".wav")
	--self.cspAcid:Play()
end

function ENT:SetEntityOwner(ent)
	self:SetOwner(ent)
	self.entOwner = ent
end

function ENT:OnRemove()
	--self.cspAcid:Stop()
end

function ENT:Think()
	if IsValid(self.entOwner) && self:GetPos():Distance(self.entOwner:GetPos()) >= 8000 then self:Remove() end
end

function ENT:PhysicsCollide(data, physobj)
	if !data.HitEntity || self.bCollided then return true end
	
	self.bCollided = true
	
	local pos = self:GetPos()
	
	ParticleEffect("stukabat_acid_splash", pos, Angle(0,0,0), self)
	
	--self:EmitSound("npc/bullsquid/splat" .. math.random(1,3) .. ".wav", 75, 100)
	
	self:EmitSound("weapons/spore_launcher/splauncher_impact.wav", 100, 100)
	
	util.BlastDmg(self, IsValid(self.entOwner) && self.entOwner || self, pos, 200, (PP["ENEMY_NPC"]["pp_enemy_stukabat"]["Blast_Damage"] or 30), function(ent)
		return true--self:Disposition(ent) == D_HT
	end, DMG_ACID, true)

	timer.Simple(0.1, function() if IsValid(self) then self:Remove() end end)

	return true
end

