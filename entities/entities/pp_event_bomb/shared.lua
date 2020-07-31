AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_entity"
ENT.RenderGroup = RENDERGROUP_TRANSLUCENT

ENT.PrintName = "Platform Procedure: Bomb Defusal"
ENT.Category = "Platform Procedure"

ENT.Spawnable = false
ENT.AdminOnly = true

function ENT:SetupDataTables()
	self:NetworkVar( "String", 1, "ID" )
end

ENT["Build_Components"] = {
	[1] = {
		"Bomb_Base",
		"075x075x075",
		function(Base)
			return Base:GetPos() + Vector( 0, 0, 0)
		end,
		Angle(0,-180,0),
		Color(72,72,72),
		"models/debug/debugwhite",
		"tile",
	},

	[2] = {
		"Bomb_Stand",
		"05x05x025",
		function(Base)
			return Base:GetPos() + Vector( 0.048, -0.299, 15)
		end,
		Angle(0,0,0),
		Color(145,145,145),
		"models/debug/debugwhite",
		"tile",
		["Use"] = function( self, ply )
			self:GetParent():BombStartDefusing( ply )
		end
	},

}
