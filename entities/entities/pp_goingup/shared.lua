AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_entity"
ENT.RenderGroup = RENDERGROUP_TRANSLUCENT

ENT.PrintName = "Platform Procedure: UpArrow"
ENT.Category = "Platform Procedure"

ENT.Spawnable = false
ENT.AdminOnly = true

function ENT:SetupDataTables()
	self:NetworkVar( "Bool", 1, "Arrived" )
	--self:NetworkVar( "String", 2, "KillerName" )
end