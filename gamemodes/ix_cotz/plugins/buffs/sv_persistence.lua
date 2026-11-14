local PLUGIN = PLUGIN

local function isDuration(value)
	return type(value) == "number" and value == value and value > 0 and value < math.huge
end

function PLUGIN:SaveBuffs(client, character)
	character = character or client:GetCharacter()
	if not character or client:GetCharacter() ~= character then return end

	self:ProcessBandageClotting(client)

	-- A save can occur before the deferred loadout restoration has run.
	local saved = client.cotzBuffCharacter ~= character and table.Copy(character:GetData("buffs", {})) or {}
	local now = CurTime()

	for name, data in pairs(client:GetBuffs()) do
		local remaining = data[1] - now
		if isDuration(remaining) then
			local savedData = table.Copy(data)
			savedData[1] = remaining
			saved[name] = savedData
		end
	end

	character:SetData("buffs", saved, true)
end

function PLUGIN:ClearBuffs(client)
	for name, data in pairs(table.Copy(client:GetBuffs())) do
		client:RemoveBuff(name, data[2])
	end

	client:SetNetVar("buffs", {})
	client.cotzBuffCharacter = nil
	client.cotzClottingTime = nil
	client.cotzClottingCharacter = nil
end

function PLUGIN:RestoreBuffs(client)
	local character = client:GetCharacter()
	if not character or client.cotzBuffCharacter == character then return end

	local saved = table.Copy(character:GetData("buffs", {}))
	client.cotzBuffCharacter = character

	for name, data in pairs(saved) do
		if self.buffs[name] and type(data) == "table" and isDuration(data[1]) and not client:HasBuff(name) then
			client:AddBuff(name, data[1], data[2])
		end
	end

	self:SaveBuffs(client, character)
end

function PLUGIN:QueueBuffRestore(client)
	local character = client:GetCharacter()
	if not character then return end

	-- Helix runs loadout twice when selecting a character; equipment resets resistances there.
	timer.Simple(0, function()
		if IsValid(client) and client:Alive() and client:GetCharacter() == character then
			self:RestoreBuffs(client)
		end
	end)
end

function PLUGIN:CharacterPreSave(character)
	local client = character:GetPlayer()
	if IsValid(client) then
		self:SaveBuffs(client, character)
	end
end

function PLUGIN:PlayerSpawn(client)
	self:SaveBuffs(client)
	self:ClearBuffs(client)
	self:QueueBuffRestore(client)
	self:RestoreBleeding(client)
end

function PLUGIN:PlayerLoadedCharacter(client)
	self:QueueBuffRestore(client)
	self:RestoreBleeding(client)
end

function PLUGIN:PrePlayerLoadedCharacter(client)
	self:SaveBuffs(client)
	self:ClearBuffs(client)
	client.cotzBandageAction = nil
	self:StopBleeding(client)
	client:SetLocalVar("bleedingSeverity", 0)
end

function PLUGIN:PlayerDisconnected(client)
	self:SaveBuffs(client)
	self:ClearBuffs(client)
	self:StopBleeding(client)
end

function PLUGIN:PlayerDeath(client)
	client.cotzBandageAction = nil
	self:ClearBuffs(client)
	local character = client:GetCharacter()
	if character then
		character:SetData("buffs", {}, true)
	end

	self:SetBleedingSeverity(client, 0)
	self:StopBleeding(client)
end
