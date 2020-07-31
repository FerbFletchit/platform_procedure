PP["Stats"] = {

	{ "Chests Generated", "Chests Opened" }, -- entities/pp_chest/shared.lua

	{ "Monsters Generated", "Monsters Killed" }, -- plugins/enemies/sh_enemies.lua

	{ "Parachutes Generated", "Parachutes Looted" }, -- entities/pp_loot_parachute/init.lua 

	{ "Bombs Generated", "Bombs Defused" }, -- entities/pp_event_bomb/init.lua 

	{ "Bosses Generated", "Bosses Killed" }, -- plugins/enemies/sh_enemies.lua

	{ "Towers Generated", "Towers Defended" }, -- entities/pp_event_tower/init.lua 

	{ "Levers Generated", "Levers Pulled" }, -- entities/pp_lever/init.lua 

}

-- When we're producing these for the end screen, make sure that the first stat in the table is over zero, if not don't add.

-- Percentage for each item 100 * (v[1] / v[2])

function PP_ReturnStats()
	for key, value in pairs(PP["Stats"]) do
		print(GetGlobalInt(value[1]).." "..value[1])
		print(GetGlobalInt(value[2]).." "..value[2])
	end
end

function PP_ReturnUseableStats()

	local End_GameStats = {}

	for key, value in pairs(PP["Stats"]) do

		if GetGlobalInt( value[1] ) >= 1 then

			table.insert(End_GameStats, value)

		end

	end

	return End_GameStats
end

function PP_StatsReset()
	for key, value in pairs( PP["Stats"] ) do

		for key2, Stat_name in pairs( value ) do

			PP_StatsSet( Stat_name, 0 )

		end
	end
end

function PP_StatsSet( Name, Amount )
	if SERVER then
		SetGlobalInt( tostring(Name), tonumber(Amount) )
	end
end


function PP_StatsAdd( Name, Amount )
	if SERVER then
		SetGlobalInt( tostring(Name), GetGlobalInt( tostring(Name) ) + tonumber(Amount) )
	end
end

function PP_StatsSub( Name, Amount ) -- Probably won't use this.
	if SERVER then
		SetGlobalInt( tostring(Name), GetGlobalInt( tostring(Name) ) - tonumber(Amount) )
	end
end

--PP_StatsAdd( "Chests Spawned", 1 )

