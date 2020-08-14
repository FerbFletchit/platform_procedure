InventoryLayout = InventoryLayout or {}

hook.Add( "PlayerButtonDown", "PP_OpenInventory", function( ply, button )
	if PP["Inventory_Key"] == button then

		ply["Inv_Cooldown"] = ply["Inv_Cooldown"] or CurTime()

		if ply["Inv_Cooldown"] <= CurTime() then
			ply["Inv_Cooldown"] = CurTime() + 0.1
			
			if IsValid(InventoryLayout["Frame"]) then
				InventoryLayout["Frame"]:Close()
				return
			end

			net.Start("PP_OpenInventory")
			net.SendToServer()
		end
	end
end)

local function CursrorSaveAndRestore(func)
	local ms_pos_x, ms_pos_y = input.GetCursorPos()
	timer.Simple(0.01, function()
		-- Nothing to validate here.
		if func then
			func()
		end
		gui.EnableScreenClicker(true)
		gui.SetMousePos( ms_pos_x, ms_pos_y )
	end )
end

local function ExciteWeaponBar()
	if table.IsEmpty(InventoryLayout) then return end
	if not InventoryLayout["WeaponList"]["Excited"] then
		InventoryLayout["WeaponList"]["Excited"] = true
		InventoryLayout["WeaponList"]:AlphaTo(255,0.5,0,function() 
			InventoryLayout["WeaponList"]:AlphaTo(0,0.5,1,function() 
				InventoryLayout["WeaponList"]["Excited"] = false
			end)
		end)
	end
end

net.Receive("PP_WeaponBarUse", function(len, ply)
	ExciteWeaponBar()
end )

net.Receive("PP_OpenInventory", function(len, ply)
	local Inventory = net.ReadString()
	Inventory = util.JSONToTable( Inventory )

	local SelectedType = "" -- Jank.

	InventoryLayout["Size"] = {ScrW()*0.25, ScrH()*0.25}
	InventoryLayout["Frame"] = vgui.Create("DFrame")
	InventoryLayout["Frame"]:SetSize(ScrW(),ScrH())
	InventoryLayout["Frame"]:SetPos(0,0)
	InventoryLayout["Frame"]:SetTitle("")						-- Set the title to nothing
	InventoryLayout["Frame"]:ShowCloseButton(false)
	InventoryLayout["Frame"]:SetDraggable(false)				-- Makes it so you carnt drag it
	InventoryLayout["Frame"]:DockPadding( ScrH()*0.10, ScrH()*0.16, 0, ScrH()*0.15 )
	gui.EnableScreenClicker(true)

	InventoryLayout["Frame"].Paint = function(w,h)
		InventoryLayout["WeaponList"]:SetAlpha(255)
	end

	InventoryLayout["Frame"].OnClose = function()
		gui.EnableScreenClicker(false)
		InventoryLayout["WeaponList"]:AlphaTo(0,0.5,2,function() end)
	end

	InventoryLayout["Frame_Cover"] = vgui.Create("DButton", InventoryLayout["Frame"])
	InventoryLayout["Frame_Cover"]:SetPos(0,0)
	InventoryLayout["Frame_Cover"]:SetSize(InventoryLayout["Frame"]:GetSize())
	InventoryLayout["Frame_Cover"]:SetText("")

	local function Exiter( self, panels, bDoDrop, Command, x, y )
		if ( bDoDrop ) then

			net.Start("PP_InventoryDrop")
			
				net.WriteInt(panels[1]["Inv_Item"][1], 8)

			net.SendToServer()

			InventoryLayout["List"]:RemoveItem(panels[1]:GetParent())

			CursrorSaveAndRestore()

			EmitSound("PP_Sound_Effects/Pop2.mp3",LocalPlayer():GetPos(),1,CHAN_AUTO,1,30,0,math.random(100,200))

			--InventoryLayout["Frame"]:Close()
		else
			panels[1]["Dropping"] = true
		end
	end

	InventoryLayout["Frame_Cover"]:Receiver( "Exiter", Exiter )

	InventoryLayout["Frame_Cover"].Paint = function(w,h)
	end

	InventoryLayout["Frame_Cover"].DoClick = function(w,h)
		InventoryLayout["Frame"]:Close()
	end

	InventoryLayout["List"] = vgui.Create( "DPanelList", InventoryLayout["Frame"] ) -- I know it deprecated, I'm old.

	InventoryLayout["List"]:Dock( LEFT )

	InventoryLayout["List"]:SetWidth( InventoryLayout["Size"][1] )
	InventoryLayout["List"]:SetSpacing( 5 ) -- Spacing between items
	InventoryLayout["List"]:SetPadding( 5 ) -- Spacing between items
	InventoryLayout["List"]:EnableHorizontal( true ) -- Only vertical items
	InventoryLayout["List"]:EnableVerticalScrollbar( true ) -- Allow scrollbar if you exceed the Y axis

	local WB_List = InventoryLayout["List"]

	function WB_List:Paint(w,h)
		draw.RoundedBox(0,0,0,w,h,PP["Color_Pallete"]["WorkBench_Dark"])
	end

	function WB_List:PaintOver(w,h)
		draw.SimpleText(LocalPlayer():GetInventoryAmount().." / "..PP["Max_Inventory"],"PP_InventoryMaxText",10,h-5,PP["Color_Pallete"]["White"],TEXT_ALIGN_LEFT,TEXT_ALIGN_BOTTOM)
	end

	local function AddInventoryItem( key, value )
			local Item_Panel = vgui.Create("DPanel")
			Item_Panel["Size"] = (InventoryLayout["List"]:GetWide() / PP["Inventory_Row_x"] - 6) -- yikes
			Item_Panel:SetSize(Item_Panel["Size"],Item_Panel["Size"])

			function Item_Panel:Paint(w,h)
				if self:IsHovered() then
					draw.RoundedBox(0,0,0,w,h,PP["Color_Pallete"]["Inventory_Highlight"])
				else
					draw.RoundedBox(0,0,0,w,h,PP["Color_Pallete"]["WorkBench_Dark"])
				end
			end

			local Item_Panel_Model = vgui.Create( "DModelPanel", Item_Panel )
			Item_Panel_Model["Inv_Item"] = {key,value}
			Item_Panel_Model:SetSize( Item_Panel:GetWide(), Item_Panel:GetTall() )
			Item_Panel_Model:SetModel( value["Model"] )
			Item_Panel_Model:SetAnimated( false )
			Item_Panel_Model:SetTooltip( InventoryItemName( value["Class"] ).."\n"..InventoryItemDescription( value["Class"] ) )

		
			Item_Panel_Model.Entity:SetMaterial( value["Material"] )
			Item_Panel_Model:SetColor( value["Color"] )
			Item_Panel_Model:Droppable( "Exiter" )
			Item_Panel_Model:Droppable( "ItemEquip" )

			local mn, mx = Item_Panel_Model.Entity:GetRenderBounds()
			local size = 0
			size = math.max( size, math.abs(mn.x) + math.abs(mx.x) )
			size = math.max( size, math.abs(mn.y) + math.abs(mx.y) )
			size = math.max( size, math.abs(mn.z) + math.abs(mx.z) )

			Item_Panel_Model:SetFOV( InventoryItemFov( value["Class"] ) or PP["Default_Inv_FOV"] )
			Item_Panel_Model:SetCamPos( Vector( size, size, size ) )
			Item_Panel_Model:SetLookAt( (mn + mx) * 0.5 )
			Item_Panel_Model["Anim"] = function() return Angle(0,0,0) end

			function Item_Panel_Model:OnDepressed()
				SelectedType = InventoryItemType( value["Class"] )
				EmitSound("PP_Sound_Effects/Click.mp3",LocalPlayer():GetPos(),1,CHAN_AUTO,1,40,0,100)
				self:SetPos(Item_Panel:GetWide(),0) -- Easy fix to make the modle dissapear when dragging.
				Item_Panel_Model["Anim"] = function() return Angle( 0, RealTime() * 30 % 360, 0 ) end
			end

			function Item_Panel_Model:OnReleased()
				SelectedType = ""
				EmitSound("PP_Sound_Effects/Click.mp3",LocalPlayer():GetPos(),1,CHAN_AUTO,1,40,0,80)
				self:SetPos(0,0) -- Easy fix to make the modle reapear when dragging.
				Item_Panel_Model["Anim"] = function() return Angle(0,0,0) end
			end

			function Item_Panel_Model:LayoutEntity( ent )
			    ent:SetAngles( self["Anim"]() or Angle(0,0,0) )
			   	
			end

			function Item_Panel_Model:PaintOver( w,h )
				if self["Dropping"] then
					--draw.SimpleText("DROP","PP_Small",w/2,h/2,PP["Color_Pallete"]["Neutral"],TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				end
			end

			InventoryLayout["List"]:AddItem(Item_Panel)
	end
	
	for key, value in ipairs(Inventory) do
		AddInventoryItem( key, value )
	end

	--[[local function AddEmptyInventorySlot()
		for i=1, ( PP["Max_Inventory"] - #Inventory ) do
			local Empty_Panel = vgui.Create("DPanel")
			Empty_Panel["Size"] = (InventoryLayout["List"]:GetWide() / PP["Inventory_Row_x"] - 6) -- yikes
			Empty_Panel:SetSize(Empty_Panel["Size"],Empty_Panel["Size"])

			function Empty_Panel:Paint(w,h)
				draw.RoundedBox(0,0,0,w,h,PP["Color_Pallete"]["WorkBench_Dark"])
			end

			InventoryLayout["List"]:AddItem(Empty_Panel)
		end
	end
	AddEmptyInventorySlot()]]


	


	local function CreateWeaponBar()

		if IsValid(InventoryLayout["WeaponList"]) then

			InventoryLayout["WeaponList"]:Remove()

		end

		InventoryLayout["WeaponList"] = vgui.Create( "DPanelList" ) -- I know it deprecated, I'm old.
		InventoryLayout["WeaponList"]["ItemSize"] = (ScrW()*0.05)
		InventoryLayout["WeaponList"]["Padding"] = 15
		InventoryLayout["WeaponList"]:SetSize(InventoryLayout["WeaponList"]["ItemSize"]+(InventoryLayout["WeaponList"]["Padding"]*2), InventoryLayout["WeaponList"]["ItemSize"]+(InventoryLayout["WeaponList"]["Padding"]*2))
		InventoryLayout["WeaponList"]:SetPos(0, ScrH()-InventoryLayout["WeaponList"]["ItemSize"] - ScrH()*0.05)
		InventoryLayout["WeaponList"]:CenterHorizontal()

		InventoryLayout["WeaponList"]:SetSpacing( InventoryLayout["WeaponList"]["Padding"] ) -- Spacing between items
		InventoryLayout["WeaponList"]:SetPadding( InventoryLayout["WeaponList"]["Padding"] ) -- Spacing between items
		InventoryLayout["WeaponList"]:EnableHorizontal( true ) -- Only vertical items
		InventoryLayout["WeaponList"]:EnableVerticalScrollbar( true ) -- Allow scrollbar if you exceed the Y axis

		local Weapon_List = InventoryLayout["WeaponList"]
		function Weapon_List:Paint(w,h)
			draw.RoundedBox(0,0,0,w,h,PP["Color_Pallete"]["WorkBench_Dark"])
		end

		local function ItemEquip( self, panels, Actually_Dropped, Command, x, y )
			if ( Actually_Dropped ) then
				if InventoryItemType( panels[1]["Inv_Item"][2]["Class"] ) == self["Info"][1] then
					
					InventoryLayout["List"]:RemoveItem(panels[1]:GetParent())

					net.Start("PP_EquipWeapon")
						net.WriteInt(panels[1]["Inv_Item"][1], 8)
					net.SendToServer()

					--CursrorSaveAndRestore( timer.Simple(0.1, function() CreateWeaponBar() end ) )
					InventoryLayout["Frame"]:Close()
					
					--[[local ms_pos_x, ms_pos_y = input.GetCursorPos()
					timer.Simple(0.1, function()
						-- Nothing to validate here.
						CreateWeaponBar()
						gui.EnableScreenClicker(true)
						gui.SetMousePos( ms_pos_x, ms_pos_y )
					end )]]
				end
			end
		end

		for key, value in ipairs(PP["Weapon_Slots"]) do

			local Equip_Panel = vgui.Create("DPanel")

			Equip_Panel["Info"] = value

			Equip_Panel:SetSize(InventoryLayout["WeaponList"]["ItemSize"], InventoryLayout["WeaponList"]["ItemSize"])

			Equip_Panel:Receiver( "ItemEquip", ItemEquip )


			for key2, value2 in pairs( LocalPlayer():GetWeapons() ) do
				if InventoryItemType( value2:GetClass() ) == value[1] then
					
					local Equip_Panel_Model = vgui.Create( "DModelPanel", Equip_Panel )
					Equip_Panel["Class"] = value2:GetClass()
					Equip_Panel_Model:SetSize( Equip_Panel:GetWide(), Equip_Panel:GetTall() )
					Equip_Panel_Model:SetModel( value2:GetModel() )
					Equip_Panel_Model:SetAnimated( false )
					Equip_Panel_Model:SetTooltip( InventoryItemName( value2:GetClass() ) )

					Equip_Panel_Model.Entity:SetMaterial( PP["Weapon_Material"] )
					Equip_Panel_Model:SetColor( value2:GetColor() )

					local mn, mx = Equip_Panel_Model.Entity:GetRenderBounds()
					local size = 0
					size = math.max( size, math.abs(mn.x) + math.abs(mx.x) )
					size = math.max( size, math.abs(mn.y) + math.abs(mx.y) )
					size = math.max( size, math.abs(mn.z) + math.abs(mx.z) )

					Equip_Panel_Model:SetFOV( 40 )
					Equip_Panel_Model:SetCamPos( Vector( size, size, size ) )
					Equip_Panel_Model:SetLookAt( (mn + mx) * 0.5 )

					function Equip_Panel_Model:OnReleased()
						EmitSound("PP_Sound_Effects/Click.mp3",LocalPlayer():GetPos(),1,CHAN_AUTO,1,40,0,80)
						net.Start("PP_WeaponSelect")
							net.WriteString(value[1])
						net.SendToServer()
					end

					function Equip_Panel_Model:LayoutEntity( ent )
						if not IsValid(value2) then
							self:Remove()
						end

						Equip_Panel_Model:SetAlpha( InventoryLayout["WeaponList"]:GetAlpha() )
					   	ent:SetAngles(Angle(0,0,30))

					end

				end
			end

			function Equip_Panel:Paint(w,h)
				if InventoryLayout["WeaponList"]:GetAlpha() == 0 then return end -- Should not think when not visible.

				local Cur_Weapon = LocalPlayer():GetActiveWeapon() or nil

				if SelectedType == value[1] then

					draw.RoundedBox(0,0,0,w,h,PP["Color_Pallete"]["Inventory_Highlight"])

				elseif IsValid(Cur_Weapon) then

					if Cur_Weapon:GetClass() == self["Class"] then

						draw.RoundedBox(0,0,0,w,h,PP["Color_Pallete"]["Inventory_Selected"])

						--draw.RoundedBox(0,0,0,w,h,PP["Color_Pallete"]["Dark"])
					else

						draw.RoundedBox(0,0,0,w,h,PP["Color_Pallete"]["Dark"]) -- Has weapon, but not selected.

					end

				else

					draw.RoundedBox(0,0,0,w,h,PP["Color_Pallete"]["Dark"])

				end
				draw.SimpleText(string.upper( input.GetKeyName( value[2] ) ),"PP_Small",10,5,PP["Color_Pallete"]["White"],TEXT_ALIGN_LEFT,TEXT_ALIGN_TOP)
			end

			Weapon_List:AddItem( Equip_Panel )


			if key > 1 then
				InventoryLayout["WeaponList"]:SetWidth( 
					InventoryLayout["WeaponList"]:GetWide() + 
					InventoryLayout["WeaponList"]["ItemSize"] +
					InventoryLayout["WeaponList"]:GetPadding()
				)
				
				InventoryLayout["WeaponList"]:CenterHorizontal()
			end
		end
	end

	CreateWeaponBar()

	net.Receive("PP_InvMenu_AddItem", function(len, ply)
		if not IsValid(InventoryLayout["Frame"]) then return end

		local Inv_Item = net.ReadString()
		Inv_Item = util.JSONToTable(Inv_Item)
		AddInventoryItem( Inv_Item[1], Inv_Item[2] )
	end )

end )


-- Inventory item lookat display

function PP_DrawEntInventoryInfo()
	
	local tr = util.TraceLine( {

		start = LocalPlayer():EyePos(),
		endpos = LocalPlayer():EyePos() + EyeAngles():Forward() * 1000,
		filter = function( ent ) 
			if PP_InventoryItems[ent:GetClass()] then 
				return true
			else
				return false
			end
		end

	} )
	
	if not IsValid( tr.Entity ) then return end
		
	local Pos = tr.HitPos + Vector(0,0,15)
	local ang = LocalPlayer():EyeAngles()

 
	ang:RotateAroundAxis( ang:Forward(), 90 )
	ang:RotateAroundAxis( ang:Right(), 90 )

	local Quality = PP_GetIngotByColor( tr.Entity:GetColor() )[2]["Name"] or ""
	local Quality_Color = PP_GetIngotByColor( tr.Entity:GetColor() )[2]["Color"] or PP["Color_Pallete"]["White"]
	local Item_Name = PP_InventoryItems[tr.Entity:GetClass()]["Name"]
	local Item_Info =  Quality.." "..Item_Name

	surface.SetFont("PP_ItemInvInfo")

	local text_w, text_h = surface.GetTextSize( Item_Info )
	text_w = text_w + 20
 	text_h = text_h + 20

	cam.Start3D2D( Pos, ang , 0.07 )

		draw.RoundedBox( 0, -text_w/2, -text_h/2, text_w, text_h-10, PP["Color_Pallete"]["Dark"] )

		draw.SimpleText( Item_Info,"PP_ItemInvInfo",-text_w/2+10,0,PP["Color_Pallete"]["White"],TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)

		draw.SimpleText( Quality,"PP_ItemInvInfo",-text_w/2+10,0,Quality_Color,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)

	cam.End3D2D()

end
hook.Add("PostDrawTranslucentRenderables", "PP_DrawEntInventoryInfo", PP_DrawEntInventoryInfo)