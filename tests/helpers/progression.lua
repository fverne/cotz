-- Run from the addon root with Lua 5.1+ or: luatex --luaonly tests/progression_spec.lua
-- Shared test environment for the current progression engine; no retired content is loaded.
local function copy(value)
	if type(value) ~= "table" then
		return value
	end
	local result = {}
	for key, entry in pairs(value) do
		result[key] = copy(entry)
	end

	return result
end
local checks = 0
local function check(condition, message)
	checks = checks + 1
	assert(condition, message)
end
math.random = function(minimum)
	return minimum
end
SERVER = true
CLIENT = false
istable = function(value)
	return type(value) == "table"
end
isnumber = function(value)
	return type(value) == "number"
end
isfunction = function(value)
	return type(value) == "function"
end
tobool = function(value)
	return value == true or value == 1
end
IsValid = function(value)
	return type(value) == "table" and not value.invalid
end
Vector = function(x, y, z)
	return { x = x, y = y, z = z }
end
Angle = Vector
unpack = unpack or table.unpack
table.Copy = copy
local timers, messages, callbacks, currentMap = {}, {}, {}, "rp_marsh_cs"
local lostItems = {}
timer = {
	Simple = function(delay, callback)
		timers[#timers + 1] = callback
	end,
}
hook = {
	Run = function() end,
	Add = function(event, id, callback)
		callbacks[id] = callback
	end,
}
game = {
	GetMap = function()
		return currentMap
	end,
}
local position = {
	DistToSqr = function()
		return 0
	end,
}
local vendors = {}
ents = {
	FindByClass = function()
		return vendors
	end,
}
ix = {
	meta = { character = {} },
	progression = { definitions = {} },
	chat = {
		Send = function(...)
			messages[#messages + 1] = { ... }
		end,
	},
	item = { list = setmetatable({}, {
		__index = function(_, key)
			return { name = key }
		end,
	}) },
	util = {
		GetValueFromProgressionTurnin = function(item, amount)
			return amount, amount * 2
		end,
	},
	dialogue = {
		notifyReputationReceive = function() end,
		notifyMoneyReceive = function() end,
		notifyItemGet = function() end,
		notifyItemLost = function(client, description)
			lostItems[#lostItems + 1] = { client = client, description = description }
		end,
	},
	command = { Add = function() end },
	type = { character = 1, string = 2 },
	npctemplates = { templates = {} },
}
local function addReward(inventory, itemID, amount, data)
	inventory.rewards = inventory.rewards or {}
	inventory.rewards[#inventory.rewards + 1] = { item = itemID, amount = amount, data = copy(data) }

	return true
end
ix.meta.character.__index = ix.meta.character
function ix.meta.character:GetData(key, default)
	if self.data[key] == nil then return default end

	return self.data[key]
end
function ix.meta.character:SetData(key, value)
	self.data[key] = value
	self.replications = self.replications + 1
end
function ix.meta.character:GetJobs()
	return self.jobs or {}
end
function ix.meta.character:SetJobs(jobs)
	self.jobs = jobs
end
function ix.meta.character:GetPlayer()
	return self.client
end
function ix.meta.character:GetName()
	return self.name or "Test Stalker"
end
function ix.meta.character:GetInventory()
	return self.inventory
end
function ix.meta.character:UpdateWeight()
	self.weightUpdates = (self.weightUpdates or 0) + 1
end
function ix.meta.character:GiveMoney(amount)
	self.money = self.money + amount
end
function ix.meta.character:Save()
	self.saves = self.saves + 1
end
local function character()
	local char = setmetatable({ data = {}, vars = {}, replications = 0, saves = 0, money = 0 }, ix.meta.character)
	char.inventory = { Add = addReward }
	char.client = {
		GetCharacter = function()
			return char
		end,
		GetPos = function()
			return position
		end,
		addReputation = function(_, amount)
			char.reputation = (char.reputation or 0) + amount
		end,
	}

	return char
end
local base = "gamemodes/ix_cotz/plugins/progression/"
dofile("tests/helpers/character_vars.lua")
dofile(base .. "libs/sh_storage.lua")
dofile(base .. "libs/sh_progression.lua")
dofile(base .. "libs/sh_requirements.lua")
dofile(base .. "libs/sh_expansion.lua")
dofile(base .. "libs/sh_services.lua")
ix.taskRewards = ix.taskRewards or {}
dofile("gamemodes/ix_cotz/plugins/jobsystem/definitions/sh_rewardsettings.lua")
dofile("gamemodes/ix_cotz/plugins/jobsystem/libs/sh_taskrewards.lua")
dofile(base .. "libs/sh_rewards.lua")
dofile("gamemodes/ix_cotz/plugins/jobsystem/libs/sv_taskrewards.lua")
dofile(base .. "libs/sv_rewards.lua")
function ix.progression.Register(id, definition)
	definition.id = id
	ix.progression.definitions[id] = definition
end

dofile(base .. "definitions/sh_requirementpools.lua")
return {
	api = ix.progression,
	character = character,
	callbacks = callbacks,
	messages = messages,
	lostItems = lostItems,
	position = position,
	copy = copy,
	addReward = addReward,
	SetMap = function(map) currentMap = map end,
}
