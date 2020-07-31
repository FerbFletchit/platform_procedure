AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
 
include('shared.lua')

function ENT:Initialize()
	
	self:SetModel( "models/aceofspades/gameplay_objects/normal_parachutebigger.mdl" )

	--self:SetMaterial( "models/shiny" or PP["Default_Material"] )
	self:SetUseType(SIMPLE_USE)

	self:SetModelScale(1)
	
	
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:PhysicsInit(SOLID_VPHYSICS)
    self:SetUseType(SIMPLE_USE)
    self:SetSolid(SOLID_VPHYSICS)

    self:SetAngles(Angle(0,45*math.random(1,6),0))

    --self:SetCollisionGroup(COLLISION_GROUP_IN_VEHICLE)


	self:PhysWake()

	self:SetGravity(-15)


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
	self.BombOnShoot = ents.Create("pp_structure_block")
	
	if IsValid( self.BombOnShoot ) then
		
		self.BombOnShoot:SetPos( self:GetPos()-self:GetUp()*35 )
		
		self.BombOnShoot:SetAngles(Angle(0,45*math.random(1,6),0))
		
		self.BombOnShoot:SetParent(self)

		self.BombOnShoot:SetModel( "models/aceofspades/weapons/dynamite.mdl" )
		
		self.BombOnShoot:Spawn()
		
		self.BombOnShoot:SetCollisionGroup(COLLISION_GROUP_NONE)

		self.BombOnShoot:PhysWake()



		self.BombOnShoot["PlayLoop"] = function()
		
			if IsValid( self.BombOnShoot ) then
					
				self.BombOnShoot:EmitSound("pp_sound_effects/Ticking.mp3", 55, 100, 1.1, CHAN_AUTO )
				
				timer.Simple(1, function()

					if IsValid(self.BombOnShoot) then

						self.BombOnShoot["PlayLoop"]()

					end

				end )

			end
		end
		self.BombOnShoot["PlayLoop"]()

	end
	

	local Bomb = self["BombOnShoot"]
	
	function Bomb:OnTakeDamage()
		self:EmitSound("ambient/explosions/explode_" .. math.random(1, 9) .. ".wav")
	end


	function Bomb:Touch()
		self:Plode()
	end

	function Bomb:Plode()
		PP_ActionEffect(self, "pp_impact", 3)
		self:EmitSound("ambient/explosions/explode_" .. math.random(1, 9) .. ".wav")

		for key, value in pairs(ents.FindInSphere(self:GetPos(),300)) do

			if value:GetClass() == "pp_event_tower" then

				value:TakeDamage(PP["Tower_HP"]/4,self,self)

			end

		end

		self:Remove()
	end

	function Bomb:Use( ply )
		ply:SendNotification("Dialouge", "Defused!")
		self:GetParent():Remove()
	end


	timer.Simple(15, function()
		if IsValid(Bomb) then
			Bomb:Plode()
		end
	end )
end

function ENT:OnTakeDamage()
	if IsValid( self.BombOnShoot ) then
		self.BombOnShoot:Remove()

		local PhysicsObject = self.BombOnShoot:GetPhysicsObject()
		
		if IsValid( PhysicsObject ) then
			PhysicsObject:SetVelocity(self:GetVelocity())
		end

		self:Remove()
	end
end

function ENT:Think()
	if not IsValid(self.BombOnShoot) then
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

		ply:SendNotification("Dialouge", "Defused!")

	end

end

function ENT:OnRemove()
	PP_ActionEffect(self, "pp_impact", 1)
	self:EmitSound("pp_sound_effects/Pop1.mp3", 75, 80, 1, CHAN_AUTO)
end