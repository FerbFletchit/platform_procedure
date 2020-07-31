AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
 
include('shared.lua')

function ENT:Initialize()
	PP_LoadEntityModel( self )

	SetGlobalBool("PP_OngoingEvent", true)

	self:SetCollisionGroup(COLLISION_GROUP_INTERACTIVE)
    self:SetMoveType(MOVETYPE_NONE)
    self:PhysicsInit(SOLID_NONE)
    self:SetUseType(SIMPLE_USE)
    self:SetSolid(SOLID_VPHYSICS)

	self:SetPos(self:GetPos()+self:GetAngles():Up()*50)
	self:DropToFloor()

	local PhysicsObject = self:GetPhysicsObject()

	if IsValid(PhysicsObject) then
		PhysicsObject:EnableGravity( false )
	end

	local Beacon_Lever = ents.Create("pp_lever")
	if IsValid( Beacon_Lever ) then
		Beacon_Lever:SetParent(self)
		Beacon_Lever:Spawn()
		Beacon_Lever:SetPos(self:GetPos()+Beacon_Lever:GetAngles():Right()*45- Beacon_Lever:GetAngles():Up()*8)
		Beacon_Lever:SetAngles(Angle(0,0,0))

		function Beacon_Lever:LeverPulled()
			self:GetParent()["Next_Chute"] = CurTime()
			self:GetParent():SetNW2Int("Start_Time", CurTime())
			self:GetParent():SetNW2Bool("Beacon_Activated", true)
			self:SetNW2Bool("Beacon_Triggered", true)
			self:EmitSound("pp_sound_effects/beacon_power.mp3",65,100,1,CHAN_AUTO)
			BroadcastNotification({"Look in the sky!", "Loot's falling!", "Shoot the parachutes!", "Care package!", "Loot's coming down!"}, "Dialouge")
		end
	end

	timer.Simple(PP["Beacon_Round_Length"], function()
		if IsValid(self) then
			if not self:GetNW2Bool("Beacon_Triggered") then
				self:BeaconOver()
			end
		end
	end )

end

function ENT:OnRemove()
	if self:GetNW2Bool("Beacon_Activated") then
		SetGlobalBool("PP_OngoingEvent", false)
		PP_SpawnTheNextOrderedPlatform()
	end
end

function ENT:BeaconOver()
	self:SetNW2Bool("Beacon_Activated", false)
	SetGlobalBool("PP_OngoingEvent", false)
	PP_SpawnTheNextOrderedPlatform()
end

function ENT:Think()
	if not self:GetNW2Bool("Beacon_Activated") then return end
	
	if PP["Beacon_Round_Length"] - (CurTime() - self:GetNW2Int("Start_Time")) <= 0 then

		self:BeaconOver()

	elseif self:GetNW2Bool("Beacon_Activated") and CurTime() > self["Next_Chute"] then
		for i=1, (PP["Beacon_Chute_Amount"] or 1) do

			local PP_Parachute = ents.Create("pp_loot_parachute")
		
			if IsValid( PP_Parachute ) then

				PP_Parachute:SetPos(self:GetPos() + Vector(math.random(-300,300),math.random(-300,300),1000) )

				PP_Parachute:Spawn()

			end
		end

		self["Next_Chute"] = CurTime() + (PP["Beacon_Chute_Rate"] or 3)
	end

	self:NextThink(CurTime() + 1)
	return true
end

function ENT:Use( ply )
end