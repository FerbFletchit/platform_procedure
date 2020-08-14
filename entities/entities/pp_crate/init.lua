AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
 
include('shared.lua')

function ENT:Initialize()
	PP_LoadEntityModel( self )
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetUseType(SIMPLE_USE)
    self:SetSolid(SOLID_VPHYSICS)
    self:SetCollisionGroup(COLLISION_GROUP_INTERACTIVE)
    self:PhysicsInit(SOLID_VPHYSICS)
	--self:PhysWake()

	self:SetPos(self:GetPos()+self:GetUp()*50)
	self:DropToFloor()

	local PhysicsObject = self:GetPhysicsObject()
	if IsValid(PhysicsObject) then
		PhysicsObject:EnableGravity( false )
	end

	self:SetHealth(3)
end

function ENT:Use( ply )
end

function ENT:OnTakeDamage( dmginfo  )
	self:SetHealth( self:Health() - 1 )
	if self:Health() <= 0 then
		self:Remove()
	end
end

function ENT:OnRemove()
	for i=1, PP["Chest_Loot_Amount"]() do
		local loot_ent = ents.Create(PP_Loot_Random()["Entity"])
		loot_ent:SetPos(self:GetPos()+self:GetForward()*2-self:GetUp()*6)
		loot_ent:SetModel(PP_SizeToModelString( "025x025x025" ))
		loot_ent:Spawn()
		loot_ent:SetCollisionGroup(COLLISION_GROUP_DEBRIS)

		local Phys = loot_ent:GetPhysicsObject()
		Phys:SetVelocity( ( self:GetUp() * 250) + ( self:GetForward() * math.random(-200,200) ) + ( self:GetRight() * math.random(-300,300) ) )
	end
end
