include('shared.lua')

local matGlow = Material("sprites/glow_grn.vmt")
local matBeam = Material("sprites/gworm_beam.vmt")

ENT.RenderGroup = RENDERGROUP_BOTH
function ENT:Initialize()
	local owner = self:GetOwner()
	if !IsValid(owner) then return end
	local att = owner:GetAttachment(owner:LookupAttachment("eye"))
	local posStart = att.Pos
	local posDest = att.Pos +att.Ang:Forward() *32768
	posDest = util.TraceLine({start = posStart, endpos = posDest, filter = {self, owner}}).HitPos
	self:SetRenderBoundsWS(posStart, posDest, Vector() *10)
end

function ENT:Think()
end

function ENT:Draw()
	local owner = self:GetOwner()
	if !IsValid(owner) then return end
	local att = owner:GetAttachment(owner:LookupAttachment("eye"))
	local posStart = att.Pos
	local posDest = att.Pos +att.Ang:Forward() *32768
	posDest = util.TraceLine({start = posStart, endpos = posDest, filter = {self, owner}}).HitPos
	render.SetMaterial(matGlow)
	render.DrawSprite(posStart, 80, 80, Color(255,0,0,255))
	render.SetMaterial(matBeam)
	render.DrawBeam(posStart, posDest, 20, 1, 1, PP["Color_Pallete"]["NPC_BOSS_Health"])
	self:SetRenderBoundsWS(posStart, posDest, Vector() *10)
end

function ENT:IsTranslucent()
	return true
end
