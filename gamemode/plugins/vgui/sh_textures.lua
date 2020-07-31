PP["Materials"] = {

	["wood1"] = {
		["Scale"] = 1,
		["Material"] = "models/debug/debugwhite", -- LIGHT Stone
		["Mass_Range"] = {0, 250}, -- Mass range: Minimum <> Maximum. (In Kilograms)
		["Color"] = Color(193,154,107),
		["Foot_Step"] = function() return "player/footsteps/wood"..math.random(1,4)..".wav" end
	},

	["Rusty"] = {
		["Scale"] = 1,
		["Material"] = "models/debug/debugwhite", -- Metal plate
		["Mass_Range"] = {1500, 2000}, -- Mass range: Minimum <> Maximum. (In Kilograms)
		["Color"] = Color(55, 49, 32),
		["Foot_Step"] = function() return "player/footsteps/metal"..math.random(1,4)..".wav" end
	},

	["MetalPlate"] = {
		["Scale"] = 5,
		["Material"] = "models/shiny", -- Metal plate
		["Mass_Range"] = {2001, 3999}, -- Mass range: Minimum <> Maximum. (In Kilograms)
		["Color"] = Color(90,90,90),
		["Foot_Step"] = function() return "player/footsteps/metal"..math.random(1,4)..".wav" end
	},

	["Floor_1_06"] = {
		["Scale"] = 1,
		["Material"] = "models/debug/debugwhite", -- HEAVY Stone. 
		["Color"] = Color( 90, 90, 90 ),
		["Mass_Range"] = {5001, 50000}, -- Mass range: Minimum <> Maximum. (In Kilograms)
		["Foot_Step"] =  function() return "player/footsteps/concrete"..math.random(1,4)..".wav" end
	},


	["Tile"] = {
		["Scale"] = 1,
		["Material"] = "RealWorldTextures/new/Tiles_c", -- HEAVY Stone. 
		["Mass_Range"] = {0, 0}, -- Mass range: Minimum <> Maximum. (In Kilograms)
		["Foot_Step"] =  function() return "player/footsteps/tile"..math.random(1,4)..".wav" end
	},

	["Bridge"] = {
		["Scale"] = 1,
		["Material"] = "phoenix_storms/plastic", -- HEAVY Stone. 
		["Mass_Range"] = {0, 0}, -- Mass range: Minimum <> Maximum. (In Kilograms)
		["Foot_Step"] =  function() return "player/footsteps/concrete"..math.random(1,4)..".wav" end
	},

}

if CLIENT then
	function PP_CreateMaterials()

		for key, value in pairs(PP["Materials"]) do
			if not value["Color"] then
				value["Color"] = Color(255, 255, 255)
			end
			CreateMaterial(key, "VertexLitGeneric", {
			  	["$basetexture"] = value["Material"],
			  	["$color2"] = "[ "..(value["Color"].r/255).." "..(value["Color"].g/255).." "..(value["Color"].b/255).." ]",
				["$seamless_scale"] = value["Scale"],

			} )

		end

	end

	PP_CreateMaterials()
end

--[[
player/footsteps/chainlink1.wav
player/footsteps/chainlink2.wav
player/footsteps/chainlink3.wav
player/footsteps/chainlink4.wav
player/footsteps/concrete1.wav
player/footsteps/concrete2.wav
player/footsteps/concrete3.wav
player/footsteps/concrete4.wav
player/footsteps/dirt1.wav
player/footsteps/dirt2.wav
player/footsteps/dirt3.wav
player/footsteps/dirt4.wav
player/footsteps/duct1.wav
player/footsteps/duct2.wav
player/footsteps/duct3.wav
player/footsteps/duct4.wav
player/footsteps/grass1.wav
player/footsteps/grass2.wav
player/footsteps/grass3.wav
player/footsteps/grass4.wav
player/footsteps/gravel1.wav
player/footsteps/gravel2.wav
player/footsteps/gravel3.wav
player/footsteps/gravel4.wav
player/footsteps/ladder1.wav
player/footsteps/ladder2.wav
player/footsteps/ladder3.wav
player/footsteps/ladder4.wav
player/footsteps/metal1.wav
player/footsteps/metal2.wav
player/footsteps/metal3.wav
player/footsteps/metal4.wav
player/footsteps/metalgrate1.wav
player/footsteps/metalgrate2.wav
player/footsteps/metalgrate3.wav
player/footsteps/metalgrate4.wav
player/footsteps/mud1.wav
player/footsteps/mud2.wav
player/footsteps/mud3.wav
player/footsteps/mud4.wav
player/footsteps/sand1.wav
player/footsteps/sand2.wav
player/footsteps/sand3.wav
player/footsteps/sand4.wav
player/footsteps/slosh1.wav
player/footsteps/slosh2.wav
player/footsteps/slosh3.wav
player/footsteps/slosh4.wav
player/footsteps/tile1.wav
player/footsteps/tile2.wav
player/footsteps/tile3.wav
player/footsteps/tile4.wav
player/footsteps/wade1.wav
player/footsteps/wade2.wav
player/footsteps/wade3.wav
player/footsteps/wade4.wav
player/footsteps/wade5.wav
player/footsteps/wade6.wav
player/footsteps/wade7.wav
player/footsteps/wade8.wav
player/footsteps/wood1.wav
player/footsteps/wood2.wav
player/footsteps/wood3.wav
player/footsteps/wood4.wav
player/footsteps/woodpanel1.wav
player/footsteps/woodpanel2.wav
player/footsteps/woodpanel3.wav
player/footsteps/woodpanel4.wav
]]

--** Eventually remove all RealWorldTextures that are not used here. 