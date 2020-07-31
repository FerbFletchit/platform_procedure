AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
 
include('shared.lua')

function ENT:Initialize()
	
	self:SetModel( "models/aceofspades/tools/radar_station.mdl" )

	self:SetMaterial("")

	self:SetUseType(SIMPLE_USE)
	
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:PhysicsInit(SOLID_NONE)
    self:SetUseType(SIMPLE_USE)
    self:SetSolid(SOLID_VPHYSICS)
    self:SetCollisionGroup(COLLISION_GROUP_PASSABLE_DOOR)
    
	local PhysicsObj = self:GetPhysicsObject()
	
	if IsValid(PhysicsObj) then

		PhysicsObj:EnableGravity( false )

		PhysicsObj:SetMass(1)

	end

end


function ENT:Think()
	local healed = nil
	
	for key, value in pairs(ents.FindInSphere(self:GetPos(),200)) do
		if IsValid( value ) then
			if value:IsPlayer() then
				if not value:Alive() then return end
				if value:Health() < value:GetMaxHealth() then
					healed = true
					PP_AddHealth( value, 25)
					PP_ActionEffect(value, "pp_impact", 1)
				end
			end
		end
	end

	if healed then

		PP_ActionEffect(self:GetPos()+self:GetUp()*30, "pp_impact", 1)

		self:EmitSound("pp_sound_effects/Sparkle.mp3",65,math.random(90,100),1,CHAN_AUTO)

		effects.BeamRingPoint( self:GetPos()+self:GetUp()*30, 0.5, 1, 100, 1, 10, Color(0,255,0))
		
	end

	self:NextThink(CurTime()+2)
	return true
end
function ENT:Use( ply )
end

function ENT:OnRemove()
	--self:EmitSound(PP["Sound_Loot_Block_Pickup"], 75, 100, 0.3, CHAN_ITEM)
end