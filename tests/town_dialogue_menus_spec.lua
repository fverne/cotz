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
check(ballastTree.StartBarter:ShouldAdd(client, target("'Ballast'")), "available free hideout claims retain barter access")
local originalGet = ix.plugin.Get
ix.plugin.Get = function(id) if id ~= "hideouts" then return originalGet(id) end end
check(not ballastTree.StartBarter:ShouldAdd(client, target("'Ballast'")), "unavailable child services cannot expose a barter root")
print(string.format("PASS: %d town dialogue menu checks", checks))
