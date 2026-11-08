-- Run from the addon root: luatex --luaonly tests/fts_hideouts_spec.lua
local checks = 0
local function check(value, message) checks = checks + 1 assert(value, message) end
local function copy(value)
	if type(value) ~= "table" then return value end
	local result = setmetatable({}, getmetatable(value))
	for key, entry in pairs(value) do result[key] = copy(entry) end

	return result
end
table.Copy = copy
table.Count = function(value)
	local count = 0
	for _ in pairs(value) do count = count + 1 end

	return count
end
local vectorMeta, angleMeta = {}, {}
function Vector(x, y, z) return setmetatable({x = x, y = y, z = z}, vectorMeta) end
function Angle(p, y, r) return setmetatable({p = p, y = y, r = r}, angleMeta) end
function Color(r, g, b, a) return {r = r, g = g, b = b, a = a or 255} end
isvector = function(value) return getmetatable(value) == vectorMeta end
isangle = function(value) return getmetatable(value) == angleMeta end
istable = function(value) return type(value) == "table" end
isstring = function(value) return type(value) == "string" end
isnumber = function(value) return type(value) == "number" end
isbool = function(value) return type(value) == "boolean" end
IsColor = function() return false end
SERVER, CLIENT = true, false
local base = "gamemodes/ix_cotz/plugins/"
local failSave, missingDupe, rejectDupe, writes, entrances = false, false, false, 0, 0
local integration = {
	ReadDupe = function(_, name)
		if missingDupe then return nil, "Dupe file not found: " .. name end

		return {Entities = {}, HeadEnt = {Pos = Vector(0, 0, 0)}}
	end,
}
local town
local hideouts = {ready = true, instances = {}, state = {
	areas = {}, templates = {}, entrances = {}, locations = {},
	hideouts = {owned = {owner = 42, storageID = 12, containers = {ammo = {inventoryID = 13}}}},
	nextID = 17, retired = {old = {owner = 1}},
}}
function hideouts:Contains(point, mins, maxs)
	return point.x >= mins.x and point.x <= maxs.x and point.y >= mins.y and point.y <= maxs.y
		and point.z >= mins.z and point.z <= maxs.z
end
function hideouts:ValidateDupe() return not rejectDupe, "Unsupported shell entity" end
function hideouts:Persist() writes = writes + 1 return not failSave end
function hideouts:SpawnEntrances() entrances = entrances + 1 end
ix = {
	plugin = {Get = function(id)
		if id == "hideouts" then return hideouts end
		if id == "advdupeint" then return integration end
		if id == "townnpcs" then return town end
	end},
	command = {Add = function() end},
	type = {bool = 1, optional = 2},
	util = {Include = function() end},
}
bit = {bor = function() return 3 end}
game = {GetMap = function() return "rp_marsh_cs" end}
PLUGIN = hideouts
dofile(base .. "hideouts/sh_markers.lua")
hideouts.containerRecipes = {general = {}, ammo = {}}
dofile(base .. "hideouts/sv_fts.lua")
local template = {
	dupe = "test_shell", mins = Vector(-512, -512, -16), maxs = Vector(512, 512, 512),
	spawns = {Vector(0, 0, 8)}, spawnAngles = {Angle(0, 45, 0)}, facing = Angle(0, 0, 0),
	exit = Vector(0, 64, 24), storage = Vector(80, 64, 24),
	containers = {["ammo-shelf"] = {pos = Vector(50, 0, 8), angles = Angle(0, 90, 0), recipe = "ammo"}},
}
local payload = {
	areas = {["remote-area"] = {mins = Vector(1000, 1000, 1000), maxs = Vector(5000, 5000, 5000)}},
	templates = {cabin = template},
	entrances = {village = {pos = Vector(1, 2, 3), angles = Angle(0, 90, 0), outside = Vector(4, 5, 6)}},
	locations = {village = {template = "cabin", entrance = "village", name = "Quoted \"village\""}},
	recovery = Vector(6, 7, 8),
}
local owned = hideouts.state.hideouts
check(hideouts:ImportFTSData(payload), "imports reusable setup")
check(writes == 1 and entrances == 1, "saves once before refreshing entrance entities")
check(hideouts.state.hideouts == owned and hideouts.state.nextID == 17 and hideouts.state.retired.old.owner == 1,
	"ownership, inventory records, retired recovery and ID allocation remain untouched")
check(hideouts.state.templates.cabin.containers["ammo-shelf"].recipe == "ammo", "manual container recipes survive")
payload.templates.cabin.dupe = "changed"
check(hideouts.state.templates.cabin.dupe == "test_shell", "import copies preset definitions")
payload.templates.cabin.dupe = "test_shell"
hideouts.state.entrances["squad:owned"] = {hideout = "owned", pos = Vector(1, 1, 1)}
local exported = hideouts:GetFTSData()
check(exported.hideouts == nil and exported.nextID == nil and exported.retired == nil,
	"exports no player-owned state")
check(exported.entrances["squad:owned"] == nil, "squad-placed entrances are excluded")
exported.templates.cabin.dupe = "edited"
check(hideouts.state.templates.cabin.dupe == "test_shell", "export is an isolated snapshot")
check(hideouts:ImportFTSData({templates = {cabin = {dupe = "replacement"}},
	entrances = {village = {pos = Vector(0, 0, 0)}}}), "reimport preserves existing configuration IDs")
check(hideouts.state.templates.cabin.dupe == "test_shell" and hideouts.state.entrances.village.pos.x == 1,
	"reimport cannot rebind existing rooms or entrances")
hideouts.instances.busy = {state = "loading"}
check(not hideouts:ImportFTSData(payload), "loading or occupied instances block imports")
hideouts.instances = {}
hideouts.ready = false
check(not hideouts:ImportFTSData(payload), "imports require loaded map data")
check(next(hideouts:GetFTSData()) == nil, "unready exports are empty")
hideouts.ready = true
local function rejects(value, message)
	local beforeWrites, beforeEntrances = writes, entrances
	local beforeAreas = hideouts.state.areas
	check(not hideouts:ImportFTSData(value), message)
	check(writes == beforeWrites and entrances == beforeEntrances and beforeAreas == hideouts.state.areas,
		"validation failure causes no state, persistence or entity mutation")
end
rejects({hideouts = {}}, "ownership fields cannot be imported")
rejects({areas = "bad"}, "malformed sections are rejected")
rejects({areas = {bad = {mins = Vector(0, 0, 0), maxs = Vector(0, 1, 1)}}}, "zero-size bounds are rejected")
rejects({recovery = Vector(0 / 0, 1, 1)}, "non-finite positions are rejected")
rejects({entrances = {bad = {hideout = "owned"}}}, "per-hideout entrances cannot be imported")
rejects({locations = {bad = {template = "missing", entrance = "village", name = "Bad"}}},
	"trader locations need existing or imported templates")
rejects({locations = {bad = {template = "cabin", entrance = "squad:owned", name = "Bad"}}},
	"trader locations cannot bind to a squad's private entrance")
local invalidTemplate = copy(template)
invalidTemplate.spawns[1] = Vector(99999, 0, 0)
rejects({templates = {bad = invalidTemplate}}, "out-of-bounds spawn points are rejected")
invalidTemplate = copy(template)
invalidTemplate.containers["ammo-shelf"].recipe = "missing"
rejects({templates = {bad = invalidTemplate}}, "unknown storage recipes are rejected")
missingDupe = true
rejects({templates = {new = template}}, "missing shell files prevent import")
missingDupe = false
rejectDupe = true
rejects({templates = {new = template}}, "unsupported shell entities prevent import")
rejectDupe = false
failSave = true
local before = hideouts.state.areas
check(not hideouts:ImportFTSData({areas = {new = payload.areas["remote-area"]}}), "failed persistence reports failure")
check(hideouts.state.areas == before and not hideouts.state.areas.new, "failed persistence rolls back staged setup")
failSave = false

-- Exercise the actual FTS entry point and formatter without running world setup.
PLUGIN = {}
local handle = assert(io.open(base .. "firsttimesetup/sh_plugin.lua"))
local source = handle:read("*a"):gsub("!=", "~=")
handle:close()
assert(load(source))()
dofile(base .. "firsttimesetup/sv_entities.lua")
local fts = PLUGIN
PLUGIN = {}
local data = fts.PluginDataGetFunctions.hideouts()
local lines = {"return {"}
for id, value in pairs(data) do lines[#lines + 1] = fts.PluginDataFormatFunctions.hideouts(id, value) end
lines[#lines + 1] = "}"
local roundTrip = assert(load(table.concat(lines, "\n")))()
check(roundTrip.areas["remote-area"].mins.x == 1000, "formatter handles hyphenated definition keys")
check(roundTrip.locations.village.name == payload.locations.village.name, "formatter escapes quoted names")
check(roundTrip.templates.cabin.spawnAngles[1].y == 45, "spawn facing angles round trip")
check(roundTrip.templates.cabin.containers["ammo-shelf"].angles.y == 90, "container transforms round trip")
local deploy = fts.PluginDataDeployFunctions.hideouts
check(deploy(nil, game.GetMap()) and deploy(payload, "another_map"), "missing and foreign-map payloads are ignored")
local getPlugin = ix.plugin.Get
ix.plugin.Get = function() end
check(next(fts.PluginDataGetFunctions.hideouts()) == nil, "dump tolerates a disabled hideout plugin")
check(deploy({}, game.GetMap()), "empty preset also tolerates a disabled plugin")
check(not deploy(payload, game.GetMap()), "nonempty preset requires its owning plugin")
ix.plugin.Get = getPlugin
check(deploy(roundTrip, game.GetMap()), "FTS deployment uses the hideout importer")
fts.map_presets[game.GetMap()] = {plugindata = {hideouts = {hideouts = {}}}}
local spawned = false
fts.SpawnContainer = function() spawned = true end
local ok, reason = fts:RunFirstTimeSetup()
check(not ok and reason:find("Hideout setup failed", 1, true) and not spawned and not fts.firstTimeSetupRun,
	"invalid hideout setup stops FTS before any world population or completion flag")
for _, map in ipairs({"rp_marsh_cs", "rp_garbage_cotz", "rp_pripyat_remaster", "rp_waystation"}) do
	PLUGIN = fts
	dofile(base .. "firsttimesetup/presets/sh_" .. map .. ".lua")
	check(type(fts.map_presets[map].plugindata.hideouts) == "table", "bundled preset has a hideout setup section")
end
print("PASS: " .. checks .. " hideout FTS checks")
