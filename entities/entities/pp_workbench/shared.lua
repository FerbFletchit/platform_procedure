AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_entity"
--ENT.AutomaticFrameAdvance = true
ENT.RenderGroup = RENDERGROUP_TRANSLUCENT

ENT.PrintName = "Platform Procedure: Workbench"
ENT.Category = "Platform Procedure"

ENT.Spawnable = false
ENT.AdminOnly = true

ENT["Player_Recipes"] = {}

function ENT:SetupDataTables()
	self:NetworkVar( "String", 1, "ID" )
end

local function WB_ButtonPress( self, ply )
	self:GetParent():CreateItem(ply)	

	if not self["PushedDown"] then
		self:EmitSound("PP_Sound_Effects/Button.mp3",65, 100, 1, CHAN_AUTO)
		self["PushedDown"] = true
		self:SetPos(self:GetPos()-self:GetUp()*5)
		timer.Simple(0.5, function()
			if IsValid(self) then
				self:SetPos(self:GetPos()+self:GetUp()*5)
				self["PushedDown"] = false
			end
		end)
	end
end

ENT["Build_Components"] = {
	[1] = {
		"Mainbody",
		"075x3x1",
		function(Base)
			return Base:GetPos() + Vector( 0, 0, 0)
		end,
		Angle(90,0,180),
		Color(80, 61, 6 ),
		"models/shiny",
		"tile",
	},
	--[[[2] = {
		"Stepup",
		"025x3x025",
		function(Base)
			return Base:GetPos() + Vector( -36, -18, -12)
		end,
		Angle(90,-180,180),
		Color(72,72,72),
		"models/shiny",
		"tile",
	},]]
	[2] = {
		"Backboard",
		"1x3x025",
		function(Base)
			return Base:GetPos() + Vector( 30, 0, 12)
		end,
		Angle(0,0,0),
		Color(127,95,0),
		"models/shiny",
		"tile",
	},
	[3] = {
		"Button",
		"025x025x025",
		function(Base)
			return Base:GetPos() + Vector( -12, -59, 24)
		end,
		Angle(90,180,180),
		Color(255,223,127),
		"models/shiny",
		"tile",
		["Use"] = function(self, ply)
			WB_ButtonPress( self, ply )
		end,
	},
	[4] = {
		"SpawnPlate",
		"075x075x025",
		function(Base)
			return Base:GetPos() + Vector( 0, -29, 18)
		end,
		Angle(90,180,180),
		Color(145,145,145),
		"models/shiny",
		"tile",
		["Initialize"] = function( self )
			self:SetRenderMode(1)
			self:SetRenderFX(4)
		end
	},
	[5] = {
		"1",
		"025x025x025",
		function(Base)
			return Base:GetPos() + Vector( 12, 59, 28)
		end,
		Angle(90,-180,180),
		Color(72,72,72),
		"models/shiny",
		"tile",
		["Use"] = function(self, ply)
			BlockForBenchTime(self, ply, "025x025x025")
		end,
	},

	[6] = {
		"2",
		"025x025x025",
		function(Base)
			return Base:GetPos() + Vector( 12, 46, 28)
		end,
		Angle(90,-180,180),
		Color(72,72,72),
		"models/shiny",
		"tile",
		["Use"] = function(self, ply)
			BlockForBenchTime(self, ply, "025x025x025")
		end
	},
	[7] = {
		"3",
		"025x025x025",
		function(Base)
			return Base:GetPos() + Vector( 12, 33, 28)
		end,
		Angle(90,-180,180),
		Color(72,72,72),
		"models/shiny",
		"tile",
		["Use"] = function(self, ply)
			BlockForBenchTime(self, ply, "025x025x025")
		end
	},

	[8] = {
		"4",
		"025x025x025",
		function(Base)
			return Base:GetPos() + Vector( -1, 59, 24)
		end,
		Angle(90,-180,180),
		Color(72,72,72),
		"models/shiny",
		"tile",
		["Use"] = function(self, ply)
			BlockForBenchTime(self, ply, "025x025x025")
		end
	},
	[9] = {
		"5",
		"025x025x025",
		function(Base)
			return Base:GetPos() + Vector( -1, 46, 24)
		end,
		Angle(90,-180,180),
		Color(72,72,72),
		"models/shiny",
		"tile",
		["Use"] = function(self, ply)
			BlockForBenchTime(self, ply, "025x025x025")
		end
	},
	[10] = {
		"6",
		"025x025x025",
		function(Base)
			return Base:GetPos() + Vector( -1, 33, 24)
		end,
		Angle(90,-180,180),
		Color(72,72,72),
		"models/shiny",
		"tile",
		["Use"] = function(self, ply)
			BlockForBenchTime(self, ply, "025x025x025")
		end
	},
	[11] = {
		"7",
		"025x025x025",
		function(Base)
			return Base:GetPos() + Vector( -14, 59, 21)
		end,
		Angle(90,-180,180),
		Color(72,72,72),
		"models/shiny",
		"tile",
		["Use"] = function(self, ply)
			BlockForBenchTime(self, ply, "025x025x025")
		end
	},
	[12] = {
		"8",
		"025x025x025",
		function(Base)
			return Base:GetPos() + Vector( -14, 46, 21)
		end,
		Angle(90,-180,180),
		Color(72,72,72),
		"models/shiny",
		"tile",
		["Use"] = function(self, ply)
			BlockForBenchTime(self, ply, "025x025x025")
		end
	},
	[13] = {
		"9",
		"025x025x025",
		function(Base)
			return Base:GetPos() + Vector( -14, 33, 21)
		end,
		Angle(90,-180,180),
		Color(72,72,72),
		"models/shiny",
		"tile",
		["Use"] = function(self, ply)
			BlockForBenchTime(self, ply, "025x025x025")
		end
	},
	[14] = {
		"10",
		"025x05x025",
		function(Base)
			return Base:GetPos() + Vector( -8, 26, 15)
		end,
		Angle(90,90,180),
		Color(72,72,72),
		"models/shiny",
		"tile",
		["Use"] = function(self, ply)
			BlockForBenchTime(self, ply, "025x05x025")
		end
	},
	[15] = {
		"11",
		"025x05x025",
		function(Base)
			return Base:GetPos() + Vector( -8, 13, 15)
		end,
		Angle(90,90,180),
		Color(72,72,72),
		"models/shiny",
		"tile",
		["Use"] = function(self, ply)
			BlockForBenchTime(self, ply, "025x05x025")
		end
	},
}
