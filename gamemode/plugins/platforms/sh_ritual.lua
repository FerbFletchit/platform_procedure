local Platform_Name = "Ritual"

Platform_Manager["Structures"][Platform_Name] = { -- The platform ID.
	--["FX"] = 1,
	["Size"] = "4x4x025",
	["Angles"] = Angle(0,180,0),
	["Mass"] = 500, -- (In Kilograms)
	--["Color"] = Color(255,0,0, 200),
	["Material"] = "models/debug/debugwhite",

	["Child_Blocks"] = {
		{
			"1x3x1",
			function(Base)
				return Base:GetPos() + Vector( 210, -53, 58)
			end,
			Angle(0,135,90),
			Color(109,109,109),
			"models/debug/debugwhite",
			"tile",
		},
		{
			"1x3x1",
			function(Base)
				return Base:GetPos() + Vector( 128, -156, 58)
			end,
			Angle(0,135,90),
			Color(109,109,109),
			"models/debug/debugwhite",
			"tile",
		},
		{
			"1x4x1",
			function(Base)
				return Base:GetPos() + Vector( 169, -111, 154)
			end,
			Angle(0,-33,0),
			Color(72,72,72),
			"models/debug/debugwhite",
			"tile",
		},
		{
			"1x3x1",
			function(Base)
				return Base:GetPos() + Vector( -31, -184, 58)
			end,
			Angle(0,204,90),
			Color(109,109,109),
			"models/debug/debugwhite",
			"tile",
		},
		{
			"1x3x1",
			function(Base)
				return Base:GetPos() + Vector( -159, -134, 58)
			end,
			Angle(0,211,90),
			Color(109,109,109),
			"models/debug/debugwhite",
			"tile",
		},
		{
			"1x4x1",
			function(Base)
				return Base:GetPos() + Vector( -95, -169, 153)
			end,
			Angle(0,-111,0),
			Color(72,72,72),
			"models/debug/debugwhite",
			"tile",
		},
		{
			"1x3x1",
			function(Base)
				return Base:GetPos() + Vector( 143, 121, 58)
			end,
			Angle(0,39,90),
			Color(109,109,109),
			"models/debug/debugwhite",
			"tile",
		},
		{
			"1x3x1",
			function(Base)
				return Base:GetPos() + Vector( -7, 184, 58)
			end,
			Angle(0,23,90),
			Color(109,109,109),
			"models/debug/debugwhite",
			"tile",
		},
		{
			"1x4x1",
			function(Base)
				return Base:GetPos() + Vector( 68, 142, 153)
			end,
			Angle(0,-289,0),
			Color(72,72,72),
			"models/debug/debugwhite",
			"tile",
		},
		{
			"1x3x1",
			function(Base)
				return Base:GetPos() + Vector( -166, 163, 58)
			end,
			Angle(0,303,90),
			Color(109,109,109),
			"models/debug/debugwhite",
			"tile",
		},
		{
			"1x3x1",
			function(Base)
				return Base:GetPos() + Vector( -237, 20, 58)
			end,
			Angle(0,293,90),
			Color(109,109,109),
			"models/debug/debugwhite",
			"tile",
		},
		{
			"1x4x1",
			function(Base)
				return Base:GetPos() + Vector( -204, 95, 153)
			end,
			Angle(0,-202,0),
			Color(72,72,72),
			"models/debug/debugwhite",
			"tile",
		},
		{
			"4x4x025",
			function(Base)
				return Base:GetPos() + Vector( -3, -3, 2)
			end,
			Angle(0,322,0),
			Color(109,109,109),
			"models/debug/debugwhite",
			"tile",
		},
		{
			"4x4x025",
			function(Base)
				return Base:GetPos() + Vector( -11, -7, 1)
			end,
			Angle(0,113,0),
			Color(72,72,72),
			"models/debug/debugwhite",
			"tile",
		},
		{
			"05x05x025",
			function(Base)
				return Base:GetPos() + Vector( -36, -200, 183)
			end,
			Angle(0,150,0),
			Color(72,72,72),
			"models/debug/debugwhite",
			"tile",
		},
		{
			"05x075x025",
			function(Base)
				return Base:GetPos() + Vector( -135, 145, -7)
			end,
			Angle(0,213,0),
			Color(72,72,72),
			"models/debug/debugwhite",
			"tile",
		},
		{
			"025x025x025",
			function(Base)
				return Base:GetPos() + Vector( -7, 154, 183)
			end,
			Angle(1,228,1),
			Color(72,72,72),
			"models/debug/debugwhite",
			"tile",
		},
		{
			"025x025x025",
			function(Base)
				return Base:GetPos() + Vector( 105, -155, 136)
			end,
			Angle(0,33,0),
			Color(72,72,72),
			"models/debug/debugwhite",
			"tile",
		},
		{
			"1x1x05",
			function(Base)
				return Base:GetPos() + Vector( 0, 2, 15)
			end,
			Angle(0,183,0),
			Color(36,36,36),
			"models/debug/debugwhite",
			"tile",
		},
		{
			"05x1x05",
			function(Base)
				return Base:GetPos() + Vector( 223, -9, 11)
			end,
			Angle(0,170,90),
			Color(72,72,72),
			"models/debug/debugwhite",
			"tile",
		},
		{
			"05x1x05",
			function(Base)
				return Base:GetPos() + Vector( 161, 87, 11)
			end,
			Angle(0,189,90),
			Color(72,72,72),
			"models/debug/debugwhite",
			"tile",
		},
		{
			"05x1x05",
			function(Base)
				return Base:GetPos() + Vector( 90, -146, 11)
			end,
			Angle(0,299,90),
			Color(72,72,72),
			"models/debug/debugwhite",
			"tile",
		},
		{
			"05x1x05",
			function(Base)
				return Base:GetPos() + Vector( -7, -196, 11)
			end,
			Angle(0,257,90),
			Color(72,72,72),
			"models/debug/debugwhite",
			"tile",
		},
		{
			"05x1x05",
			function(Base)
				return Base:GetPos() + Vector( -171, -95, 11)
			end,
			Angle(0,8,90),
			Color(72,72,72),
			"models/debug/debugwhite",
			"tile",
		},
		{
			"05x1x05",
			function(Base)
				return Base:GetPos() + Vector( -222, -13, 11)
			end,
			Angle(0,354,90),
			Color(72,72,72),
			"models/debug/debugwhite",
			"tile",
		},

	}
}

Platform_Manager["Types"][Platform_Name] = {
	["Rarity"] = 0.4, -- 0.1 - 1.
	["Angle"] = Angle(0,90*math.random(0,4),0),
	["Mass"] = 1000,
	["Life"] = 8, -- How long to get to it's end point.
	["Decay"] = 20, -- Decay Time.
	["Loot"] = false,

	["Delete_Last"] = false, -- Should the platform delete the last one.
	["Auto_Spawn_Next"] = false, -- Should it automaticall spawn the next one after time.
	["Next_Spawn"] = 5, -- How long until auto spawn next platform.

	[1] = function( Platform ) -- Everything controlled here.
		Platform["Info"] = Platform["Info"] or {}
		Platform["Info"]["Reached_Destination"] = true -- This is necessary so the callback doesn't activate right away.
		
		Platform["AutoNext"] = PP["Time_Per_Special"] -- If the players have not activated the ritual in this time, remove the skull and next platform.
		--Platform["TimeAfterRitual"] = 25

		Platform["Health_Cost"] = PP["Ritual_HP_Cost"]
		Platform["Health_Cost_Add"] = PP["Max_Health"]/4

		if SERVER then

			PP_RemoveAllOtherPlatforms( Platform )

			timer.Simple(Platform["AutoNext"], function()
				if IsValid(Platform) and not Platform:GetNW2Bool("Activated") then
					if IsValid(Platform["Skull"]) then
						Platform:SetNW2Bool("Activated", true)
						Platform["Skull"]:Remove()

						table.insert( Platform_Manager["Platforms"], Platform ) -- Ensure this is the last platform in the table.
						PP_SpawnTheNextOrderedPlatform()
					end
				end
			end )

			local Curses = {
				[1] = function( ply )

					if IsValid( ply ) and ply:IsPlayer() then

						ply:SetRunSpeed( PP["WalkSpeed"] )

						BroadcastNotification( ply:Nick().." has been CURSED with ~no run~", "Game" )

					end
				end,
				[2] = function( ply )

					if IsValid( ply ) and ply:IsPlayer() then

						ply:SetMaxHealth( PP["Max_Health"] - 50 )

						BroadcastNotification( ply:Nick().." has been CURSED with ~Fragility~", "Game" )

					end
				end,
				[3] = function( ply )

					if IsValid( ply ) and ply:IsPlayer() then

						ply:SetMaxJumpLevel( ply:GetMaxJumpLevel() - 1)

						BroadcastNotification( ply:Nick().." has been CURSED with ~Jump-Less~", "Game" )

					end
				end,
			}

			local Blessings = { -- This could me much more efficent, but I have no time.
				[1] = function( ply )

					if IsValid( ply ) and ply:IsPlayer() then

						ply:SetMaxHealth( PP["Max_Health"] + 50 )

						BroadcastNotification( ply:Nick().." has been blessed with ~Invigorate~", "Game" )

					end
				end,
				[2] = function( ply )

					if IsValid( ply ) and ply:IsPlayer() then

						ply:SetWalkSpeed( ply:GetWalkSpeed() * 1.25 )
						ply:SetRunSpeed( ply:GetRunSpeed() * 1.25 )

						BroadcastNotification( ply:Nick().." has been blessed with ~Energize~", "Game" )

					end
				end,
				[3] = function( ply )

					if IsValid( ply ) and ply:IsPlayer() then

						ply:SetMaxJumpLevel( ply:GetMaxJumpLevel() + 1)

						BroadcastNotification( ply:Nick().." has been blessed with ~Jump Up~", "Game" )

					end
				end,
			}

			local Rituals = {

				[1] = function()

					local Dead_Player = team.GetPlayers(2)[1]

					if IsValid( Dead_Player ) and Dead_Player:IsPlayer() then

						Dead_Player:SetTeam(1)

						Dead_Player:Spawn()
						
						PP_SpawnPlayerInSafeArea(Dead_Player)

						PP["StateManager"]["States"][ PP["CurrentState"] ]["Join"]( ply )

						BroadcastNotification( Dead_Player:Nick().." has been brought back from the dead!", "Game" )

					end

				end,

				[2] = function()
					local loot_dropAmt = 15
					for i=1, loot_dropAmt do
						local Lever_Loot_Entity = ents.Create("pp_loot_cube")

						if IsValid(Lever_Loot_Entity) then
							Lever_Loot_Entity:SetPos( Platform:GetPos()+Vector(
									math.random(-50,50),
									math.random(-50,50),
									math.random(500,600)
								) 
							)

							Lever_Loot_Entity:Spawn()

							Lever_Loot_Entity:ApplyIngotQuality( PP_ProduceRandomIngot(NPC_Ingot_Quality) )

							Lever_Loot_Entity:EmitSound("PP_Sound_Effects/Pop"..math.random(1,2)..".mp3",55,math.random(100,200),1,CHAN_AUTO)

						end
					end
				end,

				[3] = function()

					PP_NPCSpawn( 

						Platform:GetPos()+Vector(0,0,400), 

						"pp_enemy_stukabat",

						25

					)

				end,

				[4] = function( ply )

					for key, value in pairs(ents.FindInSphere(Platform:GetPos(), 300)) do

						if value:IsPlayer() and value:Alive() then

							value:SendNotification("Dialouge", {"Health!", "Healing up!", "Got some health!"})

							PP_AddHealth( value, math.random(80,100) )

							value:EmitSound("PP_Sound_Effects/Sparkle.mp3",65,100,1,CHAN_AUTO)

						end
					end

				end,

			}

			timer.Simple(0.1, function()

				if IsValid(Platform) then

					for key, value in pairs(ents.FindInSphere(Platform:GetPos(),400)) do

						if value:IsNPC() then

							value:Remove()

						end

					end

					--AddEffectBlock(Platform, "pp_ritual")

					Platform["Skull"] = ents.Create("pp_structure_block")
					
					if IsValid( Platform["Skull"] ) then
						
						Platform["Skull"]:SetPos(Platform:GetPos()+Platform:GetUp()*45)
						
						Platform["Skull"]:SetModel("models/aceofspades/prefabs/zombie_skull_new.mdl")

						Platform["Skull"]:SetModelScale(0.1)

						Platform["Skull"]:SetAngles( Angle( 0, 0, 0 ) )
						
						Platform["Skull"]:SetParent( Platform )
						
						Platform["Skull"]:Spawn()

						Platform["Skull"]:Activate()

						Platform["Skull"]:SetUseType(SIMPLE_USE)

						AddEffectBlock(Platform["Skull"], "chest")

						local RitualActivate = Platform["Skull"]
						
						function RitualActivate:Use( ply )
							
							if Platform:GetNW2Bool("Activated") then return end
							
							ply.RitualCool = ply.RitualCool or 0

							if CurTime() < ply.RitualCool then return end

							if ( ply:Health() - ( Platform["Health_Cost"] ) ) <= 0 then
								
								self:EmitSound("PP_Sound_Effects/ritual_laugh.mp3",65,math.random(80,110),1,CHAN_AUTO)
								
								ply:SendNotification("Dialouge", {"The black magic is too strong!", "I've been possesed!", "The demons are calling.."})
								
								ply:Kill()
								
								return
							end

							if ply:Health() > PP["Ritual_HP_Cost"] then

								ply.RitualCool = CurTime() + 5

								self:EmitSound("PP_Sound_Effects/ritual_laugh.mp3",65,math.random(80,110),1,CHAN_AUTO)

								ply:SetHealth( ply:Health() - Platform["Health_Cost"] )


								local BlessOrCurse = math.random(0,1)
								
								if tobool(BlessOrCurse) then -- blessing is true.

									ply:EmitSound("PP_Sound_Effects/Positive.mp3",65,100,1,CHAN_AUTO)
									
									table.Random(Blessings)(ply)

								else

									ply:EmitSound("PP_Sound_Effects/Negative.mp3",65,100,1,CHAN_AUTO)
									
									table.Random(Curses)(ply)

								end

								if #team.GetPlayers(2) >= 1 then

									Rituals[1]()

								else

									table.Random(Rituals)()
									
								end

							end

							Platform["Health_Cost"] = Platform["Health_Cost"] + Platform["Health_Cost_Add"]

							Platform:SetNW2Int("PP_RitualCost", Platform["Health_Cost"])

						end

						function RitualActivate:Think()
							self:SetAngles( Angle( 0, CurTime()*10, 0 ) )
							self:NextThink(CurTime() + 0.1)
							return true
						end
						
						local PhysicsObject = Platform["Skull"]:GetPhysicsObject()
						
						if IsValid( PhysicsObject ) then
							
							PhysicsObject:EnableGravity( false )

						end

					end
				end

			end )

			AddEffectBlock(Platform, "ritual")
		end
		if CLIENT then

			function Platform:DrawTranslucent()
				self:DrawModel()

				if self:GetNW2Bool("Activated") then return end
				
				local Pos = nil
	    		
	    		if not Pos then

			   		local Bound_Origin_Min, Bound_Origin_Max = self:GetModelBounds()
			    	Pos = self:GetPos()+Vector(0,0,Bound_Origin_Max[3]+70) -- Adjusting vertical postiioning of display.

			    end
			    
			    local Eye_Position = EyePos()
			    local Normalized_Angle = Angle(0,0,0):Up()

			    local Altered_Eye_Position = Eye_Position - Pos
			    local Altered_Eye_PositionOnPlane = Altered_Eye_Position - Normalized_Angle * Altered_Eye_Position:Dot(Normalized_Angle)
			    local DisplayAngle = Altered_Eye_PositionOnPlane:AngleEx(Normalized_Angle)

			    DisplayAngle:RotateAroundAxis(DisplayAngle:Up(), 90)
			    DisplayAngle:RotateAroundAxis(DisplayAngle:Forward(), 90)

				cam.Start3D2D(Pos , DisplayAngle, 0.1)
					local Display_Text = "Use The Skull To Activate The Ritual"

			        PP_DrawShadowedTxt(Display_Text,"PP_Regular",2,2,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER,PP["Color_Pallete"]["Tower_Health"])
			        PP_DrawShadowedTxt("Costs "..Platform:GetNW2Int("PP_RitualCost", Platform["Health_Cost"]).." Health","PP_Regular",2,ScreenScale(30),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER,PP["Color_Pallete"]["Tower_Health"])

			    cam.End3D2D()

			end

		end

	end
}