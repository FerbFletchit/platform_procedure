AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
 
include('shared.lua')

function ENT:Initialize()
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetCollisionGroup(SOLID_VPHYSICS)
	self:PhysWake()

	local PhysicsObj = self:GetPhysicsObject()
	if IsValid(PhysicsObj) then
		PhysicsObj:EnableGravity( false )
		PhysicsObj:SetMass(1)
	end
end

function ENT:StartDecay(Time)
	self:SetCollisionGroup(COLLISION_GROUP_IN_VEHICLE)
	self:SetRenderFX(PP["Decay_Effect"])
	
	timer.Simple(Time, function()
		if IsValid(self) then
			self:Remove()
		end
	end )
end
