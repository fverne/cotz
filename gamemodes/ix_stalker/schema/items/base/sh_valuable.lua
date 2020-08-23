ITEM.name = "valuable"
ITEM.description = "valuable item."
ITEM.longdesc = "No Longer Description Available"
ITEM.model = "models/Gibs/HGIBS.mdl"
ITEM.width = 1
ITEM.height = 1

ITEM.flatweight = 0
ITEM.weight = 0

function ITEM:GetWeight()
	if (self.quantity) then
		return self.flatweight + (self.weight * self:GetData("quantity", self.quantity))
	else
		return self.flatweight
	end
end