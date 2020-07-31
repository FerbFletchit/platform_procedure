util.AddNetworkString("PP_UpdateState")


function PP_RespawnAllPlayersOnPlatform( Platform )
	if IsValid( Platform ) then
		for key, value in pairs( player.GetAll() ) do


			-- If dead, respawn and set pos to plat form
			if value:Alive() then
				local PP_TooFarFromPlatform = 250
				
				if value:GetPos():DistToSqr(Platform:GetPos()) > (PP_TooFarFromPlatform*PP_TooFarFromPlatform) then
					
					value:SetPos( Platform:GetPos() + Vector( math.random(-10,10), math.random(-10,10), 150) )

					value:SetVelocity( -value:GetVelocity() )

					PP_ActionEffect(value:GetPos()+Vector(0,0,10), "pp_teleport", 1)

				end

			elseif team.GetPlayers(1) then
				if IsValid( PP_GetRandomAlivePlayer(value) ) then
					
					value:SetObserverMode(0)

					value:Spawn()

					value:SetPos(PP_GetRandomAlivePlayer(value):GetPos())

					PP_PlayerBaseSpawn( value )

					PP_ActionEffect(value:GetPos()+Vector(0,0,10), "pp_teleport", 1)

				end

			end

		end
	end
end