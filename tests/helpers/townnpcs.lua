-- Run from the repository root: luatex --luaonly tests/townnpcs_spec.lua
local fixture = dofile("tests/helpers/progression.lua")
SERVER = true
CLIENT = false
PLUGIN = {}
local checks = 0
local function check(value, message)
	checks = checks + 1
	assert(value, message)
end
local base = "gamemodes/ix_cotz/plugins/"
ix.util.Include = function(path) return dofile("gamemodes/" .. path) end
for _, library in ipairs({"sh_storage", "sh_progression", "sh_requirements", "sh_expansion", "sh_services"}) do
	dofile(base .. "progression/libs/" .. library .. ".lua")
end
ix.progression.definitions = {}
ix.progression.Register = function(id, definition)
	definition.id = id
	ix.progression.definitions[id] = definition
end
for _, name in ipairs({"computer_story", "computerprog", "hoarderprog", "noosphereprog", "communityprog"}) do
	dofile(base .. "progression/definitions/sh_" .. name .. ".lua")
end
local standaloneCount = 0
for _ in pairs(ix.progression.definitions) do standaloneCount = standaloneCount + 1 end
ix.item.list = {}
local itemFiles = assert(io.popen("rg --files gamemodes/ix_cotz/schema/items gamemodes/ix_cotz/plugins"))
for path in itemFiles:lines() do
	if path:find("/items/", 1, true) then
		local id = path:match("/sh_([^/]+)%.lua$")
		if id then
			local file = assert(io.open(path))
			local source = file:read("*a")
			file:close()
			local quantity = tonumber(source:match("ITEM.quantity = (%d+)"))
			ix.item.list[id] = {name = id, price = 100, quantity = quantity,
				category = path:find("/items/newammo/", 1, true) and "Ammunition"
					or path:find("/items/newweapons/", 1, true) and "Weapons"
					or path:find("/items/cookable/", 1, true) and "Cookable Meat"
					or path:find("/items/cooked/", 1, true) and "Cooked Meat",
				ammoAmount = tonumber(source:match("ITEM.ammoAmount%s*=%s*(%d+)")),
				isAmmo = path:find("/items/newammo/", 1, true) ~= nil,
				weaponCategory = source:match([[ITEM.weaponCategory%s*=%s*"([^"]+)"]]),
				isFieldCargo = path:find("/items/jobcargo/", 1, true) ~= nil}
		end
	end
end
itemFiles:close()
ix.jobs = ix.jobs or {}
ix.jobs.field = ix.jobs.field or {}
ix.taskRewards = ix.taskRewards or {}
for _, name in ipairs({"settings", "rewardsettings", "fieldsettings", "killcredit", "regionalcatalogue"}) do
	dofile("gamemodes/ix_cotz/plugins/jobsystem/definitions/sh_" .. name .. ".lua")
end
dofile(base .. "jobsystem/libs/sh_taskrewards.lua")
dofile(base .. "progression/libs/sh_rewards.lua")
dofile(base .. "progression/libs/sv_rewards.lua")
ix.jobs = {settings = ix.jobs.settings, regionalCatalogue = ix.jobs.regionalCatalogue,
	list = {}, jobsbycategory = {}, field = {
	sources = {}, settings = {}, IsAvailable = function() return true end,
}}
for _, kind in ipairs({"recovery", "sensor", "triangulation", "deadDrop", "defence"}) do
	ix.jobs.field.settings[kind] = {sources = {}}
end
local originalFindMetaTable = FindMetaTable
FindMetaTable = function() return {} end
dofile(base .. "jobsystem/libs/sh_jobs.lua")
dofile(base .. "jobsystem/libs/sh_regionaljobs.lua")
FindMetaTable = originalFindMetaTable
dofile(base .. "jobsystem/libs/sh_tooljobs.lua")
dofile(base .. "townnpcs/libs/sh_00_townnpcs.lua")
for _, name in ipairs({"sh_catalogue", "sh_jobs", "sh_regionaljobs", "sh_progressions", "sh_sites", "sh_validation", "sv_runtime"}) do
	dofile(base .. "townnpcs/libs/" .. name .. ".lua")
end
local definitions = assert(io.popen("rg --files gamemodes/ix_cotz/plugins/townnpcs/definitions"))
local paths = {}
for path in definitions:lines() do paths[#paths + 1] = path end
definitions:close()
table.sort(paths)
for _, path in ipairs(paths) do dofile(path) end
ix.townNPCs:BuildProgressions()
ix.randomitems = {tables = {}}
for _, pool in ipairs({"worldspawn_1", "worldspawn_2", "worldspawn_garbage_regular",
	"worldspawn_garbage_rare", "worldspawn_3", "worldspawn_4", "worldspawn_5", "worldspawn_6",
	"human_npc_drops", "cache_misc", "ix_entbox_drops", "ix_wood_entbox_drops", "ix_paper_entbox_drops"}) do
	dofile(base .. "randomitem/pools/" .. pool .. ".lua")
end
ix.item.list.value_nuts.quantity = 20
ix.item.list.value_bolts.quantity = 20
ix.item.list.value_kerosene.quantity = 8
ix.item.list.medic_bandage_1.quantity = 3
ix.item.list.medic_medkit_1.quantity = 3

return {fixture = fixture, town = PLUGIN, check = check}
