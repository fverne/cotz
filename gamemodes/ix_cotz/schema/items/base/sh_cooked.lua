ITEM.name = "Cooked Consumable"
ITEM.description = "Consumable that has been cooked."
ITEM.category = "Cooked Meat"
ITEM.model = "models/props/cs_office/Cardboard_box02.mdl"

ITEM.width = 1
ITEM.height = 1
ITEM.price = 0

ITEM.weight = 0 --make sure you set this
ITEM.WeightPerThirst = -0.25
ITEM.WeightPerHunger = 0.5

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
    if !self.entity then
        ix.util.PropertyDesc(tooltip, "Zone-Cooked", Color(64, 224, 208))
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

function ITEM:GetPrice()
    return self.price * self:GetWeight()
end