ITEM.name = "Kerosene"
ITEM.description = "A can of kerosene, can be used as fuel."
ITEM.longdesc = "A big plastic canister of kerosene. Kerosene is used for much of the power generation in the zone."
ITEM.model = "models/illusion/eftcontainers/kerosine.mdl"

ITEM.width = 2
ITEM.height = 2
ITEM.price = 7468

ITEM.flatweight = 5.250
ITEM.weight = 0.100

ITEM.fueltier = 2
ITEM.quantity = 8

ITEM.img = ix.util.GetMaterial("vgui/hud/valuable/kerosene.png")

function ITEM:GetPrice()
	local base = self.price / self.quantity

	return base * self:GetData("quantity", self.quantity)
end

function ITEM:PopulateTooltipIndividual(tooltip)
    ix.util.PropertyDesc(tooltip, "High Tier Cooking Fuel", Color(64, 224, 208))
end

if (CLIENT) then
	function ITEM:PaintOver(item, w, h)
		draw.SimpleText(
			item:GetData("quantity", item.quantity).."/"..item.quantity, "stalkerregularinvfont", 3, h - 1, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM, 1, color_black
		)
	end
end

ITEM.functions.combine = {
	OnCanRun = function(item, data)
		if !data or !data[1] then
			return false
		end

		local targetItem = ix.item.instances[data[1]]
		return (targetItem.uniqueID == item.uniqueID or targetItem.cookertier and targetItem.cookertier == item.fueltier)

	end,
	OnRun = function(item, data)
		local targetItem = ix.item.instances[data[1]]
		if( targetItem.uniqueID == item.uniqueID ) then
			local targetAmmoDiff = targetItem.quantity - targetItem:GetData("quantity", targetItem.quantity)
			local localQuant = item:GetData("quantity", item.quantity)
			local targetQuant = targetItem:GetData("quantity", targetItem.quantity)
			item.player:EmitSound("stalkersound/inv_properties.mp3", 110)

			if targetAmmoDiff >= localQuant then
				targetItem:SetData("quantity", targetQuant + localQuant)
				return true
			else
				item:SetData("quantity", localQuant - targetAmmoDiff)
				targetItem:SetData("quantity", targetItem.quantity)
				return false
			end
		elseif ( targetItem.cookertier and targetItem.cookertier == item.fueltier and targetItem:GetData("fuel") != targetItem.maxFuel) then
			item:SetData("quantity", item:GetData("quantity", item.quantity) - 1)
			targetItem:SetData("fuel", targetItem:GetData("fuel", 0) + 1)

			return (item:GetData("quantity", item.quantity) == 0)
		end

		return false
	end,
}

ITEM.functions.use = {
	name = "Refuel",
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
					if (v.cookertier and v.cookertier >= item.fueltier and v:GetData("fuel", false) != v.maxFuel) then
						table.insert(targets, {
							name = L(v.name),
							data = {v:GetID()},
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
		local targetItem = ix.item.instances[data[1]]
		if (!targetItem) then return false end

		if ( targetItem.cookertier and targetItem.cookertier == item.fueltier and targetItem:GetData("fuel") != targetItem.maxFuel) then
			item:SetData("quantity", item:GetData("quantity", item.quantity) - 1)
			targetItem:SetData("fuel", targetItem:GetData("fuel", 0) + 1)

			return (item:GetData("quantity", item.quantity) == 0)
		end

		return false
	end,
}

function ITEM:OnInstanced()
	if (!self:GetData("quantity")) then
		self:SetData("quantity", self.quantity)
	end
end