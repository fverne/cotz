-- Run from the repository root: luatex --luaonly tests/weapon_removal_spec.lua
local checks = 0
local function check(value, message)
	checks = checks + 1
	assert(value, message)
end

function IsValid(value) return type(value) == "table" and not value.removed end
ix = {item = {inventories = {}}}
local owner = {IsPlayer = function() return true end}
function owner:GetWeapon() return self.weapon end
ix.item.inventories[1] = {GetOwner = function() return owner end}

for _, base in ipairs({"newweapons", "miscweapons"}) do
	local path = "gamemodes/ix_cotz/schema/items/base/sh_" .. base .. ".lua"
	local file = assert(io.open(path))
	local source = file:read("*a")
	file:close()
	ITEM = {}
	local callback = assert(source:match("(function ITEM:OnRemoved%(%)\n.-\nend)"))
	assert(load(callback, "@" .. path))()
	local function item(equipped)
		return setmetatable({invID = 1, class = "same_weapon", equipped = equipped, pacRemovals = 0}, {
			__index = {
				GetData = function(self) return self.equipped end,
				RemovePAC = function(self) self.pacRemovals = self.pacRemovals + 1 end,
				OnRemoved = ITEM.OnRemoved,
			},
		})
	end
	local equipped, duplicate = item(true), item(false)
	owner.weapon = {ixItem = equipped, Remove = function(self) self.removed = true end}
	duplicate:OnRemoved()
	check(not owner.weapon.removed, base .. ": selling an unequipped duplicate preserves the equipped SWEP")
	check(duplicate.pacRemovals == 0, base .. ": selling a duplicate preserves its shared PAC appearance")
	duplicate.equipped = true
	duplicate:OnRemoved()
	check(not owner.weapon.removed, base .. ": a stale equipped flag cannot remove another instance's SWEP")
	check(duplicate.pacRemovals == 0, base .. ": a stale equipped flag cannot remove another instance's appearance")
	equipped:OnRemoved()
	check(owner.weapon.removed and equipped.pacRemovals == 1,
		base .. ": removing the equipped instance removes its own SWEP and appearance")
	duplicate.invID = 0
	duplicate:OnRemoved()
	check(true, base .. ": world-item removal tolerates a missing inventory")
end

print("PASS: " .. checks .. " weapon removal checks")
