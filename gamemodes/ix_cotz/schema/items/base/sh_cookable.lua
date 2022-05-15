ITEM.name = "Cookable Consumable"
ITEM.description = "Consumable that can be cooked."
ITEM.category = "Cookable Meat"
ITEM.model = "models/lostsignalproject/items/consumable/meat_dog.mdl"

ITEM.width = 1
ITEM.height = 1
ITEM.price = 0

ITEM.meattier = 1
ITEM.WeightPerThirst = -0.25
ITEM.WeightPerHunger = 0.5
ITEM.cookable = true

ITEM.BaseWeight = 1
ITEM.WeightPerLevel = 0.5

ITEM.DropOnDeath = true

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
        ix.util.PropertyDesc(tooltip, "Cookable", Color(64, 224, 208))
        ix.util.PropertyDesc(tooltip, "Highly Radioactive", Color(255, 10, 10))
    end

    if (self.PopulateTooltipIndividual) then
      self:PopulateTooltipIndividual(tooltip)
    end
end

function ITEM:GetThirst()
	return self:GetWeight()/self.WeightPerThirst
end

function ITEM:GetHunger()
	return self:GetWeight()/self.WeightPerHunger
end

ITEM.functions.combine = {
	OnCanRun = function(item, data)
		if !data then
			return false
		end

		local targetItem = ix.item.instances[data[1]]

		if targetItem.cookertier and item.meattier <= targetItem.cookertier then
			return true
		end

		return false
	end,
	OnRun = function(item, data)
		local targetItem = ix.item.instances[data[1]]
		item.player:EmitSound("stalkersound/inv_properties.mp3", 110)

		targetItem:CookMeat(targetItem, item:GetID())

		return false
	end,
}


ITEM.functions.use = {
	name = "Eat",
	icon = "icon16/stalker/eat.png",
	OnCanRun = function(item)
		return (!IsValid(item.entity)) and item.invID == item:GetOwner():GetCharacter():GetInventory():GetID()
	end,
	OnRun = function(item)
		local hunger = item.player:GetCharacter():GetData("hunger", 100)
		local thirst = item.player:GetCharacter():GetData("thirst", 100)
		local client = item.player

		ix.util.PlayerPerformBlackScreenAction(item.player, "Eating", 5, function(player) 
			player:SetHunger(hunger + item:GetHunger())
			player:SetThirst(thirst + item:GetThirst())
		end)

		item.player:UpdateHungerState(item.player)

		return true
	end
}

function ITEM:OnInstanced(invID, x, y)
    if (!self:GetData("weight")) then
        self:SetData("weight", self.BaseWeight)
    end
end

function ITEM:SetWeight(knifetier)
	local weightvar = self.BaseWeight * 0.05

	self:SetData("weight", math.Round(self.BaseWeight + math.Rand(-weightvar, weightvar)) + (self.WeightPerLevel * knifetier))
end

function ITEM:GetPrice()
	return self.price * self:GetWeight()
end