-- My vgui/ui is awful.
PP_Ply_HealthBar = {}
PP_Ply_HealthBar["Width"] = ScrW()*0.3
PP_Ply_HealthBar["Height"] = ScreenScale(20)

PP_Ply_HealthBar["Pos"] = {50,ScrH()-PP_Ply_HealthBar["Height"]-ScrH()*0.025}
PP_Ply_HealthBar["Padding"] = 5

PP_Ply_HealthBar["Health_Size"] = { 
	PP_Ply_HealthBar["Width"] - ( PP_Ply_HealthBar["Padding"] * 2 ),
	PP_Ply_HealthBar["Height"] - ( PP_Ply_HealthBar["Padding"] * 2 ),
}

PP_InvBox_Size = ScreenScale(20)

function PP_HealthElement()
	if LocalPlayer():Alive() then

		local PP_Ply_HealthFillUp = math.Clamp(PP_Ply_HealthBar["Health_Size"][1] * (LocalPlayer():Health() / LocalPlayer():GetMaxHealth()), 0, PP_Ply_HealthBar["Health_Size"][1])
		
		draw.RoundedBox(0,PP_Ply_HealthBar["Pos"][1],PP_Ply_HealthBar["Pos"][2] - PP_InvBox_Size - 5,PP_InvBox_Size,PP_InvBox_Size,PP["Color_Pallete"]["Dark"])
		
		if IsValid( InventoryLayout["Frame"] ) then
			draw.RoundedBox(0,PP_Ply_HealthBar["Pos"][1]+5,PP_Ply_HealthBar["Pos"][2] - PP_InvBox_Size,PP_InvBox_Size-10,PP_InvBox_Size-10,PP["Color_Pallete"]["Inv_Selected"])
		else
			draw.RoundedBox(0,PP_Ply_HealthBar["Pos"][1]+5,PP_Ply_HealthBar["Pos"][2] - PP_InvBox_Size,PP_InvBox_Size-10,PP_InvBox_Size-10,PP["Color_Pallete"]["Dark"])
		end
		
		draw.SimpleText("Q","PP_Small",PP_Ply_HealthBar["Pos"][1]+PP_InvBox_Size/2,PP_Ply_HealthBar["Pos"][2]-PP_InvBox_Size/2-5,PP["Color_Pallete"]["White"],TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
		
		draw.RoundedBox(0,PP_Ply_HealthBar["Pos"][1],PP_Ply_HealthBar["Pos"][2],PP_Ply_HealthBar["Width"] ,PP_Ply_HealthBar["Height"],PP["Color_Pallete"]["Dark"])
		
		draw.RoundedBox(0,PP_Ply_HealthBar["Pos"][1] + PP_Ply_HealthBar["Padding"],PP_Ply_HealthBar["Pos"][2] + PP_Ply_HealthBar["Padding"],PP_Ply_HealthBar["Health_Size"][1],PP_Ply_HealthBar["Health_Size"][2],PP["Color_Pallete"]["Dark"])
		
		draw.RoundedBox(0,PP_Ply_HealthBar["Pos"][1] + PP_Ply_HealthBar["Padding"]+5,PP_Ply_HealthBar["Pos"][2] + PP_Ply_HealthBar["Padding"]+5,PP_Ply_HealthFillUp-10,PP_Ply_HealthBar["Health_Size"][2]-10,PP["Color_Pallete"]["Health"])
		
		draw.SimpleText(LocalPlayer():Health().." / "..LocalPlayer():GetMaxHealth(),"PP_Ply_Health",PP_Ply_HealthBar["Pos"][1]+PP_Ply_HealthBar["Width"]/2,PP_Ply_HealthBar["Pos"][2]+PP_Ply_HealthBar["Height"]/2,PP["Color_Pallete"]["White"],TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
	
	end
end

local Crosshair = Material("materials/pp_assets/crosshair1.png")
local Crosshair_Size_W = 44
local Crosshair_Size_H = Crosshair_Size_W * 0.4
local Crosshair_Position_X, Crosshair_Position_Y = (ScrW() / 2) - (32), (ScrH() / 2) - (32)

function surface.DrawTexturedRectRotatedPoint( x, y, w, h, rot, x0, y0 )
	
	local c = math.cos( math.rad( rot ) )
	local s = math.sin( math.rad( rot ) )
	
	local newx = y0 * s - x0 * c
	local newy = y0 * c + x0 * s
	
	surface.DrawTexturedRectRotated( x + newx, y + newy, w, h, rot )
	
end
hook.Remove("MenuDrawLuaErrors")

function PP_Crosshair()
	surface.SetDrawColor( 255, 255, 255, 200 )
	surface.SetMaterial( Crosshair ) -- If you use Material, cache it!
	surface.DrawTexturedRectRotatedPoint( ScrW() / 2, ScrH() / 2, Crosshair_Size_W, Crosshair_Size_H, 0, 0, 0 )
end
hook.Remove("MenuErrorHandler")

hook.Add("HUDPaint", "Floor_Indicatior", function()

	local Skull = Material("materials/pp_assets/skull.png")

	if IsValid(floor_Indicator) then return end
	floor_Indicator = {}

	floor_Indicator["Size"] = {ScreenScale(100), ScreenScale(20)}
	
	floor_Indicator["Frame"] = vgui.Create("DFrame")
	
	floor_Indicator["Frame"]:SetSize(40,floor_Indicator["Size"][2])
	
	floor_Indicator["Frame"]:SetPos(PP_Ply_HealthBar["Pos"][1]+5+PP_InvBox_Size, PP_Ply_HealthBar["Pos"][2] - PP_InvBox_Size-5)
	
	floor_Indicator["Frame"]:SetTitle("")						-- Set the title to nothing
	
	floor_Indicator["Frame"]:ShowCloseButton( false )
	
	floor_Indicator["Frame"]:SetDraggable(true)				-- Makes it so you carnt drag it
	
	floor_Indicator["Frame"]:DockPadding(
		5,--left
		5, -- top
		5,
		5
	)

	local Frame = floor_Indicator["Frame"]

	function Frame:Paint(w,h)
		if not IsValid(LocalPlayer()) then return end
		if !LocalPlayer():Alive() or PP["CurrentState"] == 1 and Frame:GetAlpha() > 0 then

			Frame:SetAlpha(0)

		elseif LocalPlayer():Alive() and PP["CurrentState"] != 1 and Frame:GetAlpha() <= 0 then

			Frame:SetAlpha(255)

		end

		draw.RoundedBox(0,0,0,w,h,PP["Color_Pallete"]["Dark"])
	end

	floor_Indicator["List"] = vgui.Create( "DPanelList", floor_Indicator["Frame"] ) -- I know it deprecated, I'm old.

	floor_Indicator["List"]:Dock( FILL )

	floor_Indicator["List"]:SetSpacing( 5 ) -- Spacing between items
	floor_Indicator["List"]:SetPadding( 5 ) -- Spacing between items
	floor_Indicator["List"]:EnableHorizontal( true ) 

	local List = floor_Indicator["List"]

	function List:Paint(w,h)
		draw.RoundedBox(0,0,0,w,h,PP["Color_Pallete"]["Dark_Light"])
	end

	for i=1, PP["Floors"]["Per_Game"] do

		local Floor = vgui.Create("DPanel")

		Floor:SetSize(floor_Indicator["Size"][2]-20, floor_Indicator["Size"][2]-20)

		floor_Indicator["Frame"]:SetWide(floor_Indicator["Frame"]:GetWide() + floor_Indicator["Size"][2]-20)

		function Floor:Paint(w,h)
			
			if (PP["CurrentState"] - 1) >= i then
				draw.RoundedBox(0,0,0,w,h,PP["Color_Pallete"]["Floor_Indicator"])
			else
				draw.RoundedBox(0,0,0,w,h,PP["Color_Pallete"]["Dark_Lightish"])
			end

			if i == (#PP["StateManager"]["States"] - 2) then
				surface.SetDrawColor( PP["Color_Pallete"]["Health"] )
					surface.SetMaterial( Skull ) -- If you use Material, cache it!
				surface.DrawTexturedRect( 4, 4, w-8, h-8 )
			end
		end

		floor_Indicator["List"]:AddItem(Floor)

	end	
	hook.Remove("HUDPaint", "Floor_Indicatior")
end )

hook.Add( "HUDPaint", "PP_HUD", function()

	if not PP.StateManager["States"][PP["CurrentState"]] then return end
	PP.StateManager["States"][PP["CurrentState"]]["Draw"](LocalPlayer())

end )

local DataBox = {}
DataBox["Width"] = ScreenScale(100)
DataBox["Height"] = ScreenScale(20)
DataBox["Padding"] = ScreenScale(2)

DataBox["Health"] = {}
DataBox["Health"]["Width"] = DataBox["Width"] - DataBox["Padding"]*2
DataBox["Health"]["Height"] = DataBox["Height"] * 0.35
DataBox["Health"]["X"] = -DataBox["Width"]/2 + DataBox["Padding"]
DataBox["Health"]["Y"] = DataBox["Height"]-DataBox["Health"]["Height"]-DataBox["Padding"]

local function PP_PlayerDataBox( player )
	
	draw.RoundedBox(0,-DataBox["Width"]/2,0,DataBox["Width"],DataBox["Height"],PP["Color_Pallete"]["Overhead_Box"])
	draw.SimpleText( player:GetName(), "PP_OverHead", -DataBox["Width"]/2+DataBox["Padding"], DataBox["Height"]-DataBox["Health"]["Y"]+2, PP["Color_Pallete"]["Overhead_Text"], TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM)

	local Health_Progress = math.Clamp((DataBox["Health"]["Width"])*(player:Health()/player:GetMaxHealth()),0,DataBox["Health"]["Width"])
	
	draw.RoundedBox(0,DataBox["Health"]["X"],DataBox["Health"]["Y"],DataBox["Health"]["Width"],DataBox["Health"]["Height"],PP["Color_Pallete"]["Overhead_Box"])
	draw.RoundedBox(0,DataBox["Health"]["X"],DataBox["Health"]["Y"],Health_Progress,DataBox["Health"]["Height"],player:GetPlayerColor():ToColor())
	draw.SimpleText( ( math.Round(player:Health()/player:GetMaxHealth()) * 100).."%", "PP_OverHeadHealth", 0,DataBox["Health"]["Y"]+DataBox["Health"]["Height"]/2, PP["Color_Pallete"]["Overhead_Text"], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
end

local function PP_DrawPlayerData( ply )

	if ( !IsValid( ply ) ) then return end 
	if ( ply == LocalPlayer() ) then return end
	if ( !ply:Alive() ) then return end 

	local Distance = LocalPlayer():GetPos():DistToSqr( ply:GetPos() )
	if ( 400000 > Distance ) then --If the distance is less than 300 units, it will draw the name
 
		
		local attach_id = ply:LookupAttachment('eyes')
		if not attach_id then return end
				
		local attach = ply:GetAttachment(attach_id)
				
		if not attach then return end
				
		local pos = attach.Pos + Vector(0,0,20)
		local ang = LocalPlayer():EyeAngles()
 
		ang:RotateAroundAxis( ang:Forward(), 90 )
		ang:RotateAroundAxis( ang:Right(), 90 )
 
		cam.Start3D2D( pos, Angle( 0, ang.y, 90 ), 0.15 )
			PP_PlayerDataBox( ply )
			PP_DialougeDraw( ply )
		cam.End3D2D()
	end
end
hook.Add( "PostPlayerDraw", "PP_DrawPlayerData", PP_DrawPlayerData )