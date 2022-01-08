ITEM.name = "12g Dart Rounds"
ITEM.model = "models/lostsignalproject/items/ammo/12x70.mdl"
ITEM.width = 2
ITEM.height = 1
ITEM.ammo = "12 Gauge -DT-" // type of the ammo
ITEM.ammoAmount = 30 // amount of the ammo
ITEM.description = ""
ITEM.quantdesc =  "A box that contains %s 12 gauge dart rounds. "
ITEM.longdesc = "12 gauge shell loaded with a pointed dart. Gives decent armor penetration at range."
ITEM.price = 600
ITEM.img = ix.util.GetMaterial("cotz/icons/ammo/ammo_long_24_1.png")

ITEM.weight = 0.045
ITEM.flatweight = 0.03

function ITEM:GetWeight()
  return self.flatweight + (self.weight * self:GetData("quantity", self.ammoAmount))
end