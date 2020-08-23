ITEM.name = "aid"
ITEM.description = "Helps your body survive in the zone - in one way or another."
ITEM.longdesc = "Longer description here."
ITEM.category = "Aid"

ITEM.width = 1
ITEM.height = 1
ITEM.price = 0

ITEM.quantity = 0
ITEM.restore = 0

ITEM.weight = 0
ITEM.flatweight = 0

function ITEM:GetDescription()
	if (!self.entity or !IsValid(self.entity)) then
		local quant = self:GetData("quantity", self.quantity)
		local str = self.description.."\n\n"..self.longdesc.."\n \nThere's only "..quant.." uses left."

		return str
	else
		return self.description
	end
end

if (CLIENT) then
	function ITEM:PaintOver(item, w, h)
		draw.SimpleText(item:GetData("quantity", item.quantity).."/"..item.quantity, "stalkerregularinvfont", 3, h - 1, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM, 1, color_black)
	end
end

ITEM:Hook("use", function(item)
	item.player:EmitSound(item.sound or "items/battery_pickup.wav")
end)

ITEM:Hook("usetarget", function(item)
	item.player:EmitSound(item.sound or "items/battery_pickup.wav")
end)

function ITEM:GetWeight()
  return self.flatweight + (self.weight * self:GetData("quantity", self.quantity))
end