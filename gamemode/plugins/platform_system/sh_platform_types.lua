Platform_Manager["Types"] = {}

function PP_PlatformTypeSetup( Platform )
	if not IsValid(Platform) then return end
	
	local PP_Type = ""
	
	if tostring(Platform:GetType()) != "nil" or tostring(Platform:GetType()) != "" then

		PP_Type = Platform:GetType()

	end
	

	if Platform_Manager["Types"][PP_Type] then

		Platform_Manager["Types"][PP_Type][1](Platform)
		
	end
end
hook.Add("PP_PlatformTypeSetup", "PP_PlatformTypeSetup", PP_PlatformTypeSetup)