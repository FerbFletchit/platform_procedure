AddCSLuaFile( "shared.lua" )

include('shared.lua')

--ENT.NPCFaction = NPC_FACTION_RACEX
--ENT.iClass = CLASS_RACEX
--util.AddNPCClassAlly(CLASS_RACEX,"monster_pitworm_up")
ENT.sModel = "models/opfor/pit_worm_up.mdl"
ENT.fMeleeDistance = 400
ENT.fRangeDistance = 4000

ENT.bPlayDeathSequence = true
ENT.tblIgnoreDamageTypes = {DMG_ACID, DMG_AIRBOAT, DMG_DISSOLVE, DMG_DROWN, DMG_DROWNRECOVER, DMG_FALL, DMG_NERVEGAS, DMG_PHYSGUN, DMG_VEHICLE}
ENT.tblAlertAct = {}

ENT.iBloodType = BLOOD_COLOR_GREEN
ENT.sSoundDir = "npc/pitworm/"
ENT.m_tbSounds = {
	["Alert"] = { "pit_worm_alert(scream).wav", "pit_worm_alert.wav" },
	["Attack"] = "pit_worm_attack_swipe[1-3].wav",
	--["AttackEye"] = "pit_worm_attack_eyeblast.wav",
	["Pain"] = { "pit_worm_flinch[1-2].wav", "pit_worm_angry[1-3].wav" },
	["Death"] = "pit_worm_death.wav",
	["Idle"] = "pit_worm_idle[1-3].wav"
}

ENT.tblDeathActivities = {
	[HITBOX_GENERIC] = ACT_DIESIMPLE
}

function ENT:OnInit()
	--self:SetNPCFaction(NPC_FACTION_RACEX,CLASS_RACEX)
	self:SetHullType(HULL_LARGE)
	self:SetHullSizeNormal()
	self:SetMoveType(MOVETYPE_STEP)
	
	self:SetSoundLevel(88)
	self:SetCollisionBounds(Vector(60, 60, 566), Vector(-60, -60, 200))

	self:slvSetHealth(GetConVarNumber("sk_pitworm_health"))
	
	self.NextRotate = CurTime() + 1
	self.nextBlink = CurTime() +math.Rand(2,8)
	self.nextAttack = 0
	
end

function ENT:_PossPrimaryAttack(entPossessor, fcDone)
	self:SLVPlayActivity(ACT_RANGE_ATTACK1, false, fcDone)
end

function ENT:_PossSecondaryAttack(entPossessor, fcDone)
	self:SLVPlayActivity(ACT_MELEE_ATTACK1, false, fcDone)
end

function ENT:DamageHandle(dmginfo)
	if !dmginfo:IsExplosionDamage() then dmginfo:ScaleDamage(0.1) end
end

function ENT:OnThink()
	if not self.entEnemy and CurTime() >= self.NextRotate then
		self:FacePosition(VectorRand(-10000,10000))
		self.NextRotate = CurTime() + 0.5
		return
	end

	if CurTime() >= self.nextBlink then
		self.nextBlink = CurTime() + math.Rand(2,8)
		self:SetSkin(1)
		local iDelay = 0.1
		for i = 5, 0, -1 do
			timer.Simple(iDelay, function()
				if IsValid(self) then
					self:SetSkin(i)
				end
			end)
			iDelay = iDelay +0.5
		end
	end
	local pitch, yaw = self:GetPoseParameter("aim_pitch"), self:GetPoseParameter("aim_yaw")
	local bPossessed = self:SLV_IsPossesed()
	if bPossessed || IsValid(self.entEnemy) then
		self:UpdateLastEnemyPositions()
		local att = self:GetAttachment(self:LookupAttachment("eye"))
		local pos = att.Pos
		local ang = att.Ang
		local posDest
		if !bPossessed then posDest = self.posEnemyLast || self.entEnemy:GetCenter()
		else
			local tr = self:GetPossessor():GetPossessionEyeTrace()
			posDest = tr.HitPos
		end
		local angDest = (posDest -pos):Angle()
		local angSelf = self:GetAttachment(self:LookupAttachment("eye_def")).Ang
		angDest = angDest -angSelf
		angDest.p = math.NormalizeAngle(angDest.p)
		angDest.y = math.NormalizeAngle(angDest.y)
		pitch = pitch +math.min(angDest.p -pitch, 1)
		yaw = yaw +math.min(angDest.y -yaw, 1)
	else
		pitch = math.Approach(pitch, 0, -1)
		yaw = math.Approach(yaw, 0, -1)
	end
	
	self:SetPoseParameter("aim_pitch", pitch)
	self:SetPoseParameter("aim_yaw", yaw)
	self:NextThink(CurTime() + 0.02)
	return true
end

function ENT:EventHandle(...)
	local event = select(1,...)
	local subevent = select(2,...)

	if (event == "rattack") then
		if (subevent == "start") then
			local entBeam = ents.Create("obj_beam_wormboss")
			entBeam:SetOwner(self)
			entBeam:Spawn()
			entBeam:Activate()
			self.entBeam = entBeam
			self:EmitSound("pp_sound_effects/boss_laser_"..math.random(1,3)..".mp3", 85, math.random(80,100), 1, CHAN_AUTO)
			
			local shouldfling = math.Rand(0.1,1)
			if shouldfling <= 0.7 then
				local radius = math.random(500,7000)
				
				effects.BeamRingPoint( self:GetPos()+self:GetUp()*200, 5, 100, radius, 50, 15, PP["Color_Pallete"]["NPC_BOSS_Health"])

				for key, value in pairs( ents.FindInSphere(self:GetPos(),radius/2) ) do
					
					if value:IsPlayer() then

						value:SetVelocity( -self:GetVelocity() + Vector(0,0,600) )
					end

				end
			end

			self:DeleteOnDeath(self.entBeam)
		elseif IsValid(self.entBeam) then
			self.entBeam:Remove()
		end
		return true
	end
	if (event == "mattack") then
		local fDist = self.fMeleeDistance
		local iDmg = GetConVarNumber("sk_pitworm_dmg_slash")
		local angViewPunch = Angle(28,0,0)
		self:DoMeleeDamage(fDist,iDmg,angViewPunch)
		return true
	end
end

function ENT:Interrupt()
	if self:SLV_IsPossesed() then self:_PossScheduleDone() end
	if IsValid(self.entBeam) then self.entBeam:Remove() end
end

function ENT:SelectScheduleHandle(enemy,dist,distPred,disp)--(fDist,fDistPredicted,iDisposition)
	if (disp == 1 || disp == 2) && self:CanSee(self.entEnemy) then
		if distPred <= self.fMeleeDistance then
			self:SLVPlayActivity(ACT_MELEE_ATTACK1, true)
			self.nextAttack = CurTime() +4
		elseif distPred <= self.fRangeDistance then
			if CurTime() >= self.nextAttack then
				self:SLVPlayActivity(ACT_RANGE_ATTACK1, true)
				self.nextAttack = CurTime() +4
			else 
				self:FacePosition(self.entEnemy:GetPos()) 
			end
		end
	end
end
