local PLUGIN = PLUGIN

PLUGIN.markerRoles = {
	spawn = {name = "Player spawn", model = "models/props_junk/PopCan01a.mdl"},
	exit = {
		name = "Exit / management",
		model = "models/z-o-m-b-i-e/metro_ll/door/m_ll_door_final_cut_scene_01_2.mdl",
	},
	container = {
		name = "Personal storage container",
		model = "models/z-o-m-b-i-e/st/equipment_cache/st_equipment_box_01.mdl",
	},
	vendor = {name = "Squad vendor", model = "models/props_c17/cashregister01a.mdl"},
	storage = {
		name = "Legacy recovery storage",
		model = "models/z-o-m-b-i-e/st/equipment_cache/st_equipment_box_01.mdl",
	},
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
