local base = "gamemodes/ix_cotz/plugins/"
-- Load actual conversation definitions. GLua-only continue statements are inside unused service callbacks;
-- reject their execution rather than pretending this standalone suite tests those callbacks.
currentMap = "rp_marsh_cs"
net = {Receive = function() end}
util = {AddNetworkString = function() end}
hook = {Add = function() end}
ix.util.GetMaterial = function() end
local filenames = {}
local files = assert(io.popen("rg --files gamemodes/ix_cotz/plugins/dialogue/dialogue"))
for path in files:lines() do filenames[#filenames + 1] = path:match("([^/]+)$") end
files:close()
table.sort(filenames)
file = {Find = function() return filenames end}
ix.util.Include = function(path)
	local fullPath = "gamemodes/" .. path
	local handle = assert(io.open(fullPath))
	local source = handle:read("*a")
	handle:close()
	source = source:gsub("(\n[ \t]*)continue([ \t]*\n)",
		"%1error(\"Unexecuted GLua callback\")%2")
	assert(load(source, "@" .. fullPath, "t", _G))()
end
PLUGIN = {uniqueID = "dialogue"}
dofile(base .. "dialogue/libs/sh_dialogue.lua")
ix.dialogue.LoadFromDir("ix_cotz/plugins/dialogue/dialogue")
dofile(base .. "vendor_adv/libs/sh_npctemplates.lua")
ix.vendorStock = {ApplyDefaults = function() end}
local vendorPlugin = {}
PLUGIN = vendorPlugin
dofile(base .. "vendor_adv/libs/sh_towncontacts.lua")
ix.plugin = {Get = function(id) if id == "vendor_adv" then return vendorPlugin end return ix.townNPCs end}
dofile(base .. "dialogue/libs/sh_towncontacts.lua")
dofile(base .. "dialogue/libs/sh_townservices.lua")
ix.townNPCs:InstallContacts()
