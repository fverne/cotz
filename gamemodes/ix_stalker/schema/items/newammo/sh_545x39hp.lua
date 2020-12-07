ITEM.name = "5.45x39mm Hollow-Point"
ITEM.model = "models/lostsignalproject/items/ammo/545x39.mdl"
ITEM.width = 2
ITEM.height = 1
ITEM.ammo = "5.45x39MM -HP-" // type of the ammo
ITEM.ammoAmount = 60 // amount of the ammo
ITEM.description= "A box that contains %s rounds of Hollow-Point 5.45x39mm ammo. "
ITEM.longdesc = "Military 5.45x39 7H10 caliber is an improved piercing round for automatic rifles of Warsaw Pact countries. Provides better accuracy than the 7.62 caliber round thanks to reduced recoil and a 100 meter increase in range."
ITEM.price = 1500
ITEM.img = Material("vgui/hud/545x39zl.png")

ITEM.weight = 0.010
ITEM.flatweight = 0.05

function ITEM:GetWeight()
  return self.flatweight + (self.weight * self:GetData("quantity", self.ammoAmount))
end