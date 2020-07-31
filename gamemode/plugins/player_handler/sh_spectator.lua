if SERVER then

	local Player = FindMetaTable("Player")

	function Player:BecomeSpectator()
		if self:GetObserverMode() == 0 then 

			if team.GetPlayers(1) then -- if there alive players, then.

				self:Spectate( OBS_MODE_ROAMING )

				self:SpectateEntity( PP_GetRandomAlivePlayer(self) )

				self:StripWeapons()
			end

		elseif self:GetObserverMode() == 6 and not IsValid(self:GetObserverTarget()) and team.GetPlayers(1) then -- If they're spectating, but the player has died.

			self:SpectateEntity( PP_GetRandomAlivePlayer(self) ) -- watch new player.

		end
	end
	
end