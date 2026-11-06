-- Production registry and the existing progression/dialogue fixtures, followed by server boundary checks.
dofile("tests/townnpcs_spec.lua")
local checks = 0
local function check(value, message)
	checks = checks + 1
	assert(value, message)
end
local active = 0
for _, contact in pairs(ix.townNPCs.contacts) do
	if contact.job.kind ~= "none" then active = active + 1 end
end
check(active == 19, "twenty rows use nineteen issuers because Atlas alternates photography")
check(ix.townNPCs.contacts.wake.job.kind == "none", "Wake is no longer assigned photography")
check(ix.townNPCs.contacts["the-original"].job.kind == "none", "The Original has no new ordinary work")
check(ix.townNPCs.contacts.jitters.job.kind == "regionalSpecimens", "Jitters owns the Swamps specimen requests")
check(next(ix.townNPCs.contacts["the-original"].categories) == nil, "The Original exposes no offer categories")
local inheritedRequests = 0
for id, definition in pairs(ix.jobs.list) do
	local suffix = id:match("^cotz/town/v2/the%-original/(.+)$")
	if suffix then
		local replacement = ix.jobs.list["cotz/town/v2/jitters/" .. suffix]
		check(definition.completionOnly and not definition.CanAcceptTask(), "old specimen identities cannot be accepted")
		check(replacement and not replacement.completionOnly
			and replacement.requiredItem == definition.requiredItem and replacement.numberRec == definition.numberRec,
			"specimen reassignment retains each item, tier and quantity")
		check(replacement.issuerName == "'Jitters'", "hand-ins and rewards belong to the new issuer")
		inheritedRequests = inheritedRequests + 1
	end
end
check(inheritedRequests > 0, "specimen reassignment generates real offers")
for id, definition in pairs(ix.jobs.list) do
	if definition.regionalJob then
		check(definition.moneyReward == ({1000, 2000, 3000})[definition.tier], "revised reference cash")
		check(definition.repReward == ({15, 25, 35})[definition.tier], "revised reputation")
		if definition.alternateDelivery then
			local home = ix.townNPCs.contacts[definition.townContact].map
			local source = ix.jobs.regionalCatalogue.valuables[definition.requiredItem]
			check(definition.numberRec == source.batch * (definition.tier == 1 and 1 or 2), "minimum-yield batches")
			if definition.tier == 3 then
				local homeIndex
				for index, map in ipairs(ix.jobs.regionalCatalogue.maps) do
					if map == home then homeIndex = index end
				end
				for index = 1, homeIndex do
					for _, map in ipairs(source.maps) do
						check(map ~= ix.jobs.regionalCatalogue.maps[index], "hard goods have no same/easier source")
					end
				end
			end
		end
	end
end
check(ix.jobs.list["cotz/town/mute/easy/value_battery"].completionOnly, "old requests can finish but are not offered")
check(ix.jobs.list["cotz/town/old-timer/hard"].repReward == 45, "accepted old work retains reputation terms")
check(ix.jobs.regional.Species("npc_human_bandit_sniper") == "bandit",
	"snipers count toward faction kills while remaining outside patrol-size medians")
for _, slug in ipairs({"technut", "latch", "quartermaster"}) do
	for _, difficulty in ipairs({"easy", "medium", "hard"}) do
		local category = "cotz/town/v2/" .. slug .. "/" .. difficulty
		check(#(ix.jobs.jobsbycategory[category] or {}) > 0, "every valuable tier has obtainable eligible candidates")
	end
end
for _, slug in ipairs({"vesper", "intern"}) do
	check(ix.jobs.list["cotz/town/v2/" .. slug .. "/easy/sensor"].fieldSettings.recordSeconds == 900,
		"repeatable sensors record fifteen real minutes")
end
for tier, difficulty in ipairs({"easy", "medium", "hard"}) do
	check(ix.jobs.list["cotz/town/v2/spool/" .. difficulty .. "/triangulation"].fieldSettings.readingCount == tier + 2,
		"triangulation scales from three to five readings")
	local waves = ix.jobs.regional.DefenceWaves("rp_garbage_cotz", tier)
	check(#waves == tier + 2, "research has three/four/five waves")
	for _, wave in ipairs(waves) do
		for _, class in ipairs(wave) do
			check(ix.jobs.regionalCatalogue.packs.rp_garbage_cotz[ix.jobs.regional.Species(class)],
				"defence uses only regionally present species")
		end
	end
end
local root = "gamemodes/ix_cotz/plugins/jobsystem/"
PLUGIN = {}
local callbacks, timers = {}, {}
timer = {Simple = function(_, callback) timers[#timers + 1] = callback end}
local map, now = "rp_marsh_cs", 100
game.GetMap = function() return map end
CurTime = function() return now end
ix.plugin.Get = function(id)
	if id == "anomalycontroller" then
		return {anomalydefs = {{entityname = "anom_jarka"}, {entityname = "anom_par"}}}
	end
end
ix.item.list.job_camera = {name = "Loan Camera", width = 1, height = 1, weight = 0.75}
local char = {jobs = {}, data = {}, inventory = {items = {}, full = false}}
local client = {weapons = {}}
function char:GetID() return 101 end
function char:GetName() return "Photographer" end
function char:GetPlayer() return client end
function char:GetJobs() return table.Copy(self.jobs) end
function char:SetJobs(jobs) self.jobs = table.Copy(jobs) end
function char:GetInventory() return self.inventory end
function char:GetData(key, default) if self.data[key] ~= nil then return self.data[key] end return default end
function char:SetData(key, value) self.data[key] = value end
function char:CanCarry() return not self.overweight end
function char:Save() end
function client:GetCharacter() return char end
function client:Alive() return true end
function client:Notify() end
function client:NotifyLocalized() end
function client:HasWeapon(class) return self.weapons[class] ~= nil end
function client:SteamID64() return "101" end
function char.inventory:GetItems() return self.items end
function char.inventory:GetID() return 101 end
function char.inventory:FindEmptySlot() if not self.full then return 1, 1 end end
function char.inventory:HasItem(id)
	for _, item in pairs(self.items) do if item.uniqueID == id then return item end end
end
ix.item.Instance = function(_, itemID, data, _, _, callback)
	callbacks[#callbacks + 1] = function()
		local item = {uniqueID = itemID, data = data, price = 100}
		function item:GetData(key, default) if self.data[key] ~= nil then return self.data[key] end return default end
		function item:SetData(key, value) self.data[key] = value end
		function item:Transfer()
			if char.inventory.full then return false end
			char.inventory.items[self] = self
			return true
		end
		function item:Remove() self.removed = true char.inventory.items[self] = nil return true end
		function item:Equip(owner) owner.weapons.ix_camera = {ixItem = self} end
		callback(item)
		return item
	end
end
dofile(root .. "sv_regionaljobs.lua")
local server = PLUGIN
char.jobs.test = {rewardKey = "photo:1", photoKind = "mutant", progress = 0, numberRec = 3}
char.inventory.full = true
check(not ix.jobs.regional.CanStart(char, {photoKind = "mutant"}), "full inventory rejects acceptance")
char.inventory.full = false
ix.jobs.regional.ReconcileCamera(client)
ix.jobs.regional.ReconcileCamera(client)
check(#callbacks == 1, "repeated requests share one pending camera insertion")
callbacks[1]()
check(client.weapons.ix_camera ~= nil, "camera insertion equips the existing SWEP")
local camera = client.weapons.ix_camera
char.jobs.anomaly = {rewardKey = "photo:2", photoKind = "anomaly", progress = 0, numberRec = 3}
local function subject(class, health, kind)
	return {kind = kind or "entity", class = class, entity = {Health = function() return health or 100 end}}
end
local photo = {client = client, characterID = 101, weapon = camera, map = map,
	subjects = {subject("npc_mutant_dog"), subject("npc_mutant_psydog_phantom"),
		subject("npc_mutant_cat", 0), subject("anom_jarka"), subject("anom_par")}}
server["cotz/camera/photo-taken"](server, photo)
check(char.jobs.test.progress == 1 and char.jobs.anomaly.progress == 2,
	"one photo advances both jobs; dead mutants and psychic projections do not count")
server["cotz/camera/photo-taken"](server, photo)
check(char.jobs.test.progress == 1 and char.jobs.anomaly.progress == 2, "duplicates grant no progress")
photo.subjects = {subject("npc_mutant_pseudogiant_slow"), subject("npc_mutant_pseudogiant_fast"),
	subject("npc_mutant_flesh", 100, "spawnpoint")}
server["cotz/camera/photo-taken"](server, photo)
check(char.jobs.test.progress == 2, "physical variants share a species and empty points do not count")
photo.characterID = 102
photo.subjects = {subject("npc_mutant_boar")}
server["cotz/camera/photo-taken"](server, photo)
check(char.jobs.test.progress == 2, "stale-character photo is rejected")
photo.characterID = 101
server["cotz/camera/photo-taken"](server, photo)
check(char.jobs.test.isCompleted and char.jobs.test.progress == 3, "distinct species complete the target")
char.jobs.test = nil
ix.jobs.regional.ReconcileCamera(client)
check(next(char.inventory.items) ~= nil, "loan remains while another photography job is active")
char.jobs.anomaly = nil
ix.jobs.regional.ReconcileCamera(client)
check(next(char.inventory.items) == nil, "loan is removed after the last photography job ends")
char.jobs.kill = {targetMap = map, targetSpecies = "pseudodog", progress = 0, numberRec = 3}
ix.jobs.regional.RecordKill(client, "npc_mutant_pseudodog", "rp_waystation")
check(char.jobs.kill.progress == 0, "wrong-map kills do not count")
ix.jobs.regional.RecordKill(client, "npc_mutant_pseudodog", map)
check(char.jobs.kill.progress == 1, "one kill earns one specific-target credit")
char.jobs.category = {targetMap = map, targetWeights = {pseudodog = 0.5}, progress = 0, numberRec = 2}
ix.jobs.regional.RecordKill(client, "npc_mutant_pseudodog", map)
check(char.jobs.category.progress == 0.5, "category progress counts pack equivalents")
check(ix.jobs.regional.CanOffer(char, {photoKind = "mutant"}), "initial photography offer is mutant")
char:SetData("townPhotoNext", "anomaly")
check(not ix.jobs.regional.CanOffer(char, {photoKind = "mutant"})
	and ix.jobs.regional.CanOffer(char, {photoKind = "anomaly"}), "photography selection follows saved alternation")
print("PASS: " .. checks .. " regional job checks")
