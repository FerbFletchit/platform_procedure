function PP_SpawnLandPiecesAround( Platform, Amount )
	for i=1, Amount or PP["Land_Piece_Amount"]() do
		Generate_Platform( { -- Spawing the start platform!

			["Structure"] = nil, -- If nil, a structure won't be built.

			["Type"] = "Land_Piece", -- This should always be a valid type.

			["Size"] = nil,

			["Angle"] = Angle(0,45*math.random(0,8),0),

			["Start"] = Vector(	
				math.random(PP["Map_Bounds"][1][1],PP["Map_Bounds"][2][1]),
				math.random(PP["Map_Bounds"][1][2],PP["Map_Bounds"][2][2]),
				math.random(PP["Map_Bounds"][1][3],PP["Map_Bounds"][2][3])
			), -- Start Point

			["End"] = Platform["Travel"]["pos"] + Vector(
				math.random(-PP["Land_Piece_Radius"],PP["Land_Piece_Radius"]),
				math.random(-PP["Land_Piece_Radius"],PP["Land_Piece_Radius"]),
				math.random(-PP["Land_Piece_Y"],PP["Land_Piece_Y"])
			),

			["Life"] = PP["Land_Piece_Arrival"](), -- How long to get to it's end point.

			["Decay"] = PP["Land_Piece_Decay"], -- Decay Time.

		} )
	end
end

function PP_SpawnTheNextOrderedPlatform() -- Everything is pretty experimental.
	if GetGlobalBool("PP_OngoingEvent") then return end
	if not PP["Floors"]["Current_Platform_Order"] then return end
	if PP["Floors"]["Current_Platform"] >= (#PP["Floors"]["Current_Platform_Order"] or 0) then
		return
	end

	PP["Floors"]["Current_Platform"] = PP["Floors"]["Current_Platform"] + 1
	PP_ReachedEvent( nil, PP["Floors"]["Current_Platform_Order"][ PP["Floors"]["Current_Platform"] ] )
end

function PP_DeleteAndNextSpawnManage( Platform )

	-- Here we delete the platform that was before our next platform --
	local Type = Platform_Manager["Types"][Platform:GetType()]
	if Type then
		if IsValid( PP_BeforeLastPlatform() ) then
			timer.Simple(PP["Decay_Delay"], function()
				if IsValid( PP_BeforeLastPlatform() ) then

					local Last_Type = Platform_Manager["Types"][PP_BeforeLastPlatform():GetType()]

					if not Last_Type then
						PP_DecayBeforeLastPlatform(PP["Default_Time"])
					else
					
						if Type["Delete_Last"] then

							PP_DecayBeforeLastPlatform(Last_Type["Decay"] or PP["Default_Time"])

						end
					end

				end
			end )

		end

		if Type["Auto_Spawn_Next"] then
			
			timer.Simple( Type["Next_Spawn"], function()

				PP_SpawnTheNextOrderedPlatform()

			end )

		end
	end
end

function PP_ReachedEvent( Platform, New_Type )

	-- Collecting the information of the last platform spawned.
	
	local PP_Last_Platform = nil

	if not IsValid(PP_LastPlatform()) and not IsValid(Platform) then
		
		PP_Last_Platform = Platform_Manager["Platforms"][#Platform_Manager["Platforms"]]
		
		--return print("uh oh! Last platform wasn't found! Shouldn't ever happen!!!!")
	end

	PP_Last_Platform =  PP_Last_Platform or Platform or PP_LastPlatform()
	
	local PP_Last_Platform_Bounds = PP_Last_Platform["Info"]["Bounds"][2]

	-- Here we either spawn a transport or some other type of platform depending on our order. 

	local Type_Selections = Platform_Manager["Types"]

	if not New_Type or not Platform_Manager["Types"][New_Type] then -- This allows the next platform type to be system forced. Make sure it exists.

		local Last_Type = PP_Last_Platform:GetType() or ""

		local Platform_Rarity_Selector = math.Rand(0.1, 1) -- Selecting a random chance number.

		for key, value in RandomPairs(Type_Selections) do -- Randomly selecting our next platform type with rarity.

			if Platform_Rarity_Selector <= value["Rarity"] and key != Last_Type then

				New_Type = key

				break

			end

		end

	end
	
	local New_PP_Platform = {} -- Establishing a table for the next platform data.
	
	New_PP_Platform = Platform_Manager["Types"][New_Type]

	if New_PP_Platform == nil then 
		PP_ReachedEvent() 
	return end
	
	Generate_Platform( { -- Spawing the start platform!

		["Structure"] = New_Type or nil, -- If nil, a structure won't be built.

		["Type"] = New_Type, -- This should always be a valid type.

		["Size"] = New_PP_Platform["Size"] or nil,

		["Angle"] = PP_Last_Platform:GetAngles() or Angle(0,0,0),

		["Material"] = New_PP_Platform["Material"] or nil,

		["Color"] = New_PP_Platform["Color"] or nil,

		["Mass"] = New_PP_Platform["Mass"] or nil,

		["Start"] = Vector(	
			math.random(PP["Map_Bounds"][1][1],PP["Map_Bounds"][2][1]),
			math.random(PP["Map_Bounds"][1][2],PP["Map_Bounds"][2][2]),
			math.random(PP["Map_Bounds"][1][3],PP["Map_Bounds"][2][3])
		), -- Start Point

		["End"] = PP_Last_Platform["Travel"]["pos"], -- End Point.

		["Life"] = 2, -- How long to get to it's end point.

		["Decay"] = 1, -- Decay Time.

		--["Callback"] = New_PP_Platform["Callback"] or nil

	} )

	PP_DeleteAndNextSpawnManage( PP_LastPlatform() )

	-- The last platform now is the one we just spawned, we adjust it's final destination after spawn. (Sketchy)
	PP_LastPlatform()["Travel"]["pos"] = PP_NextPlatformPosition()
	--PP_LastPlatform()["Travel"]["Start"] = PP_LastPlatform()["Travel"]["pos"] - Vector(0,0,300)
end

function Generate_Platform(Platform_Table)
	--print("TYPE: "..Platform_Manager["Types"][Platform_Table["Type"]]["Size"])
	local ID = Platform_Table["ID"] or tostring( math.random( 1, 100000 ) ) -- Randomized ID string (Sorta).
	
	local Structure = Platform_Manager["Structures"][Platform_Table["Structure"]] or {}

	PP["LastPlatformSpawn"] = CurTime()

	local PP_Platform = ents.Create("pp_platform") -- Creating the platform.
	
	if not IsValid( PP_Platform ) then 
		print("Platform Procedure: Something went wrong and platform spawning has failed!")
		return -- Stop the function.
	end 
	
	PP_Platform:SetPos(Platform_Table["Start"])
	
	PP_Platform:SetID( tostring( ID ) )

	PP_Platform["Callback"] = Platform_Table["Callback"] or nil

	--* Building the Base *--

	if Platform_Table["Type"] == "Land_Piece" then

		Platform_Table["Size"] = table.Random(Platform_Manager["LandSizes"])
		
		PP_Platform:SetModel("models/hunter/blocks/cube"..Platform_Table["Size"]..".mdl")

	elseif Structure["Size"] then

		PP_Platform:SetModel("models/hunter/blocks/cube"..Structure["Size"]..".mdl")

	elseif Platform_Manager["Types"][Platform_Table["Type"]] and Platform_Manager["Types"][Platform_Table["Type"]]["Size"] then
		
		PP_Platform:SetModel("models/hunter/blocks/cube"..Platform_Manager["Types"][Platform_Table["Type"]]["Size"]..".mdl") -- ewwww

	elseif not Platform_Table["Size"] then -- If not structure, but size defined by us, set it.
		
		Platform_Table["Size"] = table.Random(Platform_Manager["Sizes"])
		
		PP_Platform:SetModel("models/hunter/blocks/cube"..Platform_Table["Size"]..".mdl")

	else -- If size is not defined in the generation, return random.

		PP_Platform:SetModel("models/hunter/blocks/cube"..Platform_Table["Size"]..".mdl")

	end
	
	PP_Platform:SetRenderMode(1) -- Supports Transparency.
	
	PP_Platform:SetRenderFX( Structure["FX"] or Platform_Table["FX"] or 0 ) -- None as default.
	
	PP_Platform:SetColor( Structure["Color"] or Platform_Table["Color"] or PP_Platform:GetColor() )

	PP_Platform:SetAngles( Structure["Angles"] or Platform_Table["Angles"] or Angle(0,0,0) )

	PP_Platform:SetType( Platform_Table["Type"] or "" )

	PP_Platform:Spawn()

	local trail = util.SpriteTrail( PP_Platform, 0, Color( 255, 255, 255, 100 ), false, PP_PlatformSize( PP_Platform ), 1, 2, 1 / ( 15 + 1 ) * 0.5, "trails/laser" )

	PP_Platform["Info"] = {
		["Size"] = Platform_Table["Size"] or "1x1x1",
		["Start"] = Platform_Table["Start"] or Vector(0,0,0),
		["Bounds"] = {PP_Platform:GetModelBounds()} or {Vector(0,0,0),Vector(0,0,0)},
		["Type"] = Platform_Table["Type"] or "",
	}

	PP_Platform["Travel"] = {
		["Angle"] = Platform_Table["Angle"] or Angle(0,0,0),
		["maxangular"] = 1000,
		["maxangulardamp"] = 900, 
		["maxspeed"] = 7000,
		["maxspeeddamp"] = 2000,
		["teleportdistance"] = 0,
		["secondstoarrive"] = Platform_Table["Life"],
		["pos"] = Platform_Table["End"],
		["dampfactor"] = 0.6,
		["angle"] = Platform_Table["Angle"] or Angle(0,0,0),
		["decay"] = Platform_Table["Decay"] or 3 -- Time it takes for the platform to be removed after reaching destination
	}

	local PhysicsObject = PP_Platform:GetPhysicsObject()
	if IsValid(PhysicsObject) then
		PhysicsObject:SetMass( Structure["Mass"] or Platform_Table["Mass"] or 50000 )
		PP_Platform["Travel"]["maxspeed"] = (PhysicsObject:GetVolume() * 0.10) -- Here we set the max speed based on volume, meaning that smaller blocks move faster if needed.
	end

	PP_Platform:SetMaterial( Structure["Material"] or Platform_Table["Material"] or Platform_Manager["Types"][Platform_Table["Type"]]["Material"] or PP_Platform:MassBasedMaterial() or PP["Default_Material"] or "")

	-- Building a KeepupRight Anchor --
	local KeepUpright = ents.Create("prop_physics")
	
	if IsValid(KeepUpright) then
	
		KeepUpright:SetPos(PP_Platform:GetPos())
		
		KeepUpright:SetModel("models/hunter/blocks/cube1x1x1.mdl")
		
		KeepUpright:SetCollisionGroup(10) -- Doesn't collide with anything.
		
		KeepUpright:Spawn()

		KeepUpright:SetNoDraw( true )

		local PhysicsObject = KeepUpright:GetPhysicsObject()
		
		if IsValid(PhysicsObject) then

			PhysicsObject:EnableGravity(false)

			PhysicsObject:SetMass(Structure["Mass"] or Platform_Table["Mass"] or 50000) -- Mass of keepupright must match the platform for effect.

		end

		constraint.NoCollide( KeepUpright, PP_Platform, 0, 0 )
		constraint.Keepupright( KeepUpright, Angle(0,0,0), 0, Structure["Mass"] or Platform_Table["Mass"] or 50000 )
		constraint.Weld( PP_Platform, KeepUpright, 0, 0, 0, true, true )

	end


	--* Building the Platform *--
	if Structure["Child_Blocks"] then -- If this platform is a structure, set based on structure set.

		--* Building Pre-Made Structures *--

		for key, value in pairs(Structure["Child_Blocks"]) do

			
			if value[1] == "models/props_junk/shoe001a" then -- This I used to make npc.
				
			elseif value[1] == "models/props_c17/doll01" then -- This I used to make loot.
				
			else

				local PP_Structure_Block = ents.Create("prop_dynamic")
				
				if IsValid(PP_Structure_Block) then

					if not table.HasValue( Platform_Manager["Sizes"], value[1] ) then -- Allows other models in the structure.

						PP_Structure_Block:SetModel(value[1])

					else

						PP_Structure_Block:SetModel("models/hunter/blocks/cube"..value[1]..".mdl")

					end

					PP_Structure_Block:SetPos(value[2](PP_Platform))

					PP_Structure_Block:SetAngles(value[3] - PP_Platform:GetAngles())

					PP_Structure_Block:SetRenderMode(1) -- Supports Transparency.

					PP_Structure_Block:SetRenderFX(Structure["FX"] or 0) -- None as default.

					PP_Structure_Block:SetColor(value[4])
					PP_Structure_Block:SetMaterial(value[5])

					PP_Structure_Block:SetParent(PP_Platform)

					PP_Structure_Block:SetMoveType(MOVETYPE_NONE)

					PP_Structure_Block:SetSolid(SOLID_VPHYSICS)
					
					PP_Structure_Block:Spawn()


					if IsValid(PP_Structure_Block) then

						timer.Simple((Platform_Table["Life"] + 5) or 10, function()

							if IsValid( PP_Structure_Block ) then

								PP_Enemy_Spawn( PP_Structure_Block )

								PP_Loot_Spawn( PP_Structure_Block )

							end

						end )

					end

					
					local PhysicsObject = PP_Structure_Block:GetPhysicsObject()

					if IsValid( PhysicsObject ) then
						PhysicsObject:SetMass(1)
					end

					constraint.NoCollide( PP_Structure_Block, PP_Platform, 0, 0 )

				end
			end
			
		end

	end
	
end