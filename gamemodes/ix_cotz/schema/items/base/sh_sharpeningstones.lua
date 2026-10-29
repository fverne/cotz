ITEM.name = "Sharpening Stone"
ITEM.description = "A whetstone with three uses. Each use restores 25% knife sharpness, up to 101%."
ITEM.longdesc = "Use Sharpen and select a knife. Above 100% sharpness grants +1 tier for one poach."
ITEM.model = "models/lostsignalproject/items/repair/sharpening_stones.mdl"
ITEM.category = "Consumables"
ITEM.width = 1
ITEM.height = 1
ITEM.price = 150
ITEM.weight = 0.2
ITEM.flatweight = 0
ITEM.sharpnessRestored = 15
ITEM.quantity = 3

function ITEM:GetDescription()
	return string.format(
		"%s\n\n%d/%d uses remaining.\n\n%s",
		self.description,
		self:GetData("quantity", self.quantity),
		self.quantity,
		self.longdesc
	)
end

function ITEM:GetPrice()
	return math.Round(self.price * self:GetData("quantity", self.quantity) / self.quantity)
end

if CLIENT then
	function ITEM:PaintOver(item, _, height)
		local text = string.format("%d/%d", item:GetData("quantity", item.quantity), item.quantity)
		draw.SimpleText(
			text,
			"stalkerregularinvfont",
			3,
			height - 1,
			color_white,
			TEXT_ALIGN_LEFT,
			TEXT_ALIGN_BOTTOM
		)
	end
end

local function ownedInventory(item)
	local client = item.player
	if not IsValid(client) or IsValid(item.entity) then return end
	local character = client:GetCharacter()
	if not character then return end
	local inventory = character:GetInventory()
	if inventory:GetItems()[item:GetID()] ~= item then return end

	return inventory
end

ITEM.functions.Sharpen = {
	name = "Sharpen",
	icon = "icon16/wrench.png",
	isMulti = true,
	multiOptions = function(item, client)
		local targets = {}
		local character = client:GetCharacter()
		if not character then return targets end
		for _, knife in pairs(character:GetInventory():GetItems()) do
			if knife.isPoachKnife and ix.poaching.GetSharpness(knife) < ix.poaching.Sharpness.maximum then
				local label = string.format("%s (%d%%)", knife.name, ix.poaching.GetSharpness(knife))
				-- Inventory menus pass this label through L(), which formats it again.
				targets[#targets + 1] = {
					name = label:gsub("%%", "%%%%"),
					data = {knife:GetID()},
				}
			end
		end

		return targets
	end,
	OnCanRun = function(item)
		return ownedInventory(item) ~= nil and item:GetData("quantity", item.quantity) > 0
			and not item.player:GetNetVar("IsPoaching", false)
	end,
	OnRun = function(item, data)
		local inventory = ownedInventory(item)
		if not inventory or item.player:GetNetVar("IsPoaching", false) then return false end
		local quantity = item:GetData("quantity", item.quantity)
		if quantity <= 0 then return false end
		if not istable(data) then return false end
		local knife = inventory:GetItems()[tonumber(data[1])]
		if not knife or not knife.isPoachKnife then return false end
		local sharpness = ix.poaching.GetSharpness(knife)
		local maximum = ix.poaching.Sharpness.maximum
		if sharpness >= maximum then return false end
		knife:SetData("sharpness", math.min(maximum, sharpness + item.sharpnessRestored))
		item:SetData("quantity", quantity - 1)
		item.player:Notify(string.format("%s sharpness: %d%%", knife.name, ix.poaching.GetSharpness(knife)))

		return quantity == 1
	end,
}
