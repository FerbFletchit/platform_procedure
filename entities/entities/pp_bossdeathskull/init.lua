AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
 
include('shared.lua')

function ENT:Initialize()    
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetCollisionGroup(COLLISION_GROUP_IN_VEHICLE)

    self:SetModel( "models/hunter/blocks/cube025x025x025.mdl" ) -- It is unseen, just for testing purpouses here.

	local PhysicsObject = self:GetPhysicsObject()
	if IsValid(PhysicsObject) then
		PhysicsObject:EnableGravity( false )
	end

	self:SetPos( self:GetPos() + Vector(0,0,50) )

	self:SetDeathString( self:GetDeathString() or "???")
	self:SetKillerName( self:GetKillerName() or "???")

	timer.Simple(60, function() 
		if IsValid( self ) then
			self:Remove() -- Removing the skull after ten seconds.
		end
	end )

end

