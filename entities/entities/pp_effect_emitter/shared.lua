AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_entity"
ENT.RenderGroup = RENDERGROUP_TRANSLUCENT

ENT.PrintName = "Platform Procedure: Effect Emitter"
ENT.Category = "Platform Procedure"

ENT.Spawnable = false
ENT.AdminOnly = true

function ENT:SetupDataTables()
	self:NetworkVar( "String", 1, "Effect" )
	self:NetworkVar( "Bool", 1, "Enabled" )
end