function PP_CreateRoute()
	SetGlobalInt("PP_CurrentRoutePoint",1)
	PP_Route = {
		[1] = PP["Start_Point"], -- Start Point.
	}

	local PP_RoutePoints = math.random(10,20)
	local Height_Distance = PP["End_Point"][3] - PP["Start_Point"][3]

	for index=1+1, PP_RoutePoints do
		-- Decide progressing route point,
		-- increasing elevation, depending on current elevation and how many points there are remaining.
		local Previous_Point = PP_Route[index - 1]
		
		local Next_Point = Vector(
			math.random(PP["Map_Bounds"][1][1],PP["Map_Bounds"][2][1]),
			math.random(PP["Map_Bounds"][1][2],PP["Map_Bounds"][2][2]),
			Previous_Point[3] + Height_Distance / PP_RoutePoints
		)
		
		table.insert(PP_Route, Next_Point)
	end
	table.insert(PP_Route, PP["End_Point"])
end

function PP_NextPlatformPosition()
	local Last_PP = PP_BeforeLastPlatform()
	local New_PP = PP_LastPlatform()

	if not IsValid(Last_PP) or not IsValid(New_PP) then
		return team.GetPlayers(1)[1]:GetPos() or Vector(0,0,0) -- Fail safe
	end

	local Last_Min = Last_PP["Info"]["Bounds"][1]
	local Last_Max = Last_PP["Info"]["Bounds"][2]

	local New_Min = Last_PP["Info"]["Bounds"][1]
	local New_Max = Last_PP["Info"]["Bounds"][2]

	local Last_Pos = Last_PP["Travel"]["pos"]
	local New_Pos

	local Gap_Size = 350 -- In units.
	local Height_Adjust = Last_Pos[3] - New_Max[3] + Last_Max[3]

	local Directions = {
		[1] = {"Front", 
			Vector(
				Last_Pos[1] + ( ( Last_Max[1] + New_Max[1] ) + Gap_Size ), 
				Last_Pos[2], 
				Height_Adjust
			)
		},
		[2] = {"Back", Vector(
			Last_Pos[1] - ( ( Last_Max[1] + New_Max[1] ) + Gap_Size ), 
			Last_Pos[2], 
			Height_Adjust
		)},
		[3] = {"Left", Vector(
			Last_Pos[1], 
			Last_Pos[2] + ( (Last_Max[2]+New_Max[2]) + Gap_Size ), 
			Height_Adjust
		)},
		[4] = {"Right", Vector(
			Last_Pos[1], 
			Last_Pos[2] - ( (Last_Max[2]+New_Max[2]) + Gap_Size ), 
			Height_Adjust
		)},
	}

	if Last_PP:GetNW2Int("Direction") then
		table.remove(Directions, Last_PP:GetNW2Int("Direction"))
	end

	local New_Direction = table.Random(Directions)

	New_Pos = New_Direction[2]
	New_PP:SetNW2Int("Direction", table.KeyFromValue( Directions, New_Direction ))

	return New_Pos
end

function PP_GotoNextRoutePoint() -- Returns a vector
	SetGlobalInt("PP_CurrentRoutePoint", GetGlobalInt("PP_CurrentRoutePoint") + 1)
	return PP_Route[GetGlobalInt("PP_CurrentRoutePoint")]
end

function PP_GetNextRoutePoint()
	return PP_Route[GetGlobalInt("PP_CurrentRoutePoint") + 1]
end

function PP_GetLastRoutePoint()
	return PP_Route[GetGlobalInt("PP_CurrentRoutePoint") - 1]
end