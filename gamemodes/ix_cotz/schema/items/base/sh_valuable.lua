ITEM.name = "valuable"
ITEM.description = "valuable item."
ITEM.longdesc = "No Longer Description Available"
ITEM.model = "models/Gibs/HGIBS.mdl"

ITEM.width = 1
ITEM.height = 1
ITEM.price = 0

ITEM.flatweight = 0
ITEM.weight = 0

ITEM.DropOnDeath = true

function ITEM:GetDescription()
    local quant = self:GetData("quantity", self.ammoAmount or self.quantity or 0)
    local quantdesc = ""
    local invdesc = ""
    if self.longdesc and self.longdesc != "" then
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

if (CLIENT) then
    function ITEM:PaintOver(item, w, h)
        if(item.quantity) then
            draw.SimpleText(item:GetData("quantity", item.quantity).."/"..item.quantity, "stalkerregularinvfont", 3, h - 1, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM, 1, color_black)
        end
    end
end

function ITEM:PopulateTooltip(tooltip)
    if !self.entity then
        ix.util.PropertyDesc(tooltip, "Valuable", Color(225, 223, 0))
    end

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