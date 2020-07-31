AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
 
include('shared.lua')

function ENT:Initialize()
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetUseType(SIMPLE_USE)
    self:SetSolid(SOLID_VPHYSICS)
	self:SetCollisionGroup(COLLISION_GROUP_INTERACTIVE)
	self:PhysicsInit(SOLID_VPHYSICS)

	self:SetUseType(SIMPLE_USE )

	local PhysicsObject = self:GetPhysicsObject()
	if IsValid(PhysicsObject) then
		PhysicsObject:EnableGravity( false )
	end

	PP_ActionEffect(self, "pp_chest", 10)
end

function ENT:Use( ply )

	if not IsValid(self:GetCrafter()) then return end
	
	if self:GetCrafter() == ply and self:GetWBPos() then

		local Bench = self:GetParent()

		ply:AddInventoryItem("pp_loot_cube", self:GetModel(), self:GetColor(), self:GetMaterial())

		Bench["Player_Recipes"][ply] = self:GetParent()["Player_Recipes"][ply] or {}
		Bench["Player_Recipes"][ply][self:GetWBPos()] = 0
		Bench:UpdateWhatCraft(ply)

		ply:PP_PlaySound("sound/PP_Sound_Effects/Click.mp3", 3)

		self:Remove()
	end
end