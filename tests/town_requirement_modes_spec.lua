-- Run from the addon root: luatex --luaonly tests/town_requirement_modes_spec.lua
local context = dofile("tests/helpers/townnpcs.lua")
local checks, branches, contacts = 0, 0, 0
local function check(value, message)
	checks = checks + 1
	assert(value, message)
end
for slug, contact in pairs(ix.townNPCs.contacts) do
	local chains, opening = {}, {}
	if #contact.progression > 0 then contacts = contacts + 1 end
	for _, step in ipairs(contact.progression) do
		if not step.intermissionFor then
			chains[step.branch] = chains[step.branch] or {}
			local chain = chains[step.branch]
			chain[#chain + 1] = step.id
		end
	end
	for _, chain in pairs(chains) do
		branches = branches + 1
		for index = 1, math.ceil(#chain / 5) do opening[chain[index]] = true end
	end
	for _, step in ipairs(contact.progression) do
		local id = ix.townNPCs:StepID(slug, step.id)
		local compiled = ix.progression.definitions[id]
		-- Wake's optional capacity purchases are independent one-step chains despite shared branch labels.
		local categoryOnly = opening[step.intermissionFor or step.id] == true or step.capacity ~= nil
		check(compiled.categoryOnly == categoryOnly, "the compiler preserves the actual opening boundary: " .. id)
		check(compiled.requirementModesVersion == 1, "every finite town contact opts into saved mode migration")
		for index, slot in ipairs(compiled.requirementSlots) do
			local specific = not categoryOnly and not step.intermissionFor and index == #compiled.requirementSlots
			check(slot.mode == (specific and "random" or "any"), "compiled slot mode matches its chain position")
		end
	end
end
check(contacts == 25 and branches == 52, "all finite town contacts and independent branches are covered")
ix.progression.AuditDefinitions()
local fresh = context.fixture.character()
ix.progression.AssignActiveRequirements(fresh)
local mail = ix.townNPCs:StepID("technut", "v3/suits/suit_mailjacket")
local line = ix.progression.GetLine(fresh, mail)
check(line.selections[1].mode == "any" and #line.selections[1].choices > 1,
	"Technut begins with a genuinely broad category")
for _, itemID in ipairs(line.selections[1].choices) do
	check(not itemID:match("^value_techtool_"), "introductory workshop stock avoids rare toolbox requirements")
end
print("PASS: " .. checks .. " compiled town requirement mode checks")
