-- Run from the repository root: luatex --luaonly tests/town_progression_overhaul_spec.lua
local context = dofile("tests/helpers/townnpcs.lua")
local checks = 0
local function check(value, message)
	checks = checks + 1
	assert(value, message)
end
local function stepID(contact, branch, item)
	return ix.townNPCs:StepID(contact, "v3/" .. branch .. "/" .. item)
end
local function complete(character, id)
	local record = ix.progression.GetCharacterProgression(character)
	record.lines[id] = {completed = true}
	ix.progression.SetCharacterProgression(character, record)
end

ix.townNPCs:BuildJobs()
local errors = ix.townNPCs:ValidateContacts()
check(#errors == 0, table.concat(errors, "\n"))
local total = ix.progression.AuditDefinitions()
check(total > 400, "all new town and standalone definitions pass the real graph and pool audit")
local fresh = context.fixture.character()
for slug, contact in pairs(ix.townNPCs.contacts) do
	local branches = {}
	for _, step in ipairs(contact.progression) do
		check(step.id:sub(1, 3) == "v3/", "new milestones never reuse old completion IDs")
		check(step.kind == "delivery" and #step.requirements > 0, "all finite unlocks use themed hand-ins")
		check(not step.discounts and not step.benefits, "removed town credits and discounts cannot return")
		local id = ix.townNPCs:StepID(slug, step.id)
		if not branches[step.branch] then
			check(#step.requires == 0, "each branch starts independently of sibling branches")
			branches[step.branch] = true
		end
		for _, required in ipairs(step.requires) do
			check(ix.townNPCs.steps[ix.townNPCs:StepID(slug, required)].branch == step.branch,
				"local prerequisites remain inside their branch")
		end
		for index, slot in ipairs(step.requirements) do
			check(ix.progression.definitions[id].requirementSlots[index].quantity
				== math.ceil(slot.quantity * contact.difficultyMultiplier), "effort is scaled exactly once")
		end
	end
	for _, item in ipairs(contact.supplies) do
		check(ix.progression.CanBuyItem(fresh, contact.name, item), "starter stock is available immediately")
	end
	for item in pairs(contact.catalogue) do
		check(not item:match("^meal_") and not item:match("^meat_"), "meals and meat are never town sale stock")
		check(not ix.townNPCs.ammoVariants[item] or not (item:match("hp$") or item:match("ap$")),
			"HP/AP ammunition has no town cash route")
	end
end
for item, seller in pairs({makarov = "gasket", mp153 = "haggler", akm = "vesper",
	mp5 = "smartass", fnfal = "quartermaster", sako85 = "spoor", suit_seva = "egghead",
	suit_skat9 = "technut", backpack_2_large = "wake", drug_morphine = "spool",
	attachment_kevlar_2 = "suture", pso1 = "beanstalk", detectorveles = "intern"}) do
	check(ix.townNPCs.canonicalSellers[item] == seller, "the approved specialist owns " .. item)
end
for _, item in ipairs({"ij600", "lax410", "ruger1022", "walkman", "cassette_standart",
	"sharpening_stone", "sharpening_stone_fine", "hidestasher_cutlery"}) do
	for _, contact in pairs(ix.townNPCs.contacts) do
		check(not contact.catalogue[item], "deferred or job-awarded item stays outside progression sales")
	end
end
for _, item in ipairs({"meal_boar", "meat_boar", "meal_human", "meat_human"}) do
	check(not ix.progression.CanBuyItem(fresh, "Unrelated vendor", item), "non-town NPCs cannot sell meat or meals")
end
local technut = ix.townNPCs.contacts.technut
for _, colour in ipairs({"brown", "green", "tan"}) do
	check(technut.catalogue["suit_trenchcoat_" .. colour].step == technut.catalogue.suit_trenchcoat_black.step,
		"all trenchcoat colours share a purchase unlock")
end
local weight, rows = 0, 0
for slug, contact in pairs(ix.townNPCs.contacts) do
	for _, step in ipairs(contact.progression) do
		if step.capacity then
			check(slug == "wake", "only Wake awards permanent capacity")
			if step.capacity.kind == "weight" then weight = weight + step.capacity.amount
			else rows = rows + step.capacity.amount end
		end
	end
end
check(weight == 5 and rows == 2, "moving capacity preserves the existing +5 kg and +2 rows limits")
local known = context.fixture.character()
complete(known, "cotz/town/gasket/GA01")
complete(known, "cotz/town/ballast/BA12")
check(not ix.progression.CanBuyItem(known, "'Gasket'", "tokarev"), "old completion cannot authorize the new gun branch")
check(not ix.townNPCs:HasService(known, "storage"), "old bank completion cannot restore a retired service")
known:SetData("progressionServiceCredits", {["'Technut'/repair"] = 500})
check(ix.progression.GetServiceCredit(known, "'Technut'", "repair") == 0
	and ix.progression.ServiceCreditCapacity(known, "'Technut'", "repair") == 0,
	"old town credit remains inactive and cannot be awarded again")
check(not ix.progression.npcRequirements["'Computer'"], "Computer has no orphaned town progression gate")
check(ix.townNPCs:HasService(fresh, "suitVariants", "'Suture'"), "Suture's conversion menu starts available")
check(not ix.townNPCs:HasService(fresh, "suitVariants", "'Vesper'"), "the former converter cannot retain the service")
check(not ix.townNPCs:HasService(fresh, "painting"), "painting retains a Technut unlock")
complete(fresh, stepID("technut", "painting", "painting"))
check(ix.townNPCs:HasService(fresh, "painting", "'Technut'"), "Technut still owns painting")
check(not ix.townNPCs:IsContactCompleted(fresh, technut),
	"finishing one independent branch cannot select the whole-contact completion greeting")
for item, allocation in pairs(ix.townNPCs.variantUnlocks) do
	check(allocation.contact == "suture" and not item:match("_looted$"), "all non-looted conversion unlocks belong to Suture")
end
local hp = stepID("brass", "hp-ammo", "9x19hp")
local ap = stepID("carbon", "ap-ammo", "9x19ap")
local regular = stepID("brass", "regular-ammo", "9x19")
local function depends(id, parent)
	for _, required in ipairs(ix.progression.definitions[id].prerequisites) do
		if required == parent then return true end
	end
end
check(depends(hp, regular), "HP requires Brass's regular-calibre milestone even when regular ammo starts in stock")
check(depends(ap, hp), "Carbon AP requires the matching HP completion at Brass")
check(ix.townNPCs.ammoExchanges["9x19hp"].boxes == 2
	and ix.townNPCs.ammoExchanges["9x19ap"].boxes == 3, "exchanges use the approved 2:1 and 3:1 ratios")
local previous
for _, item in ipairs(ix.townNPCs.regularAmmoChain) do
	local id = stepID("brass", "regular-ammo", item)
	check(ix.progression.definitions[id] ~= nil, "every authored calibre retains a Brass milestone")
	if previous then check(depends(id, previous), "regular ammo follows the authored chain exactly") end
	previous = id
end
local loads = {"12gaugetr", "12gaugedt", "12gaugemg"}
for index = 2, #loads do
	check(depends(stepID("brass", "shotgun-loads", loads[index]), stepID("brass", "shotgun-loads", loads[index - 1])),
		"special shotgun loads follow TR, DT, MG")
end
local old = context.fixture.character()
old:SetData("townNPCProgression", {counts = {}, claims = {}, opponents = {}, pending = {
	["'Ballast'"] = {identifier = "cotz/town/commission/ballast/BA02", serial = 1},
}, rewardVersion = 2})
ix.townNPCs:InitializeTownCharacter(old)
check(old:GetData("townNPCProgression").pending["'Ballast'"] ~= nil, "old pending commissions remain inactive history")
check(not ix.progression.IsCompleted(old, stepID("ballast", "hideout", "01")), "old work never completes a new branch")
local cans = {}
for _, package in ipairs(ix.townNPCs.contacts["spicy-lemon"].rewards.packages) do
	for _, item in ipairs(package.items) do if item:match("^food_can_") then cans[item] = true end end
end
check(cans.food_can_tushonka and cans.food_can_sprats and cans.food_can_tuna, "Spicy Lemon's jobs cover all canned-food families")
print("PASS: " .. checks .. " town progression overhaul checks")
