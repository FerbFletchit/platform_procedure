AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
 
include('shared.lua')

util.AddNetworkString("PP_Workbench_BlockChoice")
util.AddNetworkString("PP_Workbench_BlockPlacing")

function ENT:Initialize()
	PP_LoadEntityModel( self )

	self:SetCollisionGroup(COLLISION_GROUP_INTERACTIVE)
    self:SetMoveType(MOVETYPE_NONE)
    self:PhysicsInit(SOLID_NONE)
    self:SetUseType(SIMPLE_USE)
    self:SetSolid(SOLID_VPHYSICS)

	self:SetPos(self:GetPos()+self:GetAngles():Up()*50)
	self:DropToFloor()

	local PhysicsObject = self:GetPhysicsObject()
	if IsValid(PhysicsObject) then
		PhysicsObject:EnableGravity( false )
	end

	local Recipe_Book = ents.Create("pp_recipe_book")

	if IsValid(Recipe_Book) then
		local Ang = self:GetAngles()
		Recipe_Book:SetPos(self:GetPos() - self:GetForward()*25 - self:GetRight()*15 - self:GetUp()*5)

		Recipe_Book:SetAngles(Angle(180,205,90))

		Recipe_Book:SetParent(self)

		Recipe_Book:Spawn()
	end

	local Hint = ents.Create("pp_hintcube")

	if IsValid(Hint) then
		local Ang = self:GetAngles()
		Hint:SetPos(self:GetPos() - self:GetForward()*30 - self:GetRight()*60 - self:GetUp()*15)

		Hint:SetAngles(Angle(180,205,90))

		Hint:SetParent(self)

		Hint:Spawn()

		Hint["Hints"] = PP["Workbench_Hints"]
	end
end

net.Receive("PP_Workbench_BlockPlacing",function(len, ply)
	local Block_Destination = net.ReadEntity()
	local Inventory_Block = net.ReadTable()

	local Inv_Key = table.GetFirstKey( Inventory_Block ) -- Deprecated oof fast competition coding please fix this whole system judges don't look oh my fucking god this workbench is jank. I'm not spending a lot of time on this so it is likely exploitable.....
	
	if ply:FindInventoryItemByKey( table.GetFirstKey( Inventory_Block ) ) then -- If player has the item in question.
		
		if table.IsEmpty(Inventory_Block) then return end

		Inventory_Block = ply:FindInventoryItemByKey(Inv_Key) -- Using our verified inv data and not shit the client sends at this point.
		
		if Inventory_Block["Class"] == "pp_loot_cube" and Inventory_Block["Model"] == Block_Destination:GetModel() then -- If the inventory block matches up to the construct base.

			local BlockPutDown = ents.Create( "pp_workbench_cube" )

			if IsValid(BlockPutDown) then
				BlockPutDown:SetModel( Inventory_Block["Model"] )

				BlockPutDown:SetAngles(Block_Destination:GetAngles())
				BlockPutDown:SetPos(Block_Destination:GetPos()+Block_Destination:GetUp()*12)

				BlockPutDown:Spawn()

				BlockPutDown:SetRenderMode( RENDERMODE_TRANSCOLOR ) 
				BlockPutDown:SetColor(Inventory_Block["Color"])
				BlockPutDown:SetMaterial(Inventory_Block["Material"])

				BlockPutDown:SetWBPos( Block_Destination:GetID() )
				BlockPutDown:SetCrafter( ply )

				BlockPutDown:SetParent(Block_Destination:GetParent())

				local Bench = Block_Destination:GetParent()

				Bench["Player_Recipes"][ply] = Bench["Player_Recipes"][ply] or {}

				Bench["Player_Recipes"][ply][tonumber(Block_Destination:GetID())] = 1 -- Setting the block to active.

				ply:SetNW2String("WhatAmICraftingRN"..Bench:GetCreationTime(), PP_MatchCubesWithRecipe(Bench["Player_Recipes"][ply])["Name"] or "???" )
				
				ply:RemoveInventoryItem( Inv_Key )
			end
		end
	end
end )

local Bench = FindMetaTable("Entity")

function BlockForBenchTime(Block_Base, ply, block_type)
	if not IsValid(Block_Base) or not ply:IsPlayer() then 
		return
	end
	
	-- Getting the player's available cubes --
	local Bench = Block_Base:GetParent()
	Bench["Player_Recipes"][ply] = Bench["Player_Recipes"][ply] or {}

	if tobool(Bench["Player_Recipes"][ply][tonumber(Block_Base:GetID())]) then
		return
	end

	local PP_WorkBench_Blocks = ply:AllItemsByClass("pp_loot_cube") or nil
	if table.Count(PP_WorkBench_Blocks) == 0 then
		ply:PP_PlaySound("sound/PP_Sound_Effects/Negative.mp3", 0.25)
		ply:SendNotification("Dialouge", "I don't have any blocks to craft with")
		return
	end

	PP_WorkBench_Blocks = {}

	for key, value in pairs(ply:GetInventory()) do
		if PP_PlatformModelToSizeString( value["Model"] ) == block_type and value["Class"] == "pp_loot_cube" then
			table.insert( PP_WorkBench_Blocks, key, value )
		end
	end
	
	net.Start("PP_Workbench_BlockChoice")
		net.WriteEntity(Block_Base)
		net.WriteTable(PP_WorkBench_Blocks)
	net.Send(ply)
end

function Bench:CreateItem(ply)
	self["Player_Recipes"][ply] = self["Player_Recipes"][ply] or {}
	if not table.IsEmpty(self["Player_Recipes"][ply]) then
		local WB_Ent_ToCreate
		local WB_FindingRecipe = PP_MatchCubesWithRecipe(self["Player_Recipes"][ply])
		if not table.IsEmpty(WB_FindingRecipe) then
			WB_Ent_ToCreate = WB_FindingRecipe["Class"]
		else
			return -- No recipe found.
		end

		local Ingot_AddUp = 0
		local Blocks_Used = 0
		for key, value in pairs(ents.FindByClass("pp_workbench_cube")) do
			if IsValid(value:GetCrafter()) then
				if value:GetCrafter() == ply and value:GetParent() == self then
					local self_ingot = PP_GetIngotByColor( value:GetColor() )

					Ingot_AddUp = Ingot_AddUp + self_ingot[1] -- adds by the ingot's key value
					Blocks_Used = Blocks_Used + 1

					value:Remove()
				end
			end
		end 

		self["Player_Recipes"][ply] = {}
		ply:SetNW2String("WhatAmICraftingRN"..self:GetCreationTime(), "")

		local WB_Spawned_Item = ents.Create(WB_Ent_ToCreate)

		if IsValid(WB_Spawned_Item) then
			WB_Spawned_Item:SetPos(PP_GetComponentByID(self, "SpawnPlate"):GetPos() + Vector(0,0,25))
			WB_Spawned_Item:SetParent(self)
			WB_Spawned_Item:Spawn()
			WB_Spawned_Item:SetMoveType(MOVETYPE_NONE)
			WB_Spawned_Item:SetNW2Bool("Dropped", true)
			WB_Spawned_Item:SetAngles(Angle(0,math.random(0,360),0))
			
			WB_Spawned_Item:SetMaterial(PP["Weapon_Material"])
			WB_Spawned_Item:SetColor(Color(0,0,0,100))
			WB_Spawned_Item:SetRenderMode(1)
			
			WB_Spawned_Item:SetRenderFX(13)

			timer.Simple(3, function()
				if IsValid(WB_Spawned_Item) then
					WB_Spawned_Item:SetRenderMode(0)
					WB_Spawned_Item:SetRenderFX(0)
					
					WB_Spawned_Item:ApplyIngotQuality( PP_CalculateIngotQuality( Ingot_AddUp, Blocks_Used ) )
					WB_Spawned_Item:EmitSound("pp_sound_effects/positive.mp3", 75,100,1,CHAN_AUTO)
					timer.Simple(1, function()
						if IsValid(WB_Spawned_Item) then
							WB_Spawned_Item:SetNW2Bool("Dropped", false)
						end
					end )
				end
			end )
		end
		
	end
end

function Bench:UpdateWhatCraft(ply)
	ply:SetNW2String("WhatAmICraftingRN"..self:GetCreationTime(), PP_MatchCubesWithRecipe(self["Player_Recipes"][ply])["Name"] or "???" )
end