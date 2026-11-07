-- Run from the repository root: luatex --luaonly tests/town_dialogue_menus_spec.lua
dofile("tests/helpers/townnpcs.lua")
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
		end
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
print(string.format("PASS: %d town dialogue menu checks", checks))
