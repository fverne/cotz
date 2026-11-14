-- Set false to maintain a completely separate list from Settings > Hotkeys.
PLUGIN.useHotkeyActionDefaults = true
PLUGIN.mobileActionItems = {
	-- item_id = true enables moving actions; false retains the black screen.
}

function PLUGIN:UsesMobileAction(itemID)
	local override = self.mobileActionItems[itemID]
	if override ~= nil then return override end

	return self.useHotkeyActionDefaults and self.hotkeyitems[itemID] ~= nil
end
