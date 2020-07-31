AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_entity"
ENT.RenderGroup = RENDERGROUP_TRANSLUCENT

ENT.PrintName = "Platform Procedure: Beacon"
ENT.Category = "Platform Procedure"

ENT.Spawnable = false
ENT.AdminOnly = true

function ENT:SetupDataTables()
	self:NetworkVar( "String", 1, "ID" )
end

ENT["Build_Components"] = {
	[1] = {
		"Becaon_Base",
		"1x1x05",
		function(Base)
			return Base:GetPos() + Vector( 0, 0, 0)
		end,
		Angle(0,90,0),
		Color(72,72,72),
		"models/debug/debugwhite",
		"tile",
	},
	[2] = {
		"Becaon_Teir",
		"05x05x025",
		function(Base)
			return Base:GetPos() + Vector( -0.459, 0.935, 18.257)
		end,
		Angle(0,0,0),
		Color(109,109,109),
		"models/debug/debugwhite",
		"tile",
	},
	[3] = {
		"Becaon_Shooter",
		"025x05x025",
		function(Base)
			return Base:GetPos() + Vector( 5.275, -6, 36.347)
		end,
		Angle(0,90,-90),
		Color(109,109,109),
		"models/debug/debugwhite",
		"tile",
	},
	[4] = {
		"Becaon_Part",
		"025x075x025",
		function(Base)
			return Base:GetPos() + Vector( 17.466, 15.269, -3.717)
		end,
		Angle(0,0,0),
		Color(109,109,109),
		"models/debug/debugwhite",
		"tile",
	},
	[5] = {
		"Becaon_Cord1",
		"025x025x025",
		function(Base)
			return Base:GetPos() + Vector( 16.219, 24.975, -11.408)
		end,
		Angle(0,0,0),
		Color(234,93,93),
		"models/debug/debugwhite",
		"tile",
	},
	[6] = {
		"Becaon_Cord2",
		"025x025x025",
		function(Base)
			return Base:GetPos() + Vector( 16.229, 36.784, -12.873)
		end,
		Angle(0,0,0),
		Color(234,93,93),
		"models/debug/debugwhite",
		"tile",
	},
	[7] = {
		"Becaon_Cord3",
		"025x025x025",
		function(Base)
			return Base:GetPos() + Vector( 16.239, 48.592, -14.558)
		end,
		Angle(0,0,0),
		Color(234,93,93),
		"models/debug/debugwhite",
		"tile",
	},


}
