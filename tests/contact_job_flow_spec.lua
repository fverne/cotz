-- Run from the repository root: luatex --luaonly tests/contact_job_flow_spec.lua
local checks = 0
local function check(value, message)
	checks = checks + 1
	assert(value, message)
end
SERVER, CLIENT = true, false
IsValid = function(value) return type(value) == "table" and not value.invalid end
FindMetaTable = function() return {} end
SortedPairs = pairs
local base = "gamemodes/ix_cotz/plugins/"
ix = {jobs = {field = {}}, progression = {itemPools = {}, definitions = {}},
	dialogue = {}, plugin = {Get = function() end}, item = {list = {}}}
PLUGIN = {contacts = {}, byName = {}}
function PLUGIN:Register(id, contact)
	contact.id, contact.categories = id, {}
	self.contacts[id], self.byName[contact.name] = contact, contact
end
function PLUGIN:StepID(slug, id) return "cotz/town/" .. slug .. "/" .. id end
function PLUGIN:WantsCourierItem(contact, item) return contact.wantedItem == item end
function PLUGIN:CanInteract() return true end
ix.townNPCs = PLUGIN
local files = assert(io.popen("rg --files gamemodes/ix_cotz/plugins/townnpcs/definitions"))
for path in files:lines() do
	local file = assert(io.open(path))
	local source = file:read("*a")
	file:close()
	if source:find("PLUGIN:Register(", 1, true) then dofile(path) end
end
files:close()
dofile(base .. "jobsystem/definitions/sh_settings.lua")
dofile(base .. "jobsystem/libs/sh_jobs.lua")
dofile(base .. "jobsystem/libs/sh_regionaljobs.lua")
dofile(base .. "jobsystem/libs/sh_fieldtasks.lua")
ix.dialogue.ConfigureTownServices = function() end
ix.dialogue.ConfigureTaskRewards = function() end
ix.dialogue.ConfigureCustomization = function() end
ix.dialogue.ConfigureBarterVisibility = function() end
dofile(base .. "dialogue/libs/sh_towncontacts.lua")
local inventory, jobs = {items = {}}, {}
function inventory:GetItems() return self.items end
function inventory:GetID() return 10 end
local character = {GetInventory = function() return inventory end, GetJobs = function() return jobs end,
	GetID = function() return 7 end}
local client = {GetCharacter = function() return character end,
	ixHasJobFromNPC = function(_, npc) return jobs[npc] ~= nil end}
local trees = {}
for id, contact in pairs(PLUGIN.contacts) do
	check(contact.dialogue.jobBriefing and contact.dialogue.jobReminder and contact.dialogue.jobFinished,
		"every contact has separate spoken job text")
	local dialogue = {townContact = id, tree = {GREETING = {options = {}}, BackTopic = {options = {}}}}
	dialogue.addTopic = function(topicID, topic) dialogue.tree[topicID] = topic end
	ix.dialogue.ConfigureTownContact(dialogue, contact)
	trees[id] = dialogue.tree
end
check(PLUGIN.contacts.brass.job.kind == "none" and PLUGIN.contacts.brass.retiredRegionalJob.kind == "courier",
	"Brass has no new jobs and retains accepted courier definitions")
check(PLUGIN.contacts.wake.job.kind == "courier", "Wake offers the information couriers")

ix.jobs.list.nails = {requiredItem = "nails", alternateDelivery = true, issuerName = "'Latch'",
	townContact = "latch", desc = "Deliver %d units to a contact in Garbage who requests this category."}
ix.item.list.nails = {name = "Pack of Nails"}
local spool = PLUGIN.contacts.spool
spool.wantedItem = "nails"
local order = {identifier = "nails", numberRec = 1, progress = 0, rewardKey = "job:nails"}
jobs["'Latch'"] = order
local incoming = trees.spool.TownDeliveries
check(not incoming.ShouldAdd(nil, client) and #incoming.GetDynamicOptions(nil, client) == 0,
	"a matching assignment without items exposes no delivery")
local nails = {uniqueID = "nails", quantity = 1, quantityLeft = 0}
function nails:GetData(_, default) return self.quantityLeft or default end
inventory.items.nails = nails
check(not incoming.ShouldAdd(nil, client), "empty stacks expose no delivery")
nails.quantityLeft = 1
check(incoming.ShouldAdd(nil, client) and #incoming.GetDynamicOptions(nil, client) == 1,
	"a real requested item exposes exactly one hand-in")
local journal = ix.jobs.getFormattedDesc(order)
local spoken = ix.jobs.GetDialogueDescription(order, "'Latch'")
check(spoken:find("Pack of Nails", 1, true) and spoken:find("'Spool'", 1, true)
	and not spoken:find("units", 1, true), "Latch names the actual goods and receiving contact in speech")
check(ix.jobs.getFormattedDesc(order) == journal and journal:find("units", 1, true),
	"spoken job text leaves the journal description unchanged")
order.isCompleted = true
check(ix.jobs.GetDialogueDescription(order, "'Latch'") == PLUGIN.contacts.latch.dialogue.jobFinished,
	"completed work uses the contact's completion response")
order.isCompleted, inventory.items.nails = false, nil
jobs["'Latch'"] = nil
local parcelJob = {identifier = "parcel", rewardKey = "job:parcel", fieldTask = {
	cargo = "parcel", stage = "carrying", recipient = spool.name,
}}
ix.jobs.list.parcel = {}
jobs["'Wake'"] = parcelJob
check(not incoming.ShouldAdd(nil, client), "saved carrying state without physical cargo stays hidden")
local cargo = {uniqueID = "parcel", isFieldCargo = true,
	data = {fieldOwner = 7, fieldClaim = "wrong-claim"}}
function cargo:GetData(key) return self.data[key] end
inventory.items.parcel = cargo
check(not incoming.ShouldAdd(nil, client), "cargo from another claim cannot expose delivery")
cargo.data.fieldClaim = parcelJob.rewardKey
check(incoming.ShouldAdd(nil, client) and #incoming.GetDynamicOptions(nil, client) == 1,
	"the bound parcel exposes exactly one physical delivery option")
check(not incoming.GetDynamicOptions(nil, client)[1].dyndata.valuable,
	"physical parcels use the cargo hand-in rather than the valuable hand-in")
check(ix.jobs.FormatMapNames("Return to rp_marsh_cs.bsp, then rp_waystation.")
	== "Return to Swamps, then Waystation.", "displayed map names hide BSP filenames and extensions")
ix.jobs.list.journalFixture = {name = "Bring %d supplies", desc = "Bring %d supplies to Swamps."}
local journal = ix.jobs.getFormattedDesc({identifier = "journalFixture", numberRec = 2, moneyReward = 1000}, true)
check(journal == "Bring 2 supplies to Swamps.", "the task journal can show the objective without payment or reward instructions")
print(string.format("PASS: %d contact job flow checks", checks))
