-- Run from the addon root: luatex --luaonly tests/task_routes_spec.lua
dofile("tests/helpers/townnpcs.lua")
ix.plugin = {Get = function() end}
ix.townNPCs:BuildJobs()
local checks = 0
local function check(value, message)
	checks = checks + 1
	assert(value, message)
end
local mapLabels = {rp_marsh_cs = "Swamps", rp_garbage_cotz = "Garbage", rp_waystation = "Waystation",
	rp_pripyat_remaster = "Pripyat"}
for id, definition in pairs(ix.jobs.list) do
	if definition.regionalJob and not definition.completionOnly then
		local contact = ix.townNPCs.contacts[definition.townContact]
		local maps = definition.fieldMaps or {definition.destinationMap or definition.fieldMap or definition.targetMap}
		if definition.tier == 3 and (definition.fieldType ~= "courier") then
			for _, map in ipairs(maps) do check(map == "rp_pripyat_remaster", "hard destination: " .. id) end
		elseif definition.tier == 2 then
			for _, map in ipairs(maps) do check(map ~= contact.map, "medium leaves the home map: " .. id) end
		end
		if definition.fieldType == "recovery" or definition.fieldType == "defence" then
			for _, map in ipairs(maps) do
				check(definition.desc:find(map, 1, true), "offer describes all possible regions: " .. id)
			end
		end
	end
end
local medium = ix.jobs.list["cotz/town/v2/ballast/medium/recovery"]
check(#medium.fieldMaps == 2 and medium.fieldMaps[1] == "rp_garbage_cotz"
	and medium.fieldMaps[2] == "rp_waystation", "Ballast sends medium recoveries to Garbage or Waystation")
check(ix.jobs.list["cotz/town/v2/ballast/hard/recovery"].fieldMap == "rp_pripyat_remaster",
	"Ballast's hard recoveries use Pripyat")
local oldRoute = ix.jobs.list["cotz/town/v2/cleaner/hard/rp_pripyat_remaster/rp_waystation"]
check(oldRoute and oldRoute.completionOnly and not oldRoute.CanAcceptTask(), "old dead-drop routes remain completable")
for _, slug in ipairs({"ballast", "beanstalk", "cleaner", "haggler", "old-timer", "jitters", "boss"}) do
	local work = ix.townNPCs.contacts[slug].dialogue.work
	check(work:find("Pripyat", 1, true), "work dialogue names the hard region: " .. slug)
end
for map, label in pairs(mapLabels) do check(ix.jobs.GetMapName(map) == label, "player-facing region names") end
local preview = {identifier = "cotz/town/v2/ballast/medium/recovery", numberRec = 1, progress = 0}
local spoken = ix.jobs.GetDialogueDescription(preview, "'Ballast'", true)
check(spoken:find("Garbage or Waystation", 1, true), "spoken preview describes both medium destinations")
preview.fieldTask = {kind = "recovery", map = "rp_waystation"}
spoken = ix.jobs.GetDialogueDescription(preview, "'Ballast'", false)
check(spoken:find("Waystation", 1, true) and not spoken:find("Garbage", 1, true),
	"accepted work describes its saved destination")
local retired = ix.jobs.list["cotz/town/v2/haggler/hard/bandit"]
check(retired and retired.completionOnly and not retired.CanAcceptTask(),
	"saved hard targets missing from Pripyat retain their completion identity")
local savedHunt = {identifier = "cotz/town/v2/haggler/hard/merc", numberRec = 5, targetMap = "rp_waystation"}
local reminder = ix.jobs.GetDialogueDescription(savedHunt, "'Haggler'", false)
check(reminder:find("Waystation", 1, true) and not reminder:find("Pripyat", 1, true),
	"saved kill orders keep their spoken destination after route changes")
local journal = ix.jobs.getFormattedDesc(savedHunt, true)
check(journal:find("Waystation", 1, true) and not journal:find("Pripyat", 1, true),
	"saved kill orders keep their journal destination after route changes")
print("PASS: " .. checks .. " repeatable task route checks")
