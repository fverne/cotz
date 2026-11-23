local PREFIX = "gamemodes/ix_cotz/schema/"
local OPTIC = "md_microt1"

Material = function(path) return path end
Vector = function(...) return {...} end
Angle = Vector
IsValid = function(entity) return entity ~= nil end
istable = function(value) return type(value) == "table" end
L = function(value) return value end
include = function(path) return dofile("lua/" .. path) end
hook = {Add = function() end}
string.StartWith = function(value, prefix) return value:sub(1, #prefix) == prefix end
function table.Copy(value)
	if type(value) ~= "table" then return value end
	local copy = {}
	for key, child in pairs(value) do copy[key] = table.Copy(child) end
	return copy
end

function table.HasValue(values, wanted)
	for _, value in pairs(values) do
		if value == wanted then return true end
	end
	return false
end

local PROFILES = include("cotz/weapon_attachment_profiles.lua")
local poses = include("cotz/weapon_attachment_poses.lua")

ix = {item = {list = {}}, weight = {Update = function() end}, util = {GetMaterial = Material}}
dofile(PREFIX .. "libs/sh_weapontables.lua")

local function loadItem(folder, name)
	ITEM = {}
	dofile(PREFIX .. "items/" .. folder .. "/" .. name)
	return ITEM
end

local function loadBase(name)
	local file = assert(io.open(PREFIX .. "items/base/" .. name))
	local source = file:read("*a"):gsub("!=", "~="):gsub("!", "not "):gsub("&&", "and")
		:gsub("||", "or"):gsub("//", "--")
	file:close()
	ITEM = {functions = {}, Hook = function() end}
	assert(load(source))()
	return ITEM
end

local base = loadBase("sh_newweapons.lua")
local firearmCount = 0
local classes, anomalyHardware, standardHardware = {}, {}, {}
for file in lfs.dir(PREFIX .. "items/newweapons") do
	assert(not file:match("^sh_debug_cw_anomaly_"), "Unexpected Anomaly debug weapon " .. file)
	if file:match("^sh_.*%.lua$") and not file:match("^sh_debug_") then
		local firearm = setmetatable(loadItem("newweapons", file), {__index = base})
		firearm.uniqueID = file:match("^sh_(.*)%.lua$")
		local profile = assert(PROFILES.weapons[firearm.class], file)
		local suppressor = profile.suppressor
		classes[firearm.class] = true
		local extra = table.HasValue(firearm.validAttachments, "md_foregrip")
		firearm:OnRegistered()
		assert(firearm.canAttach == (#firearm.validAttachments > 0), file)
		assert(table.HasValue(firearm.validAttachments, "md_foregrip") == extra, file)
		if file:match("^sh_anomaly_") then
			assert(firearm.noBusiness and firearm.anomalyInventoryAttachments, file)
			assert(firearm.price > 0 and firearm.unloadedweight > 0, file)
			firearmCount = firearmCount + 1
		end

		local muzzleCount = 0
		for _, id in ipairs(firearm.validAttachments) do
			if file:match("^sh_anomaly_") then
				assert(not id:match("^cw_anomaly_"), file .. " uses pack-only hardware " .. id)
				assert(poses.weapons[firearm.class][id], file .. " needs a CW placement for " .. id)
				anomalyHardware[id] = true
			else
				standardHardware[id] = true
			end
			local definition = assert(ix.weapontables.attachments[id], id)
			local hardware = loadItem("attachments", "sh_" .. definition.uID .. ".lua")
			assert(hardware.attachName == id and hardware.attachSlot == definition.slot, file)
			if definition.slot == 2 then
				assert(id == suppressor, file)
				muzzleCount = muzzleCount + 1
			end
		end
		assert(muzzleCount == (suppressor and 1 or 0), file)
		for _, id in ipairs(PROFILES.GetSights(firearm.class)) do
			assert(table.HasValue(firearm.validAttachments, id), file .. " missing " .. id)
		end
	end
end
assert(firearmCount == 82)
for id in pairs(anomalyHardware) do
	assert(standardHardware[id], id .. " must also be available on a regular CW firearm")
end
for class in pairs(PROFILES.weapons) do assert(classes[class], class) end

local pistolSights = PROFILES.GetSights("cw_p99")
assert(table.HasValue(pistolSights, "md_microt1") and not table.HasValue(pistolSights, "md_schmidt_shortdot"))
local revolverSights = PROFILES.GetSights("cw_anomaly_mp412_vmrecoil")
assert(table.HasValue(revolverSights, "md_schmidt_shortdot") and not table.HasValue(revolverSights, "md_acog"))
assert(#PROFILES.GetSights("cw_mossberg500") == 0)
assert(#PROFILES.GetSights("cw_mp40") == 0)
assert(not table.HasValue(PROFILES.GetSights("cw_hk416"), "md_pso1"))
assert(table.HasValue(PROFILES.GetSights("cw_akm"), "md_pso1"))
assert(table.HasValue(PROFILES.GetSights("cw_ws_mosin"), "cw_anomaly_mosin"))

local retained = {sh_anomaly_attachment_1p29 = true, sh_anomaly_attachment_mosin = true}
for file in lfs.dir(PREFIX .. "items/attachments") do
	local name = file:match("^(sh_anomaly_attachment_.*)%.lua$")
	if name then
		assert(retained[name], "Unexpected Anomaly attachment " .. file)
		retained[name] = nil
	end
end
assert(next(retained) == nil)

local retired = {GetData = function() return {"cw_anomaly_kobra"} end}
assert(base.functions.detach.multiOptions(retired)[1].name == "Retired attachment")
assert(base.functions.detach.OnCanRun(retired), "retired hardware can be detached without an active attachment slot")

ITEM = loadBase("sh_attachments.lua")
local install = ITEM.functions.use

local commands = {}
concommand = {Add = function(name, callback) commands[name] = callback end}
SWEP = {}
local sourceFile = assert(io.open("lua/weapons/cw_base/sv_attachments.lua"))
local source = sourceFile:read("*a"):gsub("&&", "and")
sourceFile:close()
assert(load(source))()

local calls = 0
local function getData(item, key, default)
	return item.data[key] or default
end
local rifle = {
	name = "AK-74M",
	id = 1,
	class = "cw_anomaly_ak74m_vmrecoil",
	anomalyInventoryAttachments = true,
	isWeapon = true,
	canAttach = true,
	validAttachments = {OPTIC},
	data = {},
	GetID = function(item) return item.id end,
	GetData = getData,
	SetData = function(item, key, value) item.data[key] = value end,
}
local weapons = {[1] = rifle, [2] = {}}
local inventory = {GetItems = function() return weapons end}
local character = {GetInventory = function() return inventory end}
local equipped = setmetatable({
	CW20Weapon = true,
	ixItem = rifle,
	Attachments = {{atts = {"cw_anomaly_pso1", OPTIC}}},
	ActiveAttachments = {},
	dt = {},
	GetNWBool = function() return true end,
	_attach = function(self, group, position, definition)
		assert(group == 1 and position == 2 and definition.name == OPTIC)
		self.ActiveAttachments[definition.name] = true
		calls = calls + 1
	end,
}, {__index = SWEP})
local client = {
	GetCharacter = function() return character end,
	GetWeapon = function() return equipped end,
	GetActiveWeapon = function() return equipped end,
	Alive = function() return true end,
	Notify = function() end,
}
CustomizableWeaponry = {
	canOpenInteractionMenu = true,
	customizationEnabled = true,
	findAttachment = function(_, id) return {name = id} end,
}

local hardware = loadItem("attachments", "sh_microt1.lua")
hardware.player = client
equipped:attachSpecificAttachment(OPTIC)
assert(calls == 0, "The weapon must own the saved attachment before CW applies it.")
assert(install.OnRun(hardware, {2}) == false)
assert(#install.multiOptions(hardware, client) == 1)
assert(install.OnRun(hardware, {1}) == true and calls == 1)
assert(rifle:GetData("attachments")[1] == OPTIC)
assert(install.OnRun(hardware, {1}) == false and calls == 1)

local spare = setmetatable({id = 3, data = {}}, {__index = rifle})
weapons[3] = spare
assert(install.OnRun(hardware, {3}) == true)
assert(spare:GetData("attachments")[1] == OPTIC and calls == 1,
	"Installing on an unequipped copy must leave the equipped copy alone.")

equipped:attachSpecificAttachment(OPTIC)
assert(calls == 1, "Restoration must be idempotent when the item is already installed.")
equipped.ActiveAttachments = {}
equipped:attachSpecificAttachment(OPTIC)
assert(calls == 2, "A newly equipped SWEP must restore the saved attachment.")
commands.cw_attach(client, nil, {"1"})
assert(calls == 2, "Native CW cycling must respect inventory ownership.")

local detached = 0
equipped.detach = function(_, group)
	assert(group == 1)
	detached = detached + 1
end
equipped:detachSpecificAttachment("cw_anomaly_pso1")
assert(detached == 0, "Detaching a different optic must leave the installed one alone.")
equipped:detachSpecificAttachment(OPTIC)
assert(detached == 1)
for class in pairs(PROFILES.weapons) do assert(poses.weapons[class], class) end

local definitions = {}
CustomizableWeaponry.sights = {}
CustomizableWeaponry.suppressors = {}
for _, id in ipairs(PROFILES.sights) do
	definitions[id] = {name = id, aimPos = {id .. "Pos", id .. "Ang"}, isSight = true}
	CustomizableWeaponry.sights[id] = definitions[id]
end
CustomizableWeaponry.sights.cw_anomaly_kobra = true
CustomizableWeaponry.suppressors.cw_anomaly_sil_tgpa = true
CustomizableWeaponry.findAttachment = function(_, id) return definitions[id] end

local pu = "cw_anomaly_mosin"
local function configure(isClient)
	CLIENT = isClient
	SERVER = not isClient
	surface = {GetTextureID = function() return 1 end}
	SWEP = {}
	dofile("lua/weapons/cw_base/sh_cotzattachments.lua")

	local firearm = setmetatable({
		GetClass = function() return "cw_anomaly_ak74m_vmrecoil" end,
		Attachments = {
			[1] = {atts = {"cw_anomaly_sil_tgpa"}},
			[2] = {atts = {"cw_anomaly_kobra", "cw_anomaly_1p29"}},
			[4] = {atts = {"cw_anomaly_ammo_545x39_ep"}},
		},
		AnomalyAttachmentOrder = {"cw_anomaly_1p29"},
		ApplyAnomalyAttachments = function() end,
	}, {__index = SWEP})
	firearm:ApplyCotzAttachmentProfile()
	assert(firearm.Attachments[1].atts[1] == "md_pbs1")
	assert(table.HasValue(firearm.Attachments[2].atts, OPTIC))
	assert(not table.HasValue(firearm.Attachments[2].atts, pu))
	assert(not table.HasValue(firearm.Attachments[2].atts, "cw_anomaly_kobra"))
	assert(firearm.Attachments[4] == nil, "pack-only ammo choices do not belong in the CW slots")
	for _, slot in pairs(firearm.Attachments) do
		for _, id in ipairs(slot.atts) do
			assert(not id:match("^cw_anomaly_"), "unexpected pack-only SWEP attachment " .. id)
		end
	end
	assert(firearm:GetCotzAttachment(definitions[OPTIC]) == definitions[OPTIC])
	if isClient then
		assert(firearm.AttachmentModelsVM[OPTIC] and firearm[OPTIC .. "Pos"], "shared optic must have a model and aim")
		local mosin = setmetatable({
			GetClass = function() return "cw_ws_mosin" end,
			Attachments = {},
		}, {__index = SWEP})
		mosin:ApplyCotzAttachmentProfile()
		assert(mosin:GetCotzAttachment(definitions[pu]) ~= definitions[pu])
		assert(mosin.AttachmentModelsVM[pu] and mosin[pu .. "Pos"])
	end
	return firearm.Attachments
end

local clientSlots = configure(true)
local serverSlots = configure(false)
for key, group in pairs(clientSlots) do
	assert(table.concat(group.atts, ",") == table.concat(serverSlots[key].atts, ","))
end

print("CW inventory attachment catalogue, installation and shared slots passed")
