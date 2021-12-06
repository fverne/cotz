ITEM.name = "misc"
ITEM.description = "misc item."
ITEM.longdesc = "No Longer Description Available"
ITEM.model = "models/Gibs/HGIBS.mdl"

ITEM.width = 1
ITEM.height = 1
ITEM.price = 0

ITEM.weight = 0

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