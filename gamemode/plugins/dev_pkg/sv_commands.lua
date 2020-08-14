-- Developer Commands

hook.Add("PlayerSay", "PP_Commands", function( ply, text )
	if string.lower(text) == "!commands" then
		if ply:IsAdmin() then
			ply:SendNotification("Game", "!newgame - Starts the game over.")
			ply:SendNotification("Game", "!endgame - Takes players to the endscreen, restarting the game.")
		end
		return ""
	elseif string.lower(text) == "!newgame" then
		ply:ConCommand("pp_new_game")
		return ""
	elseif string.lower(text) == "!endgame" then
		ply:ConCommand("pp_end_game")
		return ""
	end
end)

concommand.Add("pp_weapon", function(ply, cmd, args)
	if ply:IsAdmin() then
		ply:AddInventoryItem(args[1], "models/error.mdl", PP["Ingots"][1]["Color"], "models/shiny")
	end
end )

concommand.Add("pp_new_game", function( ply )
	if ply:IsAdmin() then
		PP_NewGame()
	end
end )

concommand.Add("pp_end_game", function( ply )
	if ply:IsAdmin() then
		PP_EndGameLoss()
	end
end )


local function PP_CheaterMode( ply )
	if ply:IsAdmin() then
		return true
	else
		return false
	end
end
hook.Add( "PlayerNoClip", "PP_CheaterMode", PP_CheaterMode )


concommand.Add("pp_spawn_platform", function( player, cmd, args )
	if not player:IsAdmin() then return end
	 local tr = util.TraceLine( {
        start = player:EyePos(),
        endpos = player:EyePos() + player:EyeAngles():Forward() * 10000,
        filter = player
    } )


	local New_PP_Platform = {} -- Establishing a table for the next platform data.
	
	New_PP_Platform = Platform_Manager["Types"][args[1]]
	
	Generate_Platform( { -- Spawing the start platform!

		["Structure"] = args[1] or nil, -- If nil, a structure won't be built.

		["Type"] = args[1], -- This should always be a valid type.

		["Size"] = New_PP_Platform["Size"] or nil,

		["Angle"] = Angle(0,0,0),

		["Material"] = New_PP_Platform["Material"] or nil,

		["Color"] = New_PP_Platform["Color"] or nil,

		["Mass"] = New_PP_Platform["Mass"] or nil,

		["Start"] = Vector(	
			tr.HitPos
		), -- Start Point

		["End"] = tr.HitPos+Vector(0,0,100), -- End Point.

		["Life"] = 0.1, -- How long to get to it's end point.

		["Decay"] = 3, -- Decay Time.


	} )

end )