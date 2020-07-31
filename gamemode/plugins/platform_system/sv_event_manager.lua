function PP_DecidePlatformEvent( Platform )
	if IsValid(Platform) then
		if not Platform["Events"] then return end
		for key, value in RandomPairs( Platform["Events"] ) do

			Platform["Event_Ent"] = ents.Create(key)
			
			if IsValid( Platform["Event_Ent"] ) then
				
				Platform["Event_Ent"]:SetPos(value["Pos"]())
								
				Platform["Event_Ent"]:SetParent( Platform )
				
				Platform["Event_Ent"]:Spawn()

				Platform["Event_Ent"]:SetAngles(value["Angles"]())

				Platform["Event_Ent"]:SetParent( Platform )
				
			else
				timer.Simple(15, function()
					PP_SpawnTheNextOrderedPlatform()
				end )
			end

			return
		end
	end
end

function PP_StartBossStageTimer( Boss )

	timer.Simple(PP["Boss_Stage_MaxTime"], function()
		
		if IsValid(Boss) then -- This means that the boss has not been defeated in time.
			
			Boss:Remove()

			PP_EndGameLoss()

		end

	end )

end