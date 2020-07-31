-- Hide hud --
function hidehud(name)
	for k, v in pairs({"CHudHealth", "CHudBattery", "CHudAmmo", "CHudSecondaryAmmo", "CHudWeaponSelection"}) do
		if name == v then return false end
	end
end
hook.Add("HUDShouldDraw", "PP_HideDefaultHud", hidehud)

hook.Add("HUDDrawTargetID", "PP_HideNameHP", function() return false end)

hook.Add("HUDDrawPickupHistory", "PP_HidePickup", function() return false end)
