ITEM.name = "Ammo Base"
ITEM.model = "models/Items/BoxSRounds.mdl"
ITEM.description = "no desc"
ITEM.category = "Ammunition"
ITEM.quantdesc = "A box with %d rounds of ammunition."

ITEM.width = 1
ITEM.height = 1
ITEM.price = 0

ITEM.ammo = "pistol" -- type of the ammo
ITEM.ammoAmount = 300 -- amount of the ammo
ITEM.isAmmo = true
ITEM.loadSize = {1,5,15, ITEM.ammoAmount}
ITEM.maxStack = 300

ITEM.weight = 0

function ITEM:GetDescription()
	local quantity = self:GetData("quantity", self.ammoAmount or self.quantity or 0)
	local description = self:GetData("description", string.format(self.quantdesc, quantity))
	if self.entity or not self.longdesc or self.longdesc == "" then return description end

	return description .. "\n\n" .. self.longdesc
end

if (CLIENT) then
	function ITEM:PaintOver(item, w, h)
		draw.SimpleText(
			item:GetData("quantity", item.ammoAmount).."/"..item.maxStack, "stalkerregularinvfont", 3, h - 1, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM, 1, color_black
		)
	end
end

function ITEM:PopulateTooltip(tooltip)
    if (not self.entity) then
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

	if not self:GetData("quantity") then
		self:SetData("quantity", self.ammoAmount)
	end
end

-- The last load size is the full box, so it is never a split option.
local function canSplitAmount(item, amount)
	if not isnumber(amount) or amount >= item:GetData("quantity", item.ammoAmount) then return false end
	for i = 1, #item.loadSize - 1 do
		if item.loadSize[i] == amount then return true end
	end

	return false
end

ITEM.functions.split = {
    name = "Split",
    tip = "useTip",
    icon = "icon16/stalker_grey/split.png",
    isMulti = true,
    multiOptions = function(item, client)
		local targets = {}
		for i = 1, #item.loadSize - 1 do
			if canSplitAmount(item, item.loadSize[i]) then
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

		return (not IsValid(item.entity) and item.invID == item.player:GetCharacter():GetInventory():GetID())
	end,
	OnRun = function(item, data)
		-- The client chooses data, so only accept an amount the menu could have offered.
		if not istable(data) or not canSplitAmount(item, data[1]) then return false end
		local amount = data[1]
		local quantity = item:GetData("quantity", item.ammoAmount) - amount
		local client = item.player
		local splitData = {["quantity"] = amount, ["cotzKeepSeparate"] = true}
		if not client:GetCharacter():GetInventory():Add(item.uniqueID, 1, splitData) then
			ix.item.SpawnTemporary(item.uniqueID, client:GetItemDropPos(), AngleRand(), {["quantity"] = amount})
			client:Notify("No space in your inventory! Items have been dropped.")
		end

		client:EmitSound("stalkersound/inv_properties.mp3", 110)
		item:SetData("quantity", quantity)

		return false
	end,
}

-- Ammo stacks merge by ammo type and start from ammoAmount when no quantity is saved.
function ITEM:CanStackWith(target)
	return target.ammo ~= nil and target.ammo == self.ammo
end

function ITEM:GetStackQuantity()
	return self:GetData("quantity", self.ammoAmount)
end

ITEM.functions.combine = {
	OnCanRun = function(item, data)
		return item:GetStackCombineTarget(data) ~= nil
	end,
	OnRun = function(item, data)
		return item:CombineStack(item:GetStackCombineTarget(data))
	end,
}

-- Called after the item is registered into the item tables.
function ITEM:OnRegistered()
	if (ix.ammo) then
		ix.ammo.Register(self.ammo)
	end
end
