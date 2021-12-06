util.AddNetworkString("ixSafeboxOpen")
util.AddNetworkString("ixSafeboxMoneyTake")
util.AddNetworkString("ixSafeboxMoneyGive")

function PLUGIN:PlayerLoadedCharacter(client)
	ix.safebox.Restore(client)
end

function PLUGIN:SaveData()
	local data = {}

	for _, v in ipairs(ents.FindByClass("ix_safebox")) do
		local motion = v:GetPhysicsObject()

		if (IsValid(motion)) then
			motion = motion:IsMotionEnabled()
		end

		data[#data + 1] = { v:GetPos(), v:GetAngles(), v:GetModel(), motion }
	end

	self:SetData(data)
	data = nil
end

function PLUGIN:LoadData()
	local data = self:GetData()

	if (data) then
		for _, v in ipairs(data) do
			local entity = ents.Create("ix_safebox")
			entity:SetPos(v[1])
			entity:SetAngles(v[2])
			entity:Spawn()
			entity:SetModel(v[3])
			entity:SetSolid(SOLID_VPHYSICS)
			entity:PhysicsInit(SOLID_VPHYSICS)

			local physObject = entity:GetPhysicsObject()

			if (IsValid(physObject)) then
				if (v[4] == false) then
					physObject:EnableMotion(false)
					physObject:Sleep()
				else
					physObject:EnableMotion(true)
				end
			end
		end
	end

	data = nil
end

function ix.safebox.Restore(client, callback)
	local character = client:GetCharacter()

	if (!character) then
		return
	end

	local index = character:GetData("safeboxID")
	local characterID = character:GetID()

	if (index) then
		local inventory = ix.inventory.Get(index)

		if (inventory) then
			inventory:Sync(client)
			inventory:AddReceiver(client)

			if (callback) then
				callback()
			end
		else
			local invType = ix.item.inventoryTypes["safebox"]
			ix.inventory.Restore(index, invType.w, invType.h, function(inv)
				inv:SetOwner(characterID)
			end)
		end
	else
		ix.inventory.New(characterID, "safebox", function(inv)
			character:SetData("safeboxID", inv:GetID())
		end)
	end
end

net.Receive("ixSafeboxMoneyTake", function(length, client)
	if (!ix.config.Get("safeEnableMoney") or CurTime() < (client.ixSafeboxMoneyTimer or 0)) then
		return
	end

	local character = client:GetCharacter()

	if (!character) then
		return
	end

	local index = character:GetData("safeboxID")
	local inventory = ix.inventory.Get(index)

	if (!inventory) then
		return
	end

	local safeboxMoney = character:GetData("safeboxMoney", 0)
	local amount = net.ReadUInt(32)
	amount = math.Clamp(math.Round(tonumber(amount) or 0), 0, safeboxMoney)

	if (amount == 0) then
		return
	end

	character:SetMoney(character:GetMoney() + amount)

	local total = safeboxMoney - amount
	character:SetData("safeboxMoney", total)

	client.ixSafeboxMoneyTimer = CurTime() + 0.5
end)

net.Receive("ixStorageMoneyGive", function(length, client)
	if (!ix.config.Get("safeEnableMoney") or CurTime() < (client.ixSafeboxMoneyTimer or 0)) then
		return
	end

	local character = client:GetCharacter()

	if (!character) then
		return
	end

	local index = character:GetData("safeboxID")
	local inventory = ix.inventory.Get(index)

	if (!inventory) then
		return
	end

	local amount = net.ReadUInt(32)
	amount = math.Clamp(math.Round(tonumber(amount) or 0), 0, character:GetMoney())

	if (amount == 0) then
		return
	end

	character:SetMoney(character:GetMoney() - amount)

	local safeboxMoney = character:GetData("safeboxMoney", 0)
	local total = safeboxMoney + amount
	character:SetData("safeboxMoney", total)

	client.ixSafeboxMoneyTimer = CurTime() + 0.5
end)