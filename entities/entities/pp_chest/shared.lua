AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_entity"
ENT.RenderGroup = RENDERGROUP_TRANSLUCENT

ENT.PrintName = "Platform Procedure: Lootable Chest"
ENT.Category = "Platform Procedure"

ENT.Spawnable = false
ENT.AdminOnly = true

function ENT:SetupDataTables()
	self:NetworkVar( "String", 1, "ID" )
end

local function ChestActivated( button )
	local Chest = button:GetParent()
	button = PP_GetComponentByID(Chest, "Chest_Button")

	if button["Activated"] then return end -- If the button has already been pressed, do nothing.
	if not IsValid( button ) or not IsValid( Chest ) then return end -- If either the button or chest cannot be found, do nothing.
	
	button["Activated"] = true

	PP_StatsAdd( "Chests Opened", 1 )


	button:RemoveEffects( EF_ITEM_BLINK ) -- Remove button glow.
	
	button:SetPos(button:GetPos()-button:GetForward()*2) -- Setting the button in.

	Chest:EmitSound("PP_Sound_Effects/Chest_Open.mp3",65,math.random(80,90),1,CHAN_AUTO) -- Emit chest opening sound.

	PauseEffects(Chest) -- Remove our idling chest effect.
	
	local Lid = PP_GetComponentByID(Chest, "Chest_Lid")


	if IsValid(Lid) then
		Lid:SetPos(Lid:GetPos()+Lid:GetUp()*4-Lid:GetForward()*5) -- Adjusting lid position.
		local new_lid_ang = Chest:GetAngles()
		new_lid_ang:RotateAroundAxis(Chest:GetAngles():Right(),45)
		Lid:SetAngles( new_lid_ang ) -- Adjusting lid angle.

		for i=1, PP["Chest_Loot_Amount"]() do

			timer.Simple(i*0.03, function() -- producing the loot with a bit of delay, for visual and sound effect.
				
				if IsValid(Chest) and IsValid(Lid) then -- Validating.

					local loot_ent = ents.Create(PP_Loot_Random()["Entity"])

					loot_ent:SetPos(Lid:GetPos()+Lid:GetForward()*4-Lid:GetUp()*7)
					loot_ent:SetModel(PP_SizeToModelString( table.Random( PP_Loot["Cubes"] ) ) )
					loot_ent:Spawn()
					loot_ent:SetUseType(CONTINUOUS_USE)
					loot_ent:ApplyIngotQuality()
					local trail = util.SpriteTrail( loot_ent, 0, Color(loot_ent:GetColor().r,loot_ent:GetColor().g,loot_ent:GetColor().b,100), false, 5, 5, 0.5, 100, "trails/laser" )

					--loot_ent:SetCollisionGroup(COLLISION_GROUP_DEBRIS)

					loot_ent:EmitSound("PP_Sound_Effects/Pop"..math.random(1,2)..".mp3",55,math.random(100,200),1,CHAN_AUTO)
					loot_ent:SetGravity( -1 )
					loot_ent:SetFriction( 5 )
					constraint.NoCollide( loot_ent, Chest, 0, 0 )

					local Phys = loot_ent:GetPhysicsObject()

					if IsValid(Phys) then
						Phys:SetMass(100)
						Phys:SetVelocity( ( button:GetUp() * 5) + ( button:GetForward() * math.random(60,100) ) + ( button:GetRight() * math.random(-40,80) ) )
					end
					
					if IsValid(loot_ent) then
						if loot_ent:IsWeapon() then
							loot_ent:SetNW2Bool("Dropped", true)
							timer.Simple(0.1, function()
								if IsValid(loot_ent) then
									loot_ent:SetNW2Bool("Dropped", false)
								end
							end )
						end
					end

					if PP["Chest_Decay_AfterUse"] then
						timer.Simple(PP["Chest_Start_Decay"], function()
							if IsValid( Chest ) then
								--Chest:SetRenderMode(1)
								--Chest:SetRenderFX(PP["Decay_Effect"])
								
								--[[for key, value in pairs(Chest:GetChildren()) do

									value:SetRenderMode(1)

									value:SetRenderFX(PP["Decay_Effect"])

								end]]

								timer.Simple(PP["Chest_Decay"], function()

									if IsValid( Chest ) then

										PP_ActionEffect(Chest, "pp_impact", 1)

										Chest:Remove()

									end
								end )

							end
						end )

					end

				end

			end )
		end

	end
end

ENT["Build_Components"] = {
	[1] = {
		"Chest_Body",
		"05x1x05",
		function(Base)
			return Base:GetPos() + Vector( 0, 0, 0)
		end,
		Angle(0,0,0),
		Color(127,95,0),
		"models/shiny",
		"tile",
	},
	[2] = {
		"Chest_Lid",
		"05x1x025",
		function(Base)
			return Base:GetPos() + Vector( 0, 0, 18)
		end,
		Angle(0,0,0), -- Open angle Angle(45,0,0)
		Color(127,111,63),
		"models/shiny",
		"tile",
		["Use"] = function( self )
			ChestActivated( self )
		end
	},
	[3] = {
		"Chest_Button",
		"025x025x025",
		function(Base)
			return Base:GetPos() + Vector( 8, 0, 4)
		end,
		Angle(0,0,0),
		Color(255,223,127),
		"models/shiny",
		"tile",
		["Initialize"] = function( self )
			self:AddEffects( EF_ITEM_BLINK )
		end,
		["Use"] = function( self )
			ChestActivated( self )
		end
	},
}
