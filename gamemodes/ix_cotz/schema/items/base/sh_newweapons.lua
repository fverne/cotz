ITEM.name = "Weapon"
ITEM.description = "A Weapon."
ITEM.category = "Weapons"
ITEM.model = "models/weapons/w_pistol.mdl"
ITEM.longdesc = "Handling marks and worn fittings record journeys that no inventory list can explain. Familiarity"
	.. " with its condition matters more than a trader's assurances."

ITEM.width = 2
ITEM.height = 2

ITEM.class = "weapon_pistol"
ITEM.isWeapon = true
ITEM.isGrenade = false
ITEM.weaponCategory = "sidearm"
ITEM.equipIcon = ix.util.GetMaterial("materials/vgui/ui/stalker/misc/equip.png")
ITEM.exRender = true
ITEM.canRepair = true

ITEM.validAttachments = {}
ITEM.canAttach = true

ITEM.unloadedweight = 0

local ATTACHMENT_PROFILES = include("cotz/weapon_attachment_profiles.lua")

function ITEM:OnRegistered()
	local profile = ATTACHMENT_PROFILES.GetForModel(self.class, self.model)
	if not profile or string.StartWith(self.uniqueID, "debug_") then return end

	local attachments = ATTACHMENT_PROFILES.GetSights(self.class)
	if profile.suppressor then
		attachments[#attachments + 1] = profile.suppressor
	end

	for _, id in ipairs(self.validAttachments) do
		local definition = ix.weapontables.attachments[id]
		if definition and definition.slot > 2 then
			attachments[#attachments + 1] = id
		end
	end

	self.validAttachments = attachments
	self.canAttach = #attachments > 0
end

local function getAttachmentItem(id)
	local definition = ix.weapontables.attachments[id]

	return definition and ix.item.list[definition.uID]
end

function ITEM:GetWeight()
	if self.bulletweight == nil then
		return self:GetData("weight", self.weight)
	end

	return self:GetData("weight", self.unloadedweight) + self.bulletweight * self:GetData("ammo", 0)
end

-- Inventory drawing
if (CLIENT) then
	local Texture2 = Material("cotz/panels/hp1.png", "noclamp smooth") 

	function ITEM:PaintOver(item, w, h)
		//Equipsquare
		if (item:GetData("equip")) then
			surface.SetDrawColor(110, 255, 110, 255)
			--surface.DrawRect(w - 14, h - 14, 8, 8)
		else
			surface.SetDrawColor(255, 110, 110, 255)
		end

		surface.SetMaterial(item.equipIcon)
		surface.DrawTexturedRect(w-23,h-23,19,19)

		--Less mental way of doing the above:
		local dura = 0
		local wear = 0

		if item:GetData("wear") then --checks if we are in the business menu
			if item:GetOwner() and (item:GetOwner():GetWeapon( item.class )) and (item:GetData("equip")) then
				local weapon = item:GetOwner():GetWeapon( item.class )
				if IsValid(weapon) then
					dura = weapon:GetWeaponDurability()
					wear = weapon:GetWeaponWear()
				end
			else
				if (item:GetData("durability") && item:GetData("wear")) then
					dura = item:GetData("durability",0)
					wear = item:GetData("wear",0)
				end
			end
		end

		//durability
		surface.SetMaterial(Texture2)
		surface.SetDrawColor(Color(120, 120, 120, 255))
		surface.DrawTexturedRectUV(5, h - 10, 38, 4.6, 0, 0, 0.2, 1)

		surface.SetMaterial(Texture2)
		if (dura >= 80) then 
			surface.SetDrawColor(Color(120, 255, 120, 255))
		elseif (dura >= 60) then 
			surface.SetDrawColor(Color(180, 255, 120, 255))
		elseif (dura >= 40) then 
			surface.SetDrawColor(Color(255, 255, 120, 255))
		elseif (dura >= 20) then 
			surface.SetDrawColor(Color(255, 180, 120, 255))
		elseif (dura > 0) then 
			surface.SetDrawColor(Color(255, 120, 120, 255))	
		end
		surface.DrawTexturedRectUV(5, h - 10, math.Clamp(dura/100, 0, 1)*38, 4.6, 0, 0, math.Clamp(dura/100, 0, 1)*0.2, 1)

		//wear
		surface.SetMaterial(Texture2)
		surface.SetDrawColor(Color(120, 120, 120, 255))
		surface.DrawTexturedRectUV(5, h - 16, 38, 4.6, 0, 0, 0.2, 1)

		surface.SetMaterial(Texture2)
		if (wear >= 80) then 
			surface.SetDrawColor(Color(120, 255, 120, 255))
		elseif (wear >= 60) then 
			surface.SetDrawColor(Color(180, 255, 120, 255))
		elseif (wear >= 40) then 
			surface.SetDrawColor(Color(255, 255, 120, 255))
		elseif (wear >= 20) then 
			surface.SetDrawColor(Color(255, 180, 120, 255))
		elseif (wear > 0) then 
			surface.SetDrawColor(Color(255, 120, 120, 255))	
		end
		surface.DrawTexturedRectUV(5, h - 16, math.Clamp(wear/100, 0, 1)*38, 4.6, 0, 0, math.Clamp(wear/100, 0, 1)*0.2, 1)


		local iterator = 1
		for _, id in ipairs(item:GetData("attachments", {})) do
			local attachment = getAttachmentItem(id)
			if attachment and attachment.upgradeIcon then
				surface.SetDrawColor( Color( 255, 255, 255, 255 ) )
				surface.SetMaterial(attachment.upgradeIcon)
				surface.DrawTexturedRect(w-2-(22*iterator),4,19,19)
				iterator = iterator + 1
			end
		end
	end
end

function ITEM:GetDescription()
	local description = self:GetData("description", self.description)
	if self.entity or not self.longdesc or self.longdesc == "" then return description end

	return description .. "\n\n" .. self.longdesc
end

function ITEM:PopulateTooltip(tooltip)
    if (!self.entity) then
        ix.util.PropertyDesc(tooltip, "Firearm", Color(64, 224, 208))
        if self.weaponCategory == "secondary" then
			ix.util.PropertyDesc2(tooltip, "Secondary Weapon", Color(64, 224, 208), ix.util.GetMaterial("vgui/ui/stalker/weaponupgrades/handling.png"))
        end
        if self.weaponCategory == "primary" then
			ix.util.PropertyDesc2(tooltip, "Primary Weapon", Color(64, 224, 208), ix.util.GetMaterial("vgui/ui/stalker/weaponupgrades/handling.png"))
        end
    end

    if (self.PopulateTooltipIndividual) then
      self:PopulateTooltipIndividual(tooltip)
    end
end

function ITEM:GetRepairCost()
	return self.price ^ (1 / 3)
end

-- On item is dropped, Remove a weapon from the player and keep the ammo in the item.
ITEM:Hook("drop", function(item)
	local inventory = ix.item.inventories[item.invID]

	if (!inventory) then
		return
	end

	-- the item could have been dropped by someone else (i.e someone searching this player), so we find the real owner
	local owner

	for client, character in ix.util.GetCharacters() do
		if (character:GetID() == inventory.owner) then
			owner = client
			break
		end
	end

	if (!IsValid(owner)) then
		return
	end

	if (item:GetData("equip")) then
		item:SetData("equip", nil)

		owner.carryWeapons = owner.carryWeapons or {}

		local weapon = owner.carryWeapons[item.weaponCategory]

		if (!IsValid(weapon)) then
			weapon = owner:GetWeapon(item.class)
		end

		if (IsValid(weapon)) then
			local ammoType = item:GetWeaponAmmoType(weapon)

			weapon.ixItem = nil

			if not weapon.ixAmmoRestorePending then
				item:SetData("ammoType", item:GetAmmoSubtype(ammoType))

				item:SetData("ammo", weapon:Clip1())
			end
			item:SetData("wear", weapon:GetWeaponWear())
			item:SetData("durability", weapon:GetWeaponDurability())

			owner:StripWeapon(item.class)
			owner.carryWeapons[item.weaponCategory] = nil
			owner:EmitSound("stalkersound/inv_drop.mp3", 80)
		end

		item:RemovePAC(owner)
	end
end)

-- On player uneqipped the item, Removes a weapon from the player and keep the ammo in the item.
ITEM.functions.EquipUn = { -- sorry, for name order.
	name = "unequip",
	tip = "unequipTip",
	icon = "icon16/stalker_grey/unequip.png",
	OnRun = function(item)
		ix.util.PlayerPerformItemAction(item.player, item, "Unequipping...", 4, function(ply)
			item:Unequip(ply, true)
		end)
		return false
	end,
	OnCanRun = function(item)
		local client = item.player

		return !IsValid(item.entity) and IsValid(client) and item:GetData("equip") == true and
			hook.Run("CanPlayerUnequipItem", client, item) != false and item.invID == item.player:GetCharacter():GetInventory():GetID()
	end
}

-- On player eqipped the item, Gives a weapon to player and load the ammo data from the item.
ITEM.functions.Equip = {
	name = "equip",
	tip = "equipTip",
	icon = "icon16/stalker_grey/equip.png",
	OnRun = function(item)
		ix.util.PlayerPerformItemAction(item.player, item, "Equipping...", 4, function(ply)
			if item.invID != ply:GetCharacter():GetInventory():GetID() then return end
			item:Equip(ply)
		end)
		return false
	end,
	OnCanRun = function(item)
		local client = item.player

		return !IsValid(item.entity) and IsValid(client) and item:GetData("equip") != true and
			hook.Run("CanPlayerEquipItem", client, item) != false and item.invID == item.player:GetCharacter():GetInventory():GetID()
	end
}

ITEM.functions.Unload = {
	icon = "icon16/stalker_grey/unload2.png",
	OnRun = function(item)
		return item:Unload(item.player)
	end,
	OnCanRun = function(item)
		return (!IsValid(item.entity) && ((item:GetData("equip",false) && IsValid(item:GetOwner():GetWeapon(item.class)) && item:GetOwner():GetWeapon(item.class):Clip1() > 0) || (!item:GetData("equip",false) && item:GetData("ammo",0) > 0 )))
	end
}

function ITEM:WearPAC(client)
	if (ix.pac and self.pacData) then
		client:AddPart(self.uniqueID, self)
	end
end

function ITEM:RemovePAC(client)
	if (ix.pac and self.pacData) then
		client:RemovePart(self.uniqueID)
	end
end

function ITEM:Unload(player)
	local client = self:GetOwner() or player
	local isEquipped = self:GetData("equip", false)
	local weapon = client:GetWeapon(self.class)
	local ammoType
	local ammoAmount
	local ammoBox = ""
	local ammoSubClass = ""

	if isEquipped then
		ammoType = self:GetWeaponAmmoType(weapon)
		ammoAmount = weapon:Clip1()
	else 
		ammoType = self:GetAmmoType()
		ammoAmount = self:GetData("ammo", 0)
	end

	if ammoAmount > 0 then
		if string.sub(game.GetAmmoName(ammoType), -1) == "-" then
			ammoSubClass = string.lower(string.sub(game.GetAmmoName(ammoType), -3, -2))
			ammoBox = ix.weapontables.ammotypes[string.sub(game.GetAmmoName(ammoType),1,-6)].uID
			ammoBox = ammoBox..ammoSubClass
		else
			ammoBox = ix.weapontables.ammotypes[game.GetAmmoName(ammoType)].uID
		end

		local addbox = true

		for k,v in pairs(client:GetCharacter():GetInventory():GetItemsByUniqueID(ammoBox,true)) do
			local ammoamt = v:GetData("quantity", v.ammoAmount)
			local ammomax = v.maxStack
			local ammodiff = ammomax - ammoamt

			if (ammodiff >= ammoAmount) then
				v:SetData("quantity", ammoamt+ammoAmount)
				addbox = false
				break
			end

			v:SetData("quantity", ammomax)
			ammoAmount = ammoAmount - ammodiff
		end

		if addbox then
			if(!client:GetCharacter():GetInventory():Add(ammoBox, 1, {["quantity"] = ammoAmount})) then
				client:Notify("No space in inventory for unloaded ammo, dropping to floor.")
				ix.item.SpawnTemporary(ammoBox, client:GetItemDropPos(), AngleRand(), {["quantity"] = ammoAmount})
			end
		end

		if isEquipped then
			weapon:SetClip1(0)
		else
			self:SetData("ammo", 0)
		end
		client:EmitSound("stalkersound/inv_properties.mp3", 80)
	
	end
	return false
end

function ITEM:Equip(client)
	local items = client:GetCharacter():GetInventory():GetItems()

	client.carryWeapons = client.carryWeapons or {}

	for _, v in pairs(items) do
		if (v.id != self.id) then
			local itemTable = ix.item.instances[v.id]

			if (!itemTable) then
				client:NotifyLocalized("tellAdmin", "wid!xt")

				return false
			else
				if (itemTable.isWeapon and client.carryWeapons[self.weaponCategory] and itemTable:GetData("equip")) then
					--client:NotifyLocalized("weaponSlotFilled", self.weaponCategory)

					--return false
					if (itemTable.weaponCategory == self.weaponCategory) then
						itemTable:Unequip(client)
					end
				end
			end
		end
	end

	if (client:HasWeapon(self.class)) then
		client:StripWeapon(self.class)
	end

	local weapon = client:Give(self.class, !self.isGrenade)

	if (IsValid(weapon)) then
		local ammoType = weapon:GetPrimaryAmmoType()

		-- if wish granted
		if self:GetData("unlimitedDurability", nil) then
			-- weapon.WearDamage = 0
			weapon.DurabilityDamageChance = 0
		end

		client.carryWeapons[self.weaponCategory] = weapon
		client:SelectWeapon(weapon:GetClass())
		client:EmitSound("stalkersound/items/inv_items_wpn_1.ogg")

		-- Remove default given ammo.
		if (client:GetAmmoCount(ammoType) == weapon:Clip1() and self:GetData("ammo", 0) == 0) then
			client:RemoveAmmo(weapon:Clip1(), ammoType)
		end

		-- assume that a weapon with -1 clip1 and clip2 would be a throwable (i.e hl2 grenade)
		-- TODO: figure out if this interferes with any other weapons
		if (weapon:GetMaxClip1() == -1 and weapon:GetMaxClip2() == -1 and client:GetAmmoCount(ammoType) == 0) then
			client:SetAmmo(1, ammoType)
		end

		weapon:SetWeaponWear( self:GetData("wear", 100) )
		weapon:SetWeaponDurability( self:GetData("durability", 100) )
		self:SetData("equip", true)

		if (self.isGrenade) then
			weapon:SetClip1(1)
			client:SetAmmo(0, ammoType)
		else
			weapon:SetClip1(self:GetData("ammo", 0))
		end

		weapon.ixItem = self
		if not self.isGrenade then
			self:RestoreWeaponAmmo(client, weapon)
		end

		if (self.OnEquipWeapon) then
			self:OnEquipWeapon(client, weapon)
		end
	else
		print(Format("[Helix] Cannot equip weapon - %s does not exist!", self.class))
	end
end

function ITEM:OnInstanced(invID, x, y)
	
	if !self:GetData("durability") then
		self:SetData("durability", 100)
	end
	if !self:GetData("wear") then
		self:SetData("wear", 100)
	end
	if !self:GetData("ammo") then
		self:SetData("ammo", 0)
	end
end

function ITEM:Unequip(client, bPlaySound, bRemoveItem)
	client.carryWeapons = client.carryWeapons or {}

	local weapon = client.carryWeapons[self.weaponCategory]

	if (!IsValid(weapon)) then
		weapon = client:GetWeapon(self.class)
	end

	if (IsValid(weapon)) then
		local ammoType = self:GetWeaponAmmoType(weapon)

		weapon.ixItem = nil

		if not weapon.ixAmmoRestorePending then
			self:SetData("ammo", weapon:Clip1())
			self:SetData("ammoType", self:GetAmmoSubtype(ammoType))
		end
		self:SetData("durability", weapon:GetWeaponDurability())
		self:SetData("wear", weapon:GetWeaponWear())

		client:StripWeapon(self.class)
	else
		print(Format("[Helix] Cannot unequip weapon - %s does not exist!", self.class))
	end

	if (bPlaySound) then
		client:EmitSound("stalkersound/inv_slot.mp3")
	end

	client.carryWeapons[self.weaponCategory] = nil
	self:SetData("equip", nil)
	self:RemovePAC(client)

	if (self.OnUnequipWeapon) then
		self:OnUnequipWeapon(client, weapon)
	end

	if (bRemoveItem) then
		self:Remove()
	end
end

function ITEM:CanTransfer(oldInventory, newInventory)
	if (newInventory and self:GetData("equip")) then
		local owner = self:GetOwner()

		if (IsValid(owner)) then
			owner:NotifyLocalized("equippedWeapon")
		end

		return false
	end

	return true
end

function ITEM:RestoreWeaponAmmo(client, weapon)
	if self.anomalyInventoryAttachments then
		weapon:SetNWBool("cotz/anomaly/inventory-attachments", true)
	end

	weapon.ixAmmoRestorePending = true
	timer.Simple(0.1, function()
		if not IsValid(client) or not client:Alive() or not IsValid(weapon) then return end
		if client:GetWeapon(self.class) ~= weapon or weapon.ixItem ~= self then return end
		if not self:GetData("equip") then return end
		if self.canAttach and weapon.attachSpecificAttachment then
			for _, attachment in ipairs(self:GetData("attachments", {})) do
				if table.HasValue(self.validAttachments, attachment) then
					weapon:attachSpecificAttachment(attachment)
				end
			end
		end
		local rechamber = self:GetData("ammoRechamber")
		if rechamber then
			weapon:attachSpecificAttachment(rechamber.attachmentName)
		end
		local subtype = ix.weapontables.ammosubtypes[self:GetData("ammoType")]
		if subtype then
			weapon:attachSpecificAttachment(subtype.uID)
		end
		weapon:SetClip1(self:GetData("ammo", 0))
		weapon.ixAmmoRestorePending = nil
		if weapon.RefreshInventoryAmmo then
			weapon:RefreshInventoryAmmo()
		end
	end)
end

function ITEM:OnLoadout()
	if (self:GetData("equip")) then
		local client = self.player
		client.carryWeapons = client.carryWeapons or {}

		local weapon = client:Give(self.class)

		if (IsValid(weapon)) then
			client:RemoveAmmo(weapon:Clip1(), weapon:GetPrimaryAmmoType())
			client.carryWeapons[self.weaponCategory] = weapon

			-- if wish granted
			if self:GetData("unlimitedDurability", nil) then
				-- weapon.WearDamage = 0
				weapon.DurabilityDamageChance = 0
			end

			self:RestoreWeaponAmmo(client, weapon)

			weapon.ixItem = self
			weapon:SetWeaponWear( self:GetData("wear", 0))
			weapon:SetWeaponDurability( self:GetData("durability", 0))
		else
			print(Format("[Helix] Cannot give weapon - %s does not exist!", self.class))
		end
	end
end

function ITEM:GetAmmoType()
	local subtype = ""
	if self:GetData("ammoType") then
		subtype = " -"..self:GetData("ammoType").."-"
	end


	if !self:GetData("ammoRechamber") then
		return game.GetAmmoID(weapons.Get(self.class).Primary.Ammo..subtype)
	else
		return game.GetAmmoID(self:GetData("ammoRechamber").ammotypeName..subtype)
	end
end

function ITEM:GetWeaponAmmoType(weapon)
	-- CW attachments update Primary.Ammo before the engine ammo ID refreshes on deploy.
	if weapon.CW20Weapon and weapon.Primary and weapon.Primary.Ammo then
		local ammoID = game.GetAmmoID(weapon.Primary.Ammo)

		-- Unregistered names (e.g. "none" on melee) return -1; defer to the engine's ammo type.
		if ammoID ~= -1 then
			return ammoID
		end
	end

	return weapon:GetPrimaryAmmoType()
end

-- Returns the uppercase ammo subtype (e.g. "AP" from "9x18 -AP-"), or nil when the ammo has none.
function ITEM:GetAmmoSubtype(ammoType)
	local ammoName = game.GetAmmoName(ammoType)

	if not ammoName or string.sub(ammoName, -1) ~= "-" then return end

	return string.upper(string.sub(ammoName, -3, -2))
end

function ITEM:OnSave()
	if not self.player:Alive() then return end

	local weapon = self.player:GetWeapon(self.class)

	if IsValid(weapon) and not weapon.ixAmmoRestorePending and self:GetData("equip", false) then
		self:SetData("ammo", weapon:Clip1())
		self:SetData("wear", weapon:GetWeaponWear())
		self:SetData("durability", weapon:GetWeaponDurability())

		local ammoType = self:GetWeaponAmmoType(weapon)

		self:SetData("ammoType", self:GetAmmoSubtype(ammoType))
	end
end

function ITEM:OnRemoved()
	local inventory = ix.item.inventories[self.invID]
	local owner = inventory and inventory.GetOwner and inventory:GetOwner()

	if IsValid(owner) and owner:IsPlayer() and self:GetData("equip", false) then
		local weapon = owner:GetWeapon(self.class)
		if IsValid(weapon) and weapon.ixItem ~= self then return end

		if IsValid(weapon) then
			weapon:Remove()
		end

		self:RemovePAC(owner)
	end
end

function ITEM:GetPrice()
    return self.price * (math.Clamp(self:GetData("durability",100), 5, 100)/100)
end

ITEM.functions.detach = {
	name = "Detach",
	icon = "icon16/stalker_grey/detach.png",
	isMulti = true,
	multiOptions = function(item)
		local targets = {}
		for _, id in ipairs(item:GetData("attachments", {})) do
			local definition = ix.weapontables.attachments[id]
			local name = definition and definition.name or "Retired attachment"
			targets[#targets + 1] = {name = name, data = {id}}
		end

		return targets
	end,
	OnCanRun = function(item)
		return not IsValid(item.entity) and #item:GetData("attachments", {}) > 0
	end,
	OnRun = function(item, data)
		local id = istable(data) and data[1]
		if not isstring(id) then return false end

		local attachments = item:GetData("attachments", {})
		local index = table.KeyFromValue(attachments, id)
		if not index then return false end

		local client = item.player
		local character = client:GetCharacter()
		local attachment = getAttachmentItem(id)
		table.remove(attachments, index)

		if attachment and not character:GetInventory():Add(attachment.uniqueID) then
			ix.item.SpawnTemporary(attachment.uniqueID, client:GetItemDropPos(), AngleRand())
			client:Notify("No space in your inventory! Items have been dropped.")
		end

		local weapon = client:GetWeapon(item.class)
		if IsValid(weapon) and weapon.ixItem == item then
			weapon:detachSpecificAttachment(id)
		end
		item:SetData("attachments", attachments)
		ix.weight.Update(character)

		return false
	end,
}

function ITEM:OnWeaponDeath(client)
	local weapon = client:GetWeapon(self.class)
	if IsValid(weapon) then
		if not weapon.ixAmmoRestorePending then
			local ammoName = game.GetAmmoName(self:GetWeaponAmmoType(weapon)) or ""
			self:SetData("ammoType", ammoName:match(" %-(%w%w)%-$"))
		end
		weapon:SetClip1(0)
		weapon.ReloadDelay = nil
		weapon.ShotgunReloadState = 0
	end
	self:SetData("ammo", nil)
end

hook.Add("PlayerDeath", "ixStripClip", function(client)
	client.carryWeapons = {}

	if client:GetCharacter() then
		for _, v in pairs(client:GetCharacter():GetInventory():GetItems()) do
			if (v.isWeapon and v:GetData("equip")) then
				if v.OnWeaponDeath then
					v:OnWeaponDeath(client)
				else
					v:SetData("ammo", nil)
				end
				--v:SetData("equip", nil)

				if (v.pacData) then
					v:RemovePAC(client)
				end
			end
		end
	end
end)
