local pluginLookup = ix.plugin.Get
ix.plugin.Get = function(name)
	if name == "personalstorage" then
		return personalPlugin
	end
	if name == "passiveregeneration" then
		return regenerationPlugin
	end

	return pluginLookup(name)
end

function TestBank(id)
	local bank = { id = id, vars = {}, receivers = {}, items = {}, width = 2, height = 2 }
	function bank:GetID()
		return self.id
	end
	function bank:SetSize(width, height)
		self.width, self.height = width, height
	end
	function bank:GetSize()
		return self.width, self.height
	end
	function bank:SetOwner(owner)
		self.owner = owner
	end
	function bank:GetReceivers()
		local result = {}
		for client in pairs(self.receivers) do
			result[#result + 1] = client
		end

		return result
	end
	function bank:RemoveReceiver(client)
		self.receivers[client] = nil
	end
	function bank:GetItems()
		return self.items
	end
	ix.item.inventories[id] = bank

	return bank
end
ix.storage.Open = function(client, inventory, info)
	inventory.storageInfo = info
	inventory.receivers[client] = true
	client.ixOpenStorage = inventory
end
ix.storage.Close = function(inventory)
	inventory.storageInfo = nil
end
ix.storage.RemoveReceiver = function(client, inventory)
	inventory:RemoveReceiver(client)
	client.ixOpenStorage = nil
	if table.IsEmpty(inventory.receivers) then
		inventory.storageInfo = nil
	end
end
net = { Start = function() end, WriteUInt = function() end, Send = function() end }

Test("hideout safezone blocks incoming and outgoing damage only within bounds", function()
	Reset()
	local instance = NewInstance()
	local inside = NewEntity(nil, instance.origin)
	local outside = NewEntity(nil, Vector(10000, 0, 8))
	local damage = { amount = 50, attacker = outside, inflictor = outside }
	function damage:GetAttacker()
		return self.attacker
	end
	function damage:GetInflictor()
		return self.inflictor
	end
	function damage:SetDamage(amount)
		self.amount = amount
	end
	assert(PLUGIN:EntityTakeDamage(inside, damage) == true and damage.amount == 0)
	damage.amount, damage.attacker = 50, inside
	assert(PLUGIN:EntityTakeDamage(outside, damage) == true and damage.amount == 0)
	damage.amount, damage.attacker = 50, outside
	assert(PLUGIN:EntityTakeDamage(outside, damage) == nil and damage.amount == 50)
end)

Test("hideout regeneration uses town healing and radiation buffs", function()
	Reset()
	local client = NewClient(1)
	regenerationPlugin:RegeneratePlayer(client, true)
	assert(
		client:Health() == 91 and client.buffs.buff_townradprotect and client.buffs.buff_passivehealthregen
	)
	regenerationPlugin:RegeneratePlayer(client, true)
	assert(client:Health() == 91) -- Same interval cannot heal twice.
	Advance(9)
	regenerationPlugin:RegeneratePlayer(client, true)
	assert(client:Health() == 92)
end)

Test("simultaneous personal bank loads create one persistent inventory", function()
	Reset()
	personalPlugin.bankLoads = {}
	local client = NewClient(1)
	local creations, pending, first, second = 0
	ix.inventory.Get = function(id)
		return ix.item.inventories[id]
	end
	ix.inventory.New = function(owner, kind, callback)
		assert(owner == 0 and kind == "bankInvType")
		creations = creations + 1
		pending = function()
			callback(TestBank(300))
		end
	end
	personalPlugin:GetPersonalInventory(client:GetCharacter(), function(bank)
		first = bank
	end)
	personalPlugin:GetPersonalInventory(client:GetCharacter(), function(bank)
		second = bank
	end)
	assert(creations == 1 and not first and not second)
	pending()
	assert(first == second and first:GetID() == client:GetCharacter():GetData("bankID"))
	assert(first.owner == 1 and first.width == 2 and first.height == 2)
end)

Test("Cleaner and hideout open the same bank and guests keep private banks", function()
	Reset()
	local instance = NewInstance()
	instance.storage = NewEntity(nil, instance.origin)
	instance.storage.ixHideout = instance.id
	local owner, guest = NewClient(1), NewClient(2)
	owner.position, guest.position = instance.origin, instance.origin
	for _, client in ipairs({ owner, guest }) do
		PLUGIN.members[client] = instance.id
	end
	local ownBank, guestBank = TestBank(301), TestBank(302)
	owner:GetCharacter():SetData("bankID", 301)
	guest:GetCharacter():SetData("bankID", 302)
	owner:GetCharacter():SetData("bankW", 5)
	local restores = 0
	ix.inventory.Restore = function(id, width, height, callback)
		restores = restores + 1
		local bank = ix.item.inventories[id]
		bank:SetSize(width, height)
		callback(bank)
	end
	personalPlugin:OpenPersonalStorage(owner, owner) -- Cleaner's shared entry point.
	assert(owner.ixOpenStorage == ownBank and ownBank.storageInfo.entity == owner)
	PLUGIN:OpenStorage(owner, instance.storage)
	PLUGIN:OpenStorage(guest, instance.storage)
	assert(owner.ixOpenStorage == ownBank and guest.ixOpenStorage == guestBank)
	assert(ownBank.width == 5 and restores == 1 and ownBank.storageInfo.entity == instance.storage)
	assert(not ownBank.vars.hideout and not guestBank.vars.hideout)
	PLUGIN:CloseStorage(instance, owner)
	assert(not owner.ixOpenStorage and guest.ixOpenStorage == guestBank)
	PLUGIN:CloseStorage(instance)
	assert(
		not guest.ixOpenStorage
			and ix.item.inventories[301] == ownBank
			and ix.item.inventories[302] == guestBank
	)
end)

Test("legacy stash migration leaves overflow safely recoverable", function()
	Reset()
	local instance = NewInstance()
	instance.storage = NewEntity(nil, instance.origin)
	instance.storage.ixHideout = instance.id
	local owner = NewClient(1)
	owner.position = instance.origin
	PLUGIN.members[owner] = instance.id
	local bank = TestBank(310)
	owner:GetCharacter():SetData("bankID", 310)
	local legacy = TestBank(311)
	instance.inventory = legacy
	local moved, overflow = {}, {}
	legacy.items = { [1] = moved, [2] = overflow }
	function moved:Transfer(id)
		assert(id == bank.id)
		bank.items[1], legacy.items[1] = self, nil

		return true
	end
	function overflow:Transfer()
		return false, "noFit"
	end
	PLUGIN:OpenStorage(owner, instance.storage)
	assert(bank.items[1] == moved and legacy.items[2] == overflow)
	assert(owner.ixOpenStorage == bank and owner.notification:find("HideoutLegacyStorage"))
end)

Test("new hideouts do not allocate another shared storage inventory", function()
	Reset()
	local instance = NewInstance()
	instance.state = "loading"
	local new = ix.inventory.New
	ix.inventory.New = function()
		error("must use personal storage instead")
	end
	local complete
	PLUGIN:RestoreStorage(instance, function(ok)
		complete = ok
	end)
	assert(complete and not instance.inventory and not PLUGIN:GetHideout(instance.id).storageID)
	ix.inventory.New = new
end)

-- Load actual command definitions and verify all access flags.
local captured, add = {}, ix.command.Add
ix.command.Add = function(name, command)
	captured[name] = command
end
bit = {
	bor = function(a, b)
		return a + b
	end,
}
ix.type.number, ix.type.optional, ix.type.player, ix.type.text = 2, 8, 3, 4
TEST_COMMANDS, TEST_COMMAND_ADD = captured, add
