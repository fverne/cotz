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
ITEM.Range = 0
ITEM.RoF = ""
ITEM.Dmg = ""
ITEM.Pen = 0
ITEM.Mag = 0
ITEM.Rld = ""
ITEM.Special = ""


-- Upgrade Translator
local upgrades = {}
upgrades["fn_acc1"] = {name = "Accuracy Upgrade 1", slot = 4, uID = "acc1"}
upgrades["fn_acc2"] = {name = "Accuracy Upgrade 2", slot = 6, uID = "acc2"}
upgrades["fn_hndl1"] = {name = "Handling Upgrade 1", slot = 3, uID = "hndl1"}
upgrades["fn_hndl2"] = {name = "Handling Upgrade 2", slot = 7, uID = "hndl2"}
upgrades["fn_mag2"] = {name = "Magazine +2", slot = 2, uID = "mag2"}
upgrades["fn_mag3"] = {name = "Magazine +3", slot = 2, uID = "mag3"}
upgrades["fn_mag5"] = {name = "Magazine +5", slot = 2, uID = "mag5"}
upgrades["fn_mag9"] = {name = "Magazine +9", slot = 2, uID = "mag9"}
upgrades["fn_mag10"] = {name = "Magazine +10", slot = 2, uID = "mag10"}
upgrades["fn_mag25"] = {name = "Magazine +25", slot = 2, uID = "mag25"}
upgrades["fn_rec1"] = {name = "Recoil Upgrade 1", slot = 4, uID = "rec1"}
upgrades["fn_rec2"] = {name = "Recoil Upgrade 2", slot = 8, uID = "rec2"}
upgrades["fn_rof1"] = {name = "Rate of Fire Upgrade 1", slot = 5, uID = "rof1"}
upgrades["fn_rof2"] = {name = "Rate of Fire Upgrade 2", slot = 8, uID = "rof2"}
upgrades["fn_stab1"] = {name = "Stability Upgrade 1", slot = 5, uID = "stab1"}
upgrades["fn_stab2"] = {name = "Stability Upgrade 2", slot = 7, uID = "stab2"}
upgrades["am_cal_9x18"] = {name = "9x18 Conversion Kit", slot = 1, uID = "cal9x18"}
upgrades["am_cal_9x19"] = {name = "9x19 Conversion Kit", slot = 1, uID = "cal9x19"}
upgrades["am_cal_9x39"] = {name = "9x39 Conversion Kit", slot = 1, uID = "cal9x39"}
upgrades["am_cal_38"] = {name = ".38 Special Conversion Kit", slot = 1, uID = "cal38"}
upgrades["am_cal_45"] = {name = ".45 ACP Conversion Kit", slot = 1, uID = "cal45"}
upgrades["am_cal_357"] = {name = ".357 Magnum Conversion Kit", slot = 1, uID = "cal357"}
upgrades["am_cal_545x39"] = {name = "5.45x39mm Conversion Kit", slot = 1, uID = "cal545"}
upgrades["am_cal_556x45"] = {name = "5.56x45mm Conversion Kit", slot = 1, uID = "cal556"}
upgrades["am_cal_762x39"] = {name = "7.62x39mm Conversion Kit", slot = 1, uID = "cal762x39"}
upgrades["am_cal_762x51"] = {name = "7.62x51mm Conversion Kit", slot = 1, uID = "cal762x51"}
upgrades["am_cal_762x54"] = {name = "7.62x54mm Conversion Kit", slot = 1, uID = "cal762x54"}

-- Attachment translator
local attachments = {}
--CW2.0 Attachments
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

-- KK INS2 Attachments
attachments["kk_ins2_cstm_acog"] = {name = "Trijicon ACOG 4x32 Scope", slot = 1, uID = "acog"}
attachments["kk_ins2_aimpoint"] = {name = "Aimpoint Red Dot Sight", slot = 1, uID = "aimpoint"}
attachments["kk_ins2_anpeq15"] = {name = "AN/PEQ-15", slot = 4, uID = "anpeq"}
attachments["kk_ins2_gl_m203"] = {name = "M203 Grenade Launcher", slot = 3, uID = "attm203"}
attachments["kk_ins2_cstm_barska"] = {name = "Barska Electro Sight", slot = 1, uID = "barska"}
attachments["kk_ins2_bipod"] = {name = "Bipod", slot = 3, uID = "bipod"}
attachments["kk_ins2_cstm_cmore"] = {name = "C-More Red Dot Sight", slot = 1, uID = "cmore"}
attachments["kk_ins2_cstm_compm4s"] = {name = "Aimpoint CompM4S", slot = 1, uID = "compm4s"}
attachments["kk_ins2_elcan"] = {name = "Elcan Optical Scope", slot = 1, uID = "elcan"}
attachments["kk_ins2_eotech"] = {name = "Eotech Holographic Sight", slot = 1, uID = "eotech"}
attachments["kk_ins2_cstm_eotechxps"] = {name = "Eotech XPS2", slot = 1, uID = "eotechxps"}
attachments["kk_ins2_gl_gp25"] = {name = "GP-25 Grenade Launcher", slot = 3, uID = "gp25"}
attachments["kk_ins2_hoovy"] = {name = "Heavy Barrel", slot = 5, uID = "heavybarrel"}
attachments["kk_ins2_kobra"] = {name = "Kobra Red Dot Sight", slot = 1, uID = "kobra"}
attachments["kk_ins2_lam"] = {name = "Laser Sight", slot = 4, uID = "laser"}
attachments["kk_ins2_scope_mosin"] = {name = "Leupold Scope", slot = 1, uID = "leupold"}
attachments["kk_ins2_flashlight"] = {name = "Flashlight", slot = 4, uID = "light"}
attachments["kk_ins2_m6x"] = {name = "M6X", slot = 4, uID = "m6x"}
attachments["kk_ins2_cstm_microt1"] = {name = "Micro T-1 Red Dot Sight", slot = 1, uID = "microt1"}
attachments["kk_ins2_pbs1"] = {name = "PBS-1 Suppressor", slot = 2, uID = "pbs1"}
attachments["kk_ins2_scope_m40"] = {name = "M40a1 Scope", slot = 1, uID = "m40scope"}
attachments["kk_ins2_pbs5"] = {name = "PBS-5 Suppressor", slot = 2, uID = "pbs5"}
attachments["kk_ins2_po4"] = {name = "PO 4x24 Scope", slot = 1, uID = "po4"}
attachments["kk_ins2_mag_saiga_20"] = {name = "Saiga-12 Drum Magazine", slot = 6, uID = "saigadrum"}
attachments["kk_ins2_flashhider_big_shotgun"] = {name = "Saiga-12 Flash Hider", slot = 2, uID = "saigafh"}
attachments["kk_ins2_revolver_mag"] = {name = "Speed Loader", slot = 1, uID = ""}
attachments["kk_ins2_suppressor_shotgun"] = {name = "12 Gauge Suppressor", slot = 2, uID = "supp12"}
attachments["kk_ins2_suppressor_sec"] = {name = "NATO Suppressor", slot = 2, uID = "suppnato"}
attachments["kk_ins2_suppressor_pistol"] = {name = "Pistol Suppressor", slot = 2, uID = "supppistol"}
attachments["kk_ins2_vertgrip"] = {name = "Vertical Foregrip", slot = 1, uID = "vertgrip"}

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
		if item:GetData("durability") then
			local dura = item:GetData("durability",10000)
			if (item:GetOwner():GetWeapon( item.class )) and (item:GetData("equip")) then
				surface.SetDrawColor( Color( 255, 255, 255, 255 ) )
				surface.DrawOutlinedRect( 7, h - 15, 41, 9 )
				if (dura > 0) then
					surface.SetDrawColor(110, 255, 110, 100)
					surface.DrawRect(8, h - 14, (dura/10000) * 40, 8)
				else
					surface.SetDrawColor(255, 110, 110, 100)
					surface.DrawRect(8, h - 14, 40, 8)
				end
			else
				surface.SetDrawColor( Color( 255, 255, 255, 255 ) )
				surface.DrawOutlinedRect( 7, h - 15, 41, 9 )
				if (dura > 0) then
					surface.SetDrawColor(110, 255, 110, 100)
					surface.DrawRect(8, h - 14, (dura/10000) * 40, 8)
				else
					surface.SetDrawColor(255, 110, 110, 100)
					surface.DrawRect(8, h - 14, 40, 8)
				end
			end
		end

		//Attachment Icons
		local iterator = 1
		if item:GetData("attachments") then
			for k, v in pairs(item:GetData("attachments")) do
				surface.SetDrawColor( Color( 255, 255, 255, 255 ) )
				if ix.item.list[v[1]].upgradeIcon then
					surface.SetMaterial(ix.item.list[v[1]].upgradeIcon)
				end
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
						if self.Special ~= "" then
							str = (str.."\n".."Special Attribute(s): "..self.Special)
						end
					end
				end
			end
		end
	end

	if (self.entity) then
		return (self.description .. "\n \nDurability: " .. (math.floor(self:GetData("durability", 10000))/100) .. "%")
	else
		local client = self:GetOwner()
		local weapon = client:GetActiveWeapon()
		local SWEP = weapons.Get(self.class)
		local atts = SWEP.Attachments
		local activeAtts = self:GetData("attachments",{})
		
		str = str.."\n\nAttachments Available: \n"
		
		for atcat, data in pairs(atts) do
            for k, name in pairs(data.atts) do
				if attachments[name] then
					local attName = attachments[name]["name"]
					str = str..attName
					for x,y in pairs(activeAtts) do
						local attTable = ix.item.list[y[1]]
						local niceName = attTable:GetName()
						if attName == niceName then
							str = str.." ✓"
						end
					end
					str = str.."\n"
				end
            end
        end
        return (str .. "\n \nDurability: " .. (math.floor(self:GetData("durability", 10000))/100) .. "%")
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

	if (client:HasWeapon(self.class)) then
		client:StripWeapon(self.class)
	end

	local weapon = client:Give(self.class, !self.isGrenade)

	if (IsValid(weapon)) then
		local ammoType = weapon:GetPrimaryAmmoType()

		client.carryWeapons[self.weaponCategory] = weapon
		client:SelectWeapon(weapon:GetClass())
		client:EmitSound("stalkersound/items/inv_items_wpn_1.ogg")
		weapon:SetWeaponHP((self:GetData("durability")/100),100)
		if self:GetData("custom") then
			timer.Simple(0, function()
				local custom = self:GetData("custom", {})
				local damage = tonumber(custom.wepDmg)
				local rateoffire = tonumber(custom.wepSpd)
				local recoil = custom.wepRec
				local accuracy = custom.wepAcc
				local magazine = custom.wepMag
				
				if (custom.wepDmg) and damage > 0 then
					weapon.Damage = damage
				end
				
				if (custom.wepSpd) and rateoffire > 0 then
					weapon.FireDelay = weapon.FireDelay * rateoffire
				end
				
				if (custom.wepRec) and recoil > 0 then
					weapon.Recoil = weapon.Recoil and (weapon.Recoil * recoil)
				end
				
				if (custom.wepAcc) and accuracy > 0 then
					weapon.MaxSpreadInc = weapon.MaxSpreadInc * accuracy
					weapon.AimSpread = weapon.AimSpread * accuracy
				end				
				
				if (custom.wepMag) and magazine > 0 then
					weapon.Primary.ClipSize = magazine
				end
			end)
		end
		-- assume that a weapon with -1 clip1 and clip2 would be a throwable (i.e hl2 grenade)
		-- TODO: figure out if this interferes with any other weapons
		if (weapon:GetMaxClip1() == -1 and weapon:GetMaxClip2() == -1 and client:GetAmmoCount(ammoType) == 0) then
			client:SetAmmo(1, ammoType)
		end
		
		self:SetData("equip", true)

		if (self.isGrenade) then
			weapon:SetClip1(1)
			client:SetAmmo(0, ammoType)
		end

		weapon.ixItem = self

		if (self.OnEquipWeapon) then
			self:OnEquipWeapon(client, weapon)
		end
	else
		print(Format("[Helix] Cannot equip weapon - %s does not exist!", self.class))
	end
end

function ITEM:OnEquipWeapon(client, weapon)
    local attList = {}
    local upgList = {}        
	local atts = self:GetData("attachments")
	local upgrades = self:GetData("upg")
	local ammotype = self:GetData("ammoType", "Normal")
	
    if (atts) then
        for k, v in pairs(atts) do
            table.insert(attList, v[2])
        end
    end
	
    if (upgrades) then
		for k, v in pairs(upgrades) do
            table.insert(upgList, v[2])
        end
    end
	
    timer.Simple(0.1, function()
		if (IsValid(weapon)) then
			if ammotype ~= "Normal" then
				print(ammotype)
				weapon:attachSpecificAttachment(ammotype)
			end
    		for _, b in ipairs(attList) do
    			weapon:attachSpecificAttachment(b)
    		end
    		for _, b in ipairs(upgList) do
    			weapon:attachSpecificAttachment(b)
			end
    	end
    end)
    weapon:setM203Chamber(false)
end

function ITEM:OnInstanced(invID, x, y)
	if !self:GetData("durability") then
		self:SetData("durability", 10000)
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
			weapon:SetWeaponHP((self:GetData("durability")/100),100)
			client:RemoveAmmo(weapon:Clip1(), weapon:GetPrimaryAmmoType())
			client.carryWeapons[self.weaponCategory] = weapon
			timer.Simple(0.1,function()
			local ammotype = self:GetData("ammoType", "Normal")
				if ammotype ~= "Normal" then
					weapon:attachSpecificAttachment(ammotype)
				end
			end)

			local attList = {}
			local upgList = {}        
			local attachments = self:GetData("attachments")
			local upgrades = self:GetData("upg")

			if (attachments) then
				for k, v in pairs(attachments) do
					table.insert(attList, v[2])
				end
			end
				
			if (upgrades) then
				for k, v in pairs(upgrades) do
					table.insert(upgList, v[2])
				end
			end

			timer.Simple(0.1, function()
				if (IsValid(weapon)) then
					for _, b in ipairs(attList) do
						weapon:attachSpecificAttachment(b)
					end
					for _, b in ipairs(upgList) do
						weapon:attachSpecificAttachment(b)
					end
				end
			end)

			weapon.ixItem = self
		else
			print(Format("[Helix] Cannot give weapon - %s does not exist!", self.class))
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

ITEM.functions.Detach = {
	name = "Detach",
	tip = "Detach",
	icon = "icon16/stalker/detach.png",
    isMulti = true,
    multiOptions = function(item, client)
	
	local targets = {}

	for k, v in pairs(item:GetData("attachments", {})) do
		local attTable = ix.item.list[v[1]]
		local niceName = attTable:GetName()
		table.insert(targets, {
			name = niceName,
			data = {k},
		})
    end
    return targets
end,
	OnCanRun = function(item)
		if (table.Count(item:GetData("attachments", {})) <= 0) then
			return false
		end
				
		return (!IsValid(item.entity))
	end,
	OnRun = function(item, data)
		local client = item.player
		if (data) then
			local char = client:GetChar()

			if (char) then
				local inv = char:GetInv()

				if (inv) then
					local mods = item:GetData("attachments", {})
					local attData = mods[data[1]]
					if (attData) then
					    
						inv:Add(attData[1])
						
				        local wepon = client:GetActiveWeapon()
				        
						if (IsValid(wepon) and wepon:GetClass() == item.class) then
						    for category, data in pairs(wepon.Attachments) do
						        for key, attachment in ipairs(data.atts) do
						            if attachment == attData[2] then
						                wepon:detach(category, key, false)
						                break
						            end
					            end
				            end
						end
						mods[data[1]] = nil
						item:SetData("attachments", mods)
						
						curPrice = item:GetData("RealPrice")
                	    if !curPrice then
                		    curPrice = item.price
                		end
                        item:SetData("RealPrice", (curPrice - ix.item.list[attData[1]].price))
                        
                        local itemweight = item:GetData("weight",0)
                        local targetweight = ix.item.list[attData[1]].weight
                        local totweight = itemweight - targetweight
                        item:SetData("weight", totweight)
                        
						client:EmitSound("cw/holster4.wav")
					else
						client:NotifyLocalized("notAttachment")
					end
				end
			end
		else
			client:NotifyLocalized("detTarget")
		end
	return false
end,
}

ITEM.functions.RemoveUpgrade = {
	name = "Remove Upgrade",
	tip = "Removes an Upgrade",
	icon = "icon16/stalker/detach.png",
    isMulti = true,
    multiOptions = function(item, client)
	
		local targets = {}

		for k, v in pairs(item:GetData("upgrades", {})) do
			local attTable = ix.item.list[v[1]]
			local niceName = attTable:GetName()
			table.insert(targets, {
				name = niceName,
				data = {k},
			})
		end
		return targets
	end,
	OnCanRun = function(item)
		if (table.Count(item:GetData("upgrades", {})) <= 0) then
			return false
		end
		
		if item.player:GetChar():HasFlags("2") then
			return (!IsValid(item.entity))
		end
		
		return false
	end,
	OnRun = function(item, data)
		local client = item.player
		if (data) then
			local char = client:GetChar()

			if (char) then
				local inv = char:GetInv()

				if (inv) then
					local mods = item:GetData("upgrades", {})
					local attData = mods[data[1]]
					if (attData) then
					    
						inv:Add(attData[1])
						
				        local wepon = client:GetActiveWeapon()
				        
						if (IsValid(wepon) and wepon:GetClass() == item.class) then
						    for category, data in pairs(wepon.Attachments) do
						        for key, attachment in ipairs(data.atts) do
						            if attachment == attData[2] then
						                wepon:detach(category, key, false)
						                break
						            end
					            end
				            end
						end
						mods[data[1]] = nil
						item:SetData("attachments", mods)
						
						curPrice = item:GetData("RealPrice")
                	    if !curPrice then
                		    curPrice = item.price
                		end
                        item:SetData("RealPrice", (curPrice - ix.item.list[attData[1]].price))
                        
                        local itemweight = item:GetData("weight",0)
                        local targetweight = ix.item.list[attData[1]].weight
                        local totweight = itemweight - targetweight
                        item:SetData("weight", totweight)
                        
						client:EmitSound("cw/holster4.wav")
					else
						client:NotifyLocalized("notAttachment")
					end
				end
			end
		else
			client:NotifyLocalized("detTarget")
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

ITEM.functions.UpgList = {
    name = "Upgrade List",
    tip = "Checks upgrades, making a list of them.",
    icon = "icon16/tag_blue_edit.png",
    isMulti = true,
    multiOptions = function(item, client)
		print("plz")
    	local targets = {}
        local wepon = client:GetActiveWeapon()
        local SWEP = weapons.Get(item.class)
        local atts = SWEP.Attachments
		local curUpgs = item:GetData("upgrades",{})
        for atcat, data in pairs(atts) do
            for k, name in pairs(data.atts) do
				if upgrades[name] then
					name = upgrades[name]["name"]
					for x,y in pairs(curUpgs) do
						local attTable = ix.item.list[y[1]]
						local niceName = attTable:GetName()
						if name == niceName then
							name = name.." ✓"
						end
					end
				else
					name = "-"
				end
				if name ~= "-" then
					table.insert(targets, {
						name = name,
						data = k,
					})
				end
            end
        end
        return targets
    end;
    
    OnRun = function(item)
        return false
    end;
    
    OnCanRun = function(item)
		return (!IsValid(item.entity))
	end;
}

local function ammoswap(item, data)
    local client = item.player
    local class = item.class
    local SWEP = weapons.Get(class)
    local atts = SWEP.Attachments
    local ammotype = data[1]
    local wepon = client:GetActiveWeapon()
    local curammo = item:GetData("ammoType", name)
	
    if (string.match(tostring(wepon), class)) then
        if (atts) then
            for atcat, dat in pairs(atts) do
                for k, name in pairs(dat.atts) do
                    if (ammotype == name) then
                        if (wepon) then
                            if (curammo ~= name) then
                                client:GiveAmmo(wepon:Clip1(), wepon:GetPrimaryAmmoType(), true)
                                wepon:SetClip1(0)
                                wepon:attachSpecificAttachment(ammotype)
                            else
                                client:NotifyLocalized("Already Using This Ammo Type")
                            end
                        else
                            client:NotifyLocalized("Must Be Equipped")
                        end
					elseif ammotype == "Normal" then
						if (wepon) then
							if name == "am_magnum" or name == "am_matchgrade" or name == "am_slugrounds" or name == "am_flechetterounds" then
								client:GiveAmmo(wepon:Clip1(), wepon:GetPrimaryAmmoType(), true)
								wepon:SetClip1(0)
								wepon:detach(atcat, k, false)
								item:SetData("ammoType", "Normal")
							end
                        end
                    end
					item:SetData("ammoType", ammotype)
                end
            end
        end
    else
        client:NotifyLocalized("Wrong Gun, Pal")
    end
    return false
end


ITEM.functions.SwapAmmo = {
	name = "Change Ammo Type",
	tip = "Detach",
	icon = "icon16/wrench.png",

	OnCanRun = function(item)
		return (!IsValid(item.entity))
	end,
	
	OnRun = function(item, data)
	    return ammoswap(item, data)
	end,
	
	isMulti = true,
    multiOptions = function(item, client)
	
	local targets = {}
    local wepon = item.class
    local SWEP = weapons.Get(wepon)
    local skip = false
    local atts = SWEP.Attachments
    local ammoname = ""
    
    table.insert(targets, {
        name = "Normal",
        data = {"Normal"},
    })
    if (atts) then
        for atcat, data in pairs(atts) do
            for k, name in pairs(data.atts) do
                if name == "am_matchgrade" then
                    ammoname = "Match Grade"
                    table.insert(targets, {
                        name = ammoname,
                        data = {name},
                    })
                elseif name == "am_slugrounds" then
                    ammoname = "Slug"
                    table.insert(targets,{
                        name = ammoname,
                        data = {name},
                    })
                elseif name == "am_flechetterounds" then
                    ammoname = "Flechette"
                    table.insert(targets,{
                        name = ammoname,
                        data = {name},
                    })
				elseif name == "am_birdshot" then
					ammoname = "Birdshot"
					table.insert(targets,{
						name = ammoname,
						data = {name},
					})
				elseif name == "am_trishot" then
					ammoname = "Trishot"
					table.insert(targets,{
						name = ammoname,
						data = {name},
					})
				elseif name == "am_zoneloaded" then
					ammoname = "Zone Loaded"
					table.insert(targets,{
						name = ammoname,
						data = {name},
					})
                end
            end
        end
    end
    return targets
end,
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
			v:SetData("equip", nil)

			if (v.pacData) then
				v:RemovePAC(client)
			end
		end
	end
end)
