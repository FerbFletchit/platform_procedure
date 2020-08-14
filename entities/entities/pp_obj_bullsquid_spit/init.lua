
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( 'shared.lua' )

function ENT:Initialize()
	self:SetModel("models/weapons/w_bugbait.mdl")
	self:SetMoveCollide(COLLISION_GROUP_PROJECTILE)
	self:SetCollisionGroup(COLLISION_GROUP_PROJECTILE)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_CUSTOM)
	self:SetColor(255,255,255,0)

	local phys = self:GetPhysicsObject()
	if IsValid(phys) then
		phys:SetMass(1)
		phys:EnableDrag(false)
		phys:SetBuoyancyRatio(0)
	end
	
	self.delayRemove = CurTime() +8
end

function ENT:SetEntityOwner(ent)
	self:SetOwner(ent)
	self.entOwner = ent
end

function ENT:OnRemove()
end

function ENT:Think()
	if CurTime() < self.delayRemove then return end
	self:Remove()
end

function ENT:PhysicsCollide(data, physobj)
	PP_ActionEffect(self, "pp_acidimpact", 1)
	
	--util.Decal("BeerSplash", data.HitPos +data.HitNormal, data.HitPos -data.HitNormal)
	local ent = data.HitEntity
	if IsValid(ent) && (ent:IsPlayer() || ent:IsNPC()) then

		if !IsValid(self.entOwner) || self.entOwner:Disposition(ent) <= 2 then
			local dmg = DamageInfo()
			dmg:SetDamage( PP["ENEMY_NPC"]["pp_enemy_bullsquid"]["Spit_Damage"] )
			dmg:SetDamageType(DMG_ACID)
			dmg:SetAttacker(IsValid(self.entOwner) && self.entOwner || self)
			dmg:SetInflictor(self)
			dmg:SetDamagePosition(data.HitPos)
			ent:TakeDamageInfo(dmg)
			
			self:EmitSound("npc/bullsquid/bc_acid" .. math.random(1,2) .. ".wav", 75, 100)
		end
	end
	self:Remove()
	return true
end

