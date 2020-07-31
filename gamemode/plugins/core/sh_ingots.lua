PP["Ingots"] = {
	-- 4 blocks
	-- gold +3
	-- gold +3
	-- silver +2
	-- silver +2

	[1] = { -- 1-5
		["Name"] = "Bronze",
		["Color"] = PP["Color_Pallete"]["Bronze"],
		["Rarity"] = 1,
		["Swep_Multiplier"] = 0.5,
		["Crafting_Range"] = {1,4},
	},

	[2] = { -- 6-7
		["Name"] = "Iron",
		["Color"] = PP["Color_Pallete"]["Iron"],
		["Rarity"] = 0.75,
		["Swep_Multiplier"] = 1,
		["Crafting_Range"] = {5,6},
	},

	[3] = { -- 8-9
		["Name"] = "Gold",
		["Color"] = PP["Color_Pallete"]["Gold"],
		["Rarity"] = 0.5,
		["Swep_Multiplier"] = 1.5,
		["Crafting_Range"] = {7,8},
	},

	[4] = { -- 10
		["Name"] = "Diamond",
		["Color"] = PP["Color_Pallete"]["Diamond"],
		["Rarity"] = 0.35,
		["Swep_Multiplier"] = 2,
		["Crafting_Range"] = {9,10},
	},

}

local Meta = FindMetaTable("Entity")

function PP_CalculateIngotQuality( integer, blocks_used )
	integer = math.Clamp( math.floor( integer - (blocks_used * 0.50) ), 0, 10) -- Here we round down the craft int and scale it down (roughly) by how many blocks were used.
	-- integer will be the number quality of the item, let's now determine what ingot quality to apply.
	for key, value in ipairs(PP["Ingots"]) do
		if integer >= value["Crafting_Range"][1] and integer <= value["Crafting_Range"][2] then
			return {key,value}
		end
	end
	return {1,PP["Ingots"][1]} -- Could not determine, default to first ingot quality.
end

function PP_GetIngotByColor( color )
	for key, value in ipairs( PP["Ingots"] )	do
		
		local col = value["Color"]
		if Color(color.r, color.g, color.b) == Color(col.r, col.g, col.b) then
			return {key,value}
		end
	end
	return {0,{}}
end

function Meta:PP_RareIngotSound()
	self:EmitSound("PP_Sound_Effects/Rare.mp3",55,100,1,CHAN_AUTO) -- Emit chest opening sound.
end

function PP_IsRareIngot( color )
	if PP_GetIngotByColor( color )[1] >= #PP["Ingots"] then -- If the ingot is the last one in the list.
		return true
	end
	return false
end

function Meta:GetIngotQuality()

end

function PP_ProduceRandomIngot(ingot_selector)
	ingot_selector = ingot_selector or math.Rand(0.1,1)
	
	for key, value in RandomPairs(PP["Ingots"]) do

		if ingot_selector <= value["Rarity"] then
			return {key,value}
		end

	end

	return PP_Loot["Items"][1] -- If all else fails, return the first loot entity. 
end

function Meta:ApplyIngotQuality(Ingot)
	
	if not Ingot then
		Ingot = PP_ProduceRandomIngot()
	end
	
	self:SetNW2String("Ingot", Ingot[2]["Name"])
	self:SetMaterial( PP["Ingot_Material"] )
	self:SetColor( Ingot[2]["Color"] )

	if Ingot[1] >= #PP["Ingots"] then -- If the ingot is the last one in the list.

		self:EmitSound("PP_Sound_Effects/Rare.mp3",55,100,1,CHAN_AUTO) -- Emit chest opening sound.

	end
end

if CLIENT then
	function PP_CreateIngotMaterials()
		for key, value in ipairs( PP["Ingots"] ) do
			CreateMaterial(value["Name"], "VertexLitGeneric", {
			  	["$basetexture"] = Material( PP["Weapon_Material"] ),
			  	["$color2"] = "[ "..(value["Color"].r/255).." "..(value["Color"].g/255).." "..(value["Color"].b/255).." ]",
			  	["$detail"] = "RealWorldTextures/newer/2/metal_2_01",
				["$detailscale"] = 4.283,
				["$detailblendfactor"] = 0.65,
				["$detailblendmode"] = 0,

			  	--["$rimlight"] = 1,
				--["$rimlightexponent"] = 2,
				--["$rimlightboost"] = .2,

			} )
		end
	end
	PP_CreateIngotMaterials()
end