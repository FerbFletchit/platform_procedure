local Files, Folders = file.Find("gamemodes/platform_procedure/gamemode/plugins/*", "GAME")

print("LOADING PLUGINS! TOTAL TO LOAD: ", table.Count(Folders))

for key, value in ipairs(Folders) do

	local Files = file.Find("gamemodes/platform_procedure/gamemode/plugins/"..value.."/*.lua", "GAME")
	
	for key_2,value_2 in pairs(Files) do
		
		if string.find(value_2,"sh") == 1 then

			include("plugins/"..value.."/"..value_2)
			AddCSLuaFile("plugins/"..value.."/"..value_2)

		elseif string.find(value_2,"sv") == 1 then

			include("plugins/"..value.."/"..value_2)

		elseif string.find(value_2,"cl") == 1 then

			AddCSLuaFile("plugins/"..value.."/"..value_2)

		end
		
	end

end