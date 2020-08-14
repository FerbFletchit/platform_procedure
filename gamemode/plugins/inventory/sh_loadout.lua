if CLIENT then
	CreateMaterial("PP_Invis", "Cloak_DX90", {
		  	--["$basetexture"] = Material( "Debug/hsv" ),
		  	["$color2"] = "[ 0 0 0 ]",
		  	["$alpha"] = 0,
		  	["$translucent"] = true,
		} )

	function PP_PostDrawViewModel( view_model, weapon ) -- Used to make sure guns don't look like shit. 
		
		if not IsValid(weapon) then return end
		if not IsValid(weapon:GetActiveWeapon()) then return end

		--local Mat = "!"..weapon:GetActiveWeapon():GetNW2String("Ingot_Quality") or Material ( PP["Default_Material"] )		
		view_model:SetMaterial( "!PP_Invis" )
		
	end
	hook.Add("PostDrawViewModel", "PP_PostDrawViewModel", PP_PostDrawViewModel)

end

function PP_CreateWeaponSelectKeys( input_key, weapon_type )
	PP_WeaponSlotNumeration = PP_WeaponSlotNumeration or {}
	PP_WeaponSlotNumeration[input_key] = weapon_type
end

if PP["Weapon_Slots"] then

	for key, value in ipairs(PP["Weapon_Slots"]) do
		PP_CreateWeaponSelectKeys( value[2], value[1] )
	end

end

local Player = FindMetaTable("Player")

function Player:GivePPWeapon( weapon_table )
	-- Weapon table should look like this:
	--[[
	{ 
		["Class"] = "weapon_name",
		["Material"] = "models/shiny",
		["Color"] = Color(255,255,255),
	}
	]]
	local Ingot_Quality = PP_GetIngotByColor( weapon_table["Color"] )
	Ingot_Quality = Ingot_Quality[2]

	if table.IsEmpty( Ingot_Quality ) then 
		print("Failed to equip weapon with non-existent ingot quality.")
	return end

	self:Give(weapon_table["Class"])
	self:SelectWeapon(weapon_table["Class"])

	local New_Weapon = self:GetActiveWeapon()

	if IsValid(New_Weapon) then
		self:GetActiveWeapon():SetNW2String("Ingot_Quality", Ingot_Quality["Name"] )
		New_Weapon:SetMaterial(PP["Weapon_Material"])
		New_Weapon:SetColor(Ingot_Quality["Color"])
	end
end

function Player:RestoreWeapons()
	self["Weapon_Table"] = self["Weapon_Table"] or {}

	if table.IsEmpty(self["Weapon_Table"]) then return end -- ADDED RECENTLY 7/20/20
	
	for key, value in pairs(self["Weapon_Table"]) do
		self:SetNW2String("PP_WeaponEquip", value["Class"])
		self:GivePPWeapon( value )
	end
end

if CLIENT then
	hook.Add( "PlayerButtonDown", "PP_WeaponSelectByButton", function( ply, button )
		local Weapon_Type = PP_WeaponSlotNumeration[button]
		if PP_WeaponSlotNumeration[button] and Weapon_Type then
			net.Start("PP_WeaponSelect")
				net.WriteString(Weapon_Type)
			net.SendToServer()
		end
	end)
end

if SERVER then
	util.AddNetworkString("PP_EquipWeapon")
	util.AddNetworkString("PP_UnEquipWeapon")
	util.AddNetworkString("PP_WeaponSelect")
	util.AddNetworkString("PP_WeaponBarUse")

	--[[ply.WeaponTable = {
		["Primary"] = {
			["Class"] = nil,
			["Model"] = nil,
			["Color"] = nil,
			["Material"] = nil,
		},
		["Secondary"] = {
			["Class"] = nil,
			["Model"] = nil,
			["Color"] = nil,
			["Material"] = nil,
		},
		["Special"] = {
			["Class"] = nil,
			["Model"] = nil,
			["Color"] = nil,
			["Material"] = nil,
		}
	}]]

	local function ExiteWeaponBar( ply )
		net.Start("PP_WeaponBarUse")
		net.Send(ply)
	end

	net.Receive("PP_WeaponSelect", function(len, ply)
		ply["Weapon_Table"] = ply["Weapon_Table"] or {}
		
		ExiteWeaponBar( ply )

		local Weapon_Type = net.ReadString()
		if ply["Weapon_Table"][Weapon_Type] then
			local Weapon_To_SwitchTo = ply["Weapon_Table"][Weapon_Type]["Class"]

			if ply:HasWeapon( Weapon_To_SwitchTo ) then
				if Weapon_To_SwitchTo != ply:GetActiveWeapon():GetClass() then
					ply:SelectWeapon(ply["Weapon_Table"][Weapon_Type]["Class"] )
				end
			end

		end
	end )

	net.Receive("PP_EquipWeapon", function(len, ply)
		--Player equip cooldown timer.
		local Key = net.ReadInt(8)
		local Weapon_Class = ply:FindInventoryItemByKey( Key )

		-- If player has the weapon in their inventory
		if Weapon_Class != {} then

			if InventoryItemType( Weapon_Class["Class"] ) then

				ply["Weapon_Table"] = ply["Weapon_Table"] or {}
				
				local Weapon_In_Slot = ply["Weapon_Table"][InventoryItemType( Weapon_Class["Class"] )] or nil
				
				ply:RemoveInventoryItem( Key ) -- Removing equipping gun from inventory. 
				
				if Weapon_In_Slot and ply:HasWeapon(Weapon_In_Slot["Class"]) then -- Check if another weapon is in the slot, put back in inventory.
					
					ply:StripWeapon( Weapon_In_Slot["Class"] )
					
					ply:AddInventoryItem( -- Adding existing gun to inventory
						Weapon_In_Slot["Class"], 
						Weapon_In_Slot["Model"], 
						Weapon_In_Slot["Color"], 
						Weapon_In_Slot["Material"]
					)

				end

				--ply:StripWeapon( Class )


				ply["Weapon_Table"][InventoryItemType( Weapon_Class["Class"] )] = { -- Add to player weapon table
					["Class"] = Weapon_Class["Class"],
					["Model"] = Weapon_Class["Model"],
					["Color"] = Weapon_Class["Color"],
					["Material"] = Weapon_Class["Material"],
				}

				ply:SetNW2String("PP_WeaponEquip", Weapon_Class["Class"])
				
				ply:GivePPWeapon( ply["Weapon_Table"][InventoryItemType( Weapon_Class["Class"] )] )
				ExiteWeaponBar( ply )

			end
		end

	end )

	net.Receive("PP_UnEquipWeapon", function(len, ply)
		-- If player has the weapon in their inventory

		--If the type selected matches with the weapon type

		-- Remove inventory item

		-- Add to player weapon table

	end )

	function PP_ReloadPlayerWeapons( ply )

		ply["Weapon_Table"] = ply["Weapon_Table"] or {}

		for key, value in pairs( ply["Weapon_Table"] ) do
			
			ply:Give( value["Class"] )

		end

	end
	hook.Add("Spawn", "PP_ReloadPlayerWeapons", PP_ReloadPlayerWeapons)

	function PP_EquipSoundOverride( weapon )
		timer.Simple(0.1, function()
			if IsValid( weapon ) then
				weapon:EmitSound( "pp_weapons/loadclip.wav", 75, 100, 1, CHAN_WEAPON )
			end
		end)
	end
	hook.Add("WeaponEquip", "PP_EquipSoundOverride", PP_EquipSoundOverride)
end

function GM:PlayerCanPickupWeapon( ply, weapon ) -- Dissalows automatic weapon pickup.
	
	if not IsValid(weapon) then return end
	if weapon:GetNW2Bool("Dropped") then return end -- this is pp_chest shared.lua
	if ply:GetNW2Bool("PP_CantPickupWeapon") then return end

	if ply:GetNW2String("PP_WeaponEquip") == weapon:GetClass() then
		ply:SetNW2String("PP_WeaponEquip", "")
		return true

	else

		if not PP_InventoryItems[weapon:GetClass()] then return end

		ply:SetNW2Bool("PP_CantPickupWeapon", true )
		
		timer.Simple(1, function() 
			if IsValid(ply) then
				ply:SetNW2Bool("PP_CantPickupWeapon", false) 
			end
		end )

		ply:AddEntityInventoryItem( weapon )

		return false
	end
	return false
end