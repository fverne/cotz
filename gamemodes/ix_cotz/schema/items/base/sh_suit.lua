ITEM.name = "Armor"
ITEM.description = "An Armor Base."
ITEM.category = "Armor"
ITEM.model = "models/Gibs/HGIBS.mdl"
ITEM.longdesc = "No Longer Description Available"

ITEM.width = 1
ITEM.height = 1

ITEM.ballisticareas = {"  Head:", "  Torso:", "  Abdomen:", "  Arms:", "  Legs:", "  Anomaly:", "  Radiation:"}
ITEM.outfitCategory = "model"
ITEM.isBodyArmor = true
ITEM.skincustom = {}
ITEM.bgcustom = {}

ITEM.br = 0
ITEM.fbr = 0
ITEM.sr = 0
ITEM.fsr = 0
ITEM.ar = 0
ITEM.far = 0
ITEM.pr = nil
ITEM.fpr = 0
ITEM.radProt = nil
ITEM.equipIcon = ix.util.GetMaterial("materials/vgui/ui/stalker/misc/equip.png")

ITEM.canRepair = true

ITEM.weight = 0

ITEM.miscslots = 1

--[[
-- This will change a player's skin after changing the model. Keep in mind it starts at 0.
ITEM.newSkin = 1
-- This will change the player's model completely.
ITEM.newModel = "models/manhack.mdl"

-- This will apply body groups.
ITEM.bodyGroups = {
	["blade"] = 1,
	["bladeblur"] = 1
}
]]--

function ITEM:GetRepairCost()
	return math.pow(self.price, 1/2)
end

function ITEM:GetDescription()
	local quant = self:GetData("quantity", self.ammoAmount or self.quantity or 0)
	local quantdesc = ""
	local invdesc = ""
	local duradesc = ""

	if self.longdesc then
		invdesc = "\n\n"..(self.longdesc)
	end

	if self.quantdesc then
		quantdesc = "\n\n"..Format(self.quantdesc, quant)
	end

	if self:GetData("durability", nil) then
		duradesc = "\n\n".."Durability: " .. math.floor(self:GetData("durability", 100)) .. "%"
	end


	if (self.entity) then
		return (self.description..duradesc)
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

		--Less mental way of doing the above:
		local dura = 0
		local wear = 0

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
			ix.util.DrawResistances(tooltip, self)

			if((self.miscslots or 0) > 0) then
				local attachmenttitle = tooltip:AddRow("attachments")
				attachmenttitle:SetText("\nAttachments: ")
				attachmenttitle:SizeToContents()

				local lastrow = attachmenttitle

				local attachmentdata = self:GetData("attachments", {})
				for i = 1, (self.miscslots or 0) do
					local attachmenttmp = tooltip:AddRowAfter("attachments", "attachment"..i)
					local attachmentstr = "  ⬜ None"
					attachmenttmp:SetTextColor(Color(120,120,120))
					if(attachmentdata[i]) then
						attachmentstr = "  ⬛ "
						if (!ix.armortables.attachments[attachmentdata[i]]) then continue end
						attachmentstr = attachmentstr..ix.armortables.attachments[attachmentdata[i]].name
						attachmenttmp:SetTextColor(Color(255,255,255))
					end

					attachmenttmp:SetText(attachmentstr)
					attachmenttmp:SetFont("ixSmallFont")
					attachmenttmp:SizeToContents()

					lastrow = attachmenttmp
				end

			end
			
			if self:GetData("setSkin", self.newSkin) then
				local skintitle = tooltip:AddRow("skintitle")
				skintitle:SetText("\nCurrent skin: "..self:GetData("setSkin", self.newSkin))
				skintitle:SizeToContents()
			end

			local duratitle = tooltip:AddRowAfter("skintitle", "duratitle")
			duratitle:SetText("\nDurability: " .. math.floor(self:GetData("durability", 100)) .. "%")
			duratitle:SizeToContents()

			ix.util.PropertyDesc2(tooltip, "Protective Suit", Color(64, 224, 208), Material("vgui/ui/stalker/weaponupgrades/handling.png"))

			if self.isGasmask then
	        	ix.util.PropertyDesc2(tooltip, "Gasmask", Color(64, 224, 208), Material("vgui/ui/stalker/weaponupgrades/handling.png"))
	        end
	        
	        if self.isHelmet then
	        	ix.util.PropertyDesc2(tooltip, "Helmet", Color(64, 224, 208), Material("vgui/ui/stalker/weaponupgrades/handling.png"))
	        end

	        if (self.PopulateTooltipIndividual) then
		      self:PopulateTooltipIndividual(tooltip)
		    end
		end

		tooltip:SizeToContents()
	end
end

function ITEM:RemoveOutfit(client)
	local character = client:GetCharacter()
	local bgroups = {}

	self:SetData("equip", false)
	if (character:GetData("oldModel" .. self.outfitCategory)) then
		character:SetModel(character:GetData("oldModel" .. self.outfitCategory))
		character:SetData("oldModel" .. self.outfitCategory, nil)
	end

	if (self.newSkin) then
		if (character:GetData("oldSkin" .. self.outfitCategory)) then
			client:SetSkin(character:GetData("oldSkin" .. self.outfitCategory))
			character:SetData("oldSkin" .. self.outfitCategory, nil)
		else
			client:SetSkin(0)
		end
	end

	for k, _ in pairs(self.bodyGroups or {}) do
		local index = client:FindBodygroupByName(k)

		if (index > -1) then
			client:SetBodygroup(index, 0)

			local groups = character:GetData("groups", {})

			if (groups[index]) then
				groups[index] = nil
				character:SetData("groups", groups)
			end
		end
	end

	for k, v in pairs( self:GetData("origgroups", {})) do
		self.player:SetBodygroup( k, v )
		bgroups[k] = v
	end

	self.player:GetCharacter():SetData("groups", bgroups)

	self:OnUnequipped()
end

function ITEM:OnInstanced()
	self:SetData("durability", 100)
end

ITEM.functions.zCustomizeSkin = {
	name = "Customize Skin",
	tip = "useTip",
	icon = "icon16/stalker/customize.png",
	isMulti = true,
	multiOptions = function(item, client)
		local targets = {}

		for k, v in pairs(item.skincustom) do
			table.insert(targets, {
				name = v.name,
				data = {v.skingroup, v.modelOverride or nil},
			})
		end

		return targets
	end,
	OnCanRun = function(item)				
		return (!IsValid(item.entity) and #item.skincustom > 0 and item:GetData("equip") == true and item:GetOwner():GetCharacter():GetInventory():HasItem("paint") and item:GetOwner():GetCharacter():GetFlags("T"))
	end,
	OnRun = function(item, data)
		if !data[1] then
			return false
		end

		item.player:SetSkin(data[1])
		item:SetData("setSkin", data[1])
		if data[2] then
			item.player:GetCharacter():SetModel(data[2])
			item:SetData("setSkinOverrideModel", data[2])
		else
			item.player:GetCharacter():SetModel(item.newModel)
			item:SetData("setSkinOverrideModel", nil)
		end

		return false
	end,
}

ITEM:Hook("drop", function(item)
	local client = item.player
	if (item:GetData("equip")) then
		item.player:RecalculateResistances()
		item.player:ReevaluateOverlay()
		item:RemoveOutfit(item:GetOwner())
	end
end)

ITEM.functions.EquipUn = { -- sorry, for name order.
	name = "Take Off",
	tip = "equipTip",
	icon = "icon16/stalker/unequip.png",
	OnRun = function(item)
		local client = item.player
				
		item:RemoveOutfit(item.player)

		ix.util.PlayerPerformBlackScreenAction(item.player, "Taking off...", 6, function(player) 
		end)

		item.player:RecalculateResistances()
		item.player:ReevaluateOverlay()
		
		return false
	end,
	OnCanRun = function(item)
		local client = item.player

		return !IsValid(item.entity) and IsValid(client) and item:GetData("equip") == true and
			hook.Run("CanPlayerUnequipItem", client, item) != false and item.invID == item.player:GetCharacter():GetInventory():GetID()
	end
}

ITEM.functions.Equip = {
	name = "Put On",
	tip = "equipTip",
	icon = "icon16/stalker/equip.png",
	OnRun = function(item)
		local client = item.player
		local char = client:GetCharacter()
		local items = char:GetInventory():GetItems()

		for _, v in pairs(items) do
			if (v.id != item.id) then
				local itemTable = ix.item.instances[v.id]

				if (itemTable.isBodyArmor and v.outfitCategory == item.outfitCategory and itemTable:GetData("equip")) then
					item.player:Notify("You're already equipping a suit!")

					return false
				end

				if (v.isHelmet == true and item.isHelmet == true and itemTable:GetData("equip")) then
					item.player:Notify("You are already equipping a helmet!")

					return false
				end

				if (v.isGasmask == true and item.isGasmask == true and itemTable:GetData("equip")) then
					item.player:Notify("You are already equipping a gasmask!")

					return false
				end
			end
		end

		
		ix.util.PlayerPerformBlackScreenAction(item.player, "Putting on...", 6, function(player) 
		end)
		
		item:SetData("equip", true)
		
		local origbgroups = {}
		for k, v in ipairs(client:GetBodyGroups()) do
			origbgroups[v.id] = client:GetBodygroup(v.id)
		end
		item:SetData("origgroups", origbgroups)

		item.player:RecalculateResistances()
		item.player:ReevaluateOverlay()

		char:SetData("oldModel" .. item.outfitCategory, char:GetData("oldModel" .. item.outfitCategory, item.player:GetModel()))
		char:SetModel(item.newModel)

		if (item.newSkin) then
			char:SetData("oldSkin" .. item.outfitCategory, item.player:GetSkin())
			item.player:SetSkin(item.newSkin)
			if item:GetData("setSkin", nil) != nil then
				client:SetSkin( item:GetData("setSkin", item.newSkin) )
			end
		end

		item:OnEquipped()
		return false
	end,
	OnCanRun = function(item)
		local client = item.player

		return !IsValid(item.entity) and IsValid(client) and item:GetData("equip") != true and
			hook.Run("CanPlayerEquipItem", client, item) != false and item.invID == item.player:GetCharacter():GetInventory():GetID()
	end
}

ITEM.functions.detach = {
	name = "Detach",
	icon = "icon16/stalker/detach.png",
	isMulti = true,
	multiOptions = function(item, client)
		local targets = {}
		local curattach = item:GetData("attachments") or {}

		for k = 1, #curattach do
			table.insert(targets, {
				name = ix.armortables.attachments[curattach[k]].name,
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

			local curattach = item:GetData("attachments") or {}
			local iterator = 0
			for i = 1, #curattach do
				iterator = iterator+1
				if curattach[i] == data[1] then
					break
				end
			end

			if table.remove(curattach,iterator) != data[1] then
				return false
			end

			if not item.player:GetCharacter():GetInventory():Add(ix.armortables.attachments[data[1]].uID) then
				local position = item.player:GetItemDropPos()
				ix.item.Spawn(ix.armortables.attachments[data[1]].uID, position, nil, AngleRand())
				position = position + Vector(0, 0, 5)
				item.player:Notify("No space in your inventory! Items have been dropped.")
			end			

			if( isfunction(ix.armortables.attachments[data[1]].onDetach) ) then
				ix.armortables.attachments[data[1]].onDetach(item.player, item)
			end

			item:SetData("attachments", curattach)

			-- Recalc resistances
			item.player:RecalculateResistances()

		else
			item.player:Notify("No attachment selected.")
		end
		return false
	end,
}

function ITEM:OnLoadout()
	if (self:GetData("equip")) then
		local client = self.player

		if self:GetData("setSkin", self.newSkin) then
			client:SetSkin( self:GetData("setSkin", self.newSkin) )
		end

		if self:GetData("setBG", nil) then
			local data = self:GetData("setBG", nil)
			local bgroup = data[1]
			local bgroupsub = data[2]

			for i=1,#bgroup do
				client:SetBodygroup( bgroup[i], bgroupsub[i] )
			end
		end

		if (self.bodyGroups) then
			local groups = {}

			for k, value in pairs(self.bodyGroups) do
				local index = client:FindBodygroupByName(k)

				if (index > -1) then
					groups[index] = value
				end
			end

			local newGroups = client:GetCharacter():GetData("groups", {})

			for index, value in pairs(groups) do
				newGroups[index] = value
				client:SetBodygroup(index, value)
			end

			if (table.Count(newGroups) > 0) then
				client:GetCharacter():SetData("groups", newGroups)
			end
		end
	end
end

function ITEM:CanTransfer(oldInventory, newInventory)
	if (newInventory and self:GetData("equip")) then
		return false
	end

	return true
end

function ITEM:OnRemoved()
	local client = self:GetOwner()
	if (self:GetData("equip")) then
		client:RecalculateResistances()
		client:ReevaluateOverlay()
		self:RemoveOutfit(self:GetOwner())
	end
end

function ITEM:OnEquipped()
	self.player:EmitSound("stalkersound/inv_slot.mp3", 50, 100, 1)
	self:OnLoadout()
end

function ITEM:OnUnequipped()
	self.player:EmitSound("stalkersound/inv_slot.mp3", 50, 100, 1)
end

function ITEM:getBR() 
	local res = 1
	local upgrades = self:GetData("upgrades", {})

	if self:GetData("durability",100) < 80 then
		res = 1 - (self.br * (self:GetData("durability",0)/80))
	else
		res = 1 - self.br
	end
	
	for k,v in pairs(upgrades) do
		if (!ix.armortables.upgrades[v]) then continue end
		if ix.armortables.upgrades[v].br then
			res = res - ix.armortables.upgrades[v].br
		end
	end
	
	--For artifacts, kevlarplates, mutant hides, etc..
	local attachments = self:GetData("attachments", {})
	
	for k,v in pairs(attachments) do
		if (!ix.armortables.attachments[v]) then continue end
		if ix.armortables.attachments[v].br then
			res = res * (1 - ix.armortables.attachments[v].br)
		end
	end

	return res
end

function ITEM:getFBR() 
	local res = self.fbr
	local upgrades = self:GetData("upgrades", {})

	if self:GetData("durability",100) < 80 then
		res = self.fbr * (self:GetData("durability",0)/80)
	else
		res = self.fbr
	end
	
	for k,v in pairs(upgrades) do
		if (!ix.armortables.upgrades[v]) then continue end
		if ix.armortables.upgrades[v].fbr then
			res = res + ix.armortables.upgrades[v].fbr
		end
	end
	
	return res
end

function ITEM:getSR() 
	local res = 1
	local upgrades = self:GetData("upgrades", {})

	if self:GetData("durability",100) < 80 then
		res = 1 - (self.sr * (self:GetData("durability",0)/80))
	else
		res = 1 - self.sr
	end
	
	for k,v in pairs(upgrades) do
		if (!ix.armortables.upgrades[v]) then continue end
		if ix.armortables.upgrades[v].sr then
			res = res - ix.armortables.upgrades[v].sr
		end
	end
	
	--For artifacts, kevlarplates, mutant hides, etc..
	local attachments = self:GetData("attachments", {})
	
	for k,v in pairs(attachments) do
		if (!ix.armortables.attachments[v]) then continue end
		if ix.armortables.attachments[v].sr then
			res = res * (1 - ix.armortables.attachments[v].sr)
		end
	end

	return res
end

function ITEM:getFSR() 
	local res = self.fsr
	local upgrades = self:GetData("upgrades", {})

	if self:GetData("durability",100) < 80 then
		res = self.fsr * (self:GetData("durability",0)/80)
	else
		res = self.fsr
	end
	
	for k,v in pairs(upgrades) do
		if (!ix.armortables.upgrades[v]) then continue end
		if ix.armortables.upgrades[v].fsr then
			res = res + ix.armortables.upgrades[v].fsr
		end
	end
	
	return res
end

function ITEM:getPR() 
	local res = 1
	local upgrades = self:GetData("upgrades", {})
	
	for k,v in pairs(upgrades) do
		if (!ix.armortables.upgrades[v]) then continue end
		if ix.armortables.upgrades[v].pr then
			res = res - ix.armortables.upgrades[v].pr
		end
	end

	--For artifacts, kevlarplates, mutant hides, etc..
	local attachments = self:GetData("attachments", {})
	
	for k,v in pairs(attachments) do
		if (!ix.armortables.attachments[v]) then continue end
		if ix.armortables.attachments[v].pr then
			res = res * (1 - ix.armortables.attachments[v].pr)
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

	--For artifacts, kevlarplates, mutant hides, etc..
	local attachments = self:GetData("attachments", {})

	for k,v in pairs(attachments) do
		if (!ix.armortables.attachments[v]) then continue end
		if ix.armortables.attachments[v].fpr then
			res = res + ix.armortables.attachments[v].fpr
		end
	end
	
	return res
end

function ITEM:getAR()
	local res = 1
	local upgrades = self:GetData("upgrades", {})

	if self:GetData("durability",100) < 80 then
		res = 1 - (self.ar * (self:GetData("durability",0)/80))
	else
		res = 1 - self.ar
	end
	
	for k,v in pairs(upgrades) do
		if (!ix.armortables.upgrades[v]) then continue end
		if ix.armortables.upgrades[v].ar then
			res = res - ix.armortables.upgrades[v].ar
		end
	end
	
	--For artifacts, kevlarplates, mutant hides, etc..
	local attachments = self:GetData("attachments", {})
	
	for k,v in pairs(attachments) do
		if (!ix.armortables.attachments[v]) then continue end
		if ix.armortables.attachments[v].ar then
			res = res * (1 - ix.armortables.attachments[v].ar)
		end
	end

	return res
end

function ITEM:getFAR() 
	local res = self.far
	local upgrades = self:GetData("upgrades", {})

	if self:GetData("durability",100) < 80 then
		res = self.far * (self:GetData("durability",0)/80)
	else
		res = self.far
	end
	
	for k,v in pairs(upgrades) do
		if (!ix.armortables.upgrades[v]) then continue end
		if ix.armortables.upgrades[v].far then
			res = res + ix.armortables.upgrades[v].far
		end
	end
	
	return res
end

function ITEM:GetWeight()
  local retval = self.weight

  local upgrades = self:GetData("upgrades", {})
	
  for k,v in pairs(upgrades) do
  	if (!ix.armortables.upgrades[v]) then continue end
    if ix.armortables.upgrades[v].weight then
		  retval = retval + ix.armortables.upgrades[v].weight
    end
  end
	
	--For artifacts, kevlarplates, mutant hides, etc..
	local attachments = self:GetData("attachments", {})
	
	for k,v in pairs(attachments) do
		if (!ix.armortables.attachments[v]) then continue end
		if ix.armortables.attachments[v].weight then
			retval = retval + ix.armortables.attachments[v].weight
		end
	end

  return retval
end

function ITEM:RunAllAttachmentAttach()
	local attachments = self:GetData("attachments", {})
	
	for k,v in pairs(attachments) do
		if (!ix.armortables.attachments[v]) then continue end
		if ix.armortables.attachments[v].onAttach then
			ix.armortables.attachments[v].onAttach(self:GetOwner(), self)
		end
	end
end

function ITEM:RunAllAttachmentDetach()
	local attachments = self:GetData("attachments", {})

	for k,v in pairs(attachments) do
		if (!ix.armortables.attachments[v]) then continue end
		if ix.armortables.attachments[v].onDetach then
			ix.armortables.attachments[v].onDetach(self:GetOwner(), self)
		end
	end
end