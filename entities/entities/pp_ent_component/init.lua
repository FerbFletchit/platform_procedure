AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
 
include('shared.lua')

function ENT:Initialize()
	self:SetCollisionGroup(COLLISION_GROUP_INTERACTIVE)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)

	local Parent = self:GetParent()
	
	if not IsValid(Parent) then
		self:Remove()
		print("[Platform Procedure] Parent could not be found while building entity components, removing!")
		return
	end

	local Component = self["Component_Table"] -- Entity's own build information.
	
	if not Component then 
		self:Remove()
	end
	
	self["Build_Components"] = Parent["Build_Components"] -- List of all components in the entity structure.

	self:SetID(Component[1])
	self:SetModel( PP_SizeToModelString( Component[2] ) )
	self:SetPos(Component[3](Parent))
	self:SetAngles(Component[4] - Parent:GetAngles())
	self:SetRenderMode(1) -- Supports Transparency.
	self:SetColor(Component[5])
	self:SetMaterial(Component[6] or PP["Default_Material"])

	local PhysicsObject = Parent:GetPhysicsObject()
	local PhysicsObject2 = self:GetPhysicsObject()
	
	if IsValid(PhysicsObject) and IsValid(PhysicsObject2) then
		PhysicsObject2:EnableGravity( false )
		PhysicsObject2:SetMass(PhysicsObject:GetMass())
		PhysicsObject:SetMaterial(Component[7])
	end

	if not self["Component_Table"]["Initialize"] then return end
	self["Component_Table"]["Initialize"]( self )

	self:SetUseType(SIMPLE_USE)
end

--[[function ENT:Think()
	if not self["Component_Table"]["Think"] then 
		self:NextThink(CurTime()-1)
		return true 
	else
		self["Component_Table"]["Think"]( self )
	end
end]]

function ENT:Use( ply )
	--if not IsValid(ply) and ply:IsPlayer() then return end
	if not self["Component_Table"]["Use"] then return end

	ply[self:GetCreationID().."_Cooldown"] = ply[self:GetCreationID().."_Cooldown"] or false
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

	self["Component_Table"]["Use"]( self, ply )
end

function ENT:StartTouch( ply )
	if not self["Component_Table"]["StartTouch"] then return end
	if not IsValid(ply) and ply:IsPlayer() then return end
	self["Component_Table"]["StartTouch"]( self, ply )
end