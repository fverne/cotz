-- Run from the repository root: luatex --luaonly tests/fts_vendors_spec.lua
local checks = 0
local function check(value, message)
	checks = checks + 1
	assert(value, message)
end

function Vector(x, y, z) return {x = x, y = y, z = z} end
function Angle(p, y, r) return {p = p, y = y, r = r} end
function Color(r, g, b, a) return {r = r, g = g, b = b, a = a or 255} end
SERVER, CLIENT = true, false
bit = {bor = function(first, second) return first + second end}
game = {GetMap = function() return "rp_marsh_cs" end}
local base = "gamemodes/ix_cotz/plugins/firsttimesetup/"
local saved, spawned = {}, {}
local vendorPlugin = {SaveData = function()
	for index, row in ipairs(spawned) do saved[index] = row end
end}
ix = {
	type = {bool = 1, optional = 2},
	command = {Add = function() end},
	util = {Include = function() end},
	plugin = {
		Get = function(id) return id == "vendor_adv" and vendorPlugin or nil end,
		list = {containers = {SaveContainer = function() end}},
	},
	npctemplates = {templates = {}},
}
PLUGIN = {}
local file = assert(io.open(base .. "sh_plugin.lua"))
local source = file:read("*a"):gsub("!=", "~=")
file:close()
assert(load(source))()
local setup = PLUGIN
dofile(base .. "presets/sh_rp_marsh_cs.lua")
local preset = setup.map_presets.rp_marsh_cs
local templates = {
	["old-timer"] = {"tutorialnpc", "old_timer"},
	technut = {"technpc", "technut"},
	["spicy-lemon"] = {"cooknpc", "spicy_lemon"},
	haggler = {"tradernpc", "haggler"},
	jitters = {"medicnpc", "jitters"},
	mute = {"stalkernetnpc", "mute"},
	ballast = {"ballastnpc", "ballast"},
	gasket = {"gasketnpc", "gasket"},
	atlas = {"atlasnpc", "atlas"},
}
local placed = {}
for _, row in ipairs(preset.vendors) do
	check(not placed[row.template], "preset must not spawn a duplicate vendor: " .. row.template)
	placed[row.template] = row
end
for id, points in pairs(preset.plugindata.townnpcs) do
	local template = assert(templates[id], "unrecognised town spawn configuration: " .. id)
	dofile("gamemodes/ix_cotz/plugins/vendor_adv/definitions/sh_" .. template[2] .. ".lua")
	check(ix.npctemplates.templates[template[1]] ~= nil, "vendor template exists for " .. id)
	local row = placed[template[1]]
	check(row ~= nil, "configured spawn choices need a vendor placement for " .. id)
	local first = points[1]
	check(row.position.x == first.position.x and row.position.y == first.position.y
		and row.position.z == first.position.z, "initial vendor position matches an authored point for " .. id)
	check(row.angles.p == first.angles.p and row.angles.y == first.angles.y
		and row.angles.r == first.angles.r, "initial vendor facing matches the authored point for " .. id)
end

-- Exercise the real setup routine with only world population and unrelated controller imports mocked.
setup.SpawnContainer = function() end
setup.SpawnEntity = function() end
ix.util.SpawnAdvVendor = function(template, position, angles)
	spawned[#spawned + 1] = {template = template, position = position, angles = angles}
end
setup.PluginDataDeployFunctions = {hideouts = function() return true end}
check(setup:RunFirstTimeSetup(), "setup completes")
check(#saved == #preset.vendors and #saved == 9, "all configured vendors are saved before setup returns")
check(setup.firstTimeSetupRun, "setup records completion after vendor persistence")

-- Run the documented recovery command twice against a partly populated world.
local existing = {template = "technpc", position = Vector(1, 2, 3), money = 123}
spawned = {existing}
local present = {[ix.npctemplates.templates.technpc.name] = existing}
ix.progression = {GetNPCFromName = function(name) return present[name] end}
ix.plugin.Get = function(id)
	if id == "firsttimesetup" then return setup end
	if id == "vendor_adv" then return vendorPlugin end
end
ix.util.SpawnAdvVendor = function(template, position, angles)
	local row = {template = template, position = position, angles = angles}
	spawned[#spawned + 1] = row
	present[ix.npctemplates.templates[template].name] = row
end
file = assert(io.open(base .. "README.md"))
local recovery = assert(file:read("*a"):match("```lua\nlua_run ([^\n]+)\n```"))
file:close()
assert(load(recovery))()
check(#spawned == 9 and #saved == 9, "documented recovery creates and saves missing vendors")
check(spawned[1] == existing and existing.position.x == 1 and existing.money == 123,
	"recovery preserves an existing vendor's position and settings")
assert(load(recovery))()
check(#spawned == 9, "repeating recovery cannot duplicate existing contacts")

print("fts_vendors_spec: " .. checks .. " checks passed")
