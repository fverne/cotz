local PLUGIN = PLUGIN
PLUGIN.name = "Perma Stash"
PLUGIN.author = "Black Tea"
PLUGIN.desc = "You save your stuffs in the stash."
PLUGIN.stashData = PLUGIN.stashData or {}

local charMeta = ix.meta.character

function charMeta:getStash()
	return self:GetData("stash", {})
end

function charMeta:getMaxStash()
	return self:GetData("maxStash", 4)
end

function charMeta:getNumStash()
	local numitems = 0
	for k, v in pairs(self:getStash()) do
		numitems = numitems + 1
	end
	return numitems
end

function charMeta:getUpgradeCost()
	return math.max((self:getMaxStash() - 2) * 50 * self:getMaxStash(), 50)
end

if (SERVER) then
    function PLUGIN:PreCharacterDeleted(client, char)
    	-- get character stash items and eradicate item data from the DATABASE.
    	if (char) then
			local stashItems = char:getStash()
			local queryTable = {}
			for k, v in pairs(stashItems) do
				table.insert(queryTable, k)
			end

			-- Check all stash items of the character.
			ix.item.LoadItemByID(queryTable, 0, nil)
			for k, v in pairs(stashItems) do
				local item = ix.item.instances[k]

				-- Remove all items in stash.
				if (item) then
					item:Remove()
				end
			end
		end
    end

	function PLUGIN:LoadData()
		local savedTable = self:GetData() or {}

		for k, v in ipairs(savedTable) do
			local stash = ents.Create("nut_stash")
			stash:SetPos(v.pos)
			stash:SetAngles(v.ang)
			stash:Spawn()
			stash:Activate()

			local physicsObject = stash:GetPhysicsObject()

			if (IsValid(physicsObject)) then
				physicsObject:EnableMotion()
			end
		end
	end
	
	function PLUGIN:SaveData()
		local savedTable = {}

		for k, v in ipairs(ents.GetAll()) do
			if (v:GetClass() == "nut_stash") then
				table.insert(savedTable, {pos = v:GetPos(), ang = v:GetAngles()})
			end
		end

		self:SetData(savedTable)
	end
	
	function charMeta:setStash(tbl)
		self:SetData("stash", tbl)
	end

	function requestStash(client)
		local stashItems = client:GetCharacter():getStash()
		local queryTable = {}
		local nearStash = true

		-- Check if the client is near the stash.
		for k, v in ipairs(ents.FindInSphere(client:GetPos(), 128)) do
			if (v:GetClass() == "ix_stash") then
				nearStash = true
				break
			end
		end

		if (nearStash == false) then
			client:notify(L("stashFar", client))
			return
		end

		-- Insert items to load.
		for k, v in pairs(stashItems) do
			table.insert(queryTable, k)
		end

		-- Load item informations.
		ix.item.LoadItemByID(queryTable, 0, nil)

		-- Check if item's information is loaded, if does not, do not load the item.
		for k, v in pairs(stashItems) do
			local item = ix.item.instances[k]

			if (!item) then
				return
			end
		end

		-- Send stash menu to the client.
		netstream.Start(client, "stashMenu", stashItems)
	end
	
	netstream.Hook("stashUpgrade", function(client)
		if client:GetCharacter():HasMoney(client:GetCharacter():getUpgradeCost()) then
			client:GetCharacter():TakeMoney(client:GetCharacter():getUpgradeCost())
			client:GetCharacter():SetData("maxStash", client:GetCharacter():getMaxStash() + 2)
			client:Notify("You have improved your storage!")
			client:EmitSound("hgn/crussaria/items/itm_gold_down.wav")
		else
			client:Notify("You don't have enough money to improve your storage.")
		end
	end)

	netstream.Hook("stashIn", function(client, itemID)
		local char = client:GetCharacter()
		local item = ix.item.instances[itemID]
		local nearStash = true

		-- Check if the client is near the stash.
		for k, v in ipairs(ents.FindInSphere(client:GetPos(), 128)) do
			if (v:GetClass() == "ix_stash") then
				nearStash = true
				break
			end
		end

		-- If client is far away from the stash, don't do any interaction.
		if (nearStash == false) then
			client:Notify(L("stashFar", client))
			return
		end

		-- If item information is valid.
		if (item) then
			local clientStash = char:getStash()

			if (item:GetData("equip")) then
				client:Notify(L("You can't stash an equipped item.", client))
				return
			end
			
			-- If client is trying to put bag in the stash, reject the request.
			if (item.base == "base_bags" or clientStash[itemID] or item:GetOwner() != client) then
				client:Notify(L("Error", client))
				return
			end

			-- Make an attempt to put item into the stash.
			if (item:Transfer(char:GetData("stashid"), nil, nil, client, nil, true)) then
				clientStash[itemID] = true

				char:setStash(clientStash)
				netstream.Start(client, "stashIn")
			else
				client:Notify(L("Error", client))
			end
		end
	end)

	netstream.Hook("stashOut", function(client, itemID)
		local char = client:GetCharacter()
		local item = ix.item.instances[itemID]
		local nearStash = true

		-- Check if the client is near the stash.
		for k, v in ipairs(ents.FindInSphere(client:GetPos(), 128)) do
			if (v:GetClass() == "ix_stash") then
				nearStash = true
				break
			end
		end

		-- If client is far away from the stash, don't do any interaction.
		if (nearStash == false) then
			client:Notify(L("stashFar", client))
			return
		end

		-- If item information is valid.
		if (item) then
			local clientStash = char:getStash()

			-- If the activator does not owns the item, reject request.
			if (!clientStash[itemID]) then
				client:Notify(L("Error", client))
				return
			end

			-- Make an attempt to take item from the stash.
			if (item:Transfer(char:GetInventory():GetID(), nil, nil, client)) then
				clientStash[itemID] = nil

				char:setStash(clientStash)
				netstream.Start(client, "stashOut")
			else
				client:Notify(L("Error", client))
			end
		end
	end)
else
	-- I'm so fucking lazy
	-- Stash vgui needs more better sync.
	netstream.Hook("stashIn", function(id)
		if (ix.gui.stash and ix.gui.stash:IsVisible()) then
			ix.gui.stash:setStash()
			surface.PlaySound("items/ammocrate_open.wav")
		end
	end)

	netstream.Hook("stashOut", function(id)
		if (ix.gui.stash and ix.gui.stash:IsVisible()) then
			ix.gui.stash:setStash()
			surface.PlaySound("items/ammocrate_open.wav")
		end
	end)

	netstream.Hook("stashMenu", function(items)
		local stash = vgui.Create("nutStash")
		stash:setStash(items)
	end)
end