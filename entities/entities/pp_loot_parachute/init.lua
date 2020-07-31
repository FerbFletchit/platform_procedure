AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
 
include('shared.lua')

function ENT:Initialize()
	
	self:SetModel( "models/aceofspades/gameplay_objects/normal_parachutebigger.mdl" )

	self:SetUseType(SIMPLE_USE)
	
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:PhysicsInit(SOLID_VPHYSICS)
    self:SetUseType(SIMPLE_USE)
    self:SetSolid(SOLID_VPHYSICS)

	self:PhysWake()

	self:SetGravity(-15)

	PP_StatsAdd( "Parachutes Generated", 1 )

	local KeepUpright = ents.Create("prop_physics")
	
	if IsValid(KeepUpright) then
	
		KeepUpright:SetPos(self:GetPos())
		
		KeepUpright:SetModel("models/hunter/blocks/cube1x1x1.mdl")
		
		KeepUpright:SetCollisionGroup(10) -- Doesn't collide with anything.
		
		KeepUpright:Spawn()

		KeepUpright:SetNoDraw( true )

		local PhysicsObject = KeepUpright:GetPhysicsObject()
		local PhysicsObject2 = self:GetPhysicsObject()
		
		if IsValid(PhysicsObject) and IsValid(PhysicsObject2) then

			PhysicsObject:EnableGravity(false)
			PhysicsObject2:EnableGravity( false )

			PhysicsObject:SetMass( PhysicsObject2:GetMass() ) -- Mass of keepupright must match the platform for effect.
			
			constraint.Keepupright( KeepUpright, Angle(0,0,0), 0, PhysicsObject2:GetMass() )
			constraint.Weld( self, KeepUpright, 0, 0, 0, true, true )

			PhysicsObject2:SetVelocity(Vector(0,0,-100))

		end

	end

	-- Spawn randomo loot 
	local loot_shoot_select = PP_Loot_Random()
	self.Loot_On_Shoot = ents.Create(loot_shoot_select["Entity"])
	
	if IsValid( self.Loot_On_Shoot ) then
		self.Loot_On_Shoot:SetPos( self:GetPos()-self:GetUp()*35 )
		self.Loot_On_Shoot:SetAngles(Angle(0,0,0))
		self.Loot_On_Shoot:Spawn()
		self.Loot_On_Shoot:SetCollisionGroup(COLLISION_GROUP_NONE)

		local loot_on_shoot_qual = PP_ProduceRandomIngot(0.1)[2]
		
		self.Loot_On_Shoot:SetMaterial("models/shiny")
		self.Loot_On_Shoot:SetColor(loot_on_shoot_qual["Color"])

		self.Loot_On_Shoot:SetParent(self)
	end


	timer.Simple((PP["Parachute_RemoveTime"] or 30), function()
		if IsValid(self) then
			self:Remove()
		end
	end )
end

function ENT:OnTakeDamage()
	if IsValid( self.Loot_On_Shoot ) then
		self.Loot_On_Shoot:SetParent(nil)

		local PhysicsObject = self.Loot_On_Shoot:GetPhysicsObject()
		
		if IsValid( PhysicsObject ) then
			PhysicsObject:SetVelocity(self:GetVelocity())
		end

		self:Remove()
	end
end

function ENT:Think()
	if not IsValid(self.Loot_On_Shoot) then
		self:SetModelScale(0.1, 0.1)
		timer.Simple(0.1, function()
			if IsValid( self ) then
				self:Remove()
			end
		end )
		self:NextThink( CurTime() + 2 )
	end
	self:NextThink( CurTime() + 1 )
    return true
end

function ENT:Use( ply )
	if IsValid(self) then
		PP_StatsAdd( "Parachutes Looted", 1 )
		ply:AddEntityInventoryItem( self )
	end
end

function ENT:OnRemove()
	PP_ActionEffect(self, "pp_impact", 1)
	self:EmitSound("pp_sound_effects/Pop1.mp3", 75, 80, 1, CHAN_AUTO)
end