local PLUGIN = PLUGIN
local QUOTE_LIFETIME = 60
local ACTION_INTERVAL = 0.25
local INTERACTION_DISTANCE = 192

PLUGIN.quotes = setmetatable({}, {__mode = "k"})
PLUGIN.nextQuote = 0

for _, name in ipairs({"open", "quote", "confirm", "result"}) do
	util.AddNetworkString("cotz/gear-appearance/" .. name)
end

function PLUGIN:CanUseVendor(client, target)
	return client:GetCharacter() ~= nil and client:Alive() and ix.pac ~= nil and IsValid(target)
		and target:GetClass() == "ix_vendor_adv" and target.dialogueid == "technpc"
		and target:GetDisplayName() == "'Technut'" and target:CanAccess(client)
		and ix.townNPCs:HasService(client:GetCharacter(), "painting", target:GetDisplayName())
		and client:GetPos():DistToSqr(target:GetPos()) <= INTERACTION_DISTANCE ^ 2
end

function PLUGIN:AllowRequest(client)
	local now = CurTime()
	if now < (client.cotzGearNextAction or 0) then return false end
	client.cotzGearNextAction = now + ACTION_INTERVAL

	return true
end

function PLUGIN:GetEligibleItem(client, target, itemID)
	if not self:CanUseVendor(client, target) then return end
	local character = client:GetCharacter()
	local inventory = character:GetInventory()
	local item = inventory:GetItems()[itemID]
	local equipment = ix.plugin.Get("equipmentslots")
	if not item or item.invID ~= inventory:GetID() or not item:GetData("equip", false)
		or not ix.gearAppearance.CanCustomize(item, character, target) or IsValid(item.entity)
		or client:GetNetVar("ix_hasBlackScreen", false)
		or (equipment and equipment:GetPending(client)) then return end

	return item, character
end

function PLUGIN:SendResult(client, success, message)
	net.Start("cotz/gear-appearance/result")
	net.WriteBool(success)
	net.WriteString(message)
	net.Send(client)
end

function PLUGIN:Open(client, target)
	if not self:AllowRequest(client) or not self:CanUseVendor(client, target) then return end
	self.quotes[client] = nil
	net.Start("cotz/gear-appearance/open")
	net.WriteEntity(target)
	net.Send(client)
end

function PLUGIN:CreateQuote(client, target, itemID, state)
	self.quotes[client] = nil
	local item, character = self:GetEligibleItem(client, target, itemID)
	local appearance = item and state and ix.gearAppearance.Normalize(item, state, true)
	if not appearance then return false, "That gear or appearance is no longer available." end
	local before = ix.gearAppearance.Fingerprint(item)
	if before == ix.gearAppearance.Fingerprint(item, appearance) then
		return false, "Choose a different appearance first."
	end
	if not character:HasMoney(ix.gearAppearance.price) then return false, "You need 100 rubles." end
	self.nextQuote = self.nextQuote % 4294967295 + 1
	local quote = {
		token = self.nextQuote, character = character, target = target, item = item, itemID = itemID,
		appearance = appearance, before = before, expires = CurTime() + QUOTE_LIFETIME,
		suitSkin = item:GetData("setSkin"), suitModel = item:GetData("setSkinOverrideModel"),
		definition = util.CRC(util.TableToJSON({ix.gearAppearance.GetConfiguration(item), item.newModel})),
	}
	self.quotes[client] = quote

	return quote
end

function PLUGIN:Confirm(client, token, accepted)
	local quote = self.quotes[client]
	if not quote or quote.token ~= token then return false, "This confirmation is no longer available." end
	-- Consume before any side effects so a repeated request cannot charge twice.
	self.quotes[client] = nil
	if not accepted then return false, "Customization cancelled." end
	local item, character = self:GetEligibleItem(client, quote.target, quote.itemID)
	if item ~= quote.item or character ~= quote.character or quote.expires <= CurTime() then
		return false, "Bring your gear back to Technut for another look."
	end
	if quote.definition ~= util.CRC(util.TableToJSON({ix.gearAppearance.GetConfiguration(item), item.newModel}))
		or quote.before ~= ix.gearAppearance.Fingerprint(item)
		or quote.suitSkin ~= item:GetData("setSkin")
		or quote.suitModel ~= item:GetData("setSkinOverrideModel")
		or not ix.gearAppearance.Normalize(item, quote.appearance, true) then
		return false, "The appearance changed. Please preview it again."
	end
	if not character:HasMoney(ix.gearAppearance.price) then return false, "You need 100 rubles." end
	if item.isBodyArmor then
		for _, paint in ipairs(ix.gearAppearance.GetConfiguration(item).skins) do
			if paint.id == quote.appearance.skin then
				item:SetData("setSkin", paint.skin)
				item:SetData("setSkinOverrideModel", paint.model)
				character:SetModel(paint.model or item.newModel)
				client:SetSkin(paint.skin)
			end
		end
	else
		item:SetData("gearAppearance", quote.appearance)
	end
	character:TakeMoney(ix.gearAppearance.price)
	character:Save()
	-- Refresh the visual only; equip callbacks also change gameplay state.
	if not item.isBodyArmor then client:AddPart(item.uniqueID, item) end

	return true, "Gear customized for 100 rubles."
end

net.Receive("cotz/gear-appearance/quote", function(_, client)
	if not PLUGIN:AllowRequest(client) then
		PLUGIN:SendResult(client, false, "Please wait a moment before requesting customization again.")

		return
	end
	local target, itemID = net.ReadEntity(), net.ReadUInt(32)
	local state = ix.gearAppearance.ReadState()
	local quote, reason = PLUGIN:CreateQuote(client, target, itemID, state)
	if not quote then PLUGIN:SendResult(client, false, reason) return end
	net.Start("cotz/gear-appearance/quote")
	net.WriteUInt(quote.token, 32)
	net.WriteUInt(itemID, 32)
	net.WriteUInt(ix.gearAppearance.price, 32)
	ix.gearAppearance.WriteState(quote.appearance)
	net.Send(client)
end)

net.Receive("cotz/gear-appearance/confirm", function(_, client)
	if not PLUGIN:AllowRequest(client) then
		PLUGIN:SendResult(client, false, "Please wait a moment before confirming customization again.")

		return
	end
	local token, accepted = net.ReadUInt(32), net.ReadBool()
	local success, message = PLUGIN:Confirm(client, token, accepted)
	PLUGIN:SendResult(client, success, message)
end)

function PLUGIN:OnItemSpawned(entity)
	-- ix_item:GetItemTable returns a definition, not the saved instance.
	local item = ix.item.instances[entity.ixItemID]
	if item and item.appearanceCustomization and item:GetData("gearAppearance") then
		ix.gearAppearance.ApplyWorld(entity, item)
	end
end

function PLUGIN:PlayerLoadedCharacter(client)
	self.quotes[client] = nil
end

function PLUGIN:PlayerDisconnected(client)
	self.quotes[client] = nil
end
