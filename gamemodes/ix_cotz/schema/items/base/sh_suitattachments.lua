ITEM.name = "Attachment"
ITEM.description = "An attachment."
ITEM.category = "Attachments"
ITEM.model = "models/props/cs_office/Cardboard_box02.mdl"

ITEM.width = 1
ITEM.height = 1
ITEM.price = 0

ITEM.attachName = "namegoeshere"

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

function ITEM:PopulateTooltip(tooltip)

    if (ix.armortables.attachments[self.attachName]) then
		if ix.armortables.attachments[self.attachName].br then
			ix.util.DrawResistance(tooltip, "Ballistics: ", ix.armortables.attachments[self.attachName].br, 0)
		end
		if ix.armortables.attachments[self.attachName].sr then
			ix.util.DrawResistance(tooltip, "Rupture: ", ix.armortables.attachments[self.attachName].sr, 0)
		end
		if ix.armortables.attachments[self.attachName].ar then
			ix.util.DrawResistance(tooltip, "Anomalous: ", ix.armortables.attachments[self.attachName].ar, 0)
		end
		if ix.armortables.attachments[self.attachName].pr then
			ix.util.DrawResistance(tooltip, "Psychic: ", ix.armortables.attachments[self.attachName].pr, 0)
		end
		if ix.armortables.attachments[self.attachName].radProt then
			ix.util.DrawResistance(tooltip, "Radiation: ", ix.armortables.attachments[self.attachName].radProt, 0)
		end
		if (!self.entity) then
	        ix.util.PropertyDesc(tooltip, "Suit Attachment", Color(64, 224, 208))
		end
		if ix.armortables.attachments[self.attachName].tooltip then
	        ix.util.PropertyDesc(tooltip, ix.armortables.attachments[self.attachName].tooltip, Color(64, 224, 208))
		end
		
	end


    if (self.PopulateTooltipIndividual) then
      self:PopulateTooltipIndividual(tooltip)
    end
end

ITEM.functions.use = {
	name = "Install",
	tip = "useTip",
	icon = "icon16/stalker/attach.png",
	isMulti = true,
	multiOptions = function(item, client)
		local targets = {}
		local char = client:GetCharacter()         
		
		if (char) then
			local inv = char:GetInventory()

			if (inv) then
				local items = inv:GetItems()
				local slot = ix.armortables.attachments[item.attachName].slot
				
				for k, v in pairs(items) do
					if (v.isBodyArmor and (v.maxMiscSlots[slot] or 0) > 0) then
						table.insert(targets, {
							name = L(v.name),
							data = {v:GetID()},
						})
					else
						continue
					end
				end
			end
		end

		return targets
		end,
	OnCanRun = function(item)				
		return (!IsValid(item.entity)) and item.invID == item.player:GetCharacter():GetInventory():GetID()
	end,
	OnRun = function(item, data)
		local client = item.player
		local char = client:GetCharacter()
		local inv = char:GetInventory()
		local items = inv:GetItems()
		local target = data[1]
		
		for k, invItem in pairs(items) do
			if (data[1]) then
				if (invItem:GetID() == data[1]) then
					target = invItem

					break
				end
			else
				client:Notify("No armor selected.")
				return false
			end
		end
		
		local slot = ix.armortables.attachments[item.attachName].slot
		local targetAttach = target:GetData("attachments") or {}
		local targetMiscSlotAttach = targetAttach[slot]
		if targetMiscSlotAttach then
			if #targetMiscSlotAttach >= target.maxMiscSlots[slot] then
				client:Notify("The armor has no free attachment slots.")
				return false
			end
		end

		if( isfunction(ix.armortables.attachments[item.attachName].onAttach) ) then
			ix.armortables.attachments[item.attachName].onAttach(client, target)
		end

		table.insert(targetMiscSlotAttach,item.attachName)
		targetAttach[slot] = targetMiscSlotAttach

		target:SetData("attachments", targetAttach)
		client:Notify("Installed "..item.name.." on "..target.name)

		-- Recalc resistances
		client:RecalculateResistances()
		ix.weight.Update(char)
		return true
	end,
}

hook.Add("PlayerPostThink", "ixSuitAttachThink", function(client)
	if CLIENT then return end
	if (client.nextsuitthink or 0) > CurTime() then return end
	if (!client:GetChar()) then return end

	client.nextsuitthink = CurTime()+5
	local armor = client:getEquippedBodyArmor()
	if (!armor) then return end

	for _, v in pairs(armor:GetData("attachments", {})) do
		for _, v2 in pairs(v) do
			if (isfunction(ix.armortables.attachments[v2].onThink)) then
				ix.armortables.attachments[v2].onThink(client)
			end
		end
	end
end)
