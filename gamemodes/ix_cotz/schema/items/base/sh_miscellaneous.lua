ITEM.name = "misc"
ITEM.description = "misc item."
ITEM.longdesc = "Ordinary belongings acquire unfamiliar histories beyond the perimeter. A former owner might"
	.. " recognise something a casual buyer would overlook."
ITEM.model = "models/Gibs/HGIBS.mdl"

ITEM.width = 1
ITEM.height = 1
ITEM.price = 0

ITEM.weight = 0

function ITEM:GetDescription()
	local description = self:GetData("description", self.description)
	if self.entity or not self.longdesc or self.longdesc == "" then return description end

	return description .. "\n\n" .. self.longdesc
end

function ITEM:PopulateTooltip(tooltip)
    if (self.PopulateTooltipIndividual) then
      self:PopulateTooltipIndividual(tooltip)
    end
end

function ITEM:GetWeight()
	if (self.quantity) then
		return self.flatweight + (self.weight * self:GetData("quantity", self.quantity))
	else
		return self.flatweight
	end
end