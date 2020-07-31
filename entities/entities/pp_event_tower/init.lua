AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
 
include('shared.lua')

function ENT:Initialize()
	PP_LoadEntityModel( self )

	PP_StatsAdd( "Towers Generated", 1 )

	SetGlobalBool("PP_OngoingEvent", true)

	self:SetCollisionGroup(COLLISION_GROUP_INTERACTIVE)
    self:SetMoveType(MOVETYPE_NONE)
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetUseType(SIMPLE_USE)
    self:SetSolid(SOLID_VPHYSICS)

	--self:SetPos(self:GetPos()+self:GetAngles():Up()*100)
	--self:DropToFloor()

	local PhysicsObject = self:GetPhysicsObject()

	if IsValid(PhysicsObject) then
		PhysicsObject:EnableGravity( false )
	end

	AddEffectBlock(self, "generic")

	AddEffectBlock(PP_GetComponentByID(self, "Tower_Point"), "chest")

	self:SetNW2Int("Tower_Health", PP["Tower_HP"])
	self["Tower_Protecting"] = false
	self["Tower_Destroyed"] = false
	self:TowerStart()
end

function ENT:TowerStart()
	self["Next_Bird"] = CurTime() + 1
	self["Tower_Protecting"] = true

	self:SetNW2Int("Start_Time", CurTime())
	BroadcastNotification({"This tower is under attack!", "I must protect the tower!", "This ancient tower is under siege!"}, "Dialouge")
end

function ENT:TowerSaved()
	
	self:EmitSound("PP_Sound_Effects/positive.mp3",80,100,1,CHAN_AUTO)
	
	for i=1, PP["Tower_Win_Loot"] do
		timer.Simple((0.5*i), function()

			if IsValid( self ) then

				local loot_ent = ents.Create("pp_loot_cube")

				if IsValid(loot_ent) then
					loot_ent:SetPos(self:GetPos()+Vector(0,0,300))
					loot_ent:SetModel( PP_SizeToModelString( table.Random( PP_Loot["Cubes"] ) ) )
					
					loot_ent:Spawn()
					loot_ent:ApplyIngotQuality()

					loot_ent:EmitSound("PP_Sound_Effects/Pop"..math.random(1,2)..".mp3",55,math.random(100,200),1,CHAN_AUTO)

					local Phys = loot_ent:GetPhysicsObject()

					if IsValid(Phys) then
						Phys:SetVelocity( Vector( math.random(-300,300), math.random(-300,300), math.random(0,100) ) )
					end

				end

			end

		end )
	end

	self:SetNW2Bool("Tower_Saved", true)
	self["Tower_Protecting"] = false

	PP_StatsAdd( "Towers Defended", 1 )

	SetGlobalBool("PP_OngoingEvent", false)
	PP_SpawnTheNextOrderedPlatform()

	BroadcastNotification({"This tower has been saved!", "The tower is still standing!", "The tower is saved!"}, "Dialouge")
end

function ENT:OnRemove()
	if self["Tower_Protecting"] then
		PP_RemoveAllEnemies()
		SetGlobalBool("PP_OngoingEvent", false)
		PP_SpawnTheNextOrderedPlatform()
	end
end

function ENT:TowerDestroyed()

	if self["Tower_Destroyed"] then return end
	self["Tower_Destroyed"] = true

	self:EmitSound("ambient/explosions/exp1.wav",70,100,1,CHAN_AUTO)
	self:EmitSound("ambient/levels/streetwar/building_rubble1.wav",75,100,1,CHAN_AUTO)

	BroadcastNotification({"This tower has been destroyed", "The tower is falling!"}, "Dialouge")

	for key, value in pairs(self:GetChildren()) do
		
		self:SetParent(nil)

		timer.Simple(5*key, function()

			if IsValid( value ) then

				value:SetParent(nil)

				value:PhysicsInit(SOLID_VPHYSICS)

				value:SetCollisionGroup(COLLISION_GROUP_IN_VEHICLE)
				
				value:SetParent(nil)

				local PhysicsObject = value:GetPhysicsObject()

				if IsValid( PhysicsObject ) then

					PhysicsObject:SetVelocity(Vector(math.random(-60,60),math.random(-60,60),-math.random(1,200)))

				end

				timer.Simple(5, function()

					if IsValid( value ) then

						value:Remove()

					end

				end )

			end

		end )

	end

	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetCollisionGroup(COLLISION_GROUP_IN_VEHICLE)
	

	local PhysicsObject = self:GetPhysicsObject()

	if IsValid( PhysicsObject ) then

		PhysicsObject:SetVelocity(Vector(math.random(-20,20),math.random(-20,20),-100))

	end

	timer.Simple(5, function()

		if IsValid( self ) then

			self:Remove()

		end

	end )

	self["Tower_Protecting"] = false

	PP_RemoveAllEnemies()

	SetGlobalBool("PP_OngoingEvent", false)

	PP_SpawnTheNextOrderedPlatform()
end

function ENT:OnTakeDamage( dmginfo  )
	if not self["Tower_Protecting"] then return end
	
	if not dmginfo:GetAttacker():IsPlayer() then

		self:SetNW2Int("Tower_Health", self:GetNW2Int("Tower_Health") - dmginfo:GetDamage() )

		if self:GetNW2Int("Tower_Health") <= 0 then

			self:TowerDestroyed()

		end

	end
end

function ENT:Think()
	
	if not self["Tower_Protecting"] or self["Tower_Destroyed"] then return end
	
	if PP["Tower_Round_Length"] - (CurTime() - self:GetNW2Int("Start_Time")) <= 0 then

		self:TowerSaved()

	elseif self["Tower_Protecting"] and CurTime() > self["Next_Bird"] then
		for i=1, (PP["Tower_Enemy_Amount"] or 2) do
			PP_NPCSpawn( 
				self:GetPos() + Vector( 
					math.random(-1000, 1000),
					math.random(-1000, 1000),
					math.random(400, 1000)
				), 
				"pp_enemy_stukabat"
			)

			local Bomb_Chute = ents.Create("pp_bomb_parachute")
			if IsValid( Bomb_Chute ) then
				Bomb_Chute:SetPos(self:GetPos()+Vector(
					math.random(-100,100),
					math.random(-100,100),
					math.random(500,600)
					)
				)
				Bomb_Chute:Spawn()
			end
		end

		self["Next_Bird"] = CurTime() + (PP["Tower_Enemy_Rate"] or 6)
	end

	self:NextThink(CurTime() + 1)
	return true
end

function ENT:Use( ply )
end