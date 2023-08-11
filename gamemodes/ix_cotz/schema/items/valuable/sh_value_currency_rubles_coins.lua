ITEM.name = "Ruble Coins"
ITEM.description = "A few coins of Ukranian currency."
ITEM.longdesc = ""
ITEM.model = "models/props_lab/box01a.mdl"

ITEM.width = 1
ITEM.height = 1

-- ITEM.quantity = 5000

ITEM.flatweight = 0
ITEM.weight = 0.001

ITEM.img = ix.util.GetMaterial("cotz/ui/icons/misc_coins.png")

if (CLIENT) then
	function ITEM:PaintOver(item, w, h)
		draw.SimpleText(
			item:GetData("quantity", item.quantity), "stalkerregularinvfont", 3, h - 1, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM, 1, color_black
		)
	end
end

function ITEM:GetPrice()
	return self:GetData("quantity", self.quantity)
end

function ITEM:OnInstanced()
	if (!self:GetData("quantity")) then
		self:SetData("quantity", 1)
	end
end