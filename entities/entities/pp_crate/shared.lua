AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_entity"
ENT.RenderGroup = RENDERGROUP_TRANSLUCENT

ENT.PrintName = "Platform Procedure: Lootable Crate"
-- Description: Players protect the tower for x seconds. 
ENT.Category = "Platform Procedure"

ENT.Spawnable = false
ENT.AdminOnly = true

function ENT:SetupDataTables()
	self:NetworkVar( "String", 1, "ID" )
end

	--Angle(0,-90,90)

function OpenCrate( self )
	local Crate = self:GetParent()

	if IsValid(Crate) and not self["Activated"] then
		
		self:SetPos(self:GetPos()-self:GetForward()*2)

		self["Activated"] = true

		for i=1, PP["Chest_Loot_Amount"]() do

			local loot_ent = ents.Create(PP_Loot_Random()["Entity"])
			loot_ent:SetPos(Crate:GetPos()+Crate:GetUp()*25)
			loot_ent:SetModel(PP_SizeToModelString( "025x025x025" ))
			loot_ent:Spawn()
			loot_ent:SetCollisionGroup(COLLISION_GROUP_NONE)

			local Phys = loot_ent:GetPhysicsObject()
			--Phys:SetVelocity( ( self:GetUp() * 100) + ( self:GetRight() * math.random(-200,200) ) )

		end

	end

end

ENT["Build_Components"] = {

	[1] = {
		"Crate_Body",
		"075x075x075",
		function(Base)
			return Base:GetPos() + Vector( 0, 0, 0)
		end,
		Angle(0,0,0),
		Color(127,95,0),
		"models/shiny",
		"tile",
	},
	[2] = {
		"Crate_Button_01",
		"025x025x025",
		function(Base)
			return Base:GetPos() + Vector( 16, 0, 0)
		end,
		Angle(0,0,0),
		Color(255,223,127),
		"models/shiny",
		"tile",
		["Use"] = function( self )
			OpenCrate( self )
		end
	},
	[3] = {
		"Crate_Button_04",
		"025x025x025",
		function(Base)
			return Base:GetPos() + Vector( 0, -16, 0)
		end,
		Angle(0,-90,0),
		Color(255,223,127),
		"models/shiny",
		"tile",
		["Use"] = function( self )
			OpenCrate( self )
		end
	},
	[4] = {
		"Crate_Button_03",
		"025x025x025",
		function(Base)
			return Base:GetPos() + Vector( -16, 0, 1)
		end,
		Angle(0,180,0),
		Color(255,223,127),
		"models/shiny",
		"tile",
		["Use"] = function( self )
			OpenCrate( self )
		end
	},
	[5] = {
		"Crate_Button_02",
		"025x025x025",
		function(Base)
			return Base:GetPos() + Vector( 0, 16, 0)
		end,
		Angle(0,90,0),
		Color(255,223,127),
		"models/shiny",
		"tile",
		["Use"] = function( self )
			OpenCrate( self )
		end
	},


}
