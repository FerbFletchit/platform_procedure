AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_entity"
ENT.RenderGroup = RENDERGROUP_TRANSLUCENT

ENT.PrintName = "Platform Procedure: Tower"
ENT.Category = "Platform Procedure"

ENT.Spawnable = false
ENT.AdminOnly = true

function ENT:SetupDataTables()
	self:NetworkVar( "String", 1, "ID" )
end

ENT["Build_Components"] = {
	[1] = {
		"Tower_3",
		"1x8x1",
		function(Base)
			return Base:GetPos() + Vector( 0, 0, 0)
		end,
		Angle(0,180,90),
		Color(109,109,109),
		"models/debug/debugwhite",
		"tile",
	},
	[2] = {
		"Tower_2",
		"1x6x1",
		function(Base)
			return Base:GetPos() + Vector( 47.878, -18.327, -47.427)
		end,
		Angle(0,270,0),
		Color(109,109,109),
		"models/debug/debugwhite",
		"tile",
	},
	[3] = {
		"Tower_1",
		"1x4x1",
		function(Base)
			return Base:GetPos() + Vector( 17.126, 34.225, -94.689)
		end,
		Angle(0,269,0),
		Color(109,109,109),
		"models/debug/debugwhite",
		"tile",
	},
	[4] = {
		"",
		"1x1x025",
		function(Base)
			return Base:GetPos() + Vector( 16.94, 34.748, 5.699)
		end,
		Angle(0,90,90),
		Color(72,72,72),
		"models/debug/debugwhite",
		"tile",
	},
	[5] = {
		"",
		"1x1x025",
		function(Base)
			return Base:GetPos() + Vector( 47.892, -18.387, 101.1)
		end,
		Angle(0,90,90),
		Color(72,72,72),
		"models/debug/debugwhite",
		"tile",
	},
	[6] = {
		"",
		"1x1x025",
		function(Base)
			return Base:GetPos() + Vector( -0.303, -0.128, 193.073)
		end,
		Angle(0,90,90),
		Color(72,72,72),
		"models/debug/debugwhite",
		"tile",
	},
	[7] = {
		"Tower_PointBranch",
		"025x075x025",
		function(Base)
			return Base:GetPos() + Vector( -9.196, -0.841, 230)
		end,
		Angle(0,315,180),
		Color(127,111,63),
		"models/debug/debugwhite",
		"tile",
	},
	[8] = {
		"Tower_Point",
		"025x025x025",
		function(Base)
			return Base:GetPos() + Vector( -0.661, -1.24, 252.863)
		end,
		Angle(0,113,90),
		Color(255,223,127),
		"models/debug/debugwhite",
		"tile",
	},
	[9] = {
		"",
		"025x1x025",
		function(Base)
			return Base:GetPos() + Vector( 27.7, -18.333, -40.929)
		end,
		Angle(0,90,180),
		Color(72,72,72),
		"models/debug/debugwhite",
		"tile",
	},
	[10] = {
		"",
		"05x075x025",
		function(Base)
			return Base:GetPos() + Vector( -21.421, 0.623, 36.909)
		end,
		Angle(0,90,180),
		Color(145,145,145),
		"models/debug/debugwhite",
		"tile",
	},
	[11] = {
		"",
		"05x075x025",
		function(Base)
			return Base:GetPos() + Vector( 51.465, -39.627, -123.604)
		end,
		Angle(0,360,180),
		Color(145,145,145),
		"models/debug/debugwhite",
		"tile",
	},
	[12] = {
		"",
		"05x05x025",
		function(Base)
			return Base:GetPos() + Vector( 17.074, 56.075, -26.676)
		end,
		Angle(-90,270,-90),
		Color(145,145,145),
		"models/debug/debugwhite",
		"tile",
	},
	[13] = {
		"",
		"05x05x025",
		function(Base)
			return Base:GetPos() + Vector( 69.253, -20.678, 65.792)
		end,
		Angle(-90,0,-90),
		Color(145,145,145),
		"models/debug/debugwhite",
		"tile",
	},


}
