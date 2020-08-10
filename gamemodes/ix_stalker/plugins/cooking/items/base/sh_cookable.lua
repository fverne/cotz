ITEM.name = "Cookable Consumable"
ITEM.description = "Consumable that can be cooked."
ITEM.category = "Cookable Meat"
ITEM.model = "models/lostsignalproject/items/consumable/meat_dog.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.BaseWeight = 1
ITEM.WeightPerLevel = 0.5
ITEM.meattier = 1
ITEM.WeightPerThirst = -0.25
ITEM.WeightPerHunger = 0.5
ITEM.cookable = true

function ITEM:GetThirst()
	return self:GetWeight()/self.WeightPerThirst
end

function ITEM:GetHunger()
	return self:GetWeight()/self.WeightPerHunger
end

function ITEM:PopulateTooltip(tooltip)
    if (!self.entity) then
        ix.util.PropertyDesc(tooltip, "Cookable", Color(255, 255, 0))
    end

    if (self.PopulateTooltipIndividual) then
      self:PopulateTooltipIndividual(tooltip)
    end
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
		return (!IsValid(item.entity))
	end,
	OnRun = function(item)
		local hunger = item.player:GetCharacter():GetData("hunger", 100)
		local thirst = item.player:GetCharacter():GetData("thirst", 100)
		local client = item.player

		item.player:SetAction("Eating", 5)
		item.player:Freeze(true) 
		item.player:ScreenFade( SCREENFADE.OUT, Color( 0, 0, 0 ), 1, 3 ) 
		timer.Simple(1, function() 
			client:ScreenFade( SCREENFADE.IN, Color( 0, 0, 0 ), 1, 3 ) 
		end)
		timer.Simple(4, function() 
			client:SetHunger(hunger + item:GetHunger())
			client:SetThirst(thirst + item:GetThirst())
			client:Freeze(false)
		end)

		item.player:UpdateHungerState(item.player)

		return false
	end
}

function ITEM:OnInstanced(invID, x, y)
    if (!self:GetData("weight")) then
        self:SetData("weight", self.BaseWeight)
    end
end

function ITEM:SetWeight(knifetier)
	self:SetData("weight", self.BaseWeight + (self.WeightPerLevel * knifetier))
end