
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include('shared.lua')

function ENT:Initialize()
	self:DrawShadow(false)
	self:SetSolid(SOLID_NONE)
end

function ENT:Think()
	local owner = self:GetOwner()
	if !IsValid(owner) then return end
	local att = owner:GetAttachment(owner:LookupAttachment("eye"))
	local posStart = att.Pos
	local posDest = att.Pos +att.Ang:Forward() *32768
	local tr = util.TraceLine({start = posStart, endpos = posDest, filter = {self, owner}})
	local ents = util.BlastDmg(self, owner, tr.HitPos, 30, (PP["BOSS_NPC"]["pp_boss_worm"]["Beam Damage"] or 1), owner, DMG_ENERGYBEAM, true)
	self:NextThink(CurTime())
	return true
end