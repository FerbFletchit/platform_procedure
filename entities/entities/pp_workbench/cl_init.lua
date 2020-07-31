include('shared.lua')

function ENT:DrawTranslucent()
	self:DrawModel()

	local LabelPos = self:GetPos()+self:GetUp()*24+self:GetRight()*55-self:GetForward()*20
	
	local DisplayAngle = self:GetAngles()
    DisplayAngle:RotateAroundAxis(DisplayAngle:Up(), 90)
    DisplayAngle:RotateAroundAxis(DisplayAngle:Forward(), 0)

	cam.Start3D2D(LabelPos , DisplayAngle, 0.1)
	
	    draw.RoundedBox(0,0,0,300,50,PP["Color_Pallete"]["Dark"])
	    draw.RoundedBox(0,5,5,290,40,PP["Color_Pallete"]["Dark_Light"])
       	PP_DrawShadowedTxt("Ingot Placement","PP_WB_Labels",150,25,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER,PP["Color_Pallete"]["White"])

       	draw.RoundedBox(0,730,0,300,50,PP["Color_Pallete"]["Dark"])
       	draw.RoundedBox(0,735,5,290,40,PP["Color_Pallete"]["Dark_Light"])
       	PP_DrawShadowedTxt("Crafting Station","PP_WB_Labels",730+150,25,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER,PP["Color_Pallete"]["White"])

    cam.End3D2D()

	local Title = LocalPlayer():GetNW2String("WhatAmICraftingRN"..self:GetCreationTime())
	
	if Title == "" then return end
	    		
   	local Bound_Origin_Min, Bound_Origin_Max = self:GetModelBounds()
    Pos = self:GetPos()+Vector(0,0,Bound_Origin_Max[3]+40) -- Adjusting vertical postiioning of display.
    
    local DisplayAngle = self:GetAngles()
    DisplayAngle:RotateAroundAxis(DisplayAngle:Up(), 90)
    DisplayAngle:RotateAroundAxis(DisplayAngle:Forward(), 0)

	cam.Start3D2D(Pos , DisplayAngle, 0.1)
	
		local Display_Text = "Now Crafting:" -- Creating a main title with our plant name.
	    local Display_Text2 = Title or "???" -- This will be used for harvest display.

        PP_DrawShadowedTxt(Display_Text,"PP_Medium",2,2,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER,PP["Color_Pallete"]["White"])
        PP_DrawShadowedTxt(Display_Text2,"PP_Regular",2,90,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER,PP["Color_Pallete"]["White"])

    cam.End3D2D()
end 

net.Receive("PP_Workbench_BlockChoice", function(len, ply)
	local WorkBench_Block = net.ReadEntity()
	local WorkBench_BlocksToUse = net.ReadTable()

	if not IsValid(WorkBench_Block) then return end
	if table.IsEmpty(WorkBench_BlocksToUse) then return end

	WorkBench_Block:SetRenderFX(4)

	local CubeLayout = {}
	CubeLayout["Frame"] = vgui.Create("DFrame")
	CubeLayout["Frame"]:SetSize(ScrW(),ScrH())
	CubeLayout["Frame"]:SetPos(0,0)
	CubeLayout["Frame"]:SetTitle("")						-- Set the title to nothing
	CubeLayout["Frame"]:ShowCloseButton(false)
	CubeLayout["Frame"]:SetDraggable(false)				-- Makes it so you carnt drag it
	CubeLayout["Frame"]:MakePopup()						-- Makes it so you can move your mouse on it
	
	CubeLayout["Frame"].Paint = function(w,h)

	end

	CubeLayout["Frame"].OnClose = function()
		WorkBench_Block:SetRenderFX(0)
	end

	CubeLayout["Frame_Cover"] = vgui.Create("DButton", CubeLayout["Frame"])
	CubeLayout["Frame_Cover"]:SetPos(0,0)
	CubeLayout["Frame_Cover"]:SetSize(CubeLayout["Frame"]:GetSize())
	CubeLayout["Frame_Cover"]:SetText("")

	local function Exiter( self, panels, bDoDrop, Command, x, y )
		if ( bDoDrop ) then
			CubeLayout["Frame"]:Close()
		end
	end

	CubeLayout["Frame_Cover"]:Receiver( "Exiter", Exiter )

	CubeLayout["Frame_Cover"].Paint = function(w,h)
		if CubeLayout["Frame_Cover"]:IsHovered() and not input.IsMouseDown( 107 ) then
			local ms_x, ms_y = gui.MousePos()
			draw.SimpleText("EXIT","PP_Small",ms_x+50,ms_y,PP["Color_Pallete"]["Neutral"],TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
		end
	end

	CubeLayout["Frame_Cover"].DoClick = function(w,h)
		CubeLayout["Frame"]:Close()
	end

	CubeLayout["List"] = vgui.Create( "DPanelList", CubeLayout["Frame"] ) -- I know it deprecated, I'm old.
	CubeLayout["List"]:SetPos( ScrW()*0.1,ScrH() / 2 - ScrH()*0.3 / 2 )
	CubeLayout["List"]:SetSize( ScreenScale(122), ScreenScale(122) )
	CubeLayout["List"]:SetSpacing( 5 ) -- Spacing between items
	CubeLayout["List"]:SetPadding( 5 ) -- Spacing between items
	CubeLayout["List"]:EnableHorizontal( true ) -- Only vertical items
	CubeLayout["List"]:EnableVerticalScrollbar( true ) -- Allow scrollbar if you exceed the Y axis

	local WB_List = CubeLayout["List"]
	function WB_List:Paint(w,h)
		draw.RoundedBox(0,0,0,w,h,PP["Color_Pallete"]["WorkBench_Dark"])
	end

	for key, value in RandomPairs(WorkBench_BlocksToUse) do
		local Cube_Panel = vgui.Create("DPanel")
		Cube_Panel:SetSize(ScreenScale(22),ScreenScale(22))

		function Cube_Panel:Paint(w,h)
			draw.RoundedBox(0,0,0,w,h,PP["Color_Pallete"]["WorkBench_Dark"])
		end

		local Cube_Panel_Model = vgui.Create( "DModelPanel", Cube_Panel )
		Cube_Panel_Model["Inv_Item"] = {[key] = value}
		Cube_Panel_Model:SetSize( Cube_Panel:GetWide(), Cube_Panel:GetTall() )
		Cube_Panel_Model:SetModel( value["Model"] )
		Cube_Panel_Model:SetAnimated( false )

	
		Cube_Panel_Model.Entity:SetMaterial( value["Material"] )
		Cube_Panel_Model:SetColor( value["Color"] )
		Cube_Panel_Model:Droppable( "Exiter" )
		Cube_Panel_Model:Droppable( "BlockDrop" )

		local mn, mx = Cube_Panel_Model.Entity:GetRenderBounds()
		local size = 0
		size = math.max( size, math.abs(mn.x) + math.abs(mx.x) )
		size = math.max( size, math.abs(mn.y) + math.abs(mx.y) )
		size = math.max( size, math.abs(mn.z) + math.abs(mx.z) )

		Cube_Panel_Model:SetFOV( 50 )
		Cube_Panel_Model:SetCamPos( Vector( size, size, size ) )
		Cube_Panel_Model:SetLookAt( (mn + mx) * 0.5 )

		Cube_Panel_Model.Anim = false
		function Cube_Panel_Model:OnDepressed()
			EmitSound("PP_Sound_Effects/Click.mp3",LocalPlayer():GetPos(),1,CHAN_AUTO,1,40,0,100)
			self:SetPos(Cube_Panel:GetWide(),0) -- Easy fix to make the modle dissapear when dragging.
			Cube_Panel_Model.Anim = true
		end

		function Cube_Panel_Model:OnReleased()
			self:SetPos(0,0) -- Easy fix to make the modle reapear when dragging.
			Cube_Panel_Model.Anim = false
		end

		function Cube_Panel_Model:LayoutEntity( ent )
			if self.Anim then
		    	ent:SetAngles( Angle( 0, RealTime() * 30 % 360, 0 ) )
		   	elseif ent:GetAngles() != Angle(0,0,0) then
		   		ent:SetAngles(Angle(0,0,0))
		   	end
		end

		CubeLayout["List"]:AddItem(Cube_Panel)
	end

	local function AddEmptyBlockSlot()
		local How_Many  = #CubeLayout["List"]:GetItems()
		for i=1, ( PP["Max_Inventory"] - How_Many) do
			local Empty_Panel = vgui.Create("DPanel")
			Empty_Panel:SetSize(ScreenScale(22),ScreenScale(22))

			function Empty_Panel:Paint(w,h)
				draw.RoundedBox(0,0,0,w,h,PP["Color_Pallete"]["WorkBench_Dark"])
			end

			CubeLayout["List"]:AddItem(Empty_Panel)
		end
	end
	AddEmptyBlockSlot()

	local function BlockDrop( self, panels, bDoDrop, Command, x, y )
		if ( bDoDrop ) then
			if not IsValid(panels[1].Entity) then return end
			panels[1]:GetParent():Remove()

			net.Start("PP_Workbench_BlockPlacing")
				net.WriteEntity( WorkBench_Block )
				net.WriteTable(panels[1]["Inv_Item"])
			net.SendToServer()

			EmitSound("PP_Sound_Effects/Craft_Drop.mp3",LocalPlayer():GetPos(),1,CHAN_AUTO,1,40,0,100 + (tonumber(WorkBench_Block:GetID())*10))
			CubeLayout["Frame"]:Close()
		end
	end

	CubeLayout["Receiver"] = vgui.Create( "DPanel", CubeLayout["Frame"] )
	CubeLayout["Receiver"]:SetSize( ScreenScale(32), ScreenScale(32) )
	CubeLayout["Receiver"]:Center()
	CubeLayout["Receiver"]:Receiver( "BlockDrop", BlockDrop )

	local WB_Receiver = CubeLayout["Receiver"]
	function WB_Receiver:Paint(w,h)
		draw.RoundedBox(0,0,0,w,h,PP["Color_Pallete"]["WorkBench_Dark"])
	end

end )