ITEM.name = "5.56x45mm"
ITEM.model = "models/lostsignalproject/items/ammo/556x45.mdl"
ITEM.width = 2
ITEM.height = 1
ITEM.ammo = "5.56x45MM" // type of the ammo
ITEM.ammoAmount = 60 // amount of the ammo
ITEM.description = ""
ITEM.quantdesc =  "A box that contains %s rounds of 5.56x45mm ammo. "
ITEM.longdesc = "A standard-issue NATO 5.56x45 caliber round specially designed for accurate automatic fire. Provides good ballistic characteristics, having been designed on the basis of a hunting round. Widely known under its SS109 index."
ITEM.price = 1650
--ITEM.busflag = "SPECIAL8_1"
ITEM.img = ix.util.GetMaterial("cotz/icons/ammo/ammo_long_9_3.png")

ITEM.weight = 0.012
ITEM.flatweight = 0.05

function ITEM:GetWeight()
  return self.flatweight + (self.weight * self:GetData("quantity", self.ammoAmount))
end