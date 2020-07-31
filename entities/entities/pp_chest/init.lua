AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
 
include('shared.lua')

function ENT:Initialize()
	PP_LoadEntityModel( self )

	self:SetCollisionGroup(COLLISION_GROUP_INTERACTIVE)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetUseType(SIMPLE_USE)
    self:SetSolid(SOLID_VPHYSICS)

	--self:SetPos(self:GetPos()+Vector(0,0,5))
	--self:DropToFloor()

	local PhysicsObject = self:GetPhysicsObject()

	if IsValid(PhysicsObject) then
		PhysicsObject:EnableGravity( false )
	end

	AddEffectBlock(self, "chest")
	
	PP_StatsAdd( "Chests Generated", 1 )

end

local chestcol_ignore = {"pp_ent_component", "pp_chest", "player"}

--[[function ENT:Think()

	local pos = self:GetPos() -- Thanks bobble.
	local tracedata = {}
	tracedata.start = pos
	tracedata.endpos = pos
	tracedata.filter = {self,self:GetChildren()[1], self:GetChildren()[2]}
	tracedata.mins = self:OBBMins()
	tracedata.maxs = self:OBBMaxs()
	local trace = util.TraceHull( tracedata )

	if trace.Entity and not table.HasValue(chestcol_ignore,trace.Entity:GetClass()) and !trace.Entity:IsWorld() and trace.Entity:IsValid() then
		self:SetPos(self:GetPos()+self:GetUp()*10)
	end

	self:NextThink(CurTime()+0.5)

	return true
end]]

function ENT:Use( ply )
end