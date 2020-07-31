AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
 
include('shared.lua')

function ENT:Initialize()
	
	self:SetModel( PP["Recipe_Model"] )

	self:SetMaterial( PP["Default_Material"] )

	self:SetColor(PP["Color_Pallete"]["Recipe"])

	self:SetUseType(SIMPLE_USE)
	
	self:SetCollisionGroup(COLLISION_GROUP_NONE)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:PhysicsInit(SOLID_VPHYSICS)
    self:SetUseType(SIMPLE_USE)
    self:SetSolid(SOLID_VPHYSICS)
    
	self:PhysWake()

	self:SetGravity(math.Rand(1,3)) -- Lets them act a bit differently from each other.

end

function ENT:Use( ply )
	self:Remove()
	ply:SendNotification("Game", "New recipe learned!")
	ply:GiveRandomRecipe()
end

function ENT:OnRemove()
	--self:EmitSound(PP["Sound_Loot_Block_Pickup"], 75, 100, 0.3, CHAN_ITEM)
end