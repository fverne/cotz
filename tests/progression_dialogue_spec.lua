-- Run from the repository root: luatex --luaonly tests/progression_dialogue_spec.lua
local fixture = dofile("tests/helpers/townnpcs.lua")
local check = fixture.check
local seenBriefings, seenCompletions = {}, {}
local contacts, steps, reserves = 0, 0, 0

for slug, contact in pairs(ix.townNPCs.contacts) do
	if #contact.progression > 0 then contacts = contacts + 1 end
	for _, step in ipairs(contact.progression) do
		steps = steps + 1
		local label = slug .. "/" .. step.id
		local definition = ix.progression.definitions[ix.townNPCs:StepID(slug, step.id)]
		check(type(step.briefing) == "string" and step.briefing:find("%S"), label .. " has a briefing")
		check(type(step.completion) == "string" and step.completion:find("%S"), label .. " has a completion")
		local briefing = step.briefing:lower():gsub("%s+", " ")
		local completion = step.completion:lower():gsub("%s+", " ")
		check(not seenBriefings[briefing], label .. " has an individual briefing")
		check(not seenCompletions[completion], label .. " has an individual completion")
		seenBriefings[briefing], seenCompletions[completion] = label, label
		check(definition.briefing == step.briefing, label .. " compiles its authored briefing")
		check(definition.completionMessage == step.completion, label .. " compiles its authored completion")
		if slug == "mute" then
			check(step.briefing:match("^%*%* .+ %*%*$"), label .. " briefing remains nonverbal")
			check(step.completion:match("^%*%* .+ %*%*$"), label .. " completion remains nonverbal")
		end
		if step.intermissionFor then
			reserves = reserves + 1
			local target = ix.progression.definitions[ix.townNPCs:StepID(slug, step.intermissionFor)]
			check(definition.briefing ~= target.briefing, label .. " does not copy the next unlock briefing")
			check(definition.completionMessage ~= target.completionMessage,
				label .. " does not copy the next unlock completion")
		end
	end
end

check(contacts == 25 and steps == 638 and reserves == 223, "all active town progression dialogue is covered")
print(string.format("PASS: %d contacts, %d dialogue pairs, %d stock conversations", contacts, steps, reserves))
