ITEM.name = "5.45x39mm"
ITEM.model = "models/lostsignalproject/items/ammo/545x39.mdl"
ITEM.width = 2
ITEM.height = 1
ITEM.ammo = "5.45x39MM" // type of the ammo
ITEM.ammoAmount = 60 // amount of the ammo
ITEM.description = ""
ITEM.quantdesc =  "A box that contains %s rounds of 5.45x39mm ammo. "
ITEM.longdesc = "Military 5.45x39 7H10 caliber is an improved piercing round for automatic rifles of Warsaw Pact countries. Provides better accuracy than the 7.62 caliber round thanks to reduced recoil and a 100 meter increase in range."
ITEM.price = 1500
ITEM.busflag = {"ammo3"}
ITEM.img = ix.util.GetMaterial("cotz/icons/ammo/ammo_long_8_3.png")

ITEM.weight = 0.011
ITEM.flatweight = 0.05

function ITEM:GetWeight()
  return self.flatweight + (self.weight * self:GetData("quantity", self.ammoAmount))
end