local families = {
	recovery = {
		name = "Recover lost equipment.",
		desc = "Search the assigned area for a lost equipment case and bring it back. "
			.. "Use Field work in your PDA task list for directions. Leave room for a 2x2, 2.5 kg case.",
		categories = {"stashpackagenpc_", "item_world_NPC_"},
	},
	sensor = {
		name = "Deploy and retrieve a research sensor.",
		desc = "Deploy a sensor at the assigned site, leave the area while it records, then retrieve it. "
			.. "Use Field work in your PDA task list. Leave room for a 1x2, 0.5 kg recorder.",
		categories = {"scanarea"},
	},
	triangulation = {
		name = "Locate an unknown radio transmitter.",
		desc = "Take signal readings from separated positions and bearings, find the transmitter and bring it back. "
			.. "Use Field work in your PDA task list. Leave room for a 2x1, 0.75 kg transmitter.",
		categories = {"scanRF"},
	},
	deadDrop = {
		name = "Complete a dead-drop circuit.",
		desc = "Collect a sealed parcel at the pickup point and hide it at the delivery point. "
			.. "Use Field work in your PDA task list. Leave room for a 2x2, 5 kg parcel.",
		categories = {"stashpackagenpc_"},
	},
	defence = {
		name = "Defend a field research sampler.",
		desc = "Activate the sampler, stay nearby and clear the mutant waves while it records. "
			.. "Nearby mutants disrupt and damage the sampler. Use Field work in your PDA task list. "
			.. "Leaving interrupts the current wave. "
			.. "Bring back the results; leave room for a 1x2, 0.5 kg recorder.",
		categories = {"scanarea", "mutantkill"},
	},
}

local difficulties = {
	{key = "easy", tier = 1, cash = 3000, reputation = 25, map = "rp_marsh_cs"},
	{key = "medium", tier = 2, cash = 5000, reputation = 40, map = "rp_waystation"},
	{key = "hard", tier = 3, cash = 8000, reputation = 60, map = "rp_pripyat_remaster"},
}

for kind, family in pairs(families) do
	for _, difficulty in ipairs(difficulties) do
		local categories = {"field_" .. kind .. "_" .. difficulty.key}
		for _, prefix in ipairs(family.categories) do
			categories[#categories + 1] = prefix .. difficulty.key
		end
		ix.jobs.register({
			name = family.name,
			desc = family.desc .. " Assignment region: " .. difficulty.map .. ".",
			icon = "propic/event/area",
			tier = difficulty.tier,
			fieldType = kind,
			fieldMap = difficulty.map,
			numberRec = 1,
			reward = {},
			rewardCount = 0,
			repReward = difficulty.reputation,
			moneyReward = difficulty.cash,
			categories = categories,
		}, "field_" .. kind .. "_" .. difficulty.key)
	end
end
