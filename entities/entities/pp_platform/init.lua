AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
 
include('shared.lua')

function ENT:Initialize()
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:StartMotionController()
	self:PhysWake()
	self:SetCustomCollisionCheck(true)
end

function ENT:Think()
	--[[if self.Removing then
		if CurTime() >= self.RemoveStart + self.RemoveLength then
			self:Remove()
		end
	end]]

	local Dist = self:GetPos():DistToSqr(self["Travel"]["pos"])
	
	if (Dist * Dist) <= (PP["Platform_Callback_Distance"] or 1000) and not self["Info"]["Reached_Destination"] then

		self["Info"]["Reached_Destination"] = true

		if self["Callback"] then

			self["Callback"]( self )

		end

	end
end

function ENT:OnRemove()
	for key, value in ipairs(self:GetChildren()) do
		if IsValid(value) and value != self and not value:IsPlayer() then
			value:Remove() -- This removes structure part and keeupright anchor.
		end
	end
end
function ENT:StartDecay(Time)
	self:SetRenderFX(PP["Decay_Effect"])

	for key, value in pairs(self:GetChildren()) do
		value:SetRenderMode(1)
		value:SetRenderFX(PP["Decay_Effect"])
	end

	timer.Simple(Time, function()

		if IsValid(self) then

			self:EmitSound("PP_Sound_Effects/Ticking.mp3",50,100,1,CHAN_AUTO)

			timer.Simple(1, function()

				if IsValid(self) then
					PP_ActionEffect(self, "pp_impact", 1)
					self:EmitSound("PP_Sound_Effects/Death.mp3",60,100,1,CHAN_AUTO)
					self:Remove()

				end

			end )

		end
	end )
end

function ENT:PhysicsSimulate(phys, deltatime)
	phys:Wake()
	phys:EnableMotion(true)
	self["Travel"]["deltatime"] = deltatime
	phys:ComputeShadowControl(self["Travel"])
end