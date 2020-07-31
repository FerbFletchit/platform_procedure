if SERVER then
	util.AddNetworkString("PP_EndMenu")
end

function PP_SetupBeginningState()

	PP["StateManager"]["States"][1] = { -- Starting Phase.

		["Name"] = "Beginning",

		["Duration"] = PP["Floors"]["Beginning_State_Duration"], -- In seconds.

		["JoinServer"] = function(ply) -- What should happen if a player joins the server during this state?
			ply:SetTeam(1)
			ply:SetCollisionGroup(15)
			ply:SetNoCollideWithTeammates(true)
			ply:SetAvoidPlayers( false )
			ply:SetObserverMode(0)
			
			ply:ClearInventory()

			ply:ClearRecipes()

			ply:PP_SoundtrackStart()

			ply:SetJumpLevel(PP["ExtraJumps"])

			ply:SetHealth(PP["Max_Health"])

			ply:SetMaxHealth(PP["Max_Health"])

			ply:SetWalkSpeed(1)

			ply:SetRunSpeed(1)

			ply:SetJumpPower(1)

			ply:ManipulateBoneJiggle(6, 1) -- Fuck with their head for no reason.

			ply:ClearInventory()

			ply:ClearRecipes()
		

			if IsValid( FindPlatform("Spawn Platform") ) then

				ply:SetPos(FindPlatform("Spawn Platform"):GetPos() + Vector(math.random(-80,80), math.random(-80,80), 150))

			end

		end,

		["Join"] = function(ply) -- This is what happens wehn a player respawns in the match.
			ply:SetTeam(1)
			ply:SetCollisionGroup(15)
			ply:SetNoCollideWithTeammates(true)
			ply:SetAvoidPlayers( false )
			ply:SetObserverMode(0)
			
			ply:ClearInventory()

			ply:ClearRecipes()

			ply:PP_SoundtrackStart()


			PP_PlayerBaseSpawn( ply )

			ply:StripWeapons()

			ply:SetWalkSpeed(1)

			ply:SetRunSpeed(1)

			ply:SetJumpPower(1)

			ply:ManipulateBoneJiggle(6, 1) -- Fuck with their head for no reason.

			if IsValid( FindPlatform("Spawn Platform") ) then

				ply:SetPos(FindPlatform("Spawn Platform"):GetPos() + Vector(math.random(-80,80), math.random(-80,80), 150))

			end

			timer.Simple(math.random(1,5), function() -- I don't want everyone to talk at once. aestheticcsss.
				if IsValid( ply ) then
					ply:SendNotification("Dialouge", PP["Start_Dialouge"])
				end
			end )
			
		end,

		["Entered"] = function()
			-- Players have view on end area, which zooms to their position.
			-- Platform below players begins to rise.
			if SERVER then

				Generate_Platform( { -- Spawing the start platform!

					["Structure"] = "Spawn Platform",

					["ID"] = "Spawn Platform",

					["Start"] = PP["Start_Point"] - Vector(0, 0, 100), -- Start Point

					["End"] = PP["Start_Point"], -- End Point.

					["Life"] = PP["Floors"]["Beginning_State_Duration"], -- How long to get to it's end point.

					["Size"] = "8x8x1", -- Size.

					["Decay"] = 100, -- Decay Time.

					["Callback"] = function( self ) -- When the spawn platform has fully risen.

					end

				} )


				for key, value in pairs(player.GetAll()) do
					value:Spawn()
				end

			end
			
		end,

		["Leaving"] = function() -- Anything to trigger when leaving a state this isn't included in the init of the next state.

			for key, value in pairs( player.GetAll() ) do

				PP_PlayerBaseSpawn( value )

				value:SetWalkSpeed(PP["WalkSpeed"])

				value:SetRunSpeed(PP["RunSpeed"])

				value:SetJumpPower(PP["JumpPower"])

				value:SetJumpLevel(PP["ExtraJumps"])
				
				value:SetMaxJumpLevel(PP["ExtraJumps"])
		
			end

		end,

		["End"] = function() -- If the game state's should end is triggered. (Isn't one here so never should be)
			PP_EndGameLoss()
		end,

		["Draw"] = function(ply) -- What to draw for the player during this state.

		end,
		
		["Update"] = function()

		end,

		["Should_End"] = function() -- This is in a think function, keep it simple.
			return false -- Keeps game going.
		end,


	}

end

function PP_SetupGameFloorStates()
	for PP_Floor=1, tonumber(PP["Floors"]["Per_Game"] - 1) do -- Creating a state for each desired floor for the game, not including the last floor (for boss).
		
		table.insert( PP["StateManager"]["States"], {

			["Name"] = "Floor "..PP_Floor,
		
			["JoinServer"] = function(ply) -- What should happen if a player joins the server during this state?
				-- Player Mid-Game Spawn function
			end,

			["Join"] = function(ply) -- This is what happens wehn a player respawns in the match.
				if IsValid(ply) and ply:IsPlayer() then
					ply:RestoreWeapons()
				end
			end,

			["Entered"] = function()
				-- Popup floor display (FloorX / GameFloors)
				-- Sounds

				-- Start floor platform generation, specify which floor it is. First floor should be neutral and strategy platforms, as players don't have weapons.
				--SetGlobalInt("PP_CurrentFloor_Platform", 1)
				if SERVER then

					PP["Floors"]["Current_Platform"] = 1

					PP["Floors"]["Current_Platform_Order"] = PP_LayoutFloorPlatforms()
					
					PP_ReachedEvent( nil, PP["Floors"]["Current_Platform_Order"][ PP["Floors"]["Current_Platform"] ] )

				end


			end,

			["Leaving"] = function() -- Anything to trigger when leaving a state this isn't included in the init of the next state.
			
			end,

			["Draw"] = function()

				PP_HealthElement()

				PP_Crosshair()

			end,

			["Update"] = function() -- This is in a think function.

			end,

			["Should_End"] = function() -- This is in a think function, keep it simple.

				if #team.GetPlayers(1) == 0 then -- No alive players.

					return true -- Ends game with a loss.

				else

					return false -- Keeps game going.

				end

			end,

			["End"] = function() -- If the game state's should end is triggered.

				PP_EndGameLoss()

			end,
		} )
	end
	
end

function PP_SetupBossFloorState()

	PP["StateManager"]["States"][ ( PP["Floors"]["Per_Game"] + 1 ) ] = { -- Last floor.

		["Name"] = "Final Floor "..( PP["Floors"]["Per_Game"] ).." Boss Lair",
		
		["JoinServer"] = function(ply) -- What should happen if a player joins the server during this state?
			-- Player Mid-Game Spawn function

			-- ply:Kill()

		end,

		["Join"] = function(ply) -- This is what happens wehn a player respawns in the match.
			ply:RestoreWeapons()
		end,

		["Entered"] = function()

			-- Popup floor display (FloorX / GameFloors)
			-- Sounds

			-- Freeze players
			-- Spawn Boss lair
			-- Camera shit

			PP_ReachedEvent( nil, "Boss_Stage" )

		end,

		["Leaving"] = function() -- Anything to trigger when leaving a state this isn't included in the init of the next state.

		end,

		["Draw"] = function()

			PP_HealthElement()

			PP_Crosshair()

			draw.DrawText(string.NiceTime( math.Round( ( PP["Boss_Stage_MaxTime"] - ( CurTime() - PP["StartStateTime"] ) ) ) ).." Remain","PP_Small", ScrW() - 25, 25, Color( 0, 0, 0, 130 ), TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP )

		end,

		["Update"] = function() -- This is in a think function.

		end,

		["Should_End"] = function() -- This is in a think function, keep it simple.

			if #team.GetPlayers(1) == 0 then -- No alive players.

				return true -- Ends game with a loss.

			else

				return false -- Keeps game going.

			end

		end,

		["End"] = function() -- If the game state's should end is triggered.
			PP_EndGameLoss()
		end,
	}
end

function PP_SetupEndGameState()
	table.insert( PP["StateManager"]["States"], {
	
		["Name"]  = "End Game",

		["Duration"] = PP["EndGame_Duration"], -- In seconds.

		["JoinServer"] = function(ply) -- What should happen if a player joins the server during this state?
			-- Player Mid-Game Spawn function
			-- ply:Kill()
			--PP_SpawnPlayerInSafeArea(ply)

			--ply:RestoreWeapons()

		end,

		["Join"] = function(ply)
		end,

		["Entered"] = function()

			
			net.Start("PP_EndMenu")
				net.WriteBool(GetGlobalBool("PP_GameWin"))
			net.Broadcast()

			for key, value in pairs(player.GetAll()) do
				
				-- Open panel.

				value:ForceCameraViewPos(
					
					{
						["origin"] = PP["Win_Zone"][1]-PP["Win_Zone"][2]:Forward()*250+PP["Win_Zone"][2]:Up()*50,
						["angles"] = PP["Win_Zone"][2],
						["fov"] = 100,
						["drawviewer"] = true,
					}, 

					PP["EndGame_Duration"]+2 -- Duration.
				)

			end

			if GetGlobalBool("PP_GameWin") then

				Generate_Platform( {
					["ID"] = "First Place Platform",
					["Type"] = "First Place Platform",
					["Material"] = "Models/effects/vol_light001",
					
					["Start"] = PP["Win_Zone"]["First_Place"](),

					["End"] = PP["Win_Zone"]["First_Place"](),

					["Life"] = 0.1, -- How long to get to it's end point.
					["Decay"] = 100 -- Decay Time.
				} )


				Generate_Platform( {
					["ID"] = "Second Place Platform",
					["Type"] = "Second Place Platform",
					["Material"] = "Models/effects/vol_light001",

					["Start"] = PP["Win_Zone"]["Second_Place"](),

					["End"] = PP["Win_Zone"]["Second_Place"](),

					["Life"] = 1, -- How long to get to it's end point.
					["Decay"] = 100 -- Decay Time.
				} )

				Generate_Platform( {
					["ID"] = "Third Place Platform",
					["Type"] = "Third Place Platform",
					["Material"] = "Models/effects/vol_light001",

					["Start"] = PP["Win_Zone"]["Third_Place"](),

					["End"] = PP["Win_Zone"]["Third_Place"](),

					["Life"] = 0.1, -- How long to get to it's end point.
					["Decay"] = 100 -- Decay Time.
				} )

				-- Win shit here.
				PP_BroadcastSound("pp_sound_effects/Game_Win_Fanfare.mp3", 1)
			else -- they lost.
				Generate_Platform( {
					["ID"] = "End Loss Platform",
					["Type"] = "End Loss Platform",
					["Material"] = "Models/effects/vol_light001",
					
					["Start"] = PP["Win_Zone"]["First_Place"](),

					["End"] = PP["Win_Zone"]["First_Place"](),

					["Life"] = 0.1, -- How long to get to it's end point.
					["Decay"] = 100 -- Decay Time.
				} )
			end



		end,

		["Leaving"] = function() -- Anything to trigger when leaving a state this isn't included in the init of the next state.

		end,

		["End"] = function() -- If the game state's should end is triggered.
			
		end,

		["Draw"] = function()

		end,

		["Update"] = function() -- This is in a think function.

		end,

		["Should_End"] = function() -- This is in a think function, keep it simple.
			return false -- Keeps gamestate going.
		end,
	} )
end

function PP_NewGame()
	if SERVER then
		
		if PP["CurrentState"] == 1 then return end
		
		print("[Platform Procedure] Intiating New Game.")
		
		PP["StartStateTime"] = CurTime()
		PP["CurrentState"] = 1
		
		PP_UpdateClientState()
		Platform_Manager["Platforms"] = {}

		PP_StatsReset()
		PP_CreateRoute() -- Duplicate of NEwGame function, fix that.
		PP_CreateNewRecipes()
		SetGlobalBool("PP_OngoingEvent", false)
		SetGlobalInt("PP_CurrentNPC_Level", 1)

		game.CleanUpMap( false, {})


		PP.StateManager["States"][PP["CurrentState"]]["Entered"]()

	end
end

if SERVER then
	function PP_EndGame()
		if PP["CurrentState"] == #PP["StateManager"]["States"] then return end

		PP["StateManager"]["States"][PP["CurrentState"]]["Leaving"]()

		print("[Platform Procedure] Ending the game.")

		PP["CurrentState"] = #PP["StateManager"]["States"]
		PP["StartStateTime"] = CurTime()
		PP_UpdateClientState()

		--game.CleanUpMap( false, {})

		PP.StateManager["States"][PP["CurrentState"]]["Entered"]()
	end

	function PP_EndGameLoss()
		SetGlobalBool("PP_GameWin", false)

		PP_EndGame()

	end

	function PP_EndGameWin()

		SetGlobalBool("PP_GameWin", true)
		
		PP_EndGame()

	end
end

function PP_IsGameEnding()
	
	if PP["CurrentState"] >= #PP["StateManager"]["States"] then

		return true

	else

		return false
	end

end



function PP_SetupStates()

	PP["StateManager"]["States"] = {}

	PP_SetupBeginningState()

	PP_SetupGameFloorStates()

	PP_SetupBossFloorState()

	PP_SetupEndGameState()

end

PP_SetupStates()

