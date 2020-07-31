AddCSLuaFile( "cl_init.lua" )

include( "shared.lua" )

include( "resources.lua" )

AddCSLuaFile( "shared.lua" )

MsgN("_-_-_-_- Server Files -_-_-_-_")
MsgN("Loading Server Files")
for _, file in pairs (file.Find("platform_procedure/gamemode/server/*.lua", "LUA")) do
   MsgN("-> "..file)
   include("platform_procedure/gamemode/server/"..file) 
end

MsgN("_-_-_-_- Shared Files -_-_-_-_")
for _, file in pairs (file.Find("platform_procedure/gamemode/shared/*.lua", "LUA")) do
   MsgN("-> "..file)
   AddCSLuaFile("platform_procedure/gamemode/shared/"..file)
end

MsgN("_-_-_-_- Client Files -_-_-_-_")
for _, file in pairs (file.Find("platform_procedure/gamemode/client/*.lua", "LUA")) do
   MsgN("-> "..file)
   AddCSLuaFile("platform_procedure/gamemode/client/"..file)
end

-------------------------------------------------------------------
--						Serverside Code						     --
-------------------------------------------------------------------

hook.Add("OnEntityCreated", "PP_HideModelErrors", function( ent )
	timer.Simple(1, function()
      if IsValid( ent ) then
   		if ent:GetModel() == "models/error.mdl" then
   			ent:SetNoDraw( true )
   		end
   	end
   end )
end )

include("plugins.lua") -- Loading plugins last.
