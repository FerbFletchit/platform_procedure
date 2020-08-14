util.AddNetworkString("PP_Danger_Alert")

function GM:InitPostEntity()   
	for key, value in pairs(PP["Server_Commands"]) do
		RunConsoleCommand(key, value)
	end
end

function PP_PlayerBaseSpawn( ply )

	ply:SetJumpLevel(PP["ExtraJumps"])

	ply:SetHealth(PP["Max_Health"])

	ply:SetMaxHealth(PP["Max_Health"])
	
end

function GM:PlayerInitialSpawn( ply )
	timer.Simple(1, function()
		if not IsValid( ply ) then return end
		
		timer.Simple(5, function()
			if IsValid( ply ) then
				ply:SendNotification("Game_Entered", "A Phineas and Ferb Production")
			end
		end )
		
		BroadcastNotification(tostring(ply:Nick().." has joined the game!"),"Game")

		ply:SetShouldServerRagdoll( false )
				
		ply:SetPlayerColor(Vector(math.random(1,255)/255, math.random(1,255)/255, math.random(1,255)/255))

		ply:Kill()

		if PP["CurrentState"] != 0 then
			PP.StateManager["States"][PP["CurrentState"]]["JoinServer"](ply)

		else
			PP_NewGame()
			PP.StateManager["States"][PP["CurrentState"]]["JoinServer"](ply)
		end
		ply:SetNW2Bool("Initialized", true)
	end )
end 

function PP_SetPlayerTexture( ply )

	PP["Player_Texture_Current"] = PP["Player_Texture_Current"] or 1

	if PP["Player_Texture_Current"] < PP["Player_Textures_Amount"] then
		
		ply:SetMaterial("!VoxChell"..PP["Player_Texture_Current"])

		PP["Player_Texture_Current"] = PP["Player_Texture_Current"] + 1

	else

		PP["Player_Texture_Current"] = 1

	end

end

function GM:PlayerSpawn( ply )

	ply:CrosshairDisable()

	ply:SetModel("models/players/voxchell.mdl")

	PP_SetPlayerTexture( ply )

	ply["trail"] = util.SpriteTrail( ply, 0, ply:GetPlayerColor():ToColor(), false, 5, 1, 1, 1 / ( 15 + 1 ) * 0.5, "trails/laser" )
	
	if ply:IsAdmin() then
		ply:ManipulateBoneJiggle(1, 1) -- ;)
	end
	
	if ply:GetNW2Bool("Initialized") then -- Prevents this function from running on intiaal spawn. (Dirty)
		
		ply:UnSpectate()

		ply:SetTeam(1)

		ply:SetShouldServerRagdoll( false )

		ply:SetBloodColor( -1 ) -- Don't bleed.

		local PhysObj = ply:GetPhysicsObject()

		if IsValid(PhysObj) then
			PhysObj:SetMass(PP["Player_Mass"])
		end

		if PP["CurrentState"] != 0 then -- If the server isn't idling.
			PP.StateManager["States"][PP["CurrentState"]]["Join"](ply)
		else -- If it is for some reason.
			PP_NewGame()
		end
	end

	ply:SetupHands()

end



local function PP_Relocate(ply)

	if IsValid( ply ) and ply:Alive() then

		ply:SetPos(ply:GetPos()+ply:GetUp()*10)

	end

end

local Col_Ignore = {1,2,5,8,9,10,11,12,13,15,16,17,18,19,20,21}

hook.Add("SetupMove", "PP_handleStuck", function( ply )
	local pos = ply:GetPos() -- Thanks bobble.
	local tracedata = {}
	tracedata.start = pos
	tracedata.endpos = pos
	tracedata.filter = ply
	tracedata.mins = ply:OBBMins()
	tracedata.maxs = ply:OBBMaxs()
	local trace = util.TraceHull( tracedata )

	if trace.Entity and !trace.Entity:IsWorld() and !trace.Entity:IsPlayer() and trace.Entity:IsValid() and not table.HasValue(Col_Ignore, trace.Entity:GetCollisionGroup()) then
		PP_Relocate(ply)
	end
end )


function GM:PlayerLoadout( ply )
	ply:SetBloodColor( -1 ) -- Don't bleed.
end

function GM:PlayerSetHandsModel( ply, ent )
  	ent:SetModel("models/weapons/c_arms_pp/c_arms_pp.mdl")
  	ent:SetMaterial("!PP_Arms")
  	ent:SetSkin(0)
  	ent:SetBodyGroups(1000000)
end


function GM:OnPlayerChangedTeam( ply, old, new )
end

function GM:PlayerShouldTakeDamage(player, attacker)
	if table.HasValue(PP["DamageBlacklist"], attacker:GetClass()) or attacker:IsPlayer() then
		return false
	else
		PP_ActionEffect(player, "pp_impact", 1)
		return true
	end
end

function GM:PlayerDeathSound()
	return true
end

function GM:PlayerDeath( victim, inflictor, attacker )
	
	PP_ActionEffect(victim, "pp_impact", 1)
	
	if IsValid(victim["trail"]) then
		victim["trail"]:Remove()
	end

	if attacker:IsNPC() then
		
		local Grave = ents.Create("pp_player_grave")
		
		if IsValid( Grave ) then

			local Npc = PP["ENEMY_NPC"][attacker:GetClass()] or PP["BOSS_NPC"][attacker:GetClass()] or "???"

			if istable(Npc) then

				Npc = Npc["Name"]

			end

			Grave:SetDeathString(string.upper(victim:Nick().." Died"))
			Grave:SetKillerName("From "..Npc)

			Grave:SetPos( victim:GetPos()+Vector(0,0,25) )
			Grave:SetAngles( Angle(0,victim:GetAngles().y, 0) )
			Grave:Spawn()
		end

	elseif attacker:GetClass() == "worldspawn" then -- Fall damage.
		victim:PP_PlaySound("sound/PP_Sound_effects/Fall_Death.mp3", 1)
	else
		victim:PP_PlaySound("sound/PP_Sound_effects/Death.mp3", 1)
	end
	BroadcastNotification(victim:Nick().." has died!", "Game")
end 

function GM:CanPlayerSuicide( ply )
	return ply:IsSuperAdmin()
end

function GM:PlayerDeathThink( ply ) -- This is where we prevent the player from respawning, and add in our own logic and timing.
	
	if not PP_IsGameEnding() then -- Player won't respawn if the game is in ending.

		if ply:Team() == 1 then
			ply:SetTeam(2)
			ply:SetNW2Int("DeathTime", CurTime())
			ply:BecomeSpectator()
		end

	end
end

function GM:GetFallDamage( ply, speed )
	if speed > PP["FallDamage_Threshold"] then -- We don't always want fall damage, only if extreme.
   		return ( speed / 8 )
   	else
   		return 0
   	end
end