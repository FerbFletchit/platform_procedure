AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_entity"
ENT.RenderGroup = RENDERGROUP_TRANSLUCENT

ENT.PrintName = "Platform Procedure: DeathSkull"
ENT.Category = "Platform Procedure"

ENT.Spawnable = false
ENT.AdminOnly = true

function ENT:SetupDataTables()
	self:NetworkVar( "String", 1, "DeathString" )
	self:NetworkVar( "String", 2, "KillerName" )
end