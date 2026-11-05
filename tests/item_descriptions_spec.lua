-- Run from the addon root: luatex --luaonly tests/item_descriptions_spec.lua
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

local function literalFields(source, field)
	local values = {}
	local lines = {}
	for line in (source .. "\n"):gmatch("([^\n]*)\n") do
		lines[#lines + 1] = line
	end
	for index, line in ipairs(lines) do
		local expression = line:match("^%s*ITEM%." .. field .. "%s*=%s*(.*)")
		if expression then
			local nextIndex = index + 1
			while lines[nextIndex] and lines[nextIndex]:match("^%s*%.%.") do
				expression = expression .. lines[nextIndex]
				nextIndex = nextIndex + 1
			end
			values[#values + 1] = assert(load("return " .. expression))()
		end
	end

	return values
end

local function normalize(value)
	return value:lower():gsub("%p", " "):gsub("%s+", " "):match("^%s*(.-)%s*$")
end

local items = 0
local function scan(directory)
	for name in lfs.dir(directory) do
		if name ~= "." and name ~= ".." then
			local path = directory .. "/" .. name
			if lfs.attributes(path, "mode") == "directory" then
				scan(path)
			elseif path:find("/items/", 1, true) and name:match("%.lua$")
				and not path:find("/items/base/", 1, true) then
				local source = read(path)
				local descriptions = literalFields(source, "description")
				local longdescs = literalFields(source, "longdesc")
				check(#longdescs == 1, path .. " must declare one concrete longdesc")
				local longdesc = longdescs[1]
				check(type(longdesc) == "string" and longdesc:find("%S"), path .. " has no longdesc prose")
				check(not longdesc:lower():find("placeholder", 1, true), path .. " has placeholder text")
				local description = descriptions[1] and normalize(descriptions[1])
				if description and description ~= "" then
					check(not normalize(longdesc):find(description, 1, true), path .. " repeats its description")
				end
				items = items + 1
			end
		end
	end
end
scan("gamemodes/ix_cotz/schema/items")
scan("gamemodes/ix_cotz/plugins")
check(items > 1200, "catalogue scan must include schema and plugin items")

local cardProse = literalFields(read("gamemodes/ix_cotz/plugins/playingcards/sh_plugin.lua"), "longdesc")
check(#cardProse == 2 and cardProse[1] ~= "" and cardProse[2] ~= "", "generated cards and decks have prose")
local cardDescriptions = literalFields(read("gamemodes/ix_cotz/plugins/playingcards/sh_plugin.lua"), "description")
for index, prose in ipairs(cardProse) do
	check(not prose:find(cardDescriptions[index], 1, true), "generated card prose extends its identification")
end

-- Exercise the actual description methods without running unrelated gameplay code.
ix = {meta = {item = {}}, taskRewards = {IsTaskKit = function() return true end}, util = {}}
Format = string.format
function ix.util.GetLongLatFromVector() return {1, 2} end
function ix.util.GetHeadingFromAngle() return "North" end
math.Round = function(value) return value end
Vector = function(...) return {...} end
string.SetChar = function(value) return value end

local function method(path, declaration)
	local source = read(path)
	local start = assert(source:find(declaration or "function ITEM:GetDescription()", 1, true))
	local finish = assert(source:find("\nend", start, true)) + 3
	local snippet = source:sub(start, finish):gsub("!=", "~="):gsub("!", "not ")
	-- GMod supports numeric string indexing; standalone Lua does not.
	snippet = snippet:gsub("stashstring%[1%]", "stashstring:sub(1, 1)")
	ITEM = {}
	assert(load(snippet, "@" .. path))()

	return ITEM.GetDescription or ix.meta.item.GetDescription
end

local item = {description = "Short identification.", longdesc = "Additional background.", data = {}}
function item:GetData(key, fallback)
	if self.data[key] ~= nil then return self.data[key] end

	return fallback
end
function item:GetID() return 1 end
function item:GetOwner()
	return {GetPos = function() return {} end, GetAngles = function() return {} end}
end
local combined = item.description .. "\n\n" .. item.longdesc
local schema = method("gamemodes/ix_cotz/schema/meta/sh_item.lua", "function ix.meta.item:GetDescription()")
check(schema(item) == combined, "generic inventory items append their longdesc")
item.data.description = "Saved identification."
check(schema(item) == "Saved identification.\n\n" .. item.longdesc, "generic saved descriptions are preserved")
item.entity = {}
check(schema(item) == item.data.description, "generic world items retain their short saved description")
item.entity, item.data.description = nil, nil
local longdesc = item.longdesc
item.longdesc = nil
check(schema(item) == item.description, "items without longdesc retain their original description")
item.longdesc = longdesc

local cargo = method("gamemodes/ix_cotz/plugins/jobsystem/items/base/sh_jobcargo.lua")
item.data.fieldRecipient, item.data.fieldDescription = "Ledger", "Saved cargo identification."
check(cargo(item) == "Saved cargo identification.\n\n" .. item.longdesc .. "\nDeliver this to Ledger.",
	"cargo keeps saved identification, background, and recipient instructions")
item.entity = {}
check(cargo(item) == "Saved cargo identification.\nDeliver this to Ledger.", "world cargo omits extra prose")
item.entity, item.data.fieldRecipient, item.data.fieldDescription = nil, nil, nil
check(cargo(item) == combined .. "\nReturn this to the contact who issued your assignment.",
	"unaddressed cargo retains its fallback instructions")
local parcel = method("gamemodes/ix_cotz/plugins/jobsystem/items/jobcargo/sh_job_dead_drop_parcel.lua")
check(parcel(item):find(combined, 1, true) == 1 and parcel(item):find("Use Field work", 1, true),
	"dead-drop parcels retain prose and PDA delivery instructions")

local kit = method("gamemodes/ix_cotz/schema/items/base/sh_kits.lua")
check(kit(item):find(combined, 1, true) == 1 and kit(item):find("Redeem at an NPC", 1, true),
	"task supply kits retain prose and redemption instructions")
ix.taskRewards.IsTaskKit = function() return false end
check(kit(item) == combined, "ordinary openable kits retain their background")
local pda = method("gamemodes/ix_cotz/plugins/pda/items/pda/sh_pda.lua")
item.data.avatar, item.data.nickname = "chosen/avatar.png", "FieldName"
check(pda(item):find(combined, 1, true) == 1 and pda(item):find("chosen/avatar.png", 1, true)
	and pda(item):find("FieldName", 1, true), "PDA prose preserves avatar and nickname")
item.entity = {}
check(pda(item) == item.description, "world PDA keeps its short description")
item.entity = nil
local identity = method("gamemodes/ix_cotz/schema/items/miscellaneous/sh_identitycard.lua")
item.data.customDesc = "Saved identity details."
check(identity(item) == item.data.customDesc .. "\n\n" .. item.longdesc,
	"identification cards retain saved details alongside background")
item.data.customDesc = nil
check(identity(item) == combined, "unassigned identification cards retain their default identification")

for _, name in ipairs({"compass", "gpstracker", "gasanalyzer", "rfreceiver", "dataextractor",
	"stashpackage", "stashpackage_heavy", "stashpackage_veryheavy"}) do
	local describe = method("gamemodes/ix_cotz/plugins/inworldtasks/items/miscellaneous/sh_" .. name .. ".lua")
	item.data.stashdata = {"field site", {}}
	check(describe(item):find(combined, 1, true) == 1, name .. " includes prose before live information")
	item.entity = {}
	check(describe(item) == item.description, name .. " keeps world descriptions short")
	item.entity = nil
end
for index = 1, 3 do
	local describe = method("gamemodes/ix_cotz/plugins/hidestashspawner/items/miscellaneous/sh_hidestash_"
		.. index .. ".lua")
	check(describe(item) == combined, "unread stash clue includes background")
	item.data.stashtext = "Beside the old pump."
	check(describe(item):find(combined, 1, true) == 1
		and describe(item):find(item.data.stashtext, 1, true), "read stash clue retains its saved location")
	item.data.stashtext = nil
end

print(string.format("item_descriptions_spec: %d checks passed across %d concrete items", checks, items))
