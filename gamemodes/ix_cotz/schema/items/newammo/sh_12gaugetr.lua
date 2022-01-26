ITEM.name = "12g Tri-Ball"
ITEM.model = "models/lostsignalproject/items/ammo/12x70.mdl"
ITEM.width = 2
ITEM.height = 1
ITEM.ammo = "12 Gauge -TR-" // type of the ammo
ITEM.ammoAmount = 30 // amount of the ammo
ITEM.description = ""
ITEM.quantdesc =  "A box that contains %s 12 gauge tri-ball shells. "
ITEM.longdesc = "Tri-Ball 12 gauge shell filled with %s mm shot. This round fires three large shots, with relatively high accuracy compared to other shells. Highly lethal at close range. Only suitable for use with smoothbore weapons."
ITEM.price = 750
--ITEM.busflag = "SPECIAL8_1"
ITEM.img = ix.util.GetMaterial("cotz/icons/ammo/ammo_long_22_1.png")

ITEM.weight = 0.04
ITEM.flatweight = 0.03

function ITEM:GetWeight()
  return self.flatweight + (self.weight * self:GetData("quantity", self.ammoAmount))
end