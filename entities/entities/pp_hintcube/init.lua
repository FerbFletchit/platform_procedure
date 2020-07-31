AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
 
include('shared.lua')

function ENT:Initialize()

   self:SetMoveType(MOVETYPE_VPHYSICS)
	self:PhysicsInit(SOLID_NONE)
    self:SetUseType(SIMPLE_USE)
    self:SetSolid(SOLID_VPHYSICS)
    self:SetCollisionGroup(COLLISION_GROUP_PASSABLE_DOOR)


    self:SetAngles(Angle(-90,0,0))

    self:SetModel("models/aceofspades/weapons/muzzleflash_default.mdl")


	local PhysicsObject = self:GetPhysicsObject()

	if IsValid(PhysicsObject) then
		PhysicsObject:EnableGravity( false )
	end

	AddEffectBlock(self, "chest")
	self["trail"] = util.SpriteTrail( self, 0, PP["Color_Pallete"]["Gold"], false, 5, 1, 2, 1 / ( 15 + 1 ) * 0.5, "trails/laser" )
	self["Delay"] = 3
end

function ENT:Use(ply)

	local Hints = self["Hints"] or PP["Hints"]
	ply.NextHint = ply.NextHint or 0
	
	if CurTime() >= ply.NextHint then
		ply:SendNotification( "Hint", table.Random( Hints ) )
		
		ply.NextHint = CurTime() + self["Delay"]
	end
end

function ENT:Think()

	if IsValid( self ) then

		self:SetAngles( Angle(-90,CurTime()*10,0) )

	end

	self:NextThink(CurTime() + 0.1)

	return true

end