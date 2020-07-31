Platform_Manager["Types"] = {}

function PP_PlatformTypeSetup( Platform )
	if not IsValid(Platform) then return end

	local PP_Type = Platform:GetType() or ""

	if Platform_Manager["Types"][PP_Type] then

		Platform_Manager["Types"][PP_Type][1](Platform)
		
	end
end
hook.Add("PP_PlatformTypeSetup", "PP_PlatformTypeSetup", PP_PlatformTypeSetup)