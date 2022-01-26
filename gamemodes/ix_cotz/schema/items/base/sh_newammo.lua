ITEM.name = "Ammo Base"
ITEM.model = "models/Items/BoxSRounds.mdl"
ITEM.description = "no desc"
ITEM.category = "Ammunition"
ITEM.quantdesc = "A box with %d rounds of ammunition."

ITEM.width = 1
ITEM.height = 1
ITEM.price = 0

ITEM.ammo = "pistol" -- type of the ammo
ITEM.ammoAmount = 30 -- amount of the ammo
ITEM.isAmmo = true
ITEM.loadSize = {1,5,15, ITEM.ammoAmount}

ITEM.weight = 0

function ITEM:GetDescription()
	local quant = self:GetData("quantity", self.ammoAmount or self.quantity or 0)
	local quantdesc = ""
	local invdesc = ""
	if self.longdesc then
		invdesc = "\n\n"..(self.longdesc)
	end

	if self.quantdesc then
		quantdesc = Format(self.quantdesc, quant)
	end

	if (self.entity) then
		return (Format(self.quantdesc, quant))
	else
        return (quantdesc..invdesc)
	end
end

if (CLIENT) then
	function ITEM:PaintOver(item, w, h)
		draw.SimpleText(
			item:GetData("quantity", item.ammoAmount).."/"..item.ammoAmount, "stalkerregularinvfont", 3, h - 1, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM, 1, color_black
		)
	end
end

function ITEM:PopulateTooltip(tooltip)
    if (!self.entity) then
        ix.util.PropertyDesc(tooltip, "Ammunition", Color(64, 224, 208))
    end

    if (self.PopulateTooltipIndividual) then
      self:PopulateTooltipIndividual(tooltip)
    end
end

function ITEM:GetPrice()
	local base = self.price / self.ammoAmount

	return base * self:GetData("quantity", self.ammoAmount)
end

function ITEM:OnInstanced(invID, x, y)

	if !self:GetData("quantity") then
		self:SetData("quantity", self.ammoAmount)
	end
end

ITEM.functions.split = {
    name = "Split",
    tip = "useTip",
    icon = "icon16/stalker/split.png",
    isMulti = true,
    multiOptions = function(item, client)
		local targets = {}
        local quantity = item:GetData("quantity", item.ammoAmount)

        for i=1,#item.loadSize-1 do
			if quantity > item.loadSize[i] then
				table.insert(targets, {
					name = item.loadSize[i],
					data = {item.loadSize[i]},
				})
			end
		end
        return targets
	end,
	OnCanRun = function(item)
		if item:GetData("quantity", item.ammoAmount) == 1 then
			return false
		end

		return (!IsValid(item.entity))
	end,
    OnRun = function(item, data)
		if data[1] then
			local quantity = item:GetData("quantity", item.ammoAmount)
			local client = item.player

			client:GetCharacter():GetInventory():Add(item.uniqueID, 1, {["quantity"] = data[1]})

			quantity = quantity - data[1]

			item.player:EmitSound("stalkersound/inv_properties.mp3", 110)

			item:SetData("quantity", quantity)

		end
		return false
	end,
}

ITEM.functions.combine = {
	OnCanRun = function(item, data)
		if !data then
			return false
		end

		local targetItem = ix.item.instances[data[1]]

		if targetItem.ammo == item.ammo then
			return true
		else
			return false
		end
	end,
	OnRun = function(item, data)
		local targetItem = ix.item.instances[data[1]]
		local targetAmmoDiff = targetItem.ammoAmount - targetItem:GetData("quantity", targetItem.ammoAmount)
		local localQuant = item:GetData("quantity", item.ammoAmount)
		local targetQuant = targetItem:GetData("quantity", targetItem.ammoAmount)
		item.player:EmitSound("stalkersound/inv_properties.mp3", 110)
		if targetAmmoDiff >= localQuant then
			targetItem:SetData("quantity", targetQuant + localQuant)
			return true
		else
			item:SetData("quantity", localQuant - targetAmmoDiff)
			targetItem:SetData("quantity", targetItem.ammoAmount)
			return false
		end
	end,
}

-- Called after the item is registered into the item tables.
function ITEM:OnRegistered()
	if (ix.ammo) then
		ix.ammo.Register(self.ammo)
	end
end
