AddCSLuaFile("shared.lua")

include('shared.lua')

ENT.NPCFaction = NPC_FACTION_RACEX
ENT.iClass = CLASS_RACEX
util.AddNPCClassAlly(CLASS_RACEX,"monster_alien_babyvoltigore")
ENT.sModel = "models/opfor/baby_voltigore.mdl"
ENT.fMeleeDistance = 26
ENT.fRangeDistance = 700

ENT.bPlayDeathSequence = true

ENT.skName = "babyvoltigore"
ENT.CollisionBounds = Vector(13,13,31)

ENT.iBloodType = BLOOD_COLOR_GREEN
ENT.sSoundDir = "npc/voltigore/"

ENT.tblAlertAct = {}
ENT.tblDeathActivities = {
	[HITBOX_GENERIC] = {ACT_DIEBACKWARD, ACT_DIEFORWARD, ACT_DIESIMPLE}
}

ENT.m_tbSounds = {
	--["Attack"] = "voltigore_attack_melee[1-2].wav",
	--["Range"] = "voltigore_attack_shock.wav",
	--["Alert"] = "voltigore_alert[1-3].wav",
	["Death"] = "voltigore_die[1-3].wav",
	["Pain"] = "voltigore_pain[1-4].wav",
	--["Idle"] = "voltigore_idle[1-3].wav",
	["Step"] = "voltigore_footstep[1-3].wav",
	--["Grunt"] = "voltigore_run_grunt[1-2].wav"
}


function ENT:OnInit()
	--self:SetNPCFaction(NPC_FACTION_RACEX,CLASS_RACEX)
	self:SetHullType(HULL_HUMAN)
	self:SetHullSizeNormal()
	self:SetCollisionBounds(self.CollisionBounds,Vector(self.CollisionBounds.x *-1,self.CollisionBounds.y *-1,0))
	
	self:slvCapabilitiesAdd(bit.bor(CAP_MOVE_GROUND,CAP_MOVE_JUMP,CAP_OPEN_DOORS))
	self:slvSetHealth(GetConVarNumber("sk_" .. self.skName .. "_health"))
	
	self:SetSoundPitch(math.random(90,150))
	self.nextRange = 0
end

--[[function ENT:Think()
	
	local pos = self:GetPos() -- Thanks bobble.
	local tracedata = {}
	tracedata.start = pos
	tracedata.endpos = pos
	tracedata.filter = self
	tracedata.mins = self:OBBMins()
	tracedata.maxs = self:OBBMaxs()
	local trace = util.TraceHull( tracedata )

	if trace.Entity and !trace.Entity:IsWorld() and trace.Entity:IsValid() then
		self:SetPos(self:GetPos()+self:GetUp()*10)
	end

	self:NextThink(CurTime()+0.1)
	return true
end]]

function ENT:_PossPrimaryAttack(entPossessor, fcDone)
	self:SLVPlayActivity(ACT_MELEE_ATTACK1,false,fcDone)

	self:EmitSound("npc/voltigore/voltigore_attack_melee"..math.random(1,2)..".wav",75,math.random(80,100),1,CHAN_AUTO)
end

function ENT:_PossSecondaryAttack(entPossessor, fcDone)
	self:SLVPlayActivity(ACT_RANGE_ATTACK1,false,fcDone)
	self:EmitSound("npc/voltigore/voltigore_attack_shock.wav",75,math.random(80,100),1,CHAN_AUTO)
end

function ENT:OnFoundEnemy(iEnemies)
	self.nextRange = CurTime() +math.Rand(2,3)
	self:EmitSound("npc/voltigore/voltigore_alert"..math.random(1,3)..".wav",75,math.random(80,100),1,CHAN_AUTO)
end

function ENT:EventHandle(...)
	local event = select(1,...)

	local pos = self:GetPos() -- Thanks bobble.
	local tracedata = {}
	tracedata.start = pos
	tracedata.endpos = pos
	tracedata.filter = self
	tracedata.mins = self:OBBMins()
	tracedata.maxs = self:OBBMaxs()
	local trace = util.TraceHull( tracedata )

	if trace.Entity and !trace.Entity:IsWorld() and trace.Entity:IsValid() then
		self:SetPos(self:GetPos()+self:GetUp()*10)
	end
	
	if(event == "mattack") then
		local atk = select(2,...)
		local fDist = self.fMeleeDistance
		local iDmg
		local angViewPunch
		local bLeft = atk == "left"
		local bBoth = !bLeft
		
		if bLeft then
			iDmg = GetConVarNumber("sk_babyvoltigore_dmg_slash")
			angViewPunch = Angle(10,-6,3)
		else
			iDmg = GetConVarNumber("sk_babyvoltigore_dmg_slash_both")
			angViewPunch = Angle(14,0,0)
		end
		self:DealMeleeDamage(fDist,iDmg,angViewPunch)
		PP_ActionEffect(self:GetPos(), "pp_impact", 1)
		return true
	elseif(event == "rattack") then
		local atk = select(2,...)
		local bBeamStart = atk == "beamstart"
		local bBeam = !bBeamStart
		if bBeamStart then
			self:EmitSound("debris/beamstart2.wav", 75, math.random(200,250))
			return true
		end
		local pos = self:GetPos() +self:GetForward() *28 +self:GetUp() *10
		local fDist = self.fMeleeDistance
		local iDmg = 30
		local angViewPunch = Angle(1,0,0)
		self:DoMeleeDamage(fDist,iDmg,angViewPunch,nil,nil,nil,false)
		local effectdata = EffectData()
		effectdata:SetStart(pos)
		effectdata:SetOrigin(pos)
		effectdata:SetNormal(self:GetForward())
		effectdata:SetScale(1)
		util.Effect("MetalSpark", effectdata)
		self:EmitSound("ambient/levels/labs/electric_explosion5.wav", 75, math.random(80,100))
		self.nextRange = CurTime() +math.Rand(4,12)
		PP_ActionEffect(self:GetPos(), "pp_impact", 1)
		return true
	end
end

function ENT:SelectScheduleHandle(enemy,dist,distPred,disp)
	if(disp == D_HT) then
		if self:CanSee(enemy) then
			local bMelee = dist <= self.fMeleeDistance || distPred <= self.fMeleeDistance
			if bMelee then
				self:SLVPlayActivity(ACT_MELEE_ATTACK1, true)
				return
			end
			local bRange = dist <= self.fRangeDistance && CurTime() >= self.nextRange
			if bRange then
				self:SLVPlayActivity(ACT_RANGE_ATTACK1, true)
				return
			end
		end
		self:ChaseEnemy()
	elseif(disp == D_FR) then
		self:Hide()
	end
end