if (SERVER) then 
	
	local fueraweaps = {
		"weapon_physgun",
		"weapon_physcannon",
		"weapon_pistol",
		"weapon_crowbar",
		"weapon_slam",
		"weapon_357",
		"weapon_smg1",
		"weapon_ar2",
		"weapon_crossbow",
		"weapon_shotgun",
		"weapon_frag",
		"weapon_stunstick",
		"weapon_rpg",
		"gmod_camera",
		"gmod_toolgun"
	}

	function climbb_Spawn(ply)
		ply:GetViewModel():SetNoDraw(false)
		ply.Lastclimbb = CurTime()
		ply.LastJump = CurTime()
	end
	hook.Add("PlayerSpawn","climbb_Spawn",climbb_Spawn)

	function WallMountSound(ply)
		ply:EmitSound("pp_sound_effects/doublejump.mp3", math.Rand(30, 35), math.Rand(90, 100))
	end

	function climbb()
	for id,ply in pairs (player.GetAll()) do


	if ply.ArmaEquipar and CurTime() >= ply.ArmaEquipar then
	if not ply:Alive() then return end
	ply.ArmaEquipar = nil
	if ply:GetActiveWeapon():IsValid() then
	if table.HasValue(fueraweaps,ply:GetActiveWeapon():GetClass()) then
	timer.Simple(0.02,function()
	ply:GetActiveWeapon():SendWeaponAnim(ACT_VM_DRAW)
	end)
	else
	timer.Simple(0.02,function()
	ply:GetActiveWeapon():SendWeaponAnim(ACT_VM_DRAW)
	ply:GetActiveWeapon():Deploy()
	end)
	end
	ply:GetViewModel():SetNoDraw(false)
	end
	end
	

	-- auto jump close--
	if ply:KeyDown(IN_SPEED) and ply:KeyDown(IN_FORWARD) and ply:OnGround() then
		tracedata={}
		tracedata.start = ply:EyePos() + (ply:GetUp() * 0) + (ply:GetForward() * -30)
		tracedata.endpos = ply:EyePos()+ (ply:GetUp() * 100) + (ply:GetForward() * 30)
		tracedata.filter = ply
		local traceAutoHigh2 = util.TraceLine(tracedata)

		tracedata={}
		tracedata.start = ply:EyePos() + (ply:GetUp() * -1) + (ply:GetForward() * 32)
		tracedata.endpos = ply:EyePos()+ (ply:GetUp() * -110) + (ply:GetForward() * 128)
		tracedata.filter = ply
		local traceAutoLow = util.TraceLine(tracedata)
		
		tracedata={}
		tracedata.start = ply:EyePos() + (ply:GetForward() * 32)
		tracedata.endpos = ply:EyePos() + (ply:GetForward() * 128)
		tracedata.filter = ply
		local traceAutoHigh = util.TraceLine(tracedata)
		
		tracedata={}
		tracedata.start = ply:EyePos() + (ply:GetForward() * 129) + (ply:GetUp() * 50)
		tracedata.endpos = ply:EyePos() + (ply:GetForward() * 140) + (ply:GetUp() * -80)
		tracedata.filter = ply
		local traceFloorto = util.TraceLine(tracedata)
		
		if not (traceAutoLow.Hit) and not (traceAutoHigh.Hit) and not (traceAutoHigh2.Hit) and (traceFloorto.Hit) and ply:OnGround() then
		ply:ViewPunch(Angle(-3, 0, 0));
		ply:SetLocalVelocity(Vector(0,0,260) + (ply:EyeAngles():Right()*0 +  ply:GetForward()*200))
		end
		end
		-- auto jump close end--
		
		--high--
		if ply:KeyDown(IN_SPEED) and ply:KeyDown(IN_FORWARD) and ply:OnGround() then
		if not( ply:Crouching() ) then
		tracedata={}
		tracedata.start = ply:EyePos()+(ply:GetForward()*1)+(ply:GetUp() * -10 )
		tracedata.endpos = ply:EyePos()+(ply:GetForward()*128)+(ply:GetUp() * 30)
		tracedata.filter = ply
		local traceAimObj = util.TraceLine(tracedata)
		
		tracedata={}
		tracedata.start = ply:EyePos() + (ply:GetUp() * 0) + (ply:GetForward() * -30)
		tracedata.endpos = ply:EyePos()+ (ply:GetUp() * 100) + (ply:GetForward() * 30)
		tracedata.filter = ply
		local traceHighHigh2 = util.TraceLine(tracedata)
		
		tracedata={}
		tracedata.start = ply:EyePos() + (ply:GetUp() * 21) + (ply:GetForward() * 1)
		tracedata.endpos = ply:EyePos()+ (ply:GetUp() * 60) + (ply:GetForward() * 64)
		tracedata.filter = ply
		local traceHighLow = util.TraceLine(tracedata)
		
		tracedata={}
		tracedata.start = ply:EyePos() + (ply:GetUp() * 61) + (ply:GetForward() * 1)
		tracedata.endpos = ply:EyePos()+ (ply:GetUp() * 98) + (ply:GetForward() * 64)
		tracedata.filter = ply
		local traceHighHigh = util.TraceLine(tracedata)
		if ply:KeyDown(IN_DUCK) then
		return
		end
		if (traceHighLow.Hit) and (traceAimObj.Hit) and not (traceHighHigh.Hit) and not (traceHighHigh2.Hit) and not( ply:Crouching() ) and ply:OnGround() then
		if not ply:OnGround() then
		return
		end
		ply:SetLocalVelocity(Vector(0,0,350) + (ply:EyeAngles():Up()*0 +  ply:GetForward()*200))
		end
		end
		end
		--high end--
	if not( ply:Crouching() ) then
	if ply:KeyDown(IN_SPEED)and ply:KeyDown(IN_FORWARD) then

		--hip--
		if not( ply:Crouching() ) then
		
		tracedata={}
		tracedata.start = ply:EyePos() + (ply:GetUp() * 0) + (ply:GetForward() * -30)
		tracedata.endpos = ply:EyePos()+ (ply:GetUp() * 100) + (ply:GetForward() * 30)
		tracedata.filter = ply
		local traceHipHigh2 = util.TraceLine(tracedata)
		
		tracedata={}
		tracedata.start = ply:EyePos() + (ply:GetUp() * -10) + (ply:GetForward() * 1)
		tracedata.endpos = ply:EyePos()+ (ply:GetUp() * -32) + (ply:GetForward() * 64)
		tracedata.filter = ply
		local traceHipLow = util.TraceLine(tracedata)
		
		tracedata={}
		tracedata.start = ply:EyePos() + (ply:GetUp() * -11) + (ply:GetForward() * 1)
		tracedata.endpos = ply:EyePos()+ (ply:GetUp() * 63) + (ply:GetForward() * 64)
		tracedata.filter = ply
		local traceHipHigh = util.TraceLine(tracedata)
		if ply:KeyDown(IN_DUCK) then
		return
		end
		if (traceHipLow.Hit) and not (traceHipHigh.Hit) and not (traceHipHigh2.Hit) and not( ply:Crouching() ) then
		ply:ViewPunch(Angle(2, 1, -1));
		WallMountSound(ply)
		
		PP_ActionEffect(ply, "pp_jump", 1)

		ply:SetLocalVelocity(Vector(0,0,300) + (ply:EyeAngles():Up()*0 +  ply:GetForward()*200))
		end
		end
		--hip end--
		
		end
		if ply.Lastclimbb and CurTime() >= ply.Lastclimbb and not( ply:Crouching() ) then
		--normal--
		tracedata={}
		tracedata.start = ply:EyePos()+(ply:GetForward()*1)+(ply:GetUp() * -10 )
		tracedata.endpos = ply:EyePos()+(ply:GetForward()*128)+(ply:GetUp() * 30)
		tracedata.filter = ply
		local traceAimObj = util.TraceLine(tracedata)
		
		tracedata={}
		tracedata.start = ply:EyePos() + (ply:GetUp() * 0) + (ply:GetForward() * -30)
		tracedata.endpos = ply:EyePos()+ (ply:GetUp() * 100) + (ply:GetForward() * 30)
		tracedata.filter = ply
		local traceNorHigh2 = util.TraceLine(tracedata)
		
		tracedata={}
		tracedata.start = ply:EyePos() + (ply:GetUp() * -11) + (ply:GetForward() * 32)
		tracedata.endpos = ply:EyePos()+ (ply:GetUp() * 20) + (ply:GetForward() * 64)
		tracedata.filter = ply
		local traceNorLow = util.TraceLine(tracedata)
		
		tracedata={}
		tracedata.start = ply:EyePos() + (ply:GetUp() * 21) + (ply:GetForward() * 32)
		tracedata.endpos = ply:EyePos()+ (ply:GetUp() * 58) + (ply:GetForward() * 64)
		tracedata.filter = ply
		local traceNorHigh = util.TraceLine(tracedata)
		
		if (traceNorLow.Hit) and (traceAimObj.Hit) and not (traceNorHigh.Hit) and not (traceNorHigh2.Hit)and ply:KeyDown(IN_SPEED)and ply:KeyDown(IN_FORWARD) then
		ply:GetViewModel():SetNoDraw(true)
		ply.Lastclimbb = CurTime() + 1.5
		ply:SetLocalVelocity(Vector(0,0,400) + (ply:EyeAngles():Up()*0 +  ply:GetForward()*100))
		ply.ArmaEquipar = CurTime() + 0.5
		end
		--normal end--

	end
	end
	end
	end
	hook.Add("Think","climbb",climbb)
	
end
