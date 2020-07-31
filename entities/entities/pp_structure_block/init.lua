AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
 
include('shared.lua')

function ENT:Initialize()
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetCollisionGroup(SOLID_VPHYSICS)
	--self:PhysWake()
	--self:SetCustomCollisionCheck(true)

	local PhysicsObj = self:GetPhysicsObject()
	if IsValid(PhysicsObj) then
		PhysicsObj:EnableGravity( false )
		--PhysicsObj:SetMass(PhysicsObj:GetMass()*(0.10))
	end
end

--[[function ENT:Think()
	if self.Removing then
		if CurTime() >= self.RemoveStart + self.RemoveLength then
			self:Remove()
		end
	end
end]]

--[[function ENT:StartTouch( ply )
	if IsValid(ply) and ply:IsPlayer() then
	end
end]]

function ENT:StartDecay(Time)
	self:SetCollisionGroup(COLLISION_GROUP_IN_VEHICLE)
	self:SetRenderFX(PP["Decay_Effect"])
	--self.RemoveLength = Time
	--self.RemoveStart = CurTime()
	--self.Removing = true

	timer.Simple(Time, function()
		if IsValid(self) then
			self:Remove()
		end
	end )
end
