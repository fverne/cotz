local PLUGIN = PLUGIN

PLUGIN.markerRoles = {
	spawn = {name = "Player spawn", model = "models/props_junk/PopCan01a.mdl"},
	exit = {name = "Exit / management", model = "models/props_c17/consolebox01a.mdl"},
	container = {name = "Personal storage container", model = "models/props_junk/wood_crate001a.mdl"},
	vendor = {name = "Squad vendor", model = "models/props_c17/cashregister01a.mdl"},
	storage = {name = "Legacy recovery storage", model = "models/props_junk/wood_crate001a.mdl"},
}

function PLUGIN:ValidateMarkerSettings(role, slotID, recipeID)
	if not isstring(role) or not self.markerRoles[role] then
		return false, "Choose a valid hideout marker role."
	end
	if role == "container" then
		if not isstring(slotID) or #slotID > 32 or not slotID:match("^[%w_%-]+$") then
			return false, "Use a permanent slot ID with 1–32 letters, digits, underscores or hyphens."
		end
		if slotID == "shop" then return false, "The slot ID shop is reserved for squad stock." end
		if not isstring(recipeID) or not self.containerRecipes[recipeID] then
			return false, "Choose a valid container recipe."
		end
	end

	return true
end
