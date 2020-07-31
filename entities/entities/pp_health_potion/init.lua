AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
 
include('shared.lua')

function ENT:Initialize()
	
	self:SetModel( "models/aceofspades/custom_objects/bottle.mdl" )

	self:SetMaterial( "models/shiny" or PP["Default_Material"] )
	self:SetUseType(SIMPLE_USE)
	
	self:SetCollisionGroup(COLLISION_GROUP_NONE)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:PhysicsInit(SOLID_VPHYSICS)
    self:SetUseType(SIMPLE_USE)
    self:SetSolid(SOLID_VPHYSICS)
    
	self:PhysWake()

	timer.Simple(PP["Loot_Cube_RemoveTime"], function() -- I'll leave this for auto removing, even though not loot cube.
		if IsValid(self) then
			self:Remove()
		end
	end )
end

function ENT:Use( ply )
	ply:AddInventoryItem("pp_special_healgulp", "models/aceofspades/custom_objects/bottle.mdl", self:GetColor(), self:GetMaterial())
end

function ENT:OnRemove()
	if IsValid( self ) then
		PP_ActionEffect(self, "pp_impact", 1)
		self:EmitSound("pp_sound_effects/horny.mp3",50,80,1,CHAN_AUTO)
	end
end