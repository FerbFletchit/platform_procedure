local land = function() return table.Random(Platform_Manager["LandSizes"]) end
Platform_Manager["Types"]["Land_Piece"] = {
	["Rarity"] = 1, -- 0.1 - 1.
	["Angle"] = Angle(0,0,0),
	--["Size"] = land(),
	["Material"] = "models/debug/debugwhite",
	["Color"] = Color(127,111,63),
	["Mass"] = 200,
	["Life"] = 0.1, -- How long to get to it's end point.
	["Decay"] = 20, -- Decay Time.
	["Loot"] = false,

	["Delete_Last"] = false, -- Should the platform delete the last one.
	["Auto_Spawn_Next"] = true, -- Should it automaticall spawn the next one after time.
	["Next_Spawn"] = PP["Land_Piece_Next"], -- How long until auto spawn next platform.

	[1] = function( Platform ) -- Everything controlled here.
		Platform["Info"] = Platform["Info"] or {}
		Platform["Info"]["Reached_Destination"] = true -- This is necessary so the callback doesn't activate right away.
		
		Platform["Callback_Time"] = math.random(5,15)

		Platform["Callback"] = function( Platform ) -- What happens when we reach our destination.
			Platform:SetNW2Bool("Activated", true)
		end

		timer.Simple( Platform["Callback_Time"], function() -- This acts a fail-safe for platform callback.
			if IsValid( Platform ) then
				if not Platform:GetNW2Bool("Activated") then
					Platform["Callback"]( Platform )
				end
			end
		end )
		
		if SERVER then
			Platform:SetAngles( Angle(0,90*math.random(-4,4), 0 ) )
			Platform["Theme"] = table.Random(PP["Block_Themes"])

			local Min, Max = Platform:GetModelBounds()

			Platform:Activate()

			Platform:SetColor( Platform["Theme"][1] )

			local Top_Size = Platform["Info"]["Size"]
			Top_Size = PP_PlatformModelToTable( Top_Size, true )
			Top_Size = tostring(Top_Size[1].."x"..Top_Size[2].."x025")
			
			--timer.Simple(0.1, function()
				if IsValid(Platform) then
					Platform["Grass_Top"] = ents.Create("prop_dynamic")
					
					if IsValid( Platform["Grass_Top"] ) then
						
						
						Platform["Grass_Top"]:SetPos(Platform:GetPos()+Vector(0,0,Max[3])+Platform:GetUp()*5)

						Platform["Grass_Top"]:SetModel("models/hunter/blocks/cube"..Top_Size..".mdl")
						
						Platform["Grass_Top"]:SetAngles( Platform:GetAngles() )

						Platform["Grass_Top"]:SetMoveType(MOVETYPE_NONE)

						Platform["Grass_Top"]:SetSolid(SOLID_VPHYSICS)
						
						Platform["Grass_Top"]:Spawn()
						
						Platform["Grass_Top"]:SetParent( Platform )

						Platform["Grass_Top"]:SetMaterial(Platform:GetMaterial())

						Platform["Grass_Top"]:SetColor( Platform["Theme"][2] )

						
						local PhysicsObject = Platform["Grass_Top"]:GetPhysicsObject()
						if IsValid(PhysicsObject) then
							PhysicsObject:SetMass(1)
							PhysicsObject:EnableGravity( false )
						end

						if Platform["Grass_Top"]:GetModel() == "models/error.mdl" then
							Platform["Grass_Top"]:Remove() -- Preventative.
						end

					end
				end

			--end )

		end
	end
}