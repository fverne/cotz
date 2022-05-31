ITEM.name = "Attachment"
ITEM.description = "An attachment."
ITEM.category = "Attachments"
ITEM.model = "models/props/cs_office/Cardboard_box02.mdl"

ITEM.width = 1
ITEM.height = 1
ITEM.price = 0

ITEM.attachName = "namegoeshere"
ITEM.upgradeIcon = Material("materials/vgui/ui/stalker/weaponupgrades/genericmod.png")

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
    if (!self.entity) then
        ix.util.PropertyDesc(tooltip, "Weapon Attachment", Color(64, 224, 208))
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

				for k, v in pairs(items) do
					if (v.isWeapon and v.canAttach) then
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
		return (!IsValid(item.entity)) and item.invID == item:GetOwner():GetCharacter():GetInventory():GetID()
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
				client:Notify("No weapon selected.")
				return false
			end
		end
		
		targetAttach = target:GetData("attachments") or {}
		if targetAttach then
			for k = 1, #targetAttach do
				if ix.weapontables.attachments[targetAttach[k]].slot == item.attachSlot then
					client:Notify("Weapon already has an attachment of this type installed.")
					return false
				end
			end
		end

		for k = 1, #target.validAttachments do
			if target.validAttachments[k] == item.attachName then
				table.Add(targetAttach,{item.attachName})
				target:SetData("attachments", targetAttach)
				client:Notify("Installed "..item.name.." on "..target.name)
				
				local wepon = client:GetWeapon(target.class)
                -- If you're holding right weapon, just mod it out.
                if (IsValid(wepon) and wepon:GetClass() == target.class) then
                    wepon:attachSpecificAttachment(item.attachName)
				end
				return true
			end
		end

		client:Notify(target.name.." does not support this attachment.")
		return false
	end,
}