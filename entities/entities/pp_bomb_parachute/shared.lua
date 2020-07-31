AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_anim"
ENT.RenderGroup = RENDERGROUP_TRANSLUCENT

ENT.PrintName = "Platform Procedure: Bomb Parachute"
ENT.Category = "Platform Procedure"

ENT.Spawnable = false
ENT.AdminOnly = true

function ENT:SetupDataTables()
	self:NetworkVar( "String", 1, "ID" )
end