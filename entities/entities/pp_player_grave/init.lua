AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
 
include('shared.lua')

function ENT:Initialize()    
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetCollisionGroup(COLLISION_GROUP_IN_VEHICLE)
    self:SetColor( Color(90,90,90) )

    self:SetModel( "models/aceofspades/gameplay_objects/bluegrave.mdl" ) -- It is unseen, just for testing purpouses here.

    self:SetMaterial( "!Bridge" )

	local PhysicsObject = self:GetPhysicsObject()
	if IsValid(PhysicsObject) then
		PhysicsObject:EnableGravity( false )
	end

	self:SetPos(self:GetPos() + Vector(0,0,10))

	self:SetModelScale(0.1)
	self:SetModelScale(1, 1)

	self:SetDeathString( self:GetDeathString() or "Player Has Died")
	self:SetKillerName( self:GetKillerName() or "From Unknown Causes")

	AddEffectBlock(self, "chest")

	timer.Simple(10, function() 

		if IsValid( self ) then

			PP_ActionEffect(self, "pp_generic", 1)

			self:Remove()
		end

	end )

end

