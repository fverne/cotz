ITEM.name = "Tool"
ITEM.description = "Technician stuff."
ITEM.longdesc = "Longer description here."

ITEM.width = 1
ITEM.height = 1
ITEM.price = 1

ITEM.weight = 0
ITEM.flatweight = 0

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

function ITEM:GetWeight()
  return self.flatweight + (self.weight * self:GetData("quantity", self.quantity or 1))
end