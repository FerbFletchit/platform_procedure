PP_Loot = {}

function PP_EstablishLootEntities()
	PP_Loot["Items"] = {}
	
	for key, value in ipairs(PP["Items"]) do
		if value["Loot"] then
			PP_Loot["Items"][key] = {
				["Name"] = value["Name"],
				["Entity"] = value["Class"],
				["Type"] = value["Type"],
				["Rarity"] = value["Rarity"],
			}
		end
	end
end

PP_EstablishLootEntities()

PP_Loot["Cubes"] = {
	"025x025x025", -- Really lazy fix for decreasing long block spawn, running out of time.
	"025x025x025",
	"025x025x025",
	"025x025x025",
	"025x05x025"
}

function PP_Loot_Random() -- Loot items that pop out of chests and what not.
	local loot_chance_selector = math.Rand(0.1,1)
	
	for key, value in RandomPairs(PP_Loot["Items"]) do

		if loot_chance_selector <= value["Rarity"] then
			return value
		end

	end

	return PP_Loot["Items"][1] -- If all else fails, return the first loot entity. 

end

function PP_Loot_RandomEnt() -- Entities that should spawn randomly on platforms. 
	local loot_ent_chance_selector = math.Rand(0.1,1)

	for key, value in RandomPairs(PP["Loot_Ents"]) do
		if loot_ent_chance_selector <= value["Rarity"] then
			return value["Class"]
		end

	end
	return PP["Loot_Ents"][1]["Class"] -- If all else fails, return the first loot entity. 
end

function PP_Loot_Spawn( Platform )
	
	if SERVER then

		if Platform_Manager["Types"] and Platform:GetParent():GetType() then
			if Platform_Manager["Types"][Platform:GetParent():GetType()] then
				if not Platform_Manager["Types"][Platform:GetParent():GetType()]["Loot"] then
					return
				end
			end
		end

		if not table.HasValue(Platform_Manager["Sizes"], PP_PlatformModelToSizeString( Platform:GetModel() ) ) then 
			return end

		local PP_Loot_Bounds = {Platform:GetModelBounds()}
		local PP_Loot_Bounds_Min = PP_Loot_Bounds[1]
		local PP_Loot_Bounds_Max = PP_Loot_Bounds[2]


		-- This is a safeguard because area calculation sometimes fails. --
		local Platform_PhysicsObject = Platform:GetPhysicsObject()
		
		if IsValid(Platform_PhysicsObject) then
			if Platform_PhysicsObject:GetVolume() < PP["Spawn_MinVolume"] then 
				return 
			end

		else
			return 
		end
		-------------------------------------------------------------------
		
		local Platform_Area = PP_PlatformModelToTable( Platform:GetModel() ) -- If Volume is not found, then this multiplation nullifies the loot amount.
		Platform_Area = Platform_Area[1] * Platform_Area[2]

		if Platform_Area < PP["Loot_MinArea"] then 
		return end

		local Loot_Amount = math.Round( math.Clamp(Platform_Area * 0.05 * #team.GetPlayers(1), 1, PP["Loot_MaxPerPlatform"]) ) -- MATHHHHHH OH GOD THIS IS TRASH.

		local Penis_variable = math.Rand(0,1) -- Half the time loot will not spawn :(

		if Penis_variable < PP["Loot_Spawn_Chance"] then
			for i=1, Loot_Amount do

				local Loot_Class = PP_Loot_RandomEnt()

				local Loot = ents.Create( PP_Loot_RandomEnt() )

				local Y_Addition = PP_GetLootByEnt( Loot_Class )["Y_Offset"] or 0

				if IsValid(Loot) then
					Loot:SetPos( Platform:GetPos() + Vector(

						math.random(PP_Loot_Bounds_Min[1],PP_Loot_Bounds_Max[1]) * 0.80,

						math.random(PP_Loot_Bounds_Min[2],PP_Loot_Bounds_Max[2]) * 0.80,

						PP_Loot_Bounds_Max[3] + Y_Addition )
					)

					Loot:SetParent(Platform)

					Loot:Spawn()
					local ang = Platform:GetAngles()
					Loot:SetAngles( Angle(-ang.x,90*math.random(0,4), -ang.z) ) -- Points random direction with 90degree snapping.
						
				end			
			end
		end

		-----------------------------------
		-- Late additon: hints
		----------------------------------
		local ShouldHint = math.Rand(0,1)
		if ShouldHint <= PP["HintChance"] then
			local Hint = ents.Create("pp_hintcube")

			if IsValid(Hint) then
				Hint:SetPos(Platform:GetPos() + Vector(
							math.random(PP_Loot_Bounds_Min[1],PP_Loot_Bounds_Max[1]),
							math.random(PP_Loot_Bounds_Min[2],PP_Loot_Bounds_Max[2]),
							math.random(PP_Loot_Bounds_Max[3],PP_Loot_Bounds_Max[3]+50)
					)
				)

				Hint:SetParent(Platform)

				Hint:Spawn()

				Hint["Hints"] = PP["Fun_Hints"]
				Hint["Delay"] = 15
			end
		end
		------------------------------------------
		------------------------------------------
	
	end

end

function PP_Loot_OnPlatformCreated( Platform )
	if Platform:GetClass() == "pp_platform" then

		if not IsValid(Platform) then return end
		
		timer.Simple(1, function() -- This is a necessary timer in this hook.
			
			if not IsValid(Platform) then return end
			
			--[[if Platform_Manager["Types"] and Platform:GetType() then
				if Platform_Manager["Types"][Platform:GetType()] then
					if Platform_Manager["Types"][Platform:GetType()]["Loot"] then
						-- Decide what loot carrier (and how much) to spawn and where on the platform.
						PP_Loot_Spawn( Platform )
					end
				end
			end]]

			if PP["Parachute_Loot"] then
				
				local Chute_Chance = math.random(1,PP["Parachute_Loot_Chance"])
				
				if Chute_Chance == 1 then 
					
					if SERVER then
						timer.Simple(10, function()
							if IsValid( Platform ) then
								local PP_Parachute = ents.Create("pp_loot_parachute")
								
								if IsValid( PP_Parachute ) then
									PP_Parachute:SetPos(Platform:GetPos() + Vector(math.random(-50,50),math.random(-50,50),1000) )
									PP_Parachute:Spawn()
								end
							end
						end )
					end

				end

			end

		end )
	end
	
end 
hook.Add("OnEntityCreated", "PP_Loot_OnPlatformCreated", PP_Loot_OnPlatformCreated)