AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_entity"
ENT.RenderGroup = RENDERGROUP_TRANSLUCENT

ENT.PrintName = "Platform Procedure: Pullable Lever"
ENT.Category = "Platform Procedure"

ENT.Spawnable = false
ENT.AdminOnly = true

function ENT:SetupDataTables()
	self:NetworkVar( "String", 1, "ID" )
end

ENT["Build_Components"] = {

	[1] = {
		"Lever_Base",
		"075x1x025",
		function(Base)
			return Base:GetPos() + Vector( 0, 0, 0)
		end,
		Angle(0,135,0),
		Color(72,72,72),
		"models/debug/debugwhite",
		"tile",
	},

	[2] = {
		"Lever_Cover",
		"05x075x025",
		function(Base)
			return Base:GetPos() + Vector( 0.823, 0.699, 0.857)
		end,
		Angle(0,90,0),
		Color(127,111,63),
		"models/debug/debugwhite",
		"tile",
	},

	[3] = {
		"Lever_Handle",
		"025x075x025",
		function(Base)
			return Base:GetPos() + Vector( 0, -8, -5)
		end,
		Angle(45,180,-90),
		Color(72,72,72),
		"models/debug/debugwhite",
		"tile",
		["Initialize"] = function( self )
			self["Pulled"] = false
		end,

		["Use"] = function(self, ply)

			if self["Pulled"] then
				return
			end

			self["Pulled"] = true

			local anry = self:GetAngles()
			anry:RotateAroundAxis(anry:Up(),-90)

			self:SetAngles( anry )
			self:SetPos( self:GetPos() + self:GetForward()*20 - self:GetRight()*10 )

			self:EmitSound("buttons/lever6.wav",75,math.random(100,130),1,CHAN_AUTO)
			
			PauseEffects(self:GetParent())

			self:GetParent():LeverPulled()

			PP_StatsAdd( "Levers Pulled", 1 )
		end
	},

}
