ITEM.name = "mutantpart"
ITEM.description = "mutantpart item."
ITEM.longdesc = "Collectors and researchers judge a specimen differently from the hunter who brought it in."
	.. " Keeping it intact on the return journey is its own small task."
ITEM.category = "Mutant Parts"
ITEM.model = "models/Gibs/HGIBS.mdl"

ITEM.width = 1
ITEM.height = 1
ITEM.price = 0
ITEM.pricepertier = 0

ITEM.baseweight = 1.000
ITEM.varweight  = 0.500

ITEM.DropOnDeath = true

function ITEM:GetDescription()
	local description = self:GetData("description", self.description)
	if self.entity or not self.longdesc or self.longdesc == "" then return description end

	return description .. "\n\n" .. self.longdesc
end

function ITEM:PopulateTooltip(tooltip)
    if !self.entity then
        ix.util.PropertyDesc2(tooltip, "Mutant Part", Color(64, 224, 208), Material("vgui/ui/stalker/weaponupgrades/handling.png"))
        ix.util.PropertyDesc(tooltip, "Valuable", Color(225, 223, 0))
    end

    if (self.PopulateTooltipIndividual) then
      self:PopulateTooltipIndividual(tooltip)
    end
end

function ITEM:OnInstanced(invID, x, y)
    if(!self:GetData("weight")) then
        self:SetData("weight", self.baseweight + math.Rand(-self.varweight, self.varweight))
    end
end

function ITEM:GetPrice()
	return self.price + self.pricepertier * self:GetData("tier", 0)
end