function PP_AddGameContent( path )
    local files, folders = file.Find( path .. "/*", "GAME" )
    for k, v in pairs( files ) do
		resource.AddFile( path .. "/" .. v )
    end
        
    for k, v in pairs( folders ) do
        PP_AddGameContent( path .. "/" .. v )
    end
end


--resource.AddWorkshop( "2183728122" ) -- Platform Procedure addon.
resource.AddWorkshop( "235373337" ) -- Ace of spades models.
resource.AddWorkshop( "1516718459" ) -- Half-life models :/
resource.AddWorkshop( "1696595790" ) -- Grappling hook.
resource.AddWorkshop( "723474088" ) -- Voxel Chell.
resource.AddWorkshop( "974828281" ) -- Minecraft arms.

-------------------------------

-- FONTS --

-------------------------------

PP_AddGameContent( "resource/fonts" )

-------------------------------

-- MATERIALS --

-------------------------------

-------------------------------
-- MODELS --
-------------------------------

-------------------------------

-- MAP CONTENT --

-------------------------------

PP_AddGameContent( "maps" )


