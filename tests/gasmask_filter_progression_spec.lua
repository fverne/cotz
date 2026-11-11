-- Run from the addon root: luatex --luaonly tests/gasmask_filter_progression_spec.lua
local context = dofile("tests/helpers/townnpcs.lua")
local town = ix.townNPCs
local checks = 0
local function check(condition, message)
	checks = checks + 1
	assert(condition, message)
end

local function read(path)
	local file = assert(io.open(path))
	local source = file:read("*a")
	file:close()

	return source
end

local function putLine(character, id, line)
	local record = ix.progression.GetCharacterProgression(character)
	record.lines[id] = line
	ix.progression.SetCharacterProgression(character, record)
end

local function completeParents(character, id)
	for _, parent in ipairs(ix.progression.definitions[id].prerequisites) do
		completeParents(character, parent)
		putLine(character, parent, {completed = true, completionRewardsPaid = true})
	end
end

local routes = {
	latch = {civilian = "mask_halfmask", military = "mask_eo20", scientific = "mask_m40"},
	boss = {military = "headwear_cs4", scientific = "headwear_screen"},
}
local maskTypes = {}
local files = assert(io.popen("rg --files gamemodes/ix_cotz/schema/items/gear"))
for path in files:lines() do
	local source = read(path)
	local tier = source:match('ITEM.filterType = "([^"]+)"')
	if tier then maskTypes[path:match("/sh_([^/]+)%.lua$")] = tier end
end
files:close()

local function dependsOn(id, required, seen)
	if id == required then return true end
	seen = seen or {}
	if seen[id] then return false end
	seen[id] = true
	for _, parent in ipairs(ix.progression.definitions[id].prerequisites) do
		if dependsOn(parent, required, seen) then return true end
	end

	return false
end

local maskCount, filterCount = 0, 0
for slug, contact in pairs(town.contacts) do
	for itemID, allocation in pairs(contact.catalogue) do
		local tier = maskTypes[itemID]
		if tier then
			maskCount = maskCount + 1
			local filterID = "gasmask_filter_" .. tier
			local filterAllocation = contact.catalogue[filterID]
			check(filterAllocation, "every active mask seller supplies its required filter: " .. slug .. "/" .. itemID)
			local purchase = town:StepID(slug, allocation.step)
			local filter = town:StepID(slug, filterAllocation.step)
			check(dependsOn(purchase, filter), "every unfinished mask purchase follows its local filter: " .. itemID)
		end
		if itemID:match("^gasmask_filter_") then
			filterCount = filterCount + 1
			check(routes[slug] and routes[slug][itemID:match("^gasmask_filter_(.+)$")],
				"only sellers of matching masks receive filter stock")
		end
	end
end
check(maskCount == 14 and filterCount == 5, "all fourteen mask routes and five local filter unlocks are covered")
check(#town:ValidateContacts() == 0, "new stock, requirements and local references validate")
check(ix.progression.AuditDefinitions() > 0, "compiled progression graph remains valid and acyclic")

for slug, tiers in pairs(routes) do
	local contact = town.contacts[slug]
	for tier, maskID in pairs(tiers) do
		local filterID = "gasmask_filter_" .. tier
		local allocation = contact.catalogue[filterID]
		local filter = town:StepID(slug, allocation.step)
		local mask = town:StepID(slug, contact.catalogue[maskID].step)
		local maskIndex
		for index, step in ipairs(contact.progression) do
			if step.id == contact.catalogue[maskID].step then maskIndex = index end
		end
		local step = contact.progression[maskIndex - 1]
		check(step.id == allocation.step, "filter delivery immediately precedes its first mask: " .. slug .. "/" .. tier)
		check(step.defaultActive == true, "returning characters can start inserted stages after old parents")
		check(step.briefing:find("[Ff]ilter") or step.briefing:find("cartridge"), "filter delivery explains its purpose")
		check(not step.stock and not step.benefits, "filter stage grants purchase access rather than a stock bonus or gift")
		check(allocation.terms[2] == 4 and allocation.terms[4] == 4 and allocation.terms[6] == 1,
			"filter stock has explicit initial, maximum and refill quantities")
		local character = context.fixture.character()
		completeParents(character, filter)
		check(ix.progression.IsActive(character, filter), "old prerequisites activate a newly inserted filter stage")
		check(not ix.progression.IsActive(character, mask), "the following mask waits for its filter delivery")
		check(not ix.progression.CanBuyItem(character, contact.name, filterID), "filter purchase starts locked")
		ix.progression.DiscoverTopics(character, contact.name)
		check(character:GetData("knownProgressionTopics")[filter], "the new stage is discovered through the NPC")
		ix.progression.SetCompleted(character, filter)
		check(ix.progression.CanBuyItem(character, contact.name, filterID), "completing the stage permits filter purchase")
		check(ix.progression.IsActive(character, mask), "completing the filter stage opens the mask delivery")
		check(not ix.progression.CanBuyItem(character, contact.name, maskID), "filter delivery does not grant the mask")
		ix.progression.SetCompleted(character, mask)
		check(ix.progression.CanBuyItem(character, contact.name, maskID), "the retained mask milestone grants its purchase")

		local returning = context.fixture.character()
		completeParents(returning, filter)
		putLine(returning, mask, {completed = true, completionRewardsPaid = true})
		ix.progression.AssignActiveRequirements(returning)
		check(ix.progression.IsCompleted(returning, mask) and not ix.progression.IsActive(returning, mask),
			"completed mask milestones remain completed")
		check(ix.progression.CanBuyItem(returning, contact.name, maskID), "existing earned mask access is preserved")
		check(ix.progression.IsActive(returning, filter), "existing mask owners can complete their new filter delivery")
		check(returning.money == 0, "inserting a stage never replays old completion payments")

		local partial = context.fixture.character()
		completeParents(partial, filter)
		local pool = ix.progression.definitions[mask].requirementSlots[1].pool
		local candidate = ix.progression.itemPools[pool].candidates[1].item
		putLine(partial, mask, {
			active = true, requirements = {[candidate] = 4}, complexData = {[candidate] = 1},
			requirementPolicy = 4, requirementModesVersion = 1, rewardCredit = {money = 12.5},
		})
		ix.progression.AssignActiveRequirements(partial)
		local line = ix.progression.GetLine(partial, mask)
		check(line.requirements[candidate] == 4 and line.complexData[candidate] == 1 and line.rewardCredit.money == 12.5,
			"pending mask requirements, partial hand-ins and accrued value are preserved")
		check(not ix.progression.IsActive(partial, mask), "saved active mask requests still wait for the new filter stage")
		ix.progression.SetCompleted(partial, filter)
		check(ix.progression.IsActive(partial, mask), "filter completion resumes a partially delivered mask request")
	end
end

for _, tier in ipairs({"military", "scientific"}) do
	local character = context.fixture.character()
	local filterID = "gasmask_filter_" .. tier
	putLine(character, town:StepID("boss", town.contacts.boss.catalogue[filterID].step), {completed = true})
	check(ix.progression.CanBuyItem(character, "'Boss'", filterID), "Boss grants his own filter purchase entitlement")
	check(not ix.progression.CanBuyItem(character, "'Latch'", filterID), "Boss filter completion does not unlock Latch")
end
check(not ix.progression.CanBuyItem(context.fixture.character(), "'Cleaner'", "mask_gp5"),
	"Cleaner's stale template masks are not active sale routes")
check(not ix.progression.CanBuyItem(context.fixture.character(), "'Beanstalk'", "headwear_screen"),
	"Beanstalk's stale Screen template is not an active sale route")

-- Exercise the actual template compiler and refresh path used for saved vendors.
PLUGIN = {}
ix.npctemplates = {templates = {}}
ix.vendorStock = {ApplyDefaults = function() end}
dofile("gamemodes/ix_cotz/plugins/vendor_adv/libs/sh_towncontacts.lua")
local vendors = PLUGIN
for slug, tiers in pairs(routes) do
	local contact = town.contacts[slug]
	ix.npctemplates.templates[contact.template] = {items = {}}
	local catalogue = town.catalogues[contact.name]
	vendors:ConfigureTownTemplate(contact, catalogue, town.settings.supplyStock)
	local saved = {items = {}, GetBuyAll = function() return false end, SetBuyAll = function() end}
	vendors:RefreshTownVendor(saved, contact, catalogue, town.settings.supplyStock)
	for tier in pairs(tiers) do
		local filterID = "gasmask_filter_" .. tier
		local row = ix.npctemplates.templates[contact.template].items[filterID]
		check(row and row[2] == 4 and row[3] == 1 and row[4] == 4 and row[5] == 12 and row[6] == 1,
			"compiled template contains replenishing filter stock")
		check(saved.items[filterID] and saved.items[filterID][4] == 4,
			"saved vendors gain the filter stock through normal refresh")
	end
end

print("Gasmask filter progression checks passed:", checks)
