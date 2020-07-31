function IncludePlugins(dir)
	MsgN("Starting to include CL Plugins!");
	local fil, Folders = file.Find(dir.."*", "LUA")
	MsgN("Total: ", table.Count(Folders));
	
	for k,v in pairs(Folders)do
		if(v != "." and v != "..")then
			local Files = file.Find(dir..v.."/*.lua", "LUA");
			
			for q,w in pairs(Files) do
				include("plugins/"..v.."/"..w)
			end
		end
	end
end

include( 'shared.lua' )

MsgN("Loading Clientside Files")
for _, file in pairs(file.Find("platform_procedure/gamemode/client/*.lua", "LUA")) do
	MsgN("-> "..file)
	include("platform_procedure/gamemode/client/"..file)
end

function GM:PostDrawViewModel( vm, ply, weapon )

	if ( weapon.UseHands || !weapon:IsScripted() ) then

		local hands = LocalPlayer():GetHands()
		if ( IsValid( hands ) ) then hands:DrawModel() end

	end

end

----------------------------------------------
-- Creating the chell textures
----------------------------------------------
for i=1, 10 do

	CreateMaterial( "VoxChell"..i, "VertexLitGeneric", {
		["$baseTexture"] = "models/VoxChell/VoxChell"..i,
		
		["$model"] = 1,
		["$nocull"] = 1,

		["$normalmapalphaenvmapmask"] = 1,
		["$phong"] = 1,
		["$phongexponent"] = 5,
		["$phongboost"] = 1,
		["$phongfresnelranges"]	= "[0.05 0.5 1]",
		
	} )

end

IncludePlugins("platform_procedure/gamemode/plugins/") -- Loading plugins last.
