-- Run from the repository root: luatex --luaonly tests/gear_customization_spec.lua
local checks = 0
local function check(value, message)
	checks = checks + 1
	assert(value, message)
end

local function copy(value)
	if type(value) ~= "table" then return value end
	local result = {}
	for key, entry in pairs(value) do result[key] = copy(entry) end

	return result
end

local function serialize(value)
	if type(value) ~= "table" then return tostring(value) end
	local keys, parts = {}, {}
	for key in pairs(value) do keys[#keys + 1] = key end
	table.sort(keys, function(first, second) return tostring(first) < tostring(second) end)
	for _, key in ipairs(keys) do parts[#parts + 1] = tostring(key) .. ":" .. serialize(value[key]) end

	return "{" .. table.concat(parts, ",") .. "}"
end

table.Copy = copy
table.GetKeys = function(value)
	local result = {}
	for key in pairs(value) do result[#result + 1] = key end

	return result
end
local now = 10
CurTime = function() return now end
IsValid = function(value) return type(value) == "table" and value.valid == true end
util = {AddNetworkString = function() end, TableToJSON = serialize, CRC = function(value) return value end}
ix = {pac = {}, plugin = {}, util = {GetMaterial = function() end}}
local paintAllowed = true
ix.townNPCs = {HasService = function(_, _, name, npc)
	return paintAllowed and name == "painting" and npc == "'Technut'"
end}
local equipment = {GetPending = function() end}
ix.plugin.Get = function(id) if id == "equipmentslots" then return equipment end end
net = {callbacks = {}}
net.Receive = function(name, callback) net.callbacks[name] = callback end
local wire, cursor = {}, 1
for _, kind in ipairs({"String", "UInt", "Bool", "Entity"}) do
	net["Write" .. kind] = function(value) wire[#wire + 1] = value end
	net["Read" .. kind] = function() local value = wire[cursor] cursor = cursor + 1 return value end
end
net.Start = function() wire, cursor = {}, 1 end
net.Send = function() end
local root = "gamemodes/ix_cotz/plugins/gearcustomization/"
dofile(root .. "sh_appearance.lua")
PLUGIN = {}
dofile(root .. "sv_service.lua")
local service = PLUGIN

local config = {
	targets = {{1, 1}, {1, 2, 1}}, defaultSkin = "green", worldMaterialSlots = {0},
	skins = {
		{id = "green", name = "Green", skin = 2, worldSkin = 0},
		{id = "black", name = "Black", skin = 4, worldSkin = 1, worldMaterials = {[0] = "gear/black"}},
	},
	bodygroups = {{id = "cover", name = "Cover", group = "cover", default = "open", options = {
		{id = "open", name = "Open", value = 0, worldValue = 0},
		{id = "closed", name = "Closed", value = 1, worldValue = 1},
	}}},
}
local template = {
	appearanceCustomization = config, model = "gear.mdl", skin = 0, uniqueID = "helmet",
	pacData = {{self = {ClassName = "group", UniqueID = "root"}, children = {
		{self = {ClassName = "model2", Model = "helmet.mdl", Skin = 2, UniqueID = "shell"}, children = {}},
		{self = {ClassName = "model", Model = "unrelated.mdl", Skin = 7, UniqueID = "other"}, children = {
			{self = {ClassName = "model2", Model = "helmet.mdl", Skin = 2, AimPartUID = "shell"}, children = {}},
		}},
	}}},
}
local function fixture(id)
	local state = {equip = true}
	local item = setmetatable({id = id or 1, invID = 10}, {__index = template})
	function item:GetData(key, default) if state[key] == nil then return default end return state[key] end
	function item:SetData(key, value) state[key] = copy(value) self.writes = (self.writes or 0) + 1 end
	function item:GetID() return self.id end
	local inventory = {items = {[item.id] = item}, GetID = function() return 10 end}
	function inventory:GetItems() return self.items end
	local character = {money = 500, saves = 0, charges = 0, GetInventory = function() return inventory end}
	function character:HasMoney(amount) return self.money >= amount end
	function character:TakeMoney(amount) self.money = self.money - amount self.charges = self.charges + 1 end
	function character:Save() self.saves = self.saves + 1 end
	local position = {distance = 0}
	function position:DistToSqr() return self.distance end
	local client = {valid = true, character = character, alive = true, parts = 0}
	function client:GetCharacter() return self.character end
	function client:Alive() return self.alive end
	function client:GetPos() return position end
	function client:GetNetVar() return self.blackScreen end
	function client:AddPart(_, instance) self.parts = self.parts + 1 self.partItem = instance end
	local vendor = {valid = true, dialogueid = "technpc", access = true, name = "'Technut'"}
	function vendor:GetClass() return "ix_vendor_adv" end
	function vendor:GetDisplayName() return self.name end
	function vendor:CanAccess() return self.access end
	function vendor:GetPos() return {} end

	return client, vendor, item, character, inventory, state, position
end

local client, vendor, item = fixture()
local selected = {skin = "black", bodygroups = {cover = "closed"}}
check(ix.gearAppearance.ValidateDefinition(item), "Explicit targets and defaults validate")
check(ix.gearAppearance.IsSupported(item), "Wearable alternatives enable customization")
check(ix.gearAppearance.Normalize(item).skin == "green", "Legacy instances use the declared factory skin")
check(not ix.gearAppearance.Normalize(item, {skin = "999"}, true), "Unknown skin IDs are rejected")
check(not ix.gearAppearance.Normalize(item, {skin = "black", bodygroups = {cover = "bad"}}, true),
	"Unapproved bodygroup values are rejected")
check(not ix.gearAppearance.Normalize(item, {skin = "black", bodygroups = {cover = "open", extra = "x"}}, true),
	"Extra bodygroup IDs are rejected")
item:SetData("gearAppearance", {skin = "retired", bodygroups = {cover = "removed"}})
check(ix.gearAppearance.Normalize(item).skin == "green" and item:GetData("gearAppearance").skin == "retired",
	"Removed options fall back visually without rewriting saves")
local original = serialize(item.pacData)
local tree = ix.gearAppearance.BuildPAC(item, selected, "player1:1")
check(tree[1].children[1].self.Skin == 4 and tree[1].children[2].children[1].self.Skin == 4,
	"All explicitly targeted clipped copies receive the selected skin")
check(tree[1].children[2].self.Skin == 7, "Unrelated compound-outfit models retain their skin")
check(tree[1].children[1].children[1].self.ModelIndex == 1, "Bodygroup selections generate PAC bodygroup parts")
check(tree[1].children[2].children[1].self.AimPartUID == tree[1].children[1].self.UniqueID,
	"Internal PAC references follow remapped instance identities")
local other = ix.gearAppearance.BuildPAC(item, selected, "player2:2")
check(tree[1].self.UniqueID ~= other[1].self.UniqueID, "Instances and wearers cannot share root identities")
check(serialize(item.pacData) == original, "Preview/rendering never mutates item definitions")
local bodyOnly = copy(template)
bodyOnly.appearanceCustomization.skins = {}
bodyOnly.appearanceCustomization.defaultSkin = nil
bodyOnly.GetData = function(_, _, default) return default end
check(ix.gearAppearance.ValidateDefinition(bodyOnly) and ix.gearAppearance.IsSupported(bodyOnly),
	"Future items can expose bodygroup-only customization")
local bodyTree = ix.gearAppearance.BuildPAC(bodyOnly, {skin = "", bodygroups = {cover = "closed"}}, "body-only")
check(bodyTree[1].children[1].self.Skin == 2 and bodyTree[1].children[1].children[1].self.ModelIndex == 1,
	"Bodygroup-only customization preserves the original skin")
bodyOnly.appearanceCustomization.bodygroups[1].options = {}
check(not ix.gearAppearance.ValidateDefinition(bodyOnly), "Empty bodygroup option lists are rejected at startup")
local world = {materials = {}, groups = {}, SetSkin = function(self, skin) self.skin = skin end}
function world:SetSubMaterial(index, material) self.materials[index] = material end
function world:FindBodygroupByName() return 0 end
function world:SetBodygroup(index, value) self.groups[index] = value end
ix.gearAppearance.ApplyWorld(world, item, selected)
check(world.skin == 1 and world.materials[0] == "gear/black" and world.groups[0] == 1,
	"Ground models use explicit skin, submaterial and bodygroup mappings")
ix.gearAppearance.ApplyWorld(world, item, {skin = "green", bodygroups = {cover = "open"}})
check(world.materials[0] == nil and world.groups[0] == 0, "Returning to factory clears prior material overrides")
local _, _, dropped = fixture()
dropped:SetData("gearAppearance", selected)
ix.item = {instances = {[1] = dropped}}
world.ixItemID = 1
world.GetItemTable = function() return template end
service:OnItemSpawned(world)
check(world.skin == 1 and world.materials[0] == "gear/black",
	"World spawning/restoration reads saved instance data instead of the entity's definition API")
net.Start()
ix.gearAppearance.WriteDescriptor({itemID = 123, appearance = selected})
local descriptor = ix.gearAppearance.ReadDescriptor()
check(descriptor.itemID == 123 and descriptor.appearance.bodygroups.cover == "closed",
	"Typed descriptors round-trip without sending PAC tables or inventory contents")
wire, cursor = {"black", 17}, 1
check(not ix.gearAppearance.ReadState(), "Network bodygroup counts are bounded")
wire, cursor = {"black", 2, "cover", "open", "cover", "closed"}, 1
check(not ix.gearAppearance.ReadState(), "Duplicate network fields are rejected")

local character, inventory, state, position
client, vendor, item, character, inventory, state, position = fixture()
local quote = assert(service:CreateQuote(client, vendor, 1, selected))
check(character.money == 500 and item.writes == nil, "Quoting and previewing never charge or save changes")
check(service:Confirm(client, quote.token, true), "Technut customizes after the painting unlock")
check(character.money == 400 and character.charges == 1 and character.saves == 1,
	"One confirmed multi-control change charges 100 rubles once")
check(item:GetData("gearAppearance").skin == "black" and state.equip and client.parts == 1,
	"The existing instance stays equipped and only its PAC visual is refreshed")
check(not service:Confirm(client, quote.token, true) and character.money == 400,
	"Replaying a consumed confirmation cannot charge twice")
check(not service:CreateQuote(client, vendor, 1, selected), "Unchanged selections cannot be purchased")

-- Suit painting shares the quote boundary and keeps the existing saved skin fields.
paintAllowed = false
local lockedClient, lockedVendor = fixture()
check(not service:CanUseVendor(lockedClient, lockedVendor), "the combined service is inaccessible before painting")
check(not service:CreateQuote(lockedClient, lockedVendor, 1, selected), "ordinary gear also requires the unlock")
paintAllowed = true
local lockedQuote = assert(service:CreateQuote(lockedClient, lockedVendor, 1, selected))
paintAllowed = false
check(not service:Confirm(lockedClient, lockedQuote.token, true), "gear confirmation rechecks progression")
local function suitFixture()
	local player, target, suit, owner, inv, data, pos = fixture()
	suit.isBodyArmor, suit.newModel, suit.newSkin = true, "suit.mdl", 0
	suit.appearanceCustomization, suit.pacData = nil, nil
	suit.skincustom = {
		[1] = {name = "Skin 0", skingroup = 0},
		[5] = {name = "Skin 3", skingroup = 3, modelOverride = "alternate.mdl"},
	}
	owner.SetModel = function(self, model) self.model = model end
	player.SetSkin = function(self, skin) self.skin = skin end

	return player, target, suit, owner, inv, data, pos
end
local painter, workshop, suit, wearer, suitInventory, suitData = suitFixture()
local paint = {skin = "3", bodygroups = {}}
check(not ix.gearAppearance.IsSupported(suit), "suit paints do not enter PAC gear descriptor handling")
check(not service:CreateQuote(painter, workshop, 1, paint), "suit painting retains its progression gate")
paintAllowed = true
check(ix.gearAppearance.Normalize(suit).skin == "0", "existing suits use their saved/default skin")
check(not service:CreateQuote(painter, workshop, 1, {skin = "2", bodygroups = {}}),
	"suit painting rejects finishes outside the item's sparse allowlist")
local paintQuote = assert(service:CreateQuote(painter, workshop, 1, paint))
check(suitData.setSkin == nil and wearer.money == 500, "suit preview and quoting preserve saved state and money")
paintAllowed = false
check(not service:Confirm(painter, paintQuote.token, true) and wearer.money == 500,
	"confirmation rechecks the suit painting unlock")
paintAllowed = true
paintQuote = assert(service:CreateQuote(painter, workshop, 1, paint))
check(service:Confirm(painter, paintQuote.token, true), "a confirmed approved suit finish is applied")
check(suitData.setSkin == 3 and suitData.setSkinOverrideModel == "alternate.mdl"
	and wearer.model == "alternate.mdl" and painter.skin == 3,
	"painting preserves the suit's existing skin/model-override persistence")
check(wearer.money == 400 and wearer.charges == 1 and painter.parts == 0 and suitData.gearAppearance == nil,
	"painting charges once and never equips a suit as a PAC part")
check(not service:Confirm(painter, paintQuote.token, true) and wearer.money == 400,
	"suit paint confirmations cannot be replayed")
paintQuote = assert(service:CreateQuote(painter, workshop, 1, {skin = "0", bodygroups = {}}))
check(service:Confirm(painter, paintQuote.token, true) and suitData.setSkinOverrideModel == nil
	and wearer.model == "suit.mdl" and painter.skin == 0,
	"returning to a normal finish clears the old model override")
paintQuote = assert(service:CreateQuote(painter, workshop, 1, paint))
suitData.equip = false
check(not service:Confirm(painter, paintQuote.token, true) and wearer.money == 300,
	"unequipping a quoted suit prevents payment and changes")

local failures = {
	{"insufficient funds", function(_, _, _, char) char.money = 99 end},
	{"lost vendor access", function(_, target) target.access = false end},
	{"wrong vendor", function(_, target) target.name = "'Boss'" end},
	{"wrong dialogue binding", function(_, target) target.dialogueid = "bossnpc" end},
	{"removed vendor", function(_, target) target.valid = false end},
	{"character switch", function(player) player.character = nil end},
	{"death", function(player) player.alive = false end},
	{"unequipped item", function(_, _, _, _, _, data) data.equip = false end},
	{"foreign inventory", function(_, _, instance) instance.invID = 99 end},
	{"removed inventory membership", function(_, _, _, _, inv) inv.items = {} end},
	{"world item", function(_, _, instance) instance.entity = {valid = true} end},
	{"active equipment delay", function(player) player.blackScreen = true end},
	{"excessive distance", function(_, _, _, _, _, _, pos) pos.distance = 192 ^ 2 + 1 end},
	{"expired confirmation", function() now = now + 61 end},
	{"appearance changed", function(_, _, _, _, _, data) data.gearAppearance = copy(selected) end},
	{"definition changed", function(_, _, instance)
		instance.appearanceCustomization = copy(config)
		instance.appearanceCustomization.skins[2].skin = 3
	end},
}
for _, failure in ipairs(failures) do
	client, vendor, item, character, inventory, state, position = fixture()
	quote = assert(service:CreateQuote(client, vendor, 1, selected))
	failure[2](client, vendor, item, character, inventory, state, position)
	local money = character.money
	check(not service:Confirm(client, quote.token, true), "Reject " .. failure[1])
	check(character.money == money and character.charges == 0 and item.writes == nil,
		"Rejected " .. failure[1] .. " preserves cash and item state")
end
client, vendor, item, character = fixture()
equipment.GetPending = function() return {} end
check(not service:CreateQuote(client, vendor, 1, selected), "Pending slot transitions block customization")
equipment.GetPending = function() end
quote = assert(service:CreateQuote(client, vendor, 1, selected))
check(not service:Confirm(client, quote.token, false) and character.money == 500,
	"Cancelling consumes the quote without charging")
local secondClient = fixture(2)
quote = assert(service:CreateQuote(client, vendor, 1, selected))
local secondQuote = assert(service:CreateQuote(secondClient, vendor, 2, selected))
check(quote.token ~= secondQuote.token and service.quotes[client] == quote,
	"Two customers at one vendor have independent confirmations")
check(not service:Confirm(secondClient, quote.token, true), "Another customer's token cannot be used")
local invalidQuote = service:CreateQuote(client, vendor, 1, {skin = "forged", bodygroups = {}})
check(not invalidQuote and not service:Confirm(client, quote.token, true),
	"A new rejected quote invalidates the previous pending purchase")
check(service:AllowRequest(client) and not service:AllowRequest(client), "Server requests are rate limited")
now = now + 0.25
check(service:AllowRequest(client), "The request interval expires normally")
service:PlayerLoadedCharacter(client)
check(service.quotes[client] == nil, "Character changes invalidate pending quotes")

Vector = function(...) return {...} end
Angle = Vector
CLIENT = false
local files = io.popen("rg --files gamemodes/ix_cotz/schema/items/gear gamemodes/ix_cotz/schema/items/newbags")
local configured = 0
for path in files:lines() do
	ITEM = {functions = {}, Hook = function() end}
	local file = assert(io.open(path))
	local source = file:read("*a"):gsub("!=", "~="):gsub("!", "not ")
	file:close()
	assert(load(source, "@" .. path))()
	if ITEM.appearanceCustomization then
		configured = configured + 1
		check(ix.gearAppearance.ValidateDefinition(ITEM), "Concrete definition validates: " .. path)
		local normalized = ix.gearAppearance.Normalize(setmetatable({GetData = function(_, _, default)
			return default
		end}, {__index = ITEM}))
		local default
		for _, option in ipairs(ITEM.appearanceCustomization.skins) do
			if option.id == normalized.skin then default = option end
		end
		for _, target in ipairs(ITEM.appearanceCustomization.targets) do
			local node = ITEM.pacData[target[1]]
			for index = 2, #target do node = node.children[target[index]] end
			check(default.skin == (node.self.Skin or 0), "Existing concrete PAC defaults are preserved: " .. path)
		end
		check(#ITEM.appearanceCustomization.bodygroups == 0, "Current pose bodygroups remain fixed: " .. path)
		if path:find("sh_mask_eo20.lua", 1, true) then
			check(#ITEM.appearanceCustomization.skins == 49, "EO-20 excludes the twelve missing-material finishes")
		end
	end
end
files:close()
check(configured == 18, "All 18 wearable definitions with effective skin alternatives are configured")
SERVER = true
PLUGIN = {}
ix.item = {list = {helmet = item}}
ix.util.Include = function(name)
	if name:sub(1, 3) ~= "cl_" then dofile(root .. name) end
end
dofile(root .. "sh_plugin.lua")
PLUGIN:InitializedPlugins()
check(type(PLUGIN.Open) == "function" and PLUGIN.InstallIconRenderer == nil,
	"Shared loading installs server services and validates items without executing client files")
print("Gear customization: " .. checks .. " checks passed")
