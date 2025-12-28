ITEM.name = "PAC Outfit"
ITEM.description = "A PAC Outfit Base."
ITEM.longdesc = "No Longer Description Available"
ITEM.category = "Outfit"
ITEM.model = "models/Gibs/HGIBS.mdl"

ITEM.width = 2
ITEM.height = 2
ITEM.price = 0

ITEM.pacData = {}

ITEM.isHelmet = nil
ITEM.isGasmask = nil

ITEM.br = 0
ITEM.fbr = 0
ITEM.sr = 0
ITEM.fsr = 0
ITEM.ar = 0
ITEM.far = 0
ITEM.pr = 0
ITEM.fpr = 0
ITEM.flatRadProt = 0
ITEM.radProt = 0
ITEM.resistance = true

ITEM.equipIcon = ix.util.GetMaterial("materials/vgui/ui/stalker/misc/equip.png")

ITEM.weight = 0


function ITEM:GetDescription()
	local quant = self:GetData("quantity", self.ammoAmount or self.quantity or 0)
	local quantdesc = ""
	local invdesc = ""
	if self.longdesc then
		invdesc = "\n\n"..(self.longdesc)
	end

	if self.quantdesc then
		quantdesc = "\n\n"..Format(self.quantdesc, quant)
	end

	if (self.entity) then
		return (self.description)
	else
        return (self.description..quantdesc..invdesc)
	end
end

-- Inventory drawing
if (CLIENT) then
	local Texture2 = Material("cotz/panels/hp1.png", "noclamp smooth")

	function ITEM:PaintOver(item, w, h)
		if (item:GetData("equip")) then
			surface.SetDrawColor(110, 255, 110, 255)
		else
			surface.SetDrawColor(255, 110, 110, 255)
		end

		surface.SetMaterial(item.equipIcon)
		surface.DrawTexturedRect(w-23,h-23,19,19)

		local dura = 0

		if (item:GetData("durability")) then
			dura = item:GetData("durability",0)
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
	end

	function ITEM:PopulateTooltip(tooltip)
		if !self.entity then
			ix.util.DrawGearResistances(tooltip, self)

			local duratitle = tooltip:AddRow("duratitle")
			duratitle:SetText("\nDurability: " .. math.floor(self:GetData("durability", 100)) .. "%")
			duratitle:SizeToContents()

			if self.isGasmask then
	        	ix.util.PropertyDesc2(tooltip, "Gasmask", Color(64, 224, 208), Material("vgui/ui/stalker/weaponupgrades/handling.png"))
	        end

	        if self.isHelmet then
	        	ix.util.PropertyDesc2(tooltip, "Helmet", Color(64, 224, 208), Material("vgui/ui/stalker/weaponupgrades/handling.png"))
	        end

			if self.isBackPack then
	        	ix.util.PropertyDesc2(tooltip, "Backpack", Color(64, 224, 208), Material("vgui/ui/stalker/weaponupgrades/handling.png"))
	        end

	        if (self.PopulateTooltipIndividual) then
		      self:PopulateTooltipIndividual(tooltip)
		    end
		end
	end
end

function ITEM:OnInstanced()
	self:SetData("durability", 100)
end

function ITEM:RemovePart(client)
	local char = client:GetCharacter()
	client:RemovePart(self.uniqueID)

	if (self.attribBoosts) then
		for k, _ in pairs(self.attribBoosts) do
			char:RemoveBoost(self.uniqueID, k)
		end
	end
end

-- On item is dropped, Remove a weapon from the player and keep the ammo in the item.
ITEM:Hook("drop", function(item)
	if (item:GetData("equip")) then
		item.player:RecalculateResistances()
		item.player:ReevaluateOverlay()
		item:RemovePart(item:GetOwner())
	end
end)

-- On player uneqipped the item, Removes a weapon from the player and keep the ammo in the item.
ITEM.functions.EquipUn = { -- sorry, for name order.
	name = "Take Off",
	tip = "equipTip",
	icon = "icon16/stalker/unequip.png",
	OnRun = function(item)
		ix.util.PlayerPerformBlackScreenAction(item.player, "Taking off...", 4, function(ply)
			item:SetData("equip", false)
			item:RemovePart(ply)
			ply:RecalculateResistances()
			ply:ReevaluateOverlay()
		end)

		item:OnUnequipped()

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
	name = "Put On",
	tip = "equipTip",
	icon = "icon16/stalker/equip.png",
	OnRun = function(item)
		local char = item.player:GetCharacter()
		local items = char:GetInventory():GetItems()

		for _, v in pairs(items) do
			if (v.id != item.id) then
				local itemTable = ix.item.instances[v.id]

				if (v.isHelmet == true and item.isHelmet == true and itemTable:GetData("equip")) then
					item.player:Notify("You are already equipping a helmet!")

					return false
				end

				if (v.isGasmask == true and item.isGasmask == true and itemTable:GetData("equip")) then
					item.player:Notify("You are already equipping a gasmask!")

					return false
				end

				if (v.isBackpack == true and item.isBackpack == true and itemTable:GetData("equip")) then
					item.player:Notify("You are already equipping a backpack!")

					return false
				end
			end
		end

		ix.util.PlayerPerformBlackScreenAction(item.player, "Putting on...", 4, function(ply)
			if item.invID != ply:GetCharacter():GetInventory():GetID() then return end
			item:SetData("equip", true)
			ply:AddPart(item.uniqueID, item)

			if (item.attribBoosts) then
				for k, v in pairs(item.attribBoosts) do
					char:AddBoost(item.uniqueID, k, v)
				end
			end

			ply:RecalculateResistances()
			ply:ReevaluateOverlay()
		end)

		item:OnEquipped()

		return false
	end,
	OnCanRun = function(item)
		local client = item.player

		return !IsValid(item.entity) and IsValid(client) and item:GetData("equip") != true and item.invID == item.player:GetCharacter():GetInventory():GetID()
	end
}

function ITEM:CanTransfer(oldInventory, newInventory)
	if (newInventory and self:GetData("equip")) then
		return false
	end

	return true
end

function ITEM:OnRemoved()
	local inventory = ix.item.inventories[self.invID]
	local owner = inventory.GetOwner and inventory:GetOwner()

	if (IsValid(owner) and owner:IsPlayer()) then
		if (self:GetData("equip")) then
			self:RemovePart(owner)
		end
	end
end

function ITEM:OnEquipped()
	if self.isGasmask == true then
		-- self.player:ApplyDSPGasmask()
		self:GetOwner():EmitSound("stalkersound/gasmask_on.ogg")
		return
	end
end

function ITEM:OnUnequipped()
	if self.isGasmask == true then
		-- self.player:UnApplyDSPGasmask()
		self:GetOwner():EmitSound("stalkersound/gasmask_off.ogg")
		return
	end
end


function ITEM:getBR()
	local res = self.br
	local upgrades = self:GetData("upgrades", {})

	for k,v in pairs(upgrades) do
		if upgrades[v].br ~= nil then
			res = res + upgrades[v].br
		end
	end

	return res
end

function ITEM:getFBR()
	local res = self.fbr
	local upgrades = self:GetData("upgrades", {})

	for k,v in pairs(upgrades) do
		if upgrades[v].fbr ~= nil then
			res = res + upgrades[v].fbr
		end
	end

	return res
end

function ITEM:getSR() 
	local res = self.sr
	local upgrades = self:GetData("upgrades", {})

	for k,v in pairs(upgrades) do
		if upgrades[v].sr ~= nil then
			res = res + upgrades[v].sr
		end
	end

	return res
end

function ITEM:getFSR() 
	local res = self.fsr
	local upgrades = self:GetData("upgrades", {})
	
	for k,v in pairs(upgrades) do
		if (!ix.armortables.upgrades[v]) then continue end
		if ix.armortables.upgrades[v].fsr then
			res = res + ix.armortables.upgrades[v].fsr
		end
	end
	
	return res
end

function ITEM:getAR()
	local res = self.ar
	local upgrades = self:GetData("upgrades", {})

	for k,v in pairs(upgrades) do
		if v.ar ~= nil then
			res = res + upgrades[v].ar
		end
	end

	return res
end

function ITEM:getFAR()
	local res = self.far
	local upgrades = self:GetData("upgrades", {})

	for k,v in pairs(upgrades) do
		if upgrades[v].far ~= nil then
			res = res + upgrades[v].far
		end
	end

	return res
end


function ITEM:getPR() 
	local res = self.pr
	local upgrades = self:GetData("upgrades", {})
	
	for k,v in pairs(upgrades) do
		if (!ix.armortables.upgrades[v]) then continue end
		if ix.armortables.upgrades[v].pr then
			res = res + ix.armortables.upgrades[v].pr
		end
	end

	return res
end

function ITEM:getFPR() 
	local res = self.fpr
	local upgrades = self:GetData("upgrades", {})
	
	for k,v in pairs(upgrades) do
		if (!ix.armortables.upgrades[v]) then continue end
		if ix.armortables.upgrades[v].fpr then
			res = res + ix.armortables.upgrades[v].fpr
		end
	end
	
	return res
end

function ITEM:getRadProt()
	local res = self.radProt
	local upgrades = self:GetData("upgrades", {})

	for k,v in pairs(upgrades) do
		if upgrades[v].radProt ~= nil then
			res = res + upgrades[v].radProt
		end
	end

	return res
end


-- function ITEM:pacAdjust(pacdata, client)
-- 	if (client:GetModel() == "models/nasca/stalker/male_berill1.mdl") then
--     	return self.pacDataBerill1
-- 	elseif (client:GetModel() == "models/nasca/stalker/male_expedition.mdl") then
-- 	   	return self.pacDataExpedition
-- 	elseif (client:GetModel() == "models/nasca/stalker/male_nbc_lone.mdl" or client:GetModel() == "models/nasca/stalker/male_nbc_mono.mdl" or client:GetModel() == "models/nasca/stalker/male_nbc_free.mdl" or client:GetModel() == "models/nasca/stalker/male_nbc_duty.mdl") then
-- 	   	return self.pacDataNBC
--     /*elseif (client:GetModel() == "models/nasca/stalker/male_eagle_lone.mdl" or client:GetModel() == "models/nasca/stalker/male_eagle_bandit.mdl" or client:GetModel() == "models/nasca/stalker/male_eagle_duty.mdl" or client:GetModel() == "models/nasca/stalker/male_eagle_free.mdl" or client:GetModel() == "models/nasca/stalker/male_eagle_merc.mdl") then
--     	print(client:GetModel())
--     	client:Notify("eagle")
--     	return self.pacDataEagle*/
--     else
--     	return self.pacData
-- 	end
-- end
