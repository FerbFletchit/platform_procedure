AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
 
include('shared.lua')

function ENT:Initialize()
	--PP["Bomb_Round_Length"]
	--PP["Bomb_TimeToDefuse"]

	PP_StatsAdd( "Bombs Generated", 1 )

	PP_LoadEntityModel( self )

	SetGlobalBool("PP_OngoingEvent", true)

	self:SetCollisionGroup(COLLISION_GROUP_INTERACTIVE)
    self:SetMoveType(MOVETYPE_NONE)
    self:PhysicsInit(SOLID_NONE)
    self:SetUseType(SIMPLE_USE)
    self:SetSolid(SOLID_VPHYSICS)

	--self:SetPos(self:GetPos()+self:GetAngles():Up()*50)
	--self:DropToFloor()

	local PhysicsObject = self:GetPhysicsObject()

	if IsValid(PhysicsObject) then
		PhysicsObject:EnableGravity( false )
	end

	AddEffectBlock(self, "generic")

	self["Bomb"] = ents.Create("prop_dynamic")
	if IsValid( self["Bomb"] ) then
		self["Bomb"]:SetModel("models/aceofspades/weapons/dynamite.mdl")
		self["Bomb"]:SetPos(self:GetPos()+Vector(0,0,26))
		self["Bomb"]:SetParent(self)
		self["Bomb"]:SetCollisionGroup(COLLISION_GROUP_NONE)
		self["Bomb"]:Spawn()

		--function self["Bomb"]:Use()
			--print("bomb use")
		--end
	end

	self:SetNW2String("Bomb_Defuser", "" )
	self["Bomb_Activate"] = true
	self:BombStart()
end

function ENT:BombStart()
	self["Next_Bird"] = CurTime()
	self["Bomb_Activate"] = true

	self:SetNW2Int("Start_Time", CurTime())

	self["PlayLoop"] = function()
		
		if IsValid( self ) then
			
			if self["Bomb_Activate"] then
				
				self:EmitSound("pp_sound_effects/Ticking.mp3", 55, 100, 1.1, CHAN_AUTO )
				
				timer.Simple(1, function()

					if IsValid(self) then

						self["PlayLoop"]()

					end

				end )

			end

		end

	end
	self["PlayLoop"]()

	BroadcastNotification({"Does anyone know how to defuses bombs?", "Is that thing ticking?", "Should probably defuse that."}, "Dialouge")
end

function ENT:BombStartDefusing( ply )
	if self:GetNW2Bool("Bomb_Defused") then return end
	if IsValid(self["Ply_Defusing"]) then

		ply:SendNotification("Dialouge", "It's already being defused!")
		return
	end

	self["Ply_Defusing"] = ply
	self["Start_Defusing"] = CurTime()
	ply:SendNotification("Dialouge", "Defusing!")

	if IsValid( ply ) and ply:IsPlayer() then
		ply:StripWeapons()
		self:SetNW2String("Bomb_Defuser", ply:Nick() or "???" )
	end
end


function ENT:BombDefused( ply )
	if self:GetNW2Bool("Bomb_Defused") then return end
	
	PP_StatsAdd( "Bombs Defused", 1 )
	
	self:SetNW2Bool("Bomb_Defused", true)
	self:EmitSound("pp_sound_effects/defused.mp3",90,100,1,CHAN_AUTO)

	self["Bomb_Activate"] = false

	if IsValid( self["Ply_Defusing"] ) then
		self["Ply_Defusing"]:RestoreWeapons()
	end

	SetGlobalBool("PP_OngoingEvent", false)
	PP_SpawnTheNextOrderedPlatform()
end

function ENT:OnRemove()
	if self["Bomb_Activate"] then
		
		if IsValid( self["Ply_Defusing"] ) then
			self["Ply_Defusing"]:RestoreWeapons()
		end

		PP_RemoveAllEnemies()
		if IsValid(self:GetParent()) and self:GetParent() == "pp_platform" then
			table.insert( Platform_Manager["Platforms"], Platform ) -- Ensure this is the last platform in the table.
		end

		SetGlobalBool("PP_OngoingEvent", false)
		PP_SpawnTheNextOrderedPlatform()
	end
end

function ENT:BombBlown()
	self["Bomb_Activate"] = false
	if IsValid( self["Ply_Defusing"] ) then
		self["Ply_Defusing"]:RestoreWeapons()
	end


	PP_ActionEffect(self, "pp_explode", 1)
	PP_ActionEffect(self, "pp_smoke", 3)
	self:EmitSound("ambient/explosions/explode_3.wav",80,100,1,CHAN_AUTO)
	
	-- Explosion effect

	for key, value in pairs( team.GetPlayers(1) ) do
		value:SetHealth( math.Clamp(value:Health() / 2, 1, 250) )
	end

	PP_RemoveAllEnemies()
	SetGlobalBool("PP_OngoingEvent", false)
	PP_SpawnTheNextOrderedPlatform()

	BroadcastNotification({"This bomb has blown!", "Ow! Bombs hurts", "That bomb was deadly!", "F*CK Bombs hurt"}, "Dialouge")

	self:Remove()
end

function ENT:Think()
	if not self["Bomb_Activate"] then return end

	if IsValid( self["Ply_Defusing"] ) then
		if self["Ply_Defusing"]:GetPos():DistToSqr(self:GetPos()) >= (PP["Bomb_Defuse_Distance"]*PP["Bomb_Defuse_Distance"]) then
			
			self:SetNW2String("Bomb_Defuser", "" )
			self["Ply_Defusing"]:RestoreWeapons()
			self["Ply_Defusing"]:SendNotification("Dialouge", "I've stopped defusing.")
			self["Ply_Defusing"] = nil

		elseif PP["Bomb_TimeToDefuse"] - (CurTime() - self["Start_Defusing"]) <= 0 then
			self:BombDefused( self["Ply_Defusing"] )
		else
			--print("sound")
			self:EmitSound("sound/pp_weapons/magout.wav",75,math.random(70,100),1,CHAN_AUTO)
		end
	end


	if CurTime() > self["Next_Bird"] then
			PP_NPCSpawn( 
				self:GetPos() + VectorRand(-1000,1000), 
				"pp_enemy_stukabat", 
				1 -- Level
			)

		self["Next_Bird"] = CurTime() + PP["Bomb_Enemy_Rate"]
	end
	
	if PP["Bomb_Round_Length"] - (CurTime() - self:GetNW2Int("Start_Time")) <= 0 then
		self:BombBlown()
	end

	self:NextThink(CurTime() + 1)
	return true
end

function ENT:Use( ply )
end