-- Junk pile of code --

local function PP_lastminuteeffortforcollision( ply )
	if IsValid( ply ) and ply:IsPlayer() then
		
		ply:SetCollisionGroup(15)
		
		ply:SetAvoidPlayers( false )
		
		for key, value in pairs(player.GetAll()) do -- Nothign else would fucking work and I have 10 hours left.
			constraint.NoCollide( ply, value, 0, 0 )
		end

	end
end
hook.Add( "PlayerSpawn", "PP_lastminuteeffortforcollision", PP_lastminuteeffortforcollision )

hook.Add("SetupMove", "PP_Jumping", function(ply, mv)
	if not mv:KeyPressed(IN_JUMP) then -- Don't do anything if not jumping.
		return
	end

	local PhysObj = ply:GetPhysicsObject()

	if IsValid(PhysObj) then

		PhysObj:AddVelocity(Vector(0,0,ply:GetJumpPower()))

	end
	
	ply:DoCustomAnimEvent(PLAYERANIMEVENT_JUMP , -1)
end)

hook.Add( "PlayerUse", "PP_Use_Prevention", function( ply, ent )
	if not ply:Alive() then
		ply:SendNotification("I'm dead :(", "Dialouge")
		return
	end
end )

if CLIENT then
	CreateMaterial("PP_Arms", "VertexLitGeneric", {
	  	["$basetexture"] = PP["ViewModelTexture"],
	  	["$color2"] = "[ "..(PP["Color_Pallete"]["ViewModelArms"].r/255).." "..(PP["Color_Pallete"]["ViewModelArms"].g/255).." "..(PP["Color_Pallete"]["ViewModelArms"].b/255).." ]",
	} )
end

function PP_AddHealth( ply, health )

	if IsValid( ply ) then

		local New_HP = ply:Health() + health

		if New_HP > ply:GetMaxHealth() then

			ply:SetHealth( ply:GetMaxHealth() )

			PP_ActionEffect(ply, "pp_heal", 2)

		else

			ply:SetHealth(New_HP)
			PP_ActionEffect(ply, "pp_heal", 2)

		end

	end

end

function GM:PlayerFootstep(ply, pos, foot, sound, volume, rf)
	
	if not PP["Materials"] then
		return true
	end

	local Trace = util.QuickTrace( pos, Vector(0,0,-10), ply )
	if Trace.Hit then 
		local Found_Material = string.TrimLeft(Trace.Entity:GetMaterial(), "!" )
		if PP["Materials"][Found_Material] and PP["Materials"][Found_Material]["Foot_Step"] then
			ply:EmitSound( PP["Materials"][Found_Material]["Foot_Step"](), 35, 100, 1, 4 )
		else
			ply:EmitSound( "player/footsteps/woodpanel"..math.random(1,4)..".wav", 35, 100, 1, 4 )
		end
	end
	return true
end

function PP_GetRandomAlivePlayer(ply)
	for key, value in RandomPairs( player.GetAll() ) do
		if value:Alive() and ply != value then
			return value
		end
	end
end

function PP_SpawnPlayerInSafeArea(ply)
	if #player.GetAll() > 1 then -- If not single player.
		for key, value in pairs( player.GetAll() ) do
			if value:Alive() and ply != value then -- Find another alive player
				local Velocity = value:GetVelocity()

				if Velocity[3] > ( -200 ) then -- Player not falling.
					ply:SetPos(value:GetPos())
					return
				end
			end
		end
		-- If no safe players then, spawn player at random player.
		ply:SetPos(PP_GetRandomAlivePlayer(ply):GetPos())
	elseif IsValid(PP_LastPlatform()) then
		ply:SetPos(PP_LastPlatform():GetPos() + PP_LastPlatform():GetUp()*50)
	end
end

local Player = FindMetaTable("Player")

function Player:DangerOMG()
	
	self:EmitSound("pp_sound_effects/boss_alert.mp3",55,100,1,CHAN_AUTO)

	self:SetNW2Bool("PP_Danger", true)
	self:SetNW2String("PP_Danger_String", table.Random(PP["Danger_Lines"]))
	self:ConCommand("act zombie")
	util.ScreenShake( Vector(1,1,1), 5, 5, 5, 5000 )

	timer.Simple(5, function()
		if IsValid(self) then
			self:SetNW2Bool("PP_Danger", false)
		end
	end )
end

if CLIENT then
	function PP_DialougeDraw( ply )
		if ply:GetNW2Bool("PP_Danger") then
			local Danger_Text = ply:GetNW2String("PP_Danger_String")
			draw.SimpleText(Danger_Text,"PP_DANGER",math.random(-2,2),-30+math.random(-2,2),PP["Color_Pallete"]["Dark"],TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			draw.SimpleText(Danger_Text,"PP_DANGER",math.random(-5,5),-30+math.random(-5,5),PP["Color_Pallete"]["Danger"],TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
		elseif ply:GetNW2String("PP_Dialouge") != "" then
			local Head_Dialouge_text = ply:GetNW2String("PP_Dialouge")
			draw.SimpleText(Head_Dialouge_text,"PP_Dialouge_head",0,-50,PP["Color_Pallete"]["White"],TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
		end
	end
end