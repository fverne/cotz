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
check(active == 20, "Mute adds triangulation alongside the existing nineteen issuers")
for _, slug in ipairs({"beanstalk", "egghead", "intern"}) do
	local contact = ix.townNPCs.contacts[slug]
	check(contact.map == "rp_marsh_cs" and contact.bunker, "all three scientists remain in the Swamps Eco Bunker")
end
check(ix.townNPCs.contacts.egghead.job.category ~= ix.townNPCs.contacts.jitters.job.category,
	"bunker and settlement specimen work have distinct home-map categories")
check(ix.townNPCs.contacts.beanstalk.job.kind == "defence", "Beanstalk retains research defence")
for tier, difficulty in ipairs({"easy", "medium", "hard"}) do
	check(ix.townNPCs.contacts.egghead.job.maps[difficulty]
		== ({"rp_garbage_cotz", "rp_waystation", "rp_pripyat_remaster"})[tier],
		"Egghead retains the later-region specimen progression from his bunker home")
end
check(ix.townNPCs.contacts.wake.job.kind == "courier", "Wake owns information deliveries")
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
netstream = {Start = function() end}
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
local notices = {}
function client:Notify(text) notices[#notices + 1] = text end
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
local originalRandom = math.random
local contactCount = 0
for _ in pairs(ix.townNPCs.contacts) do contactCount = contactCount + 1 end
for tier, difficulty in ipairs({"easy", "medium", "hard"}) do
	local recipients = {}
	for index = 1, contactCount do
		math.random = function(limit) return math.min(index, limit) end
		local job = {identifier = "cotz/town/v2/wake/" .. difficulty .. "/courier"}
		local assigned = ix.jobs.regional.AssignCourier(char, "'Wake'", job)
		math.random = originalRandom
		check(assigned, "each information courier tier has an available recipient")
		local state = job.fieldTask
		local contact = ix.townNPCs.byName[state.recipient]
		recipients[contact.id] = true
		check(state.recipientMap == contact.map, "courier assignment saves the recipient's actual home")
		if tier == 1 then
			check(contact.map == "rp_marsh_cs" and not contact.bunker,
				"easy couriers visit the Swamps settlement without requiring bunker access")
		elseif tier == 2 then
			check(contact.map == "rp_waystation", "medium couriers visit Waystation")
		else
			check(contact.bunker or contact.map == "rp_waystation", "hard couriers visit the bunker or Waystation")
		end
	end
	for _, slug in ipairs({"beanstalk", "egghead", "intern"}) do
		check((recipients[slug] == true) == (tier == 3), "all three bunker scientists are hard courier recipients only")
	end
end
char.jobs.test = {identifier = "cotz/town/v2/atlas/easy/mutant", rewardKey = "photo:1",
	photoKind = "mutant", progress = 0, numberRec = 3}
char.inventory.full = true
check(not ix.jobs.regional.CanStart(char, {photoKind = "mutant"}), "full inventory rejects acceptance")
char.inventory.full = false
ix.jobs.regional.ReconcileCamera(client)
ix.jobs.regional.ReconcileCamera(client)
check(#callbacks == 1, "repeated requests share one pending camera insertion")
callbacks[1]()
check(client.weapons.ix_camera ~= nil, "camera insertion equips the existing SWEP")
local camera = client.weapons.ix_camera
char.jobs.anomaly = {identifier = "cotz/town/v2/atlas/easy/anomaly", rewardKey = "photo:2",
	photoKind = "anomaly", progress = 0, numberRec = 3}
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
local completeNotices = 0
for _, notice in ipairs(notices) do
	if notice:find("Task completed:", 1, true) then completeNotices = completeNotices + 1 end
end
check(completeNotices == 1, "photography completion announces the transition once")
check(ix.jobs.regional.PhotoSummary({photoKind = "mutant", photoTypes = {blinddog = true}, numberRec = 3})
	:find("Blinddog", 1, true), "camera ledger names captured species")
for tier, difficulty in ipairs({"easy", "medium", "hard"}) do
	local definition = ix.jobs.list["cotz/town/v2/mute/" .. difficulty .. "/triangulation"]
	check(definition and definition.fieldSettings.readingCount == tier + 2, "Mute offers all triangulation tiers")
end
for _, contact in pairs(ix.townNPCs.contacts) do
	local dialogue = ix.dialogue.list[ix.npctemplates.templates[contact.template].dialogueid]
	if contact.job.kind == "none" then
		for _, rootID in ipairs({"GREETING", "BackTopic"}) do
			for _, option in ipairs(dialogue.tree[rootID].options) do
				check(option ~= "GetTaskByDifficulty", "inactive issuers have no dangling job option")
			end
		end
	end
end
local receiverJobs = 0
for id, definition in pairs(ix.jobs.list) do
	if definition.alternateDelivery and not definition.completionOnly then
		local names = ix.jobs.regional.EligibleReceivers(definition)
		check(#names > 0, "valuable delivery lists eligible contacts")
		local inactive = ix.jobs.getFormattedDescInactive(id)
		local activeDescription = ix.jobs.getFormattedDesc({identifier = id, numberRec = definition.numberRec})
		for _, name in ipairs(names) do
			check(inactive:find(name, 1, true) and activeDescription:find(name, 1, true),
				"both preview and journal name each eligible receiver")
			check(ix.jobs.regional.ReceiverMatches(char, ix.townNPCs.byName[name], {identifier = id}),
				"listed receiver passes authoritative eligibility")
		end
		check(not activeDescription:find("rp_", 1, true), "journal uses display region names")
		receiverJobs = receiverJobs + 1
	end
end
check(receiverJobs > 0, "receiver coverage exercises real generated valuable jobs")
check(ix.jobs.FormatMapNames("rp_marsh_cs to rp_waystation") == "Swamps to Waystation",
	"accepted descriptions containing BSP names use current display names")
ix.jobs.list.testKill = {name = "Test hunt %d"}
char.jobs = {kill = {identifier = "testKill", targetMap = map, targetSpecies = "pseudodog",
	progress = 2, numberRec = 3}}
local noticeCount = #notices
ix.jobs.regional.RecordKill(client, "npc_mutant_pseudodog", map)
check(#notices == noticeCount + 1 and notices[#notices]:find("Task completed:", 1, true),
	"regional kill completion announces readiness")
ix.jobs.regional.RecordKill(client, "npc_mutant_pseudodog", map)
check(#notices == noticeCount + 1, "extra kills cannot repeat the completed notification")
local themedContacts, separateShopInterests = 0, 0
for slug, contact in pairs(ix.townNPCs.contacts) do
	if slug ~= "the-original" then
		check(#contact.courierPools == 4, "every active contact declares four themed courier categories")
		themedContacts = themedContacts + 1
		for itemID in pairs(contact.courierItems) do
			if not (contact.wantedItems or {})[itemID] and contact.enforceCatalogue
				and not (contact.disabledItems or {})[itemID] then
				check(ix.townNPCs:WantsCourierItem(contact, itemID, false)
					and ix.townNPCs:CanSellItem(itemID, contact.name) == false,
					"courier-only categories do not expand ordinary vendor assortments")
				separateShopInterests = separateShopInterests + 1
			end
		end
	end
end
check(themedContacts == 26 and separateShopInterests > 0, "category expansion covers the active roster")
local sample
for _, definition in pairs(ix.jobs.list) do
	if definition.alternateDelivery and not definition.completionOnly then sample = definition break end
end
local previousLookup = ix.progression.GetNPCFromName
ix.progression.GetNPCFromName = function() end
check(not ix.jobs.regional.CanOffer(char, sample), "new couriers cannot rely on unplaced receivers")
ix.progression.GetNPCFromName = function() return {} end
check(ix.jobs.regional.CanOffer(char, sample), "placing an eligible contact restores courier availability")
ix.progression.GetNPCFromName = previousLookup
print("PASS: " .. checks .. " regional job checks")
