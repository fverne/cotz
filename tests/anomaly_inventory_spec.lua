local PREFIX = "gamemodes/ix_cotz/schema/"
local KOBRA = "cw_anomaly_kobra"

Material = function(path) return path end
Vector = function(...) return {...} end
Angle = Vector
IsValid = function(entity) return entity ~= nil end
istable = function(value) return type(value) == "table" end
L = function(value) return value end

function table.HasValue(values, wanted)
	for _, value in pairs(values) do
		if value == wanted then return true end
	end
	return false
end

ix = {item = {list = {}}, weight = {Update = function() end}}
dofile(PREFIX .. "libs/sh_weapontables.lua")

local function loadItem(folder, name)
	ITEM = {}
	dofile(PREFIX .. "items/" .. folder .. "/" .. name)
	return ITEM
end

local classes = {}
local firearmCount = 0
for file in lfs.dir(PREFIX .. "items/newweapons") do
	if file:match("^sh_anomaly_.*%.lua$") then
		local firearm = loadItem("newweapons", file)
		assert(firearm.noBusiness and firearm.anomalyInventoryAttachments)
		assert(firearm.canAttach == (#firearm.validAttachments > 0), file)
		assert(firearm.price > 0 and firearm.unloadedweight > 0, file)
		assert(not classes[firearm.class], file)
		classes[firearm.class] = true
		firearmCount = firearmCount + 1

		for _, id in ipairs(firearm.validAttachments) do
			local definition = assert(ix.weapontables.attachments[id], id)
			local hardware = loadItem("attachments", "sh_" .. definition.uID .. ".lua")
			assert(hardware.attachName == id and hardware.attachSlot == definition.slot, file)
			assert(hardware.noBusiness)
		end
	end
end
assert(firearmCount == 82)

-- Load the existing inventory action with legacy GLua syntax translated for the standalone interpreter.
local sourceFile = assert(io.open(PREFIX .. "items/base/sh_attachments.lua"))
local source = sourceFile:read("*a"):gsub("!", "not ")
sourceFile:close()
ITEM = {functions = {}}
assert(load(source))()
local install = ITEM.functions.use

local commands = {}
concommand = {Add = function(name, callback) commands[name] = callback end}
SWEP = {}
sourceFile = assert(io.open("lua/weapons/cw_base/sv_attachments.lua"))
source = sourceFile:read("*a"):gsub("&&", "and")
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
	validAttachments = {KOBRA},
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
	Attachments = {{atts = {"cw_anomaly_pso1", KOBRA}}},
	ActiveAttachments = {},
	dt = {},
	GetNWBool = function() return true end,
	_attach = function(self, group, position, definition)
		assert(group == 1 and position == 2 and definition.name == KOBRA)
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

local hardware = loadItem("attachments", "sh_anomaly_attachment_kobra.lua")
hardware.player = client
equipped:attachSpecificAttachment(KOBRA)
assert(calls == 0, "The weapon must own the saved attachment before CW applies it.")
assert(install.OnRun(hardware, {2}) == false)
assert(#install.multiOptions(hardware, client) == 1)
assert(install.OnRun(hardware, {1}) == true and calls == 1)
assert(rifle:GetData("attachments")[1] == KOBRA)
assert(install.OnRun(hardware, {1}) == false and calls == 1)

local spare = setmetatable({id = 3, data = {}}, {__index = rifle})
weapons[3] = spare
assert(install.OnRun(hardware, {3}) == true)
assert(spare:GetData("attachments")[1] == KOBRA and calls == 1,
	"Installing on an unequipped copy must leave the equipped copy alone.")

equipped:attachSpecificAttachment(KOBRA)
assert(calls == 1, "Restoration must be idempotent when the item is already installed.")
equipped.ActiveAttachments = {}
equipped:attachSpecificAttachment(KOBRA)
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
equipped:detachSpecificAttachment(KOBRA)
assert(detached == 1)
print("Anomaly inventory definitions and attachment installation passed")
