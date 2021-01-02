ITEM.name = "valuable"
ITEM.description = "valuable item."
ITEM.longdesc = "No Longer Description Available"
ITEM.category = "trinket"
ITEM.model = "models/Gibs/HGIBS.mdl"

ITEM.width = 1
ITEM.height = 1
ITEM.price = 0

ITEM.baseweight = 1.000
ITEM.varweight  = 0.500

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
        ix.util.PropertyDesc2(tooltip, "Mutant Part", Color(64, 224, 208), Material("vgui/ui/stalker/weaponupgrades/handling.png"))
        ix.util.PropertyDesc(tooltip, "Valuable", Color(225, 223, 0))
    end

    if (self.PopulateTooltipIndividual) then
      self:PopulateTooltipIndividual(tooltip)
    end
end

function ITEM:OnInstanced(invID, x, y)
    if(!self:GetData("weight")) then
        self:SetData("weight", self.baseweight + math.random(-self.varweight, self.varweight))
    end
end