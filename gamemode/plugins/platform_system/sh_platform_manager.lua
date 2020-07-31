Platform_Manager = Platform_Manager or {}
Platform_Manager["Platforms"] = Platform_Manager["Platforms"] or {} -- Global Table of all platforms created each game.
local Platform = FindMetaTable( "Entity" )

function FindPlatform(ID_String)
	for key, value in pairs(ents.FindByClass("pp_platform")) do
		local P_ID = value:GetID() or ""
		if P_ID == ID_String then
			return value
		end
	end
end

function Platform:MassBasedMaterial()
	local PhysicsObject = self:GetPhysicsObject()
	if IsValid(PhysicsObject) then
		local Mass = PhysicsObject:GetMass()
		for key, value in RandomPairs(PP["Materials"]) do
			if Mass >= value["Mass_Range"][1] and Mass <= value["Mass_Range"][2] then
				return "!"..key or PP["Default_Material"]
			end
		end
		return PP["Default_Material"] -- If the volume isn't in any of the ranges.
	else
		return PP["Default_Material"]
	end
end

function PP_PlatformSize( platform ) -- This returns an arbitrary value based on downscaled volume.
	if IsValid( platform ) then
		local PhysicsObject = platform:GetPhysicsObject()
		if IsValid(PhysicsObject) then
			return math.Round( math.Clamp( PhysicsObject:GetVolume() * 0.000002, 0, 100 ) )
		else
			return 0
		end
	end
end

function PP_PlatformModelToSizeString( String )
	if not String or string == "" then
		return ""
	else
		String = string.Replace(String, "models/hunter/blocks/cube", "")
		String = string.Replace(String, ".mdl", "")
		return String
	end
	
	return ""
end

function PP_PlatformModelToTable( String, Nice )
	if not String or string == "" then
		return {}
	else
		String = string.Replace(String, "models/hunter/blocks/cube", "")
		String = string.Replace(String, ".mdl", "")
		String = string.Explode( "x", String )
		
		if not Nice then
			for key, value in pairs(String) do
				String[key] = string.Replace(value, "0", "0.")
			end
		end

		return String
	end
end

function PP_SizeToModelString( String )
	return "models/hunter/blocks/cube"..String..".mdl"
end

function PP_DecayLastPlatform(time)
	if SERVER then
		if IsValid(PP_LastPlatform()) then
			PP_LastPlatform():StartDecay(time or 3)
		end
	end
end


function PP_DecayBeforeLastPlatform(time)
	if SERVER then
		if IsValid( PP_BeforeLastPlatform()) then
			 PP_BeforeLastPlatform():StartDecay(time or 3)
		end
	end
end

function PP_LastPlatform()
	return Platform_Manager["Platforms"][table.Count(Platform_Manager["Platforms"])]
end

function PP_BeforeLastPlatform()
	return Platform_Manager["Platforms"][table.Count(Platform_Manager["Platforms"]) - 1]
end


function PP_RemoveAllOtherPlatforms( not_remove, time )
	for key, value in pairs(ents.FindByClass("pp_platform")) do
		if value != not_remove then
			value:StartDecay(time or PP["Decay_Delay"])

			timer.Simple(time or PP["Decay_Delay"]+4, function()

				if IsValid(value) then -- In case that was unsuccesful.
					
					value:Remove()

				end

			end )
		end
	end
end

function GM:OnEntityCreated( entity )

	if entity:GetClass() == "pp_platform" then

		if not IsValid(entity) then return end

		table.insert( Platform_Manager["Platforms"], entity ) -- Tracking all platforms spawned.
		
		timer.Simple(0, function() -- This is a necessary timer in this hook.

			if CLIENT then

				local PhysicsObject = entity:GetPhysicsObject()

				if IsValid( PhysicsObject ) then

					entity:SetMaterial( PP["Platform_Material"] )
				end
				
			end
			PP_PlatformTypeSetup(entity) -- Setting up the platform type and its functions.

		end )
	end
	
end 

function GM:EntityRemoved( entity )
	if entity:GetClass() == "pp_platform" then

		if not IsValid(entity) then return end

		if table.HasValue(Platform_Manager["Platforms"],entity) then

			table.RemoveByValue(Platform_Manager["Platforms"],entity)

		end
		
	end
end

Platform_Manager["Transport_Platforms"] = {
	"8x8x4",
	--"8x8x2",
	--"8x8x1",
}

Platform_Manager["LandSizes"] = {
	-- "05x05x05",
	-- "05x075x025",
	"05x1x025",
	"05x1x05",
	"05x2x025",
	"05x2x05",
	"05x3x025",
	"05x3x05",
	"05x4x025",
	"05x4x05",
	"05x5x025",
	"05x5x05",
	"05x6x025",
	"05x6x05",
	"05x7x025",
	"05x7x05",
	"05x8x025",
	"05x8x05",
	"125x125x025",
	-- "1x1x025",
	-- "1x1x05",
	-- "1x1x1",
	-- "1x2x025",
	-- "1x2x05",
	-- "1x2x1",
	"1x3x025",
	"1x3x1",
	"1x4x025",
	"1x4x05",
	"1x4x1",
	"1x5x025",
	"1x6x025",
	"1x6x05",
	"1x6x1",
	"1x7x025",
	"1x8x025",
	"1x8x05",
	"1x8x1",
	"2x2x025",
	"2x2x05",
	-- "2x2x1",
	-- "2x2x2",
	"2x3x025",
	"2x4x025",
	"2x4x05",
	"2x4x1",
	"2x6x025",
	"2x6x05",
	"2x6x1",
	"2x8x025",
	"2x8x05",
	"2x8x1",
	"3x3x025",
	"3x3x05",
	"3x4x025",
	"3x6x025",
	"3x8x025",
}

Platform_Manager["Sizes"] = {
	"025x025x025",
	"025x05x025",
	"025x075x025",
	"025x125x025",
	"025x150x025",
	"025x1x025",
	"025x2x025",
	"025x3x025",
	"025x4x025",
	"025x5x025",
	"025x6x025",
	"025x7x025",
	"025x8x025",
	"05x05x025",
	"05x05x05",
	"05x075x025",
	"05x105x05",
	"05x1x025",
	"05x1x05",
	"05x2x025",
	"05x2x05",
	"05x3x025",
	"05x3x05",
	"05x4x025",
	"05x4x05",
	"05x5x025",
	"05x5x05",
	"05x6x025",
	"05x6x05",
	"05x7x025",
	"05x7x05",
	"05x8x025",
	"05x8x05",
	"075x075x025",
	"075x075x075",
	"075x1x025",
	"075x1x075",
	"075x1x1",
	"075x2x025",
	"075x2x075",
	"075x2x1",
	"075x3x025",
	"075x3x075",
	"075x3x1",
	"075x4x025",
	"075x4x075",
	"075x5x075",
	"075x6x025",
	"075x6x075",
	"075x7x075",
	"075x8x025",
	"075x8x075",
	"125x125x025",
	"150x150x025",
	"1x150x1",
	"1x1x025",
	"1x1x05",
	"1x1x1",
	"1x2x025",
	"1x2x05",
	"1x2x1",
	"1x3x025",
	"1x3x1",
	"1x4x025",
	"1x4x05",
	"1x4x1",
	"1x5x025",
	"1x6x025",
	"1x6x05",
	"1x6x1",
	"1x7x025",
	"1x8x025",
	"1x8x05",
	"1x8x1",
	"2x1x1",
	"2x2x025",
	"2x2x05",
	"2x2x1",
	"2x2x2",
	"2x3x025",
	"2x4x025",
	"2x4x05",
	"2x4x1",
	"2x6x025",
	"2x6x05",
	"2x6x1",
	"2x8x025",
	"2x8x05",
	"2x8x1",
	"3x3x025",
	"3x3x05",
	"3x4x025",
	"3x6x025",
	"3x8x025",
	"4x4x025",
	"4x4x05",
	"4x4x1",
	"4x4x2",
	"4x4x4",
	"4x6x025",
	"4x6x05",
	"4x6x1",
	"4x6x2",
	"4x6x4",
	"4x6x6",
	"4x8x025",
	"4x8x05",
	"4x8x1",
	"6x6x025",
	"6x6x05",
	"6x6x1",
	"6x6x2",
	"6x6x6",
	"6x8x05",
	"6x8x1",
	"6x8x2",
	"8x8x025",
	"8x8x05",
	"8x8x1",
	"8x8x2",
	"8x8x4",
	"8x8x8",
}