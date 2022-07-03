ITEM.name = "12g Buckshot"
ITEM.model = "models/lostsignalproject/items/ammo/12x70.mdl"
ITEM.width = 2
ITEM.height = 1
ITEM.ammo = "12 Gauge" // type of the ammo
ITEM.ammoAmount = 30 // amount of the ammo
ITEM.description = ""
ITEM.quantdesc =  "A box that contains %s 12 gauge shells. "
ITEM.longdesc = "Standard 12 gauge shell filled with 6 mm shot. Highly lethal at close range. Only suitable for use with smoothbore weapons."
ITEM.price = 800
ITEM.busflag = {"ammo2"}
ITEM.img = ix.util.GetMaterial("cotz/icons/ammo/ammo_long_22_2.png")

ITEM.weight = 0.031
ITEM.flatweight = 0.03

function ITEM:GetWeight()
  return self.flatweight + (self.weight * self:GetData("quantity", self.ammoAmount))
end