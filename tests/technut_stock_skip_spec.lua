-- Run from the addon root: luatex --luaonly tests/technut_stock_skip_spec.lua
local context = dofile("tests/helpers/townnpcs.lua")
local checks = 0
local function check(value, message)
	checks = checks + 1
	assert(value, message)
end
local suits = {
	"suit_trenchcoat_black", "suit_sunrise", "suit_io7a", "suit_wind", "suit_ps5m", "suit_cs2",
	"suit_nbc", "suit_berill", "suit_cs3", "suit_skat10", "suit_skat9",
}
local unrelated = ix.townNPCs:StepID("jitters", "v3/medkits/medic_medkit_2/stock")
for _, suit in ipairs(suits) do
	local nextID = ix.townNPCs:StepID("technut", "v3/suits/" .. suit)
	local stockID = nextID .. "/stock"
	for _, successorState in ipairs({"missing", "inactive", "partial", "completed"}) do
		local character = context.fixture.character()
		character:SetData("townNPCProgression", {
			counts = {}, claims = {}, opponents = {}, pending = {}, rewardVersion = 2,
		})
		character:SetData("knownProgressionTopics", {[stockID] = true, [unrelated] = true})
		local record = ix.progression.GetCharacterProgression(character)
		for _, parent in ipairs(ix.progression.definitions[nextID].prerequisites) do
			record.lines[parent] = {completed = true, completionRewardsPaid = true}
		end
		record.lines[stockID] = {
			active = true, requirements = {value_bolts = 3}, complexData = {value_bolts = 1},
			rewardCredit = {money = 100, reputation = 10},
		}
		record.lines[unrelated] = {active = true}
		if successorState ~= "missing" then
			record.lines[nextID] = {
				active = successorState == "partial", completed = successorState == "completed",
				completionRewardsPaid = successorState == "completed",
				requirements = {value_nuts = 3}, complexData = {value_nuts = 1}, requirementPolicy = 4,
			}
		end
		ix.progression.SetCharacterProgression(character, record)
		ix.townNPCs:InitializeTownCharacter(character)
		local skipped = ix.progression.GetLine(character, stockID)
		check(skipped.active == false and skipped.skipped and not skipped.completed,
			"active retired stock is skipped without a rewarded completion")
		check(skipped.complexData.value_bolts == 1 and skipped.rewardCredit.money == 100,
			"retired contributions and credit remain saved history")
		check(character.money == 0 and not character.reputation, "skipping pays no completion rewards")
		check(ix.progression.GetLine(character, unrelated).active, "another contact's stock step is unchanged")
		if successorState == "completed" then
			check(ix.progression.IsCompleted(character, nextID)
				and not ix.progression.IsActive(character, nextID), "completed suits are never reopened")
		else
			check(ix.progression.IsActive(character, nextID), "the following suit becomes active")
			check(character:GetData("knownProgressionTopics")[nextID], "a discussed stock step reveals its successor")
			check(not ix.progression.IsCompleted(character, nextID), "the suit itself still requires its delivery")
		end
		if successorState ~= "missing" then
			check(ix.progression.GetRequirements(character, nextID).value_nuts == 3
				and ix.progression.GetComplexProgressionValue(character, nextID).value_nuts == 1,
				"saved successor requirements and contributions survive")
		end
		local saves = character.saves
		ix.townNPCs:InitializeTownCharacter(character)
		check(character.saves == saves and character.money == 0, "reinitializing does not migrate or pay twice")
	end
end

local targetID = ix.townNPCs:StepID("technut", "v3/suits/suit_trenchcoat_black")
local stockID = targetID .. "/stock"
for _, oldState in ipairs({"inactive", "completed", "undiscussed"}) do
	local character = context.fixture.character()
	local record = ix.progression.GetCharacterProgression(character)
	record.lines[stockID] = {active = oldState ~= "inactive", completed = oldState == "completed"}
	ix.progression.SetCharacterProgression(character, record)
	ix.townNPCs:InitializeTownCharacter(character)
	check(not ix.progression.IsActive(character, targetID), "skipping cannot bypass missing suit prerequisites")
	check(not character:GetData("knownProgressionTopics", {})[targetID], "undiscussed requests stay undiscovered")
	local line = ix.progression.GetLine(character, stockID)
	check((line.skipped == true) == (oldState == "undiscussed"), "only active unfinished stock is migrated")
	if oldState == "completed" then
		check(line.completed and line.active, "completed historical stock is unchanged")
	end
end

local fresh = context.fixture.character()
ix.townNPCs:InitializeTownCharacter(fresh)
check(not ix.progression.IsActive(fresh, targetID), "fresh characters cannot skip suit progression")
print("PASS: " .. checks .. " Technut stock skip checks")
