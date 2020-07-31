if SERVER then
	util.AddNetworkString("PP_Boss_Spawn")
end

local NPC = FindMetaTable("Entity")

local Multiplier_NPC_Enemy_NPC_Level_Health = 0.25
local Multiplier_NPC_Enemy_NPC_Level_Damage = 0.1

local NPC_Enemy_NPC_Level_Manager = {}

function PP_SetupEnemyEnemy_NPC_Levels()
	NPC_Enemy_NPC_Level_Manager = {}

	local Levels_Per_Quality = ( PP["Max_NPC_Level"] ) / #PP["Ingots"]
	for key, Ingot in ipairs( PP["Ingots"] ) do -- Getting ingot qualities, 

		for i=1, Levels_Per_Quality do -- create a section of Enemy_NPC_Levels based on the ingot qualities going up.

			table.insert(NPC_Enemy_NPC_Level_Manager, {
				["Color"] = Ingot["Color"], -- Giving the Enemy_NPC_Levels corresponding quality color.
			} )

		end

	end
end

PP_SetupEnemyEnemy_NPC_Levels()

local function PP_NpcEnemy_NPC_LevelStats( class, Enemy_NPC_Level )
	
	if not PP["ENEMY_NPC"][class] then
		return {}
	end

	if NPC_Enemy_NPC_Level_Manager[Enemy_NPC_Level] then
		return {
			["Health"] = PP["ENEMY_NPC"][class]["Health"] * Enemy_NPC_Level * Multiplier_NPC_Enemy_NPC_Level_Health,
			["Damage"] = (PP["ENEMY_NPC"][class]["Damage"] ) * (Enemy_NPC_Level * Multiplier_NPC_Enemy_NPC_Level_Damage),
		}
	else
		return {}
	end
end 

local function PP_RandomNPCClass()

	for key, value in RandomPairs( PP["ENEMY_NPC"] ) do

		local NPC_Enemy_NPC_Level_Range = PP["ENEMY_NPC"][table.GetFirstKey(PP["ENEMY_NPC"])]["Level_Range"]

		if GetGlobalInt("PP_CurrentNPC_Level", 1) >= NPC_Enemy_NPC_Level_Range[1] and GetGlobalInt("PP_CurrentNPC_Level", 1) <= NPC_Enemy_NPC_Level_Range[2] then

			return key

		end

	end

	return table.GetFirstKey( PP["ENEMY_NPC"] )

end

function PP_BossSpawn( pos, class, Enemy_NPC_Level_choice )

	if not pos then return end

	if not class then return end

	if not SERVER then return end

	local Enemy_BOSS = ents.Create( class )

	local Enemy_BOSS_Level = Enemy_BOSS_Level_choice or GetGlobalInt("PP_CurrentNPC_Level", 100) 

	if IsValid( Enemy_BOSS ) then

		local Enemy_Stats = PP["BOSS_NPC"][class]

		Enemy_BOSS:SetPos( pos )

		Enemy_BOSS:SetModelScale(0.1)
		Enemy_BOSS:SetModelScale(1, 3)

		Enemy_BOSS:Spawn()

		PP_StatsAdd( "Bosses Generated", 1 )

		Enemy_BOSS:Activate()

		Enemy_BOSS:SetMaterial( PP["NPC_Material"] )

		Enemy_BOSS:SetColor( Enemy_Stats["Color"] )

		local Boss_Health = math.Clamp(Enemy_Stats["Min_Health"]+(#team.GetPlayers(1)*Enemy_Stats["Health_PerPlayer"]), Enemy_Stats["Min_Health"], Enemy_Stats["Max_Health"])

		Enemy_BOSS:SetMaxHealth( Boss_Health )

		Enemy_BOSS:slvSetHealth( Boss_Health )

		Enemy_BOSS:SetNW2Int( "Enemy_NPC_Level", Enemy_NPC_Level_choice or GetGlobalInt("PP_CurrentNPC_Level", 100) )
	
		timer.Simple(3, function() -- necessary to make sure ent is spawned first.
			
			PP_StartBossStageTimer( Enemy_BOSS ) -- This is the kill timerto end the game just in case.

			net.Start("PP_Boss_Spawn")

				net.WriteEntity(Enemy_BOSS)

			net.Broadcast()
		end )
	end

	for key, value in pairs( player.GetAll() ) do
		
		value:DangerOMG()

		value:PP_SoundtrackStart(
			table.Random(PP["Boss_Soundtrack"]), 
			false -- Will not stop autoplaying of other songs after.
		)
	 
	end

end

function PP_NPCSpawn( pos, class, Enemy_NPC_Level_choice )
	
	if PP["Disable_Enemies_FirstFloor"] and PP["CurrentState"] <= 2 then 
		return 
	end

	if #ents.FindByClass("pp_enemy_") >= PP["Max_Enemies"] then
		return
	end

	if not pos then return end

	if not class then
		class =  PP_RandomNPCClass()
	end

	if not SERVER then return end

	local Enemy_NPC = ents.Create( class )

	local Enemy_NPC_Level = Enemy_NPC_Level_choice or GetGlobalInt("PP_CurrentNPC_Level", 1) 

	if IsValid( Enemy_NPC ) then

		local Enemy_Stats = PP_NpcEnemy_NPC_LevelStats( class, Enemy_NPC_Level )

		Enemy_NPC:SetPos( pos )

		Enemy_NPC:Spawn()

		timer.Simple(PP["Enemy_Lifespan"], function()
			if IsValid(Enemy_NPC) then
				PP_ActionEffect(Enemy_NPC, "pp_impact", 1)
				Enemy_NPC:Remove()
			end
		end )

		PP_StatsAdd( "Monsters Generated", 1 )

		if PP["ENEMY_NPC"][ class ]["Custom_Spawn"] then
			PP["ENEMY_NPC"][ class ]["Custom_Spawn"]( Enemy_NPC )
		end

		Enemy_NPC:PhysWake()

		Enemy_NPC:SetCollisionGroup( COLLISION_GROUP_NPC )

		for key, value in pairs(ents.FindByClass("pp_enemy_*")) do -- Nothign else would fucking work and I have 10 hours left.
			if IsValid( value ) then
				constraint.NoCollide( Enemy_NPC, value, 0, 0 )
			end
		end

		-- Spawn Effect --

		Enemy_NPC:SetModelScale(0.1)

		Enemy_NPC:SetModelScale(table.Random(PP["ENEMY_NPC"][ class ]["Sizes"]) or 1, 0.5)

		PP_ActionEffect(Enemy_NPC, "enemy_spawn", 2)

		-------------------------------

		Enemy_NPC:SetMaterial(  PP["NPC_Material"] )

		Enemy_NPC:SetColor( NPC_Enemy_NPC_Level_Manager[Enemy_NPC_Level]["Color"] )

		Enemy_NPC:SetMaxHealth( Enemy_Stats["Health"] or 100 )

		Enemy_NPC:slvSetHealth( Enemy_Stats["Health"] or 100 )

		Enemy_NPC:SetNW2Int( "Enemy_NPC_Level", Enemy_NPC_Level_choice or GetGlobalInt("PP_CurrentNPC_Level", 1) )

		Enemy_NPC:SetNW2String("Enemy_Name", table.Random(PP["ENEMY_NPC"][ class ]["Names"] ))
	
		SetGlobalInt("PP_CurrentNPC_Level", GetGlobalInt("PP_CurrentNPC_Level", 1) + 1)
	end

end

function PP_EnemyShouldCollide( ent1, ent2 )
    -- If players are about to collide with each other, then they won't collide.
    if ( IsValid( ent1 ) and IsValid( ent2 ) ) and (PP["ENEMY_NPC"][ent1:GetClass()] and PP["ENEMY_NPC"][ent2:GetClass()]) then 
    	return false 
  	end

    -- We must call this because anything else should return true.
    return true
end
hook.Add("ShouldCollide", "PP_EnemyShouldCollide", PP_EnemyShouldCollide)

function NPC:DropLoot()
	local npc_info = PP["ENEMY_NPC"][self:GetClass()] --[[or PP["BOSS_NPC"][self:GetClass()]]

	if not npc_info then return end

	local NPC_Ingot_Quality = math.Clamp(1 - ( (1) * (self:GetNW2Int("Enemy_NPC_Level") / PP["Max_NPC_Level"] ) ), 0.1, 1 )

	for index=1, npc_info["Death_Loot_Amount"] do
		local NPC_Loot_Entity = ents.Create("pp_loot_cube")

		if IsValid(NPC_Loot_Entity) then
			NPC_Loot_Entity:SetPos( self:GetPos() )

			NPC_Loot_Entity:Spawn()

			NPC_Loot_Entity:ApplyIngotQuality( PP_ProduceRandomIngot(NPC_Ingot_Quality) )

			NPC_Loot_Entity:EmitSound("PP_Sound_Effects/Pop"..math.random(1,2)..".mp3",55,math.random(100,200),1,CHAN_AUTO)

			local Phys = NPC_Loot_Entity:GetPhysicsObject()

			if IsValid(Phys) then

				Phys:SetVelocity( Vector( math.random(-500, 500), math.random(-500, 500), math.random(-500, 500) ) )

			end

		end
	end

end

function PP_Enemy_NPC_LevelUpNPCs( addition )
	SetGlobalInt("PP_CurrentNPC_Level", GetGlobalInt("PP_CurrentNPC_Level", 1) + (addition or 1) )
end


-- Here we override player taking Damage to select Damage based on npc stats and Enemy_NPC_Level
function PP_ScaleEnemyDamage( ply, dmginfo )

	if not PP["ENEMY_NPC"][dmginfo:GetAttacker():GetClass()] then return end -- This is only for npc Damage.
	
	local NPC_Damage_Set
	local NPC_Damage_Stats = PP_NpcEnemy_NPC_LevelStats( dmginfo:GetAttacker():GetClass(), dmginfo:GetAttacker():GetNW2Int("Enemy_NPC_Level") )
		
	if DmgStat then

		NPC_Damage_Set = NPC_Damage_Stats["Damage"]

	else

		NPC_Damage_Set = PP["Damage"]

	end
	
	dmginfo:SetDamage( NPC_Damage_Set )
end
hook.Add("EntityTakeNPC_Damage_Set", "PP_ScaleEnemyNPC_Damage_Set", PP_ScaleEnemyNPC_Damage_Set)

function PP_EnemyTakeNPCDamage( npc, dmginfo )
	npc = PP["ENEMY_NPC"][npc:GetClass()]
	if not npc then return end -- This is only for npc Damage.
	
	if dmginfo:GetAttacker():IsPlayer() or dmginfo:GetAttacker():IsNextBot() or dmginfo:GetAttacker():IsNPC() then
		local drop_chance = math.Rand(1,10)

		if drop_chance < npc["Loot_From_Shot_Chance"] then
			local cube_from_body = ents.Create("pp_loot_cube")

			cube_from_body:SetPos( dmginfo:GetDamagePosition() or npc:GetPos() )
			cube_from_body:SetModel(PP_SizeToModelString( table.Random( PP_Loot["Cubes"] ) ) )
			cube_from_body:Spawn()
			cube_from_body:ApplyIngotQuality()

			cube_from_body:SetCollisionGroup(COLLISION_GROUP_DEBRIS)

			cube_from_body:EmitSound("PP_Sound_Effects/Pop"..math.random(1,2)..".mp3",60,math.random(75,100),1,CHAN_AUTO)

			cube_from_body:SetAngles( Angle(math.random(-360), math.random(-360), math.random(-360)) )
			local Phys = cube_from_body:GetPhysicsObject()

			if IsValid(Phys) then
				Phys:SetVelocity( dmginfo:GetDamageForce() * 0.1 )
			end
		end

	else
		return false -- no dammage
	end
end
hook.Add("EntityTakeDamage", "PP_EnemyTakeNPCDamage", PP_EnemyTakeNPCDamage)

function GM:OnNPCKilled( npc, attacker, inflictor )
	local npc_info = PP["ENEMY_NPC"][npc:GetClass()]
	if npc_info then -- This is only for npc Damage.

		PP_StatsAdd( "Monsters Killed", 1 )
		
		-- Notifation of kill
		npc:EmitSound( "pp_sound_effects/death.mp3", 75, 100, 1, CHAN_AUTO, CHAN_AUTO )

		local Skull = ents.Create("pp_deathskull")

		if IsValid( Skull ) then
			Skull:SetPos( npc:GetPos() )
			Skull:SetDeathString(string.upper("LVL. "..npc:GetNW2Int("Enemy_NPC_Level", 1).." "..npc:GetNW2String("Enemy_Name", "Monster").." SLAIN BY"))
			
			if attacker:IsPlayer() then

				Skull:SetKillerName(string.upper(attacker:Nick()) or "???")
			else

				Skull:SetKillerName("???")
			end

			Skull:Spawn()
		end

		-- Add frag
		if inflictor:IsPlayer() then

			inflictor:AddFrags(1)

		end

		-- Drop loot
		if npc_info["Death_Loot_Amount"] >= 1 then
			npc:DropLoot()

		end
	else
		local npc_info = PP["BOSS_NPC"][npc:GetClass()]
		if not npc_info then return end
		if not IsValid(npc) then return end

		PP_StatsAdd( "Bosses Killed", 1 )

		-- Notifation of kill
		npc:EmitSound( "pp_sound_effects/death.mp3", 100, 100, 1, CHAN_AUTO, CHAN_AUTO )

		npc:EmitSound( "pp_sound_effects/game_win_fanfare.mp3", 100, 100, 1, CHAN_AUTO, CHAN_AUTO )
			
		local Skull = ents.Create("pp_bossdeathskull")

		if IsValid( Skull ) then
			Skull:SetPos( npc:GetHeadPos()+npc:GetUp()*100 or npc:GetPos()+npc:GetUp()*100 )
			Skull:SetDeathString(string.upper("BOSS "..npc_info["Name"].." SLAIN BY"))
			
			if attacker:IsPlayer() then

				Skull:SetKillerName(string.upper(attacker:Nick()) or "Players")
			else

				Skull:SetKillerName("Players")
			end

			Skull:Spawn()
		end

		-- Add frag
		if inflictor:IsPlayer() then

			inflictor:AddFrags(1)
			inflictor:SetNW2Int("PP_Boss_Kill", inflictor:GetNW2Int("PP_Boss_Kill") + 1)
		end

		-- Drop loot
		if npc_info["Death_Loot_Amount"] >= 1 then

			npc:DropLoot()

		end

		if SERVER then
			PP_ReachedEvent( FindPlatform("Boss_Stage"), "End_Game" )
		end

	end

end

function PP_RemoveAllEnemies()
	for key, value in pairs(ents.FindByClass("pp_enemy_*")) do
		value:Remove()
	end
end

function PP_Enemy_Spawn( Platform )
	
	if SERVER then
		if not table.HasValue(Platform_Manager["Sizes"], PP_PlatformModelToSizeString( Platform:GetModel() ) ) then return end

		local PP_EnemySpawn_Bounds = {Platform:GetModelBounds()}
		local PP_EnemySpawn_Bounds_Min = PP_EnemySpawn_Bounds[1]
		local PP_EnemySpawn_Bounds_Max = PP_EnemySpawn_Bounds[2]

		
		-- This is a safeguard because area calculation sometimes fails. --
		local Platform_PhysicsObject = Platform:GetPhysicsObject()
		if IsValid(Platform_PhysicsObject) then

			if Platform_PhysicsObject:GetVolume() < PP["Spawn_MinVolume"] then 
				return 
			end

		else
			return 
		end
		--------------------------------------------------------------------
		
		local Platform_Area = PP_PlatformModelToTable( Platform:GetModel() ) -- If Volume is not found, then this multiplation nullifies the loot amount.
		
		if table.IsEmpty(Platform_Area) then return end

		Platform_Area = Platform_Area[1] * Platform_Area[2]

		if Platform_Area <= PP["Enemy_MinArea"] then 
			return end

		local Enemy_Amount = math.Round( math.Clamp(Platform_Area * 0.05 * #team.GetPlayers(1), 1, PP["Enemy_MaxPerPlatform"] ) ) -- MATHHHHHH OH GOD THIS IS TRASH.

		local Penis_variable = math.Rand(0.1,1)

		if Penis_variable < PP["Enemy_Spawn_Chance"] then
			
			for i=1, Enemy_Amount do

				timer.Simple(PP["Enemy_Spawn_Delay"]*i, function()
					if IsValid( Platform ) then
						local Enemy_Spawn_Pos = Platform:GetPos() + Vector(

							math.random(PP_EnemySpawn_Bounds_Min[1],PP_EnemySpawn_Bounds_Max[1]) * 0.80,

							math.random(PP_EnemySpawn_Bounds_Min[2],PP_EnemySpawn_Bounds_Max[2]) * 0.80,

							PP_EnemySpawn_Bounds_Max[3] * 3

						)

						PP_NPCSpawn( Enemy_Spawn_Pos )
					end
				end )

			end

		end
	
	end

end

function PP_ClearMobs()
	for key, value in pairs(ents.FindByClass("pp_enemy_*")) do
		if IsValid( value ) then
			PP_ActionEffect(value, "pp_impact", 1)
			value:Remove()
		end
	end
end