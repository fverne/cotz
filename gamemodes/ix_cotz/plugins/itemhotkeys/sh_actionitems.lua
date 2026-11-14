-- Set false to maintain a completely separate list from Settings > Hotkeys.
PLUGIN.useHotkeyActionDefaults = true
PLUGIN.mobileActionItems = {
	-- item_id = true enables moving actions; false retains the black screen.
	medic_medkit_1 = false,
	medic_medkit_3 = false,
	medic_medkit_5 = false,
}

function PLUGIN:UsesMobileAction(itemID)
	local override = self.mobileActionItems[itemID]
	if override ~= nil then return override end

	return self.useHotkeyActionDefaults and self.hotkeyitems[itemID] ~= nil
end
