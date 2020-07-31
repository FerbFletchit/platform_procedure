if SERVER then
	util.AddNetworkString("PP_OpenInventory")
	util.AddNetworkString("PP_InvMenu_AddItem")
	util.AddNetworkString("PP_InventoryDrop")
end


function PP_EstablishInventoryItems()	
	PP_InventoryItems = {}

	for key, value in ipairs(PP["Items"]) do
		PP_InventoryItems[ value["Class"] ] = {
			["Name"] = value["Name"],
			["Type"] = value["Type"],
			["Description"] = value["Description"],
			["FOV"] = value["FOV"]-- New addition.
		}
	end
end

PP_EstablishInventoryItems()

function InventoryItemFov( class ) -- I should make this all one function with a search argument. 
	if PP_InventoryItems[class] then
		return PP_InventoryItems[ class ]["FOV"]
	end
	return nil
end

function InventoryItemType( class )
	if PP_InventoryItems[class] then
		return PP_InventoryItems[ class ]["Type"]
	end
	return nil
end

function InventoryItemName( class )
	if PP_InventoryItems[ class ] then
		return PP_InventoryItems[ class ]["Name"]
	end
	return ""
end


function InventoryItemDescription( class )
	if PP_InventoryItems[ class ] then
		return PP_InventoryItems[ class ]["Description"]
	end
	return ""
end


local Player = FindMetaTable("Player")

function Player:GetInventoryAmount()
	return self:GetNW2Int("PP_Inventory_Amount",0)
end

if SERVER then
	net.Receive("PP_OpenInventory", function(len, ply)
		
		if #ply:GetInventory() == 0 then
			ply:SendNotification("Dialouge", "I have nothing.")
			return
		end

		local Inv_ToJson = util.TableToJSON( ply:GetInventory() )
		net.Start("PP_OpenInventory")
			net.WriteString( Inv_ToJson )
		net.Send( ply )
	end )

	net.Receive("PP_InventoryDrop", function(len, ply)
		local Key = net.ReadInt(8)
		if ply:FindInventoryItemByKey( Key ) != {} then
			ply:DropInventoryItem( Key )
		end
	end )
end

function Player:HasFullInventory()
	self["Inventory"] = self["Inventory"] or {}
	self.FullNoticeCool = self.FullNoticeCool or 0
	if #self["Inventory"] >= PP["Max_Inventory"] then

		if CurTime() > self.FullNoticeCool then
			self:SendNotification("Dialouge", {"My inventory is full", "I have a full inventory!", "I can't hold any more!"} )
			self.FullNoticeCool = CurTime() + 3
		end
		
		return true
	else
		return false
	end
end


function Player:GetInventory()
	self["Inventory"] = self["Inventory"] or {}

	return self["Inventory"]
end

function Player:ClearInventory()
	self:SetNW2Int("PP_Inventory_Amount",0)
	self["Inventory"] = {}
	self["Weapon_Table"] = {}
end

function Player:AllItemsByClass(class)
	local Table = {}
	for key, value in pairs(self["Inventory"] or {}) do
		if value["Class"] == class then
			table.insert(Table,value)
		end
	end
	return Table
end

function Player:AddEntityInventoryItem( ent )
	
	if not self:Alive() then return end
	
	if not IsValid( ent ) then 
		print("[Platform Procedure] Tried to add an inventory entity that is not valid!")
	return end

	if not PP_InventoryItems[ent:GetClass()] then 
		print("[Platform Procedure] Tried to add an inventory item that doesn't exist!")
		return {}
	end

	self["Inventory"] = self["Inventory"] or {}

	if self:HasFullInventory() then return end -- Sends notification as well.

	local New_InvItem = {
		["Class"] = ent:GetClass(),
		["Model"] = ent:GetModel(),
		["Color"] = ent:GetColor(),
		["Material"] = ent:GetMaterial()
	}

	table.insert(self["Inventory"], New_InvItem)
	self:SetNW2Int("PP_Inventory_Amount",self:GetNW2Int("PP_Inventory_Amount")+1)

	New_InvItem = {#self["Inventory"], New_InvItem}

	net.Start("PP_InvMenu_AddItem")
		net.WriteString( util.TableToJSON( New_InvItem ) )
	net.Send( self )

	if IsValid( ent ) then
		ent:Remove()
	end
end

function Player:AddInventoryItem(class, model, color, material)
	if not PP_InventoryItems[class] then 
		
		print("[Platform Procedure] Tried to add an inventory item that doesn't exist!")
		
		return {}
	end

	self["Inventory"] = self["Inventory"] or {}

	if self:HasFullInventory() then return end -- Sends notification as well

	local New_InvItem = {
		["Class"] = class,
		["Model"] = model,
		["Color"] = color,
		["Material"] = material
	}

	table.insert(self["Inventory"], New_InvItem)
	self:SetNW2Int("PP_Inventory_Amount",self:GetNW2Int("PP_Inventory_Amount")+1)

	New_InvItem = {#self["Inventory"], New_InvItem}

	net.Start("PP_InvMenu_AddItem")
		net.WriteString( util.TableToJSON( New_InvItem ) )
	net.Send( self )
end

function Player:FindInventoryItemByKey( key )
	self["Inventory"] = self["Inventory"] or {}

	if self["Inventory"][key] then
		return self["Inventory"][key]
	end

	return {}
end

function Player:FindInventoryItem(class)
	self["Inventory"] = self["Inventory"] or {}

	for key, value in pairs(self["Inventory"]) do
		if value["Class"] == class then
			return {key, value}
		end
	end

	return {}
end

function Player:RemoveInventoryItem( Table_Key )
	if self["Inventory"][Table_Key] then
		table.remove( self["Inventory"], Table_Key )
		self:SetNW2Int("PP_Inventory_Amount",self:GetNW2Int("PP_Inventory_Amount")-1)
	end
end

function Player:DropInventoryItem( Table_Key )
	
	if not self:Alive() then return end
	
	local Inv_Item = self["Inventory"][Table_Key]
	if Inv_Item then

		local Dropped = ents.Create(Inv_Item["Class"])
		Dropped:SetPos(self:EyePos() + self:EyeAngles():Forward()*50)

		Dropped:SetModel( Inv_Item["Model"] or "error.mdl" )

		if IsValid(Dropped) then
			Dropped:Spawn()
			Dropped:SetColor( Inv_Item["Color"] or Color(255,255,255) )
			Dropped:SetMaterial( Inv_Item["Material"] or "" )

			if PP_IsRareIngot( Dropped:GetColor() ) then
				Dropped:PP_RareIngotSound()
			end

			local PhysicsObject = Dropped:GetPhysicsObject()
			if IsValid(PhysicsObject) then
				PhysicsObject:AddVelocity(self:EyeAngles():Forward()*100)
			end

			-- Weapon shit fuck Garry's Mod.
			if IsValid(Dropped) then
				if Dropped:IsWeapon() then 
					Dropped:SetNW2Bool("Dropped", true)
					timer.Simple(3, function()
						if IsValid(Dropped) then
							Dropped:SetNW2Bool("Dropped", false)
						end
					end )
				end
			end

		end

		table.remove( self["Inventory"], Table_Key )
		self:SetNW2Int("PP_Inventory_Amount",self:GetNW2Int("PP_Inventory_Amount")-1)
	end 
end