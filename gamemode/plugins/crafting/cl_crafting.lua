-- Blueprint open up
local Saved_Recipe = nil
net.Receive("PP_RecipeOpen", function(len, ply)
	local Recipes = net.ReadString()
	Recipes = util.JSONToTable( Recipes )
	local SelectedRecipe = Saved_Recipe or 1

	
	local panelid = { -- worst way to do this, but I'm running out of time judges.....
		[1] = 1,
		[2] = 2,
		[3] = 3,
		[4] = 10,
		[5] = 11,
		[6] = 4,
		[7] = 5,
		[8] = 6,
		[9] = 10,
		[10] = 11,
		[11] = 7,
		[12] = 8,
		[13] = 9,
		[14] = 10,
		[15] = 11,
	}

	local BPLayout = {}
	BPLayout["Padding"] = 10
	BPLayout["Spacing"] = 0
	BPLayout["Bottom"] = 65
	BPLayout["Frame"] = vgui.Create("DFrame")
	BPLayout["Frame"]:SetSize(ScrW(),ScrH())
	BPLayout["Frame"]:SetPos(0,0)
	BPLayout["Frame"]:SetTitle("")						-- Set the title to nothing
	BPLayout["Frame"]:ShowCloseButton(false)
	BPLayout["Frame"]:SetDraggable(false)				-- Makes it so you carnt drag it
	BPLayout["Frame"]:MakePopup()						-- Makes it so you can move your mouse on it
	
	BPLayout["Frame"].Paint = function(w,h)
	end

	BPLayout["Frame"].OnClose = function()
	end

	BPLayout["Frame_Cover"] = vgui.Create("DButton", BPLayout["Frame"])
	BPLayout["Frame_Cover"]:SetPos(0,0)
	BPLayout["Frame_Cover"]:SetSize(BPLayout["Frame"]:GetSize())
	BPLayout["Frame_Cover"]:SetText("")

	BPLayout["Frame_Cover"].Paint = function(w,h)
		if BPLayout["Frame_Cover"]:IsHovered() then
			local ms_x, ms_y = gui.MousePos()
			draw.SimpleText("EXIT","PP_Small",ms_x+50,ms_y,PP["Color_Pallete"]["Neutral"],TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
		end
	end

	BPLayout["Frame_Cover"].DoClick = function(w,h)
		BPLayout["Frame"]:Close()
	end

	BPLayout["BluePrint"] = vgui.Create("DPanel", BPLayout["Frame"])
	BPLayout["BluePrint"]:SetSize(ScrW()*0.34, ScrH()*0.43)
	BPLayout["BluePrint"]:Center()

	local BluePrint = BPLayout["BluePrint"]
	function BluePrint:Paint(w,h)
		draw.RoundedBox(0,0,0,w,h,PP["Color_Pallete"]["Dark"])
		draw.SimpleText("#"..SelectedRecipe.." "..Recipes[SelectedRecipe]["Name"],"PP_Small",w/2,h-BPLayout["Bottom"]/2,PP["Color_Pallete"]["White"],TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
	end

	local NextRecipe = vgui.Create("DButton", BluePrint)
	NextRecipe["Size"] = ( BPLayout["Bottom"]-10 )
	NextRecipe:SetText("")
	NextRecipe:SetSize(BPLayout["Bottom"]-10, BPLayout["Bottom"]-10)
	NextRecipe:SetPos(BPLayout["BluePrint"]:GetWide() - NextRecipe["Size"] - 5, BPLayout["BluePrint"]:GetTall() - NextRecipe["Size"] - 5)

	function NextRecipe:Paint(w,h)
		draw.RoundedBox(0,0,0,w,h,PP["Color_Pallete"]["Dark"])
		draw.SimpleText(">","PP_Small",w/2,h/2,PP["Color_Pallete"]["White"],TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
	end

	function NextRecipe:OnDepressed()
		EmitSound("PP_Sound_Effects/Click.mp3",LocalPlayer():GetPos(),1,CHAN_AUTO,1,40,0,100)
	end

	function NextRecipe:OnReleased()
		EmitSound("PP_Sound_Effects/Click.mp3",LocalPlayer():GetPos(),1,CHAN_AUTO,1,40,0,80)
	end


	local LastRecipe = vgui.Create("DButton", BluePrint)
	LastRecipe["Size"] = ( BPLayout["Bottom"]-10 )
	LastRecipe:SetText("")
	LastRecipe:SetSize(BPLayout["Bottom"]-10, BPLayout["Bottom"]-10)
	LastRecipe:SetPos(5, BPLayout["BluePrint"]:GetTall() - LastRecipe["Size"] - 5)

	function LastRecipe:Paint(w,h)
		draw.RoundedBox(0,0,0,w,h,PP["Color_Pallete"]["Dark"])
		draw.SimpleText("<","PP_Small",w/2,h/2,PP["Color_Pallete"]["White"],TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
	end
	
	function LastRecipe:OnDepressed()
		EmitSound("PP_Sound_Effects/Click.mp3",LocalPlayer():GetPos(),1,CHAN_AUTO,1,40,0,100)
	end
	
	function LastRecipe:OnReleased()
		EmitSound("PP_Sound_Effects/Click.mp3",LocalPlayer():GetPos(),1,CHAN_AUTO,1,40,0,80)
	end

	local function ListOutRecipeWithYuckyCode( Recipe_Key )
		if IsValid(BPLayout["List1"]) then BPLayout["List1"]:Remove() end
		BPLayout["List1"] = vgui.Create( "DPanelList", BPLayout["BluePrint"] ) -- I know it deprecated, I'm old.
		BPLayout["List1"]:SetPos(3,3) -- I know I should use docking, but I suck at vgui.
		BPLayout["List1"]:SetSize( BPLayout["BluePrint"]:GetWide() - 6, BPLayout["BluePrint"]:GetTall() - BPLayout["Bottom"])
		
		BPLayout["List1"]:SetSpacing( BPLayout["Spacing"] ) -- Spacing between items
		BPLayout["List1"]:SetPadding( 0 ) -- Spacing between items
		BPLayout["List1"]:EnableHorizontal( true ) -- Only vertical items

		local list = BPLayout["List1"]

		function list:Paint(w,h)
			--draw.RoundedBox(0,0,0,w,h,PP["Color_Pallete"]["Dark"])
		end

		for i=1, 15 do
			local Sq = vgui.Create("DPanel")

			Sq["Yup"] = panelid[i]

			Sq["Nope"] = i

			local Sq_Size = BPLayout["List1"]:GetWide()/5

			Sq:SetSize(Sq_Size,Sq_Size)

			function Sq:Paint(w,h)

				if i == 4 or i == 5 then
					draw.RoundedBox(0,5,5,w - 10,h,PP["Color_Pallete"]["Dark"])

				elseif i == 9 or i == 10 then
					draw.RoundedBox(0,5,0,w - 10,h,PP["Color_Pallete"]["Dark"])

				elseif i == 14 or i == 15 then
					draw.RoundedBox(0,5,0,w - 10,h-5,PP["Color_Pallete"]["Dark"])

				else
					draw.RoundedBox(0,5,5,w - 10,h - 10,PP["Color_Pallete"]["Dark"])
				end

			end

			BPLayout["List1"]:AddItem(Sq)
		end

		for key, value in ipairs( Recipes[Recipe_Key]["Recipe"] ) do
			if value > 0  then
				for key2, value2 in pairs(BPLayout["List1"]:GetItems()) do
					if value2["Yup"] == key then

						local poop = vgui.Create("DPanel", value2)
						poop:SetSize(value2:GetSize())
						poop:SetAlpha(0)
						poop:AlphaTo(255,0.25,math.Rand(0.1,0.5), function() end )

						local Box_Color = PP["Color_Pallete"]["Craft_Recipe_Block"]
						function poop:Paint(w,h)

							
							if value2["Nope"] == 4 or value2["Nope"] == 5 then
								function value2:Paint() end
								draw.RoundedBox(0,5,5,w - 10,h,PP["Color_Pallete"]["Dark"])
								draw.RoundedBox(0,10,10,w - 20,h-5,Box_Color)

							elseif value2["Nope"] == 9 or value2["Nope"] == 10 then
								function value2:Paint() end
								draw.RoundedBox(0,5,0,w - 10,h,PP["Color_Pallete"]["Dark"])
								draw.RoundedBox(0,10,0,w - 20,h,Box_Color)

							elseif value2["Nope"] == 14 or value2["Nope"] == 15 then
								function value2:Paint() end
								draw.RoundedBox(0,5,0,w - 10,h-5,PP["Color_Pallete"]["Dark"])
								draw.RoundedBox(0,10,0,w - 20,h-10,Box_Color)

							else
								draw.RoundedBox(0,5,5,w - 10,h - 10,PP["Color_Pallete"]["Dark"])

								draw.RoundedBox(0,10,10,w - 20,h - 20,Box_Color)
							end

							
						end

					end
				end 
			end

		end
	end

	function NextRecipe:DoClick()

		SelectedRecipe = math.Clamp(SelectedRecipe + 1, 1, #Recipes + 1)

		if SelectedRecipe > #Recipes then
			
			SelectedRecipe = 1

		end

		ListOutRecipeWithYuckyCode( SelectedRecipe )
		Saved_Recipe = SelectedRecipe
	end

	function LastRecipe:DoClick()
		SelectedRecipe = math.Clamp(SelectedRecipe - 1, 0, #Recipes)

		if SelectedRecipe == 0 then

			SelectedRecipe = #Recipes

		end

		ListOutRecipeWithYuckyCode( SelectedRecipe )
		Saved_Recipe = SelectedRecipe
	end

	if SelectedRecipe > #Recipes then
		SelectedRecipe = 1
		Saved_Recipe = 1
		ListOutRecipeWithYuckyCode( 1 )

	else

		ListOutRecipeWithYuckyCode( SelectedRecipe )

	end


end )

-- key number, pulls up the recipe table and builds UI accordingly