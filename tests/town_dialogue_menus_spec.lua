-- Run from the repository root: luatex --luaonly tests/town_dialogue_menus_spec.lua
local context = dofile("tests/helpers/townnpcs.lua")
dofile("tests/helpers/town_dialogue.lua")
local checks, contacts = 0, 0
local function check(value, message)
	checks = checks + 1
	assert(value, message)
end
local function includes(topic, id)
	for _, option in ipairs(topic.options or {}) do
		if option == id then return true end
	end

	return false
end
for id, dialogue in pairs(ix.dialogue.list) do
	if dialogue.townContact then
		contacts = contacts + 1
		local tree = dialogue.tree
		local visited = {}
		local function visit(topicID)
			if visited[topicID] then return end
			visited[topicID] = true
			local topic = tree[topicID]
			check(topic ~= nil, id .. ": every offered topic exists: " .. topicID)
			for _, option in ipairs(topic.options or {}) do visit(option) end
		end
		visit("GREETING")
		for _, rootID in ipairs({"GREETING", "BackTopic"}) do
			for _, topicID in ipairs(tree[rootID].options) do
				check(not topicID:match("^Interest") and topicID ~= "BackgroundTopic"
					and topicID ~= "SpecialtyTopic" and topicID ~= "AdviceTopic" and topicID ~= "ContactsTopic",
					id .. ": flavour belongs in questions")
				check(topicID ~= "PaintSuit" and topicID ~= "ChangeSuitVariant" and topicID ~= "PDAAvatarTopic",
					id .. ": appearance services belong in customization")
				check(topicID ~= "AmmoExchange", id .. ": ammunition exchanges belong in barter")
			end
			check(includes(tree[rootID], "TownDeliveries"), id .. ": deliveries survive a return to root")
			check(not includes(tree[rootID], "TaskRewardChoices"), id .. ": task rewards stay out of the root")
		end
		local completedClient = {GetCharacter = function()
			return {GetJobs = function() return {["test contact"] = {isCompleted = true}} end}
		end}
		local completedTarget = {GetDisplayName = function() return "test contact" end}
		check(#tree.AboutWorkTopic:GetDynamicOptions(completedClient, completedTarget) == 0,
			id .. ": completed assignments have no redundant completion action")
		check(includes(tree.AboutWorkTopic, "TaskRewardChoices"), id .. ": task rewards belong under work")
		check(includes(tree.TaskRewardChoices, "AboutWorkTopic"), id .. ": rewards return to work")
		check(tree.TradeTopic.quickAction, id .. ": trading preserves the current dialogue choices")
		check(ix.dialogue.GetOptionCategory("InterestTownRelationsTopic") == "text", id .. ": flavour stays white")
		local options = table.concat(tree.GREETING.options, ",")
		ix.dialogue.ConfigureCustomization(dialogue)
		check(table.concat(tree.GREETING.options, ",") == options, id .. ": customization grouping is idempotent")
	end
end
check(contacts == 27, "the menu audit covers all 27 town contacts")
check(ix.dialogue.list.technpc.tree.CustomizeGear.quickAction
	and not ix.dialogue.list.technpc.tree.PaintSuit, "Technut opens the combined gear and suit window")
check(includes(ix.dialogue.list.suturenpc.tree.GearCustomizationTopic, "ChangeSuitVariant"),
	"Suture's suit conversions stay in customization")
check(includes(ix.dialogue.list.brassnpc.tree.StartBarter, "AmmoExchange")
	and includes(ix.dialogue.list.carbonnpc.tree.StartBarter, "AmmoExchange"),
	"both ammunition providers offer their exchange under barter")
local fresh = context.fixture.character()
local client = {GetCharacter = function() return fresh end}
local function target(name) return {GetDisplayName = function() return name end} end
local function complete(id)
	local record = ix.progression.GetCharacterProgression(fresh)
	record.lines[id] = {completed = true}
	ix.progression.SetCharacterProgression(fresh, record)
end
ix.pac = {}
local technut = target("'Technut'")
local customize = ix.dialogue.list.technpc.tree.CustomizeGear
check(not customize:ShouldAdd(client, technut), "fresh characters cannot see Technut's customization root")
complete("cotz/town/technut/v3/painting/painting")
check(customize:ShouldAdd(client, technut), "the painting milestone reveals the combined customization root")
local brass, carbon = target("'Brass'"), target("'Carbon'")
local brassTree, carbonTree = ix.dialogue.list.brassnpc.tree, ix.dialogue.list.carbonnpc.tree
check(not brassTree.AmmoExchange:ShouldAdd(client, brass) and not brassTree.StartBarter:ShouldAdd(client, brass),
	"Brass's exchange and barter root are hidden before the first unlocked recipe")
check(not carbonTree.AmmoExchange:ShouldAdd(client, carbon) and not carbonTree.StartBarter:ShouldAdd(client, carbon),
	"Carbon's exchange and barter root are hidden before the first unlocked recipe")
complete("cotz/town/brass/v3/hp-ammo/9x19hp")
check(brassTree.AmmoExchange:ShouldAdd(client, brass) and brassTree.StartBarter:ShouldAdd(client, brass),
	"the HP milestone reveals Brass's HP barter without requiring carried ammunition")
complete("cotz/town/carbon/v3/ap-ammo/9x19ap")
check(carbonTree.AmmoExchange:ShouldAdd(client, carbon) and carbonTree.StartBarter:ShouldAdd(client, carbon),
	"the AP milestone reveals Carbon's AP barter")
local suture = target("'Suture'")
local sutureTree = ix.dialogue.list.suturenpc.tree
-- The town fixture indexes identity/tuning only; provide these actual suit base relationships for the consumer.
ix.item.list.suit_anorak.baseSuit = "suit_anorak"
ix.item.list.suit_anorak_ecologist.baseSuit = "suit_anorak"
check(not sutureTree.ChangeSuitVariant:ShouldAdd(client, suture)
	and not sutureTree.GearCustomizationTopic:ShouldAdd(client, suture),
	"Suture's starting service does not expose an empty customization root")
local variant = assert(ix.townNPCs.variantUnlocks.suit_anorak_ecologist)
complete(ix.townNPCs:StepID(variant.contact, variant.step))
local baseGate = assert(ix.townNPCs.itemGates.suit_anorak)
if baseGate.id then complete(baseGate.id) end
check(sutureTree.ChangeSuitVariant:ShouldAdd(client, suture)
	and sutureTree.GearCustomizationTopic:ShouldAdd(client, suture),
	"an unlocked conversion reveals Suture's customization root without inventory requirements")
local hagglerTree = ix.dialogue.list.tradernpc.tree
local haggler = target("'Haggler'")
check(not hagglerTree.StartBarter:ShouldAdd(client, haggler), "a legacy barter root is hidden with no active offers")
local legacyAvailable = true
ix.npcbarter = {GetActiveBartersForNPC = function() return legacyAvailable and {"legacy"} or {} end}
check(hagglerTree.StartBarter:ShouldAdd(client, haggler), "active legacy offers retain their barter root")
legacyAvailable = false
ix.dialogue.ConfigureBarterVisibility(ix.dialogue.list.tradernpc)
check(not hagglerTree.StartBarter:ShouldAdd(client, haggler), "barter visibility remains idempotent")
local ballastTree = ix.dialogue.list.ballastnpc.tree
for _, rootID in ipairs({"GREETING", "BackTopic"}) do
	local options = ballastTree[rootID].options
	check(table.concat(options, ",") == table.concat(ix.dialogue.OrderOptions(options, true), ","),
		"upgrade integration preserves service ordering in " .. rootID)
	check(options[#options] == "GOODBYE", "upgrade service stays before goodbye in " .. rootID)
end
local originalGet = ix.plugin.Get
local requested
local hideouts = {
	SendUpgradeHideouts = function(_, player, vendor) requested = {"hideouts", player, vendor} end,
	SendUpgradeOffers = function(_, player, vendor, id) requested = {"offers", player, vendor, id} end,
	ExecuteUpgrade = function(_, player, vendor, data) requested = {"execute", player, vendor, data} return true end,
}
ix.plugin.Get = function(id) if id == "hideouts" then return hideouts end return originalGet(id) end
local ballast = target("'Ballast'")
check(ballastTree.HideoutUpgrades:ShouldAdd(client, ballast),
	"the local hideout contact offers upgrades when its plugin is available")
local wasServer, wasClient = SERVER, CLIENT
SERVER, CLIENT = true, false
ballastTree.HideoutUpgrades:preCallback(client, ballast)
check(requested and requested[1] == "hideouts" and requested[2] == client and requested[3] == ballast,
	"the upgrade topic requests the authoritative hideout list")
ballastTree.HideoutUpgradeList:DynamicPreCallback(client, ballast, {hideout = "7"})
check(requested[1] == "offers" and requested[4] == "7", "choosing a hideout requests its authoritative offers")
requested = nil
ballastTree.HideoutUpgradeList:DynamicPreCallback(client, ballast, {hideout = 7})
check(requested == nil, "malformed hideout choices are ignored")
ballastTree.HideoutUpgradeConfirm.ResolveDynamicOption(nil, client, ballast, {accepted = false})
check(requested == nil, "declining an upgrade never executes it")
ballastTree.HideoutUpgradeConfirm.ResolveDynamicOption(nil, client, ballast, {accepted = true, index = 1, revision = 3})
check(requested[1] == "execute" and requested[4].revision == 3, "accepting forwards the reviewed offer to the server")
SERVER, CLIENT = false, true
client.cotzHideoutUpgradeList = {target = ballast, hideouts = {{id = "7", name = "Room", squad = false},
	{id = "9", name = "Den", squad = true}}}
local listed = ballastTree.HideoutUpgrades.GetDynamicOptions(nil, client, ballast)
check(#listed == 2 and listed[2].statement == "Squad hideout: Den" and listed[1].dyndata.hideout == "7",
	"cached hideouts become dynamic choices")
client.cotzHideoutUpgradeOffers = {target = ballast, hideout = "7", revision = 5, offers = {
	{label = "Floor", summary = "500", description = "More floor.", payable = true, redeemable = false},
	{label = "Crate", summary = "900", description = "Locked.", payable = false, redeemable = true},
}}
check(#ballastTree.HideoutUpgradeList.GetDynamicOptions(nil, client, ballast) == 2, "cached offers are listed")
local confirm = ballastTree.HideoutUpgradeConfirm
confirm.DynamicPreCallback(confirm, client, ballast, {index = 1})
local choices = confirm.GetDynamicOptions(confirm, client, ballast)
check(#choices == 2 and choices[1].dyndata.accepted and choices[1].dyndata.revision == 5
	and confirm.response:find("More floor.", 1, true), "a payable offer can be confirmed with its revision")
confirm.DynamicPreCallback(confirm, client, ballast, {index = 2})
choices = confirm.GetDynamicOptions(confirm, client, ballast)
check(#choices == 2 and choices[1].dyndata.crate and not choices[2].dyndata.accepted,
	"an unpayable offer only offers a carried crate and a way back")
local nextTopic, data = confirm.ResolveDynamicOption(nil, client, ballast, {accepted = false})
check(nextTopic == "HideoutUpgradeList" and data.hideout == "7", "the confirmation returns to the hideout's offers")
SERVER, CLIENT = wasServer, wasClient
client.cotzHideoutUpgradeList, client.cotzHideoutUpgradeOffers = nil, nil
ix.plugin.Get = function(id) if id ~= "hideouts" then return originalGet(id) end end
check(not ballastTree.HideoutUpgrades:ShouldAdd(client, ballast), "hideout upgrades hide when hideouts are unavailable")
ix.plugin.Get = originalGet
check(brassTree.StartBarter:ShouldAdd(client, brass), "unlocked barter remains visible after service grouping")
check(includes(ballastTree.GREETING, "HideoutUpgrades"), "a lone hideout upgrade service keeps its direct action")
local grouped = 0
for id, dialogue in pairs(ix.dialogue.list) do
	if dialogue.townContact and dialogue.tree.ServicesTopic then
		grouped = grouped + 1
		local tree = dialogue.tree
		check(tree.ServicesTopic.statement == "What services do you provide?", id .. ": services use the shared prompt")
		for _, rootID in ipairs({"GREETING", "BackTopic"}) do
			check(includes(tree[rootID], "ServicesTopic"), id .. ": both roots offer services")
			for _, topicID in ipairs(tree[rootID].options) do
				check(topicID == "ServicesTopic" or ix.dialogue.GetOptionCategory(topicID, tree[topicID]) ~= "service",
					id .. ": individual services stay out of the root")
			end
		end
		check(includes(tree.ServicesTopic, "BackTopic"), id .. ": services return to the main menu")
		local before = table.concat(tree.ServicesTopic.options, ",")
		ix.dialogue.ConfigureServices(dialogue)
		check(table.concat(tree.ServicesTopic.options, ",") == before, id .. ": services grouping is idempotent")
	end
end
check(grouped > 0, "the roster includes contacts with multiple services")
local future = {townContact = "future", tree = {}}
future.addTopic = function(id, data)
	data.statement = data.statement or ""
	data.options = data.options or {}
	data.ShouldAdd = data.ShouldAdd or function() return true end
	future.tree[id] = data
end
future.addTopic("GREETING", {options = {"TradeTopic", "RepairItems", "GOODBYE"}})
future.addTopic("BackTopic", {options = {"TradeTopic", "RepairItems", "GOODBYE"}})
future.addTopic("RepairItems", {statement = "Repair.", options = {"BackTopic"}})
ix.dialogue.ConfigureServices(future)
check(not future.tree.ServicesTopic and includes(future.tree.GREETING, "RepairItems"),
	"a single service stays directly accessible")
local available = false
future.addTopic("FutureService", {statement = "New service.", category = "service", options = {"BackTopic"},
	ShouldAdd = function() return available end})
future.tree.GREETING.options[#future.tree.GREETING.options + 1] = "FutureService"
ix.dialogue.ConfigureServices(future)
check(includes(future.tree.ServicesTopic, "RepairItems") and includes(future.tree.ServicesTopic, "FutureService"),
	"adding a second service automatically groups both without a hard-coded topic ID")
check(includes(future.tree.BackTopic, "ServicesTopic"), "late services appear on both root variants")
check(includes(future.tree.FutureService, "ServicesBackTopic"), "services return to their submenu")
check(not future.tree.FutureService:ShouldAdd(client, ballast), "grouping preserves locked service conditions")
future.tree.RepairItems.ShouldAdd = function() return false end
check(not future.tree.ServicesTopic:ShouldAdd(client, ballast), "an empty service submenu is hidden")
available = true
check(future.tree.ServicesTopic:ShouldAdd(client, ballast), "unlocking a child reveals services")
check(ix.dialogue.GetOptionCategory("ServicesTopic") == "service"
	and ix.dialogue.GetOptionCategory("ServicesBackTopic") == "back", "service navigation keeps its action colors")
print(string.format("PASS: %d town dialogue menu checks", checks))
