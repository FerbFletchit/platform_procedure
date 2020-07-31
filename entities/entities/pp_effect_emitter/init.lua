AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
 
include('shared.lua')

function ENT:Initialize()
	self:SetEnabled( true ) -- PP Function for enabling effect.
    
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetCollisionGroup(COLLISION_GROUP_IN_VEHICLE)

    self:SetModel( "models/hunter/blocks/cube025x025x025.mdl" ) -- It is unseen, just for testing purpouses here.

	local PhysicsObject = self:GetPhysicsObject()
	if IsValid(PhysicsObject) then
		PhysicsObject:EnableGravity( false )
	end

	if not PP_Effects[self:GetEffect()] then
		self:Remove() -- If the effect isn't known,
	end

	self:NextThink( CurTime() + PP_Effects[self:GetEffect()]["Rate"])
end

function ENT:Think()
	if self:GetEnabled() then

	 	local effectdata = EffectData()
		effectdata:SetOrigin( self:GetPos() )
		util.Effect( "pp_"..self:GetEffect(), effectdata )

		self:NextThink( CurTime() + PP_Effects[self:GetEffect()]["Rate"])
		return true
	end
end
