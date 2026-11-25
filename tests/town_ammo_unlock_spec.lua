-- Run from the repository root: luatex --luaonly tests/town_ammo_unlock_spec.lua
local context = dofile("tests/helpers/townnpcs.lua")
local checks = 0
local function check(value, message)
	checks = checks + 1
	assert(value, message)
end

local ammoSteps = 0
for slug, contact in pairs(ix.townNPCs.contacts) do
	for _, step in ipairs(contact.progression) do
		if step.intermissionFor and not step.stock then
			ammoSteps = ammoSteps + 1
			local gunID = ix.townNPCs:StepID(slug, step.intermissionFor)
			local ammoID = ix.townNPCs:StepID(slug, step.id)
			local definition = ix.progression.definitions[ammoID]
			check(#definition.prerequisites == 1 and definition.prerequisites[1] == gunID,
				"an ammunition unlock requires only its gun unlock: " .. ammoID)
			for _, other in ipairs(contact.progression) do
				for _, required in ipairs(other.requires) do
					check(required ~= step.id, "ammunition unlocks gate no later milestone: " .. ammoID)
				end
			end
			check(#definition.vendorUnlocks == 1, "an ammunition unlock opens exactly one sale: " .. ammoID)
			local unlock = definition.vendorUnlocks[1]
			local expected = unlock.args[1] == "12gauge" and 2 or 4
			check(unlock.args[3] == expected and unlock.args[5] == expected,
				"initial and maximum stock follow Brass's default for " .. unlock.args[1])
			local owner = context.fixture.character()
			check(not ix.progression.IsActive(owner, ammoID), "ammunition stays closed before its gun: " .. ammoID)
			check(not ix.progression.CanBuyItem(owner, contact.name, unlock.args[1]), "no purchase before delivery: " .. ammoID)
		end
	end
end
check(ammoSteps == 25, "all 25 missing gun calibres have an ammunition unlock")

-- Haggler: unlocking the sawn-off BM-16 opens the buckshot delivery, and the delivery opens the sale.
local gun = ix.townNPCs:StepID("haggler", "v3/pact-cqb/toz66short")
local ammo = ix.townNPCs:StepID("haggler", "v3/pact-cqb/toz66short/ammo")
local owner = context.fixture.character()
local state = ix.progression.GetCharacterProgression(owner)
state.lines[gun] = {completed = true}
ix.progression.SetCharacterProgression(owner, state)
ix.progression.AssignActiveRequirements(owner)
check(ix.progression.IsActive(owner, ammo), "a completed gun unlock opens its ammunition branch retroactively")
check(not ix.progression.CanBuyItem(owner, "'Haggler'", "12gauge"), "opening the branch is not purchase access")
state = ix.progression.GetCharacterProgression(owner)
state.lines[ammo] = {completed = true}
ix.progression.SetCharacterProgression(owner, state)
check(ix.progression.CanBuyItem(owner, "'Haggler'", "12gauge"), "completing the delivery opens the ammunition sale")
print("PASS: " .. checks .. " town ammunition unlock checks")
