local PLUGIN = PLUGIN
PLUGIN.name = "Sherpas"
PLUGIN.author = "verne"
PLUGIN.description = "Instance-based player and squad vendors."

ix.sherpa = ix.sherpa or {}
ix.sherpa.PAGE_SIZE = 20

ix.char.RegisterVar("SherpaVendors", {
	field = "SherpaVendors", fieldType = ix.type.text, default = {}, bNoDisplay = true,
})
ix.inventory.Register("cotzSherpaStock", 10, 8)

function ix.sherpa.IsVendor(entity)
	return IsValid(entity) and entity.GetSherpa and entity:GetSherpa() == true
end

function ix.meta.character:HasSherpaVendor(vendor)
	local id = isentity(vendor) and vendor:GetNetVar("sherpaID") or vendor
	local name = isentity(vendor) and vendor:GetDisplayName() or vendor
	for _, value in pairs(self:GetSherpaVendors()) do
		if value == id or value == name then return true end
	end

	return false
end

ix.util.Include("sv_stock.lua")
ix.util.Include("sh_commands.lua")
ix.util.Include("cl_trade.lua")
