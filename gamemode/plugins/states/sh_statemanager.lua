PP["CurrentState"] = PP["CurrentState"] or 0
PP["StartStateTime"] = PP["StartStateTime"] or CurTime()
PP["StateManager"] = PP["StateManager"] or {}

local PP_StateNextThink = CurTime()
hook.Add( "Think", "PP_StateManagerThinking", function()
	if CurTime() > PP_StateNextThink then 
		if SERVER then
			if PP["CurrentState"] and PP["CurrentState"] != 0 and PP["StartStateTime"] then
				
				if #player.GetAll() == 0 then
					PP_IdleServer()
				end

				PP.StateManager["States"][PP["CurrentState"]]["Update"]()

				if PP.StateManager["States"][PP["CurrentState"]]["Duration"] then
					if CurTime() >= PP["StartStateTime"] + PP.StateManager["States"][PP["CurrentState"]]["Duration"] and not PP.StateManager["ChangingState"] then
						PP.StateManager["ChangingState"] = true
						PP_NextGameState()
					end

				elseif PP.StateManager["States"][PP["CurrentState"]]["Should_End"]() then

					PP.StateManager["States"][PP["CurrentState"]]["End"]() -- So if the state should end, run its end function to see what to do.

				end

			end
		end
		PP_StateNextThink = CurTime() + 1
	end
		
	

end )
	

function PP_GetGameState()
	return PP["CurrentState"]
end

function PP_IdleServer()
	print("[Platform Procedure] Initiating Server Idle Mode.")
	game.CleanUpMap( false, {})
	PP["CurrentState"] = nil
	PP["StartStateTime"] = nil
end

function PP_NextGameState()
	if not SERVER then return end
	PP.StateManager["States"][PP["CurrentState"]]["Leaving"]() -- Triggers current state leaving function.
	PP["StartStateTime"] = CurTime()
	
	if PP["CurrentState"] >= #PP.StateManager["States"] then -- Checking to see if current state is last.
		PP_NewGame()
		--PP["CurrentState"] = 1 -- Setting to first state.
	else
		PP["CurrentState"] = PP["CurrentState"] + 1
		PP.StateManager["States"][PP["CurrentState"]]["Entered"]()
	end
	PP_UpdateClientState()
	PP.StateManager["ChangingState"] = false
end

function PP_UpdateClientState()
	if SERVER then -- Updating the client with the current state. Good measure without much resource.
		net.Start("PP_UpdateState")
			net.WriteInt((PP["CurrentState"] or 1), 4)
		net.Broadcast()
	end
end

function PP_SwitchGameState(Desired_State)
	if not SERVER then return end
	if PP.StateManager["States"][Desired_State] != nil then -- Making sure our desired state is valid.
		PP.StateManager["States"][PP["CurrentState"]]["Leaving"]() -- Triggers current state leaving function.
		
		PP["CurrentState"] = Desired_State
		PP["StartStateTime"] = CurTime()
		PP_UpdateClientState()

		PP.StateManager["States"][PP["CurrentState"]]["Entered"]()
		
	else
		print("[State Manager] Desired state to switch to is invalid!")
	end
end

function PP_CurrentStateTimeLeft()
	if PP.StateManager["States"][PP["CurrentState"]]["Duration"] then
		return math.Round( ( PP.StateManager["States"][PP["CurrentState"]]["Duration"] - ( CurTime() - PP["StartStateTime"] ) ) )
	else
		return 0
	end
end