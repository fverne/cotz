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
	local description = self:GetData("description", self.description)
	if self.entity or not self.longdesc or self.longdesc == "" then return description end

	return description .. "\n\n" .. self.longdesc
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
	icon = "icon16/stalker_grey/attach.png",
	isMulti = true,
	multiOptions = function(item, client)
		local targets = {}
		local char = client:GetCharacter()         
		
		if (char) then
			local inv = char:GetInventory()

			if (inv) then
				local items = inv:GetItems()

				for _, weapon in pairs(items) do
					if weapon.isWeapon and weapon.canAttach
						and table.HasValue(weapon.validAttachments, item.attachName) then
						table.insert(targets, {
							name = L(weapon.name),
							data = {weapon:GetID()},
						})
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
		local target = istable(data) and items[data[1]]
		if not target or not target.isWeapon or not target.canAttach then
			client:Notify("No compatible weapon selected.")
			return false
		end

		if not table.HasValue(target.validAttachments, item.attachName) then
			client:Notify(target.name .. " does not support this attachment.")
			return false
		end

		local attachments = target:GetData("attachments", {})
		for _, attachment in ipairs(attachments) do
			local definition = ix.weapontables.attachments[attachment]
			if definition and definition.slot == item.attachSlot then
				client:Notify("Weapon already has an attachment of this type installed.")
				return false
			end
		end

		ix.weight.Update(char)
		attachments[#attachments + 1] = item.attachName
		target:SetData("attachments", attachments)
		client:Notify("Installed " .. item.name .. " on " .. target.name)

		local weapon = client:GetWeapon(target.class)
		if IsValid(weapon) and weapon.ixItem == target then
			weapon:attachSpecificAttachment(item.attachName)
		end

		return true
	end,
}
