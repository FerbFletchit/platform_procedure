local PP_BossUI = {}

net.Receive("PP_Boss_Spawn", function(len, ply)
	
	local PP_Boss = net.ReadEntity() -- boss entity
	
	local PP_BossName
	if IsValid(PP_Boss) then
		PP_BossName = ( "LVL. "..PP_Boss:GetNW2Int("Enemy_NPC_Level").." "..PP["BOSS_NPC"][PP_Boss:GetClass()]["Name"] )
	else
		PP_BossName = "???"
	end

	if IsValid(PP_BossUI["Frame"]) then 

		PP_BossUI["Frame"]:Remove()

	end
	
	PP_BossUI["Size"] = {ScrW()*0.45, ScrH()*0.12}
	PP_BossUI["Top"] = PP_BossUI["Size"][2]*0.45

	PP_BossUI["Frame"] = vgui.Create("DFrame")

	PP_BossUI["Frame"]:SetPos(0, ScrH()*0.02)

	PP_BossUI["Frame"]:SetSize(PP_BossUI["Size"][1], PP_BossUI["Size"][2])

	PP_BossUI["Frame"]:CenterHorizontal()

	PP_BossUI["Frame"]:SetTitle("")

	PP_BossUI["Frame"]:ShowCloseButton( false )

	--PP_BossUI["Frame"]:MakePopup()  


	PP_BossUI["Frame"]:DockPadding( -- Hey, I finally docked something!!!
		0, -- Left.
		PP_BossUI["Top"], -- Top.
		0, -- Right.
		0  -- Bottom.
	)

	local PP_Boss_Main = PP_BossUI["Frame"]

	function PP_Boss_Main:Paint(w,h)
		draw.SimpleText(PP_BossName, "PP_BossTitle", 15, PP_BossUI["Top"]/2, PP["Color_Pallete"]["White"], TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
	end
	

	PP_BossUI["Health"] = vgui.Create("DPanel", PP_BossUI["Frame"])
	PP_BossUI["Health"]:Dock( FILL )

	local PP_Boss_Healthbar = PP_BossUI["Health"]

	function PP_Boss_Healthbar:Paint(w,h)
		
		draw.RoundedBox(0,0,0,w,h,PP["Color_Pallete"]["Dark"])
		draw.RoundedBox(0,10,10,w - 20,h - 20,PP["Color_Pallete"]["Dark"])

		if not IsValid(PP_Boss) then

			if not PP_BossUI["Frame"]["Removing"] then

				PP_BossUI["Frame"]["Removing"] = true

				PP_BossUI["Frame"]:AlphaTo(0,1,0,function()

					PP_BossUI["Frame"]:Remove()

				end)
			end

		else
			local PP_Boss_HealthChange = math.Clamp((w - 30) * (PP_Boss:Health() / PP_Boss:GetMaxHealth()),0,(w - 30))
			draw.RoundedBox(0,15,15,PP_Boss_HealthChange,h - 30,PP["Color_Pallete"]["NPC_BOSS_Health"])
		end

	end

end )

function GM:CreateClientsideRagdoll(entity, ragdoll)

	if not entity:IsPlayer() then

		ragdoll:Remove()

	end

end

local NPCDataBox = {}
NPCDataBox["Width"] =  ScreenScale(222)
NPCDataBox["Height"] = ScreenScale(62)
NPCDataBox["Padding"] = ScreenScale(8)

NPCDataBox["Health"] = {}
NPCDataBox["Health"]["Width"] = NPCDataBox["Width"] - NPCDataBox["Padding"]*2
NPCDataBox["Health"]["Height"] = NPCDataBox["Height"] * 0.35
NPCDataBox["Health"]["X"] = -NPCDataBox["Width"] / 2 + NPCDataBox["Padding"]
NPCDataBox["Health"]["Y"] = NPCDataBox["Height"] - NPCDataBox["Health"]["Height"] - NPCDataBox["Padding"]

local function PP_DrawNPCHUD()
	
	if ( !IsValid( LocalPlayer() ) ) then return end
	
	for key, value in pairs(ents.FindInSphere( LocalPlayer():GetPos(), 300 )) do
		
		local Enemy_Data = PP["ENEMY_NPC"][value:GetClass()]
		
		if Enemy_Data then

			local pos = value:GetPos() + Vector(0,0,select(2,value:GetModelBounds())[3] + 25 + Enemy_Data["Head_Y"])

			local ang = LocalPlayer():EyeAngles()

			ang:RotateAroundAxis( ang:Forward(), 90 )
			ang:RotateAroundAxis( ang:Right(), 90 )

			local name = "LVL. "..value:GetNW2Int("Enemy_NPC_Level", 1).." "..value:GetNW2String("Enemy_Name", "Monster")	
		 	local health = math.Clamp( 100*(value:Health() / value:GetMaxHealth()),0,100)
			
			local Dist = LocalPlayer():GetPos():DistToSqr(value:GetPos())

			cam.Start3D2D( pos, ang, 0.1)
					if health < 10 then
						draw.RoundedBox(0,-NPCDataBox["Width"]/2,0,NPCDataBox["Width"],NPCDataBox["Height"],PP["Color_Pallete"]["NPC_Low_Health"])
					else
						draw.RoundedBox(0,-NPCDataBox["Width"]/2,0,NPCDataBox["Width"],NPCDataBox["Height"],PP["Color_Pallete"]["Overhead_Box"])
					end
					draw.SimpleText( name, "PP_EnemyOverHead", -NPCDataBox["Width"]/2+NPCDataBox["Padding"], NPCDataBox["Padding"], PP["Color_Pallete"]["Overhead_Text"], TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)

					local Health_Progress = math.Clamp((NPCDataBox["Health"]["Width"])*(value:Health()/value:GetMaxHealth()),0,NPCDataBox["Health"]["Width"])
					
					draw.RoundedBox(0,NPCDataBox["Health"]["X"],NPCDataBox["Health"]["Y"],NPCDataBox["Health"]["Width"],NPCDataBox["Health"]["Height"],PP["Color_Pallete"]["Overhead_Box"])
					
					draw.RoundedBox(0,NPCDataBox["Health"]["X"],NPCDataBox["Health"]["Y"],Health_Progress,NPCDataBox["Health"]["Height"],value:GetColor())
					
					draw.SimpleText( math.Round(health).."%", "PP_OverHeadHealth", 0,NPCDataBox["Health"]["Y"]+NPCDataBox["Health"]["Height"]/2, PP["Color_Pallete"]["Overhead_Text"], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)


			cam.End3D2D()

		end

	end
end

hook.Add( "PostDrawTranslucentRenderables", "PP_DrawNPCHUD", PP_DrawNPCHUD )