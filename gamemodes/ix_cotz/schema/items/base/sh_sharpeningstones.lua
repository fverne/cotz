ITEM.name = "Sharpening Stone"
ITEM.description = "A single-use whetstone. Restores 25% knife sharpness, up to 101%."
ITEM.longdesc = "Use Sharpen and select a knife. Above 100% sharpness grants +1 tier for one poach."
ITEM.model = "models/props_debris/concrete_chunk05g.mdl"
ITEM.category = "Consumables"
ITEM.width = 1
ITEM.height = 1
ITEM.price = 150
ITEM.weight = 0.2
ITEM.flatweight = 0
ITEM.sharpnessRestored = 25

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
				targets[#targets + 1] = {
					name = string.format("%s (%d%%)", knife.name, ix.poaching.GetSharpness(knife)),
					data = {knife:GetID()},
				}
			end
		end

		return targets
	end,
	OnCanRun = function(item)
		return ownedInventory(item) ~= nil and not item.player:GetNetVar("IsPoaching", false)
	end,
	OnRun = function(item, data)
		local inventory = ownedInventory(item)
		if not inventory or item.player:GetNetVar("IsPoaching", false) then return false end
		if not istable(data) then return false end
		local knife = inventory:GetItems()[tonumber(data[1])]
		if not knife or not knife.isPoachKnife then return false end
		local sharpness = ix.poaching.GetSharpness(knife)
		local maximum = ix.poaching.Sharpness.maximum
		if sharpness >= maximum then return false end
		knife:SetData("sharpness", math.min(maximum, sharpness + item.sharpnessRestored))
		item.player:Notify(string.format("%s sharpness: %d%%", knife.name, ix.poaching.GetSharpness(knife)))

		return true
	end,
}
