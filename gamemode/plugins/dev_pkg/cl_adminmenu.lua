concommand.Add("pp_commands", function(ply)
	if not ply:IsAdmin() then return end
	-- Very basic menu.
	ply:SendNotification("Game", "!newgame | Starts the game over.")
	ply:SendNotification("Game", "!endgame | Takes players to the endscreen, restarting the game.")
end )