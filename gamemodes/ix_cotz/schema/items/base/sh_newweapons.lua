ITEM.name = "Weapon"
ITEM.description = "A Weapon."
ITEM.category = "Weapons"
ITEM.model = "models/weapons/w_pistol.mdl"
ITEM.longdesc = "No longer description available."

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

ITEM.repair_PartsComplexity = 1
ITEM.repair_PartsRarity = 1

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


		//Attachment Icons
		local iterator = 1
		if item:GetData("attachments") then
			for k, v in pairs(item:GetData("attachments")) do
				surface.SetDrawColor( Color( 255, 255, 255, 255 ) )
				surface.SetMaterial(ix.item.list[ix.weapontables.attachments[v].uID].upgradeIcon)
				surface.DrawTexturedRect(w-2-(22*iterator),4,19,19)
				iterator = iterator + 1
			end
		end
	end
end

function ITEM:GetDescription()
	local str = self.description.." \n\n"..self.longdesc

	if (self.entity) then
		return (self.description .. "\n \nWear: " .. math.floor(self:GetData("wear", 100)) .. "%\nDurability: " .. math.floor(self:GetData("durability", 100)) .. "%")
	else
		//Attachments
		str = str.."\n\nAttachments available:\n"
		if self.canAttach then
			for i=1, #self.validAttachments do
				str = str.."- "..ix.weapontables.attachments[self.validAttachments[i]].name
				if self:GetData("attachments") then
					local att = self:GetData("attachments")
					for k=1, #att do
						if att[k] == self.validAttachments[i] then
							str = str.." ✓"
						end
					end
				end
				str = str.."\n"
			end
		else
			str = str.."None\n"
		end

        return (str .. "\n \nWear: " .. math.floor(self:GetData("wear", 100)) .. "%\nDurability: " .. math.floor(self:GetData("durability", 100)) .. "%")
	end
end

function ITEM:PopulateTooltip(tooltip)
    if (!self.entity) then
        ix.util.PropertyDesc(tooltip, "Firearm", Color(64, 224, 208))
        if self.weaponCategory == "secondary" then
        	ix.util.PropertyDesc2(tooltip, "Secondary Weapon", Color(64, 224, 208), Material("vgui/ui/stalker/weaponupgrades/handling.png"))
        end
        if self.weaponCategory == "primary" then
        	ix.util.PropertyDesc2(tooltip, "Primary Weapon", Color(64, 224, 208), Material("vgui/ui/stalker/weaponupgrades/handling.png"))
        end
    end

    if (self.PopulateTooltipIndividual) then
      self:PopulateTooltipIndividual(tooltip)
    end
end

function ITEM:GetRepairCost()
	return ((self.price * 0.0025) * self.repair_PartsComplexity) + ((self.price * 0.0025) * self.repair_PartsRarity)
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
			local ammoType = weapon:GetPrimaryAmmoType()

			weapon.ixItem = nil

			if string.sub(game.GetAmmoName(ammoType), -1) == "-" then
				item:SetData("ammoType", string.upper(string.sub(game.GetAmmoName(weapon:GetPrimaryAmmoType()), -3, -2)))
			else
				item:SetData("ammoType", nil)
			end
				
			item:SetData("ammo", weapon:Clip1())
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
	name = "Unequip",
	tip = "equipTip",
	icon = "icon16/stalker/unequip.png",
	OnRun = function(item)
		item:Unequip(item.player, true)
		return false
	end,
	OnCanRun = function(item)
		local client = item.player

		return !IsValid(item.entity) and IsValid(client) and item:GetData("equip") == true and
			hook.Run("CanPlayerUnequipItem", client, item) != false and item.invID == item:GetOwner():GetCharacter():GetInventory():GetID()
	end
}

-- On player eqipped the item, Gives a weapon to player and load the ammo data from the item.
ITEM.functions.Equip = {
	name = "Equip",
	tip = "equipTip",
	icon = "icon16/stalker/equip.png",
	OnRun = function(item)
		item:Equip(item.player)
		return false
	end,
	OnCanRun = function(item)
		local client = item.player

		return !IsValid(item.entity) and IsValid(client) and item:GetData("equip") != true and
			hook.Run("CanPlayerEquipItem", client, item) != false and item.invID == item:GetOwner():GetCharacter():GetInventory():GetID()
	end
}

ITEM.functions.Unload = {
	icon = "icon16/stalker/unload2.png",
	OnRun = function(item)
		return item:Unload()
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

function ITEM:Unload()
	local client = self:GetOwner()
	local isEquipped = self:GetData("equip", false)
	local weapon = client:GetWeapon(self.class)
	local ammoType
	local ammoAmount
	local ammoBox = ""
	local ammoSubClass = ""

	if isEquipped then
		ammoType = weapon:GetPrimaryAmmoType()
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
			local ammomax = v.ammoAmount
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
				ix.item.Spawn(ammoBox, client:GetItemDropPos(), nil, AngleRand(), {["quantity"] = ammoAmount})
				client:Notify("No space in inventory for unloaded ammo")
				return false
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

					itemTable:Unequip(client)

				end
			end
		end
	end

	if self.canAttach == true then
		timer.Simple(0.1,function()
			local attachments = self:GetData("attachments") or {}
			local weapon1 = client:GetActiveWeapon()
			
			for k = 1, #attachments do
				weapon1:attachSpecificAttachment(attachments[k])
			end
		end)
	end

	if (client:HasWeapon(self.class)) then
		client:StripWeapon(self.class)
	end

	local weapon = client:Give(self.class, !self.isGrenade)

	if (IsValid(weapon)) then
		local ammoType = weapon:GetPrimaryAmmoType()

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

		if self:GetData("ammoRechamber") then
			weapon:attachSpecificAttachment(self:GetData("ammoRechamber").attachmentName)
		end

		weapon:SetWeaponWear( self:GetData("wear", 100) )
		weapon:SetWeaponDurability( self:GetData("durability", 100) )
		self:SetData("equip", true)
		if self:GetData("ammoType") ~= nil then
			timer.Simple(0.1,function()
				local weapon1 = client:GetActiveWeapon()

				weapon1:attachSpecificAttachment(ix.weapontables.ammosubtypes[self:GetData("ammoType")].uID)

				weapon1:SetClip1(self:GetData("ammo", 0))
			end)
		end

		if (self.isGrenade) then
			weapon:SetClip1(1)
			client:SetAmmo(0, ammoType)
		else
			weapon:SetClip1(self:GetData("ammo", 0))
		end

		weapon.ixItem = self

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
		local ammoType = weapon:GetPrimaryAmmoType()

		weapon.ixItem = nil

		self:SetData("ammo", weapon:Clip1())
		if string.sub(game.GetAmmoName(ammoType), -1) == "-" then
			self:SetData("ammoType", string.upper(string.sub(game.GetAmmoName(weapon:GetPrimaryAmmoType()), -3, -2)))
		else
			self:SetData("ammoType", nil)
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

function ITEM:OnLoadout()
	if (self:GetData("equip")) then
		local client = self.player
		client.carryWeapons = client.carryWeapons or {}

		local weapon = client:Give(self.class)

		if (IsValid(weapon)) then
			client:RemoveAmmo(weapon:Clip1(), weapon:GetPrimaryAmmoType())
			client.carryWeapons[self.weaponCategory] = weapon

			if self:GetData("ammoRechamber") then
				weapon:attachSpecificAttachment(self:GetData("ammoRechamber").attachmentName)
			end

			timer.Simple(0.1,function()
				if self:GetData("ammoType") then
					weapon:attachSpecificAttachment(ix.weapontables.ammosubtypes[self:GetData("ammoType")].uID)
				end
				weapon:SetClip1(self:GetData("ammo", 0))
			end)

			if self.canAttach == true then
				timer.Simple(0.1,function()
					local attachments = self:GetData("attachments") or {}
					
					for k = 1, #attachments do
						weapon:attachSpecificAttachment(attachments[k])
					end
				end)
			end

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

function ITEM:OnSave()
	local weapon = self.player:GetWeapon(self.class)

	if (IsValid(weapon)) && self:GetData("equip",false) then
		self:SetData("ammo", weapon:Clip1())
		self:SetData("wear", weapon:GetWeaponWear())
		self:SetData("durability", weapon:GetWeaponDurability())

		local ammoType = weapon:GetPrimaryAmmoType()

		if string.sub(game.GetAmmoName(ammoType), -1) == "-" then
			self:SetData("ammoType", string.upper(string.sub(game.GetAmmoName(weapon:GetPrimaryAmmoType()), -3, -2)))
		else
			self:SetData("ammoType", nil)
		end
	end
end

function ITEM:OnRemoved()
	local inventory = ix.item.inventories[self.invID]
	local owner = inventory.GetOwner and inventory:GetOwner()

	if (IsValid(owner) and owner:IsPlayer()) then
		local weapon = owner:GetWeapon(self.class)

		if (IsValid(weapon)) then
			weapon:Remove()
		end

		self:RemovePAC(owner)
	end
end

function ITEM:GetPrice()
    return self.price * (math.Clamp(self:GetData("durability",100), 15, 100)/100)
end

ITEM.functions.detach = {
	name = "Detach",
	icon = "icon16/stalker/detach.png",
	isMulti = true,
	multiOptions = function(item, client)
		local targets = {}
		local curattach = item:GetData("attachments") or {}

		for k = 1, #curattach do
			table.insert(targets, {
				name = ix.weapontables.attachments[curattach[k]].name,
				data = {curattach[k]},
			})
		end

		return targets
		end,
	OnCanRun = function(item)
		return (!IsValid(item.entity) and item.canAttach and (#(item:GetData("attachments",{})) > 0))
	end,
	OnRun = function(item, data)
		if data[1] then

			item.player:GetCharacter():GetInventory():Add(ix.weapontables.attachments[data[1]].uID)

			local curattach = item:GetData("attachments") or {}
			local iterator = 0
			for i = 1, #curattach do
				iterator = iterator+1
				if curattach[i] == data[1] then
					break
				end
			end
			table.remove(curattach,iterator)

			local wepon = item.player:GetWeapon(item.class)
			-- If you're holding right weapon, just mod it out.
            if (IsValid(wepon) and wepon:GetClass() == item.class) then
                wepon:detachSpecificAttachment(data[1])
			end
			item:SetData("attachments", curattach)

		else
			item.player:Notify("No attachment selected.")
		end
		return false
	end,
}

hook.Add("PlayerDeath", "ixStripClip", function(client)
	client.carryWeapons = {}

	for _, v in pairs(client:GetCharacter():GetInventory():GetItems()) do
		if (v.isWeapon and v:GetData("equip")) then
			v:SetData("ammo", nil)
			--v:SetData("equip", nil)

			if (v.pacData) then
				v:RemovePAC(client)
			end
		end
	end
end)
