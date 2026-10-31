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
local meta = ix.meta.character
local function addReward(inventory, itemID, amount, data)
	inventory.rewards = inventory.rewards or {}
	inventory.rewards[#inventory.rewards + 1] = { item = itemID, amount = amount, data = copy(data) }

	return true
end
meta.__index = meta
function meta:GetData(key, default)
	if self.data[key] == nil then return default end

	return self.data[key]
end
function meta:SetData(key, value)
	self.data[key] = value
	self.replications = self.replications + 1
end
function meta:GetJobs()
	return self.jobs or {}
end
function meta:SetJobs(jobs)
	self.jobs = jobs
end
function meta:GetPlayer()
	return self.client
end
function meta:GetName()
	return self.name or "Test Stalker"
end
function meta:GetInventory()
	return self.inventory
end
function meta:GiveMoney(amount)
	self.money = self.money + amount
end
function meta:Save()
	self.saves = self.saves + 1
end
local function character()
	local char = setmetatable({ data = {}, replications = 0, saves = 0, money = 0 }, meta)
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
dofile(base .. "libs/sh_storage.lua")
dofile(base .. "libs/sh_progression.lua")
dofile(base .. "libs/sh_requirements.lua")
dofile(base .. "libs/sh_expansion.lua")
dofile(base .. "libs/sh_services.lua")
dofile("gamemodes/ix_cotz/plugins/jobsystem/libs/sh_taskrewards.lua")
dofile(base .. "libs/sh_rewards.lua")
dofile("gamemodes/ix_cotz/plugins/jobsystem/libs/sv_taskrewards.lua")
dofile(base .. "libs/sv_rewards.lua")
local api = ix.progression
function api.Register(id, definition)
	definition.id = id
	api.definitions[id] = definition
end

dofile(base .. "definitions/sh_requirementpools.lua")
return {
	api = api,
	character = character,
	callbacks = callbacks,
	messages = messages,
	lostItems = lostItems,
	position = position,
	copy = copy,
	addReward = addReward,
	SetMap = function(map) currentMap = map end,
}
