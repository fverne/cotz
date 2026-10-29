ix.progression.Register("arenaProgramme1", {
	name = "Arena programme 1",
	description = "Complete a competitive match against a new opponent.",
	keyNpc = "'Arena Master'",
	progMap = "rp_marsh_cs",
	defaultActive = true,
	nextProgressions = {"arenaProgramme2"},
	progressthresholds = {1},
	BuildResponse = ix.progression.BuildDeliveryResponse,
	progressfunctions = {},
	briefing = (
		"Get through a proper match and I'll help with the bill for patching you up. A "
		.. "cancellation or your mate disconnecting doesn't impress me."
	),
	completionMessage = "A proper finish. Your place in the programme is recorded.",
	completionBenefits = {services = {{npc = "'Arena Master'", service = "treatment", amount = 150}}},
})

ix.progression.Register("arenaProgramme2", {
	name = "Arena programme 2",
	description = "Complete a competitive match against a new opponent.",
	keyNpc = "'Arena Master'",
	progMap = "rp_marsh_cs",
	defaultActive = false,
	nextProgressions = {"arenaProgramme3"},
	progressthresholds = {1},
	BuildResponse = ix.progression.BuildDeliveryResponse,
	progressfunctions = {},
	briefing = (
		"One familiar opponent teaches you familiar habits. Face somebody new, finish the "
		.. "match, and I'll put aside a combat medical supply."
	),
	completionMessage = "A proper finish. Your place in the programme is recorded.",
	completionBenefits = {items = {{item = "medic_medkit_1"}}},
})

ix.progression.Register("arenaProgramme3", {
	name = "Arena programme 3",
	description = "Complete a competitive match against a new opponent.",
	keyNpc = "'Arena Master'",
	progMap = "rp_marsh_cs",
	defaultActive = false,
	nextProgressions = {},
	progressthresholds = {1},
	BuildResponse = ix.progression.BuildDeliveryResponse,
	progressfunctions = {},
	briefing = (
		"You've shown you can stand against different opponents. Finish one more new matchup "
		.. "and you'll earn the veteran's treatment rate here."
	),
	completionMessage = "A proper finish. Your place in the programme is recorded.",
	completionBenefits = {},
	recognition = "Arena Veteran",
	serviceDiscounts = {{npc = "'Arena Master'", service = "treatment", fraction = 0.1}},
})

if SERVER then
	local function advanceArenaProgramme(client, opponent)
		local character = client:GetCharacter()
		if not character then return end
		local completed = character:GetData("arenaProgressionOpponents", {}) or {}
		local identity = opponent:SteamID64()
		if completed[identity] or identity == client:SteamID64() or client:IsBot() or opponent:IsBot() then
			return
		end
		for rank = 1, 3 do
			local id = "arenaProgramme" .. rank
			if ix.progression.IsActive(character, id) then
				completed[identity] = true
				character:SetData("arenaProgressionOpponents", completed)
				ix.progression.AddProgressionValue(character, id, 1)

				return
			end
		end
	end

	hook.Add("cotz/arena/match-completed", "cotz/progression/arena-programme", function(first, second)
		advanceArenaProgramme(first, second)
		advanceArenaProgramme(second, first)
	end)
end
