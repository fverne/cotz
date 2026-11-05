PLUGIN.name = "Gear Customization"
PLUGIN.author = "COTZ"
PLUGIN.description = "Vendor cosmetics for individual wearable items."

ix.util.Include("sh_appearance.lua")
ix.util.Include("sv_service.lua")
ix.util.Include("cl_menu.lua")
ix.util.Include("cl_icons.lua")

function PLUGIN:InitializedPlugins()
	for id, item in pairs(ix.item.list) do
		if item.appearanceCustomization then
			local valid, reason = ix.gearAppearance.ValidateDefinition(item)
			assert(valid, "Invalid gear customization for " .. id .. ": " .. (reason or "unknown error"))
		end
	end
	if CLIENT then self:InstallIconRenderer() end
end
