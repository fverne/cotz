local PLUGIN = PLUGIN

PLUGIN.name = "Personal Storage"
PLUGIN.author = "gm1003 ツ - modified by verne"
PLUGIN.description = "Adds upgradable personal storage to characters."

ix.config.Add("bankW", 2, "How many slots in a row there is by default in the bank inventory.", nil, {
	data = { min = 0, max = 20 },
	category = "Bank",
})
ix.config.Add("bankH", 2, "How many slots in a column there is by default in the bank inventory.", nil, {
	data = { min = 0, max = 20 },
	category = "Bank",
})
ix.config.Add("bankWMax", 10, "How many slots in a row there is by default in the bank inventory.", nil, {
	data = { min = 0, max = 20 },
	category = "Bank",
})
ix.config.Add("bankHMax", 8, "How many slots in a column there is by default in the bank inventory.", nil, {
	data = { min = 0, max = 20 },
	category = "Bank",
})

ix.inventory.Register("bankInvType", ix.config.Get("bankW", 2), ix.config.Get("bankH", 2))

if SERVER then
	PLUGIN.bankLoads = PLUGIN.bankLoads or {}

	function PLUGIN:GetPersonalInventory(character, callback)
		local characterID = character:GetID()
		local width = character:GetData("bankW", ix.config.Get("bankW", 2))
		local height = character:GetData("bankH", ix.config.Get("bankH", 2))
		local inventoryID = tonumber(character:GetData("bankID"))
		local inventory = inventoryID and ix.inventory.Get(inventoryID)
		if self.bankLoads[characterID] then
			self.bankLoads[characterID][#self.bankLoads[characterID] + 1] = callback

			return
		end
		if inventory then
			local loadedWidth, loadedHeight = inventory:GetSize()
			if loadedWidth == width and loadedHeight == height then
				callback(inventory)

				return
			end
			-- Character loading may use the bank type's default dimensions.
			-- Restore again at its upgraded size so rows outside that default
			-- grid are not left invisible in a resized in-memory inventory.
			self:ClosePersonalInventory(inventory)
		end
		self.bankLoads[characterID] = { callback }
		local function loaded(bank)
			bank:SetSize(width, height)
			bank:SetOwner(characterID)
			local callbacks = self.bankLoads[characterID] or {}
			self.bankLoads[characterID] = nil
			for _, complete in ipairs(callbacks) do
				complete(bank)
			end
		end
		if inventoryID then
			ix.inventory.Restore(inventoryID, width, height, loaded)
		else
			ix.inventory.New(0, "bankInvType", function(bank)
				character:SetData("bankID", bank:GetID())
				character:Save(function()
					loaded(bank)
				end)
			end)
		end
	end

	function PLUGIN:ClosePersonalInventory(inventory)
		if not inventory.storageInfo then
			return
		end
		ix.storage.Close(inventory)
		for _, receiver in ipairs(inventory:GetReceivers()) do
			inventory:RemoveReceiver(receiver)
			receiver.ixOpenStorage = nil
		end
	end

	function PLUGIN:OpenPersonalInventory(client, inventory, entity)
		local character = IsValid(client) and client:GetCharacter()
		if
			not character
			or tonumber(character:GetData("bankID")) ~= inventory:GetID()
			or not IsValid(entity)
		then
			return false
		end
		-- Rebind an existing session when moving between Ballast and a hideout.
		self:ClosePersonalInventory(inventory)
		ix.storage.Open(client, inventory, {
			entity = entity,
			name = "Personal Storage",
			searchText = "Accessing personal storage...",
			searchTime = 0,
		})

		return true
	end

	function PLUGIN:OpenPersonalStorage(client, entity)
		local character = client:GetCharacter()
		if not character then
			return
		end
		self:GetPersonalInventory(character, function(inventory)
			if not IsValid(client) or client:GetCharacter() ~= character then
				return
			end
			self:OpenPersonalInventory(client, inventory, entity)
		end)
	end

	function PLUGIN:OnCharacterCreated(client, character)
		self:GetPersonalInventory(character, function() end)
	end
end

ix.command.Add("debugupgradesafewidth", {
	adminOnly = true,
	arguments = {
		ix.type.player,
	},
	OnRun = function(self, client, target)
		local bankW = target:GetCharacter():GetData("bankW", ix.config.Get("bankW", 2))
		if bankW < ix.config.Get("bankWMax", 2) then
			target:GetCharacter():SetData("bankW", bankW + 1)
			client:Notify("Updated the target inventory to width: " .. target:GetCharacter():GetData("bankW"))
		else
			client:Notify(
				"Cannot update target inventory! It's width is maxed, which is "
					.. target:GetCharacter():GetData("bankW", ix.config.Get("bankW", 3))
			)
		end
	end,
})

ix.command.Add("debugupgradesafeheight", {
	adminOnly = true,
	arguments = {
		ix.type.player,
	},
	OnRun = function(self, client, target)
		local bankH = target:GetCharacter():GetData("bankH", ix.config.Get("bankH", 2))
		if bankH < ix.config.Get("bankHMax", 2) then
			target:GetCharacter():SetData("bankH", bankH + 1)
			client:Notify(
				"Updated the target inventory to height: " .. target:GetCharacter():GetData("bankH")
			)
		else
			client:Notify(
				"Cannot update target inventory! It's height maxed, which is "
					.. target:GetCharacter():GetData("bankH", ix.config.Get("bankH", 2))
			)
		end
	end,
})

ix.command.Add("debugupgradesafereset", {
	adminOnly = true,
	arguments = {
		ix.type.player,
	},
	OnRun = function(self, client, target)
		target:GetCharacter():SetData("bankW", ix.config.Get("bankW", 2))
		target:GetCharacter():SetData("bankH", ix.config.Get("bankH", 2))
		client:Notify("Reset target inventory.")
	end,
})

ix.command.Add("debugupgradesafeopen", {
	adminOnly = true,
	arguments = {
		ix.type.player,
	},
	OnRun = function(self, client, target)
		PLUGIN:OpenPersonalStorage(client, client)
	end,
})
