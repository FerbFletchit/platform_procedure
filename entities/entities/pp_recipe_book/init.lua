AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
 
include('shared.lua')

function ENT:Initialize()
	
	self:SetModel( PP["Recipe_Book_Model"] )

	self:SetMaterial( PP["Default_Material"] )

	self:SetColor( PP["Color_Pallete"]["Recipe_Book"] )

	self:SetUseType(SIMPLE_USE)
	
	self:SetCollisionGroup(COLLISION_GROUP_NONE)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:PhysicsInit(SOLID_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    
	self:PhysWake()

	local PhysicsObject = self:GetPhysicsObject()
	if IsValid(PhysicsObject) then
		PhysicsObject:EnableGravity( false )
	end

	self:SetUseType(SIMPLE_USE)

end

function ENT:Use( ply )
	ply[self:GetCreationID().."_Cooldown"] = ply[self:GetCreationID().."_Cooldown"] or false -- Because simple use wasn't working?
	if ply[self:GetCreationID().."_Cooldown"] then
		return
	else
		ply[self:GetCreationID().."_Cooldown"] = true
		timer.Simple(1, function()
			if IsValid( ply ) and IsValid( self ) then
				ply[self:GetCreationID().."_Cooldown"] = false
			end
		end )
	end
	
	--if IsValid(self) then
		ply:OpenRecipeBook()
	--end
end