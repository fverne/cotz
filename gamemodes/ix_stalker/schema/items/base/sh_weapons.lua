ITEM.name = "Weapon"
ITEM.description = "A Weapon."
ITEM.category = "Weapons"
ITEM.model = "models/weapons/w_pistol.mdl"
ITEM.class = "weapon_pistol"
ITEM.width = 2
ITEM.height = 2
ITEM.isWeapon = true
ITEM.isGrenade = false
ITEM.busflag = {"dev"}
ITEM.weaponCategory = "sidearm"
ITEM.equipIcon = Material("materials/vgui/ui/stalker/misc/equip.png")
ITEM.longdesc = "No longer description available."
ITEM.validAttachments = {}
ITEM.canAttach = true
ITEM.Range = 0
ITEM.RoF = ""
ITEM.Dmg = ""
ITEM.Pen = 0
ITEM.Mag = 0
ITEM.Rld = ""
ITEM.Special = ""


-- Attachment translator
local attachments = {}
attachments["md_microt1"] = {name = "Aimpoint Micro T1", slot = 1, uID = "microt1"}
attachments["md_nightforce_nxs"] = {name = "Nightforce NXS", slot = 1, uID = "nightforce"}
attachments["md_rmr"] = {name = "Trijicon RMR", slot = 1, uID = "trijiconrmr"}
attachments["md_schmidt_shortdot"] = {name = "Schmidt Shortdot", slot = 1, uID = "shortdot"}
attachments["md_pso1"] = {name = "PSO-1", slot = 1, uID = "pso1"}
attachments["md_psothermal"] = {name = "PSO-T", slot = 1, uID = "psothermal"}
attachments["md_aimpoint"] = {name = "Aimpoint CompM4", slot = 1, uID = "pso1"}
attachments["md_cmore"] = {name = "CMore Railway", slot = 1, uID = "cmore"}
attachments["md_eotech"] = {name = "Eotech Holographic Sight", slot = 1, uID = "eotech"}
attachments["md_reflex"] = {name = "King Arms MR", slot = 1, uID = "kingarmsmr"}
attachments["md_kobra"] = {name = "Kobra Sight", slot = 1, uID = "kobra"}
attachments["md_acog"] = {name = "Trijicon ACOG Sight", slot = 1, uID = "acog"}
attachments["md_pbs1"] = {name = "PBS Supressor", slot = 2, uID = "pbssuppressor"}
attachments["md_cobram2"] = {name = "Cobra M2 Suppressor", slot = 2, uID = "cobrasuppressor"}
attachments["md_tundra9mm"] = {name = "Tundra Supressor", slot = 2, uID = "tundrasuppressor"}
attachments["md_saker"] = {name = "SAKER Supressor", slot = 2, uID = "sakersuppressor"}
attachments["md_foregrip"] = {name = "Foregrip", slot = 3, uID = "foregrip"}

-- Ammo translator
local ammotypes = {}
ammotypes["7.62x25MM"] = {uID = "762x25"}
ammotypes["7.62x39MM"] = {uID = "762x39"}
ammotypes["7.62x51MM"] = {uID = "762x51"}
ammotypes["7.62x54MMR"] = {uID = "762x54"}
ammotypes["7.62x54MM"] = {uID = "762x54"}
ammotypes["5.45x39MM"] = {uID = "545x39"}
ammotypes["5.56x45MM"] = {uID = "556x45"}
ammotypes["5.7x28MM"] = {uID = "57x28"}
ammotypes["14.5x144MM"] = {uID = "145x114"}
ammotypes[".22LR"] = {uID = "22lr"}
ammotypes[".338 Lapua"] = {uID = "338lapua"}
ammotypes[".44 Magnum"] = {uID = "44magnum"}
ammotypes[".45 ACP"] = {uID = "45acp"}
ammotypes[".50 AE"] = {uID = "50ae"}
ammotypes["9x18MM"] = {uID = "9x18"}
ammotypes["9x19MM"] = {uID = "9x19"}
ammotypes["9x39MM"] = {uID = "9x39"}
ammotypes["12 Gauge"] = {uID = "12gauge"}

-- Inventory drawing
if (CLIENT) then
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

		//Durability bar
		if item:GetData("durability") then --checks if we are in the business menu
			if (item:GetOwner():GetWeapon( item.class )) and (item:GetData("equip")) then
				local weapon = item:GetOwner():GetWeapon( item.class )
				surface.SetDrawColor( Color( 255, 255, 255, 255 ) )
				surface.DrawOutlinedRect( 7, h - 15, 41, 9 )
				if IsValid(weapon) then
					if (weapon:GetWeaponHP() > 0) then
						surface.SetDrawColor(110, 255, 110, 100)
						surface.DrawRect(8, h - 14, (weapon:GetWeaponHP()/100) * 40, 8)
					else
						surface.SetDrawColor(255, 110, 110, 100)
						surface.DrawRect(8, h - 14, 40, 8)
					end
				end
			else
				if (item:GetData("durability")) then
					surface.SetDrawColor( Color( 255, 255, 255, 255 ) )
					surface.DrawOutlinedRect( 7, h - 15, 41, 9 )
					if (item:GetData("durability") > 0) then
						surface.SetDrawColor(110, 255, 110, 100)
						surface.DrawRect(8, h - 14, (item:GetData("durability")/100) * 40, 8)
					else
						surface.SetDrawColor(255, 110, 110, 100)
						surface.DrawRect(8, h - 14, 40, 8)
					end
				end
			end
		end

		//Attachment Icons
		local iterator = 1
		if item:GetData("attachments") then
			for k, v in pairs(item:GetData("attachments")) do
				surface.SetDrawColor( Color( 255, 255, 255, 255 ) )
				surface.SetMaterial(ix.item.list[attachments[v].uID].upgradeIcon)
				surface.DrawTexturedRect(w-2-(22*iterator),4,19,19)
				iterator = iterator + 1
			end
		end
	end

	function ITEM:PopulateTooltip(tooltip)
		if (self:GetData("equip")) then
			local name = tooltip:GetRow("name")
			name:SetBackgroundColor(derma.GetColor("Success", tooltip))
		end
	end
end

function ITEM:GetDescription()
	local str = self.description.." \n\n"..self.longdesc

	local customData = self:GetData("custom", {})
	if(customData.desc) then
		str = customData.desc
	end
	
	if self.Range then
		str = (str.."\n\n".."Range: "..self.Range)
		if self.RoF then
			str = (str.."\n".."Rate of Fire: "..self.RoF)
			if self.Dmg then
				str = (str.."\n".."Damage: "..self.Dmg) 
				if self.Pen then
					str = (str.."\n".."Penetration: "..self.Pen)
					if self.Rld then
						str = (str.."\n".."Reload Time: "..self.Rld)
						if self.Special then
							str = (str.."\n".."Special Attribute(s): "..self.Special)
						end
					end
				end
			end
		end
	end

	if (self.entity) then
		return (self.description .. "\n \nDurability: " .. math.floor(self:GetData("durability", 100)) .. "%")
	else
		//Attachments
		str = str.."\n\nAttachments available:\n"
		if self.canAttach then
			for i=1, #self.validAttachments do
				str = str.."- "..attachments[self.validAttachments[i]].name
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
        return (str .. "\n \nDurability: " .. math.floor(self:GetData("durability", 100)) .. "%")
	end
end

function ITEM:GetName()
	local name = self.name
	
	local customData = self:GetData("custom", {})
	if(customData.name) then
		name = customData.name
	end
	
	return name
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
			item:SetData("ammo", weapon:Clip1())
			item:SetData("durability", weapon:GetWeaponHP())

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
			hook.Run("CanPlayerUnequipItem", client, item) != false and item.invID == client:GetCharacter():GetInventory():GetID()
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
			hook.Run("CanPlayerEquipItem", client, item) != false and item.invID == client:GetCharacter():GetInventory():GetID()
	end
}

ITEM.functions.Unload = {
	icon = "icon16/stalker/unload2.png",
	OnRun = function(item)
		local client = item:GetOwner()
		local weapon = client:GetActiveWeapon()
		local ammoType =  weapon:GetPrimaryAmmoType()
		local ammoAmount = weapon:Clip1()
		local ammoBox = ""
		local ammoSubClass = ""
		if weapon:GetClass() == item.class then
			if ammoAmount > 0 then

				if string.sub(game.GetAmmoName(ammoType), -1) == "-" then
					ammoSubClass = string.lower(string.sub(game.GetAmmoName(ammoType), -3, -2))
					ammoBox = ammotypes[string.sub(game.GetAmmoName(ammoType),1,-6)].uID
					ammoBox = ammoBox..ammoSubClass
				else
					ammoBox = ammotypes[game.GetAmmoName(ammoType)].uID
				end

				if(!client:GetCharacter():GetInventory():Add(ammoBox, 1, {["quantity"] = ammoAmount})) then
					client:Notify("No space in inventory for unloaded ammo")
					return false
				end
				weapon:SetClip1(0)
				client:EmitSound("stalkersound/inv_properties.mp3", 80)

			end
		else
			client:Notify("You must be wielding the weapon to unload it")
		end
		return false
	end,
	OnCanRun = function(item)
		return (!IsValid(item.entity) and (item:GetData("equip") == true) and item:GetOwner():GetActiveWeapon():GetClass() == item.class and item:GetOwner():GetActiveWeapon():Clip1() > 0)
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
					client:NotifyLocalized("weaponSlotFilled", self.weaponCategory)

					return false
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

		timer.Simple(0, function()
			local custom = self:GetData("custom", {})
			
			if(custom.wepDmg) then
				weapon.Damage = tonumber(custom.wepDmg)
			end
			
			if(custom.wepSpd) then
				weapon.FireDelay = weapon.FireDelay * tonumber(custom.wepSpd)
			end
			
			if(custom.wepRec) then
				weapon.Recoil = weapon.Recoil and (weapon.Recoil * custom.wepRec)
			end

			if(custom.wepAcc) then
				weapon.MaxSpreadInc = weapon.MaxSpreadInc * custom.wepAcc
				weapon.AimSpread = weapon.AimSpread * custom.wepAcc
			end				

			if(custom.wepMag) then
				weapon.Primary.ClipSize = tonumber(custom.wepMag)
			end
		
			client:SelectWeapon(weapon:GetClass())
			
			timer.Simple(1, function()
				if(ix.plugin.list["customization"]) then
					ix.plugin.list["customization"]:updateSWEP(client, self)
				end
			end)
		end)

		-- Remove default given ammo.
		if (client:GetAmmoCount(ammoType) == weapon:Clip1() and self:GetData("ammo", 0) == 0) then
			client:RemoveAmmo(weapon:Clip1(), ammoType)
		end

		-- assume that a weapon with -1 clip1 and clip2 would be a throwable (i.e hl2 grenade)
		-- TODO: figure out if this interferes with any other weapons
		if (weapon:GetMaxClip1() == -1 and weapon:GetMaxClip2() == -1 and client:GetAmmoCount(ammoType) == 0) then
			client:SetAmmo(1, ammoType)
		end

		weapon:SetWeaponHP( self:GetData("durability") )
		self:SetData("equip", true)
		if self:GetData("ammoType") ~= nil then
			timer.Simple(0.1,function()
				local weapon1 = client:GetActiveWeapon()
				if self:GetData("ammoType") == "ZL" then
					weapon1:attachSpecificAttachment("am_zoneloaded")
				elseif self:GetData("ammoType") == "MG" then
					weapon1:attachSpecificAttachment("am_matchgrade")
				elseif self:GetData("ammoType") == "SG" then
					weapon1:attachSpecificAttachment("am_slugrounds")
				elseif self:GetData("ammoType") == "BD" then
					weapon1:attachSpecificAttachment("am_birdshot")
				elseif self:GetData("ammoType") == "TR" then
					weapon1:attachSpecificAttachment("am_trishot")
				end
				weapon1:SetClip1(self:GetData("ammo", 0))
			end)
		else
			timer.Simple(0.1,function()
				local weapon1 = client:GetActiveWeapon()
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
		weapon.ixItem = nil

		self:SetData("ammo", weapon:Clip1())
		self:SetData("durability", weapon:GetWeaponHP())

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
			timer.Simple(0.1,function()
				if self:GetData("ammoType") then
					if self:GetData("ammoType") == "ZL" then
						weapon:attachSpecificAttachment("am_zoneloaded")
						
					elseif self:GetData("ammoType") == "MG" then
						weapon:attachSpecificAttachment("am_matchgrade")
					elseif self:GetData("ammoType") == "SG" then
						weapon:attachSpecificAttachment("am_slugrounds")
					elseif self:GetData("ammoType") == "BD" then
						weapon:attachSpecificAttachment("am_birdshot")
					elseif self:GetData("ammoType") == "TR" then
						weapon:attachSpecificAttachment("am_trishot")
					end
				end
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
			weapon:SetClip1(self:GetData("ammo", 0))
			weapon:SetWeaponHP( self:GetData("durability", 0))
		else
			print(Format("[Helix] Cannot give weapon - %s does not exist!", self.class))
		end
	end
end

function ITEM:OnSave()
	local weapon = self.player:GetWeapon(self.class)

	if (IsValid(weapon)) then
		self:SetData("ammo", weapon:Clip1())
		self:SetData("durability", weapon:GetWeaponHP())
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

ITEM.functions.detach = {
	name = "Detach",
	icon = "icon16/stalker/detach.png",
	isMulti = true,
	multiOptions = function(item, client)
		local targets = {}
		local curattach = item:GetData("attachments") or {}

		for k = 1, #curattach do
			table.insert(targets, {
				name = attachments[curattach[k]].name,
				data = {curattach[k]},
			})
		end

		return targets
		end,
	OnCanRun = function(item)
		return (!IsValid(item.entity) and item.canAttach)
	end,
	OnRun = function(item, data)
		if data[1] then

			item.player:GetCharacter():GetInventory():Add(attachments[data[1]].uID)

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

ITEM.functions.Custom = {
	name = "Customize",
	tip = "Customize this item",
	icon = "icon16/wrench.png",
	OnRun = function(item)		
		ix.plugin.list["customization"]:startCustom(item.player, item)
		
		return false
	end,
	
	OnCanRun = function(item)
		local client = item.player
		return client:GetCharacter():HasFlags("N") and !IsValid(item.entity)
	end
}

ITEM.functions.Inspect = {
	name = "Inspect",
	tip = "Inspect this item",
	icon = "icon16/picture.png",
	OnClick = function(item, test)
		local customData = item:GetData("custom", {})

		local frame = vgui.Create("DFrame")
		frame:SetSize(540, 680)
		frame:SetTitle(item.name)
		frame:MakePopup()
		frame:Center()

		frame.html = frame:Add("DHTML")
		frame.html:Dock(FILL)
		
		local imageCode = [[<img src = "]]..customData.img..[["/>]]
		
		frame.html:SetHTML([[<html><body style="background-color: #000000; color: #282B2D; font-family: 'Book Antiqua', Palatino, 'Palatino Linotype', 'Palatino LT STD', Georgia, serif; font-size 16px; text-align: justify;">]]..imageCode..[[</body></html>]])
	end,
	OnRun = function(item)
		return false
	end,
	OnCanRun = function(item)
		local customData = item:GetData("custom", {})
	
		if(!customData.img) then
			return false
		end
		
		if(item.entity) then
			return false
		end
		
		return true
	end
}

ITEM.functions.Clone = {
	name = "Clone",
	tip = "Clone this item",
	icon = "icon16/wrench.png",
	OnRun = function(item)
		local client = item.player	
	
		client:requestQuery("Are you sure you want to clone this item?", "Clone", function(text)
			if text then
				local inventory = client:GetCharacter():GetInventory()
				
				if(!inventory:Add(item.uniqueID, 1, item.data)) then
					client:Notify("Inventory is full")
				end
			end
		end)
		return false
	end,
	OnCanRun = function(item)
		local client = item.player
		return client:GetCharacter():HasFlags("N") and !IsValid(item.entity)
	end
}

hook.Add("PlayerDeath", "ixStripClip", function(client)
	client.carryWeapons = {}

	for _, v in pairs(client:GetCharacter():GetInventory():GetItems()) do
		if (v.isWeapon and v:GetData("equip")) then
			v:SetData("ammo", nil)
			v:SetData("equip", nil)

			if (v.pacData) then
				v:RemovePAC(client)
			end
		end
	end
end)
