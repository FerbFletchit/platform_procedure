AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
 
include('shared.lua')

function ENT:Initialize()
	PP_LoadEntityModel( self )

	PP_StatsAdd( "Levers Generated", 1 )

    self:PhysicsInit(SOLID_NONE)

    for key, value in pairs(self:GetChildren()) do
    	value:SetCollisionGroup(11)
    end

    self:SetUseType(SIMPLE_USE)


	local PhysicsObject = self:GetPhysicsObject()

	if IsValid(PhysicsObject) then
		PhysicsObject:EnableGravity( false )
	end

	AddEffectBlock(self, "chest")

	self["Lever_Alerted_Plys"] = {}
end

function ENT:Think()

	for key, value in pairs(ents.FindInSphere(self:GetPos(),300)) do

		if value:IsPlayer() and value:Alive() then

			if not table.HasValue(self["Lever_Alerted_Plys"], value) then

				table.insert(self["Lever_Alerted_Plys"], value)
				value:SendNotification("Dialouge", {"A lever!", "Should I pull this lever?", "A lever to pull!"})

			end

		end

	end

	self:NextThink(CurTime() + 1)
	return true
end

function ENT:LeverPulled()	
end 