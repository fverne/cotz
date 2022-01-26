ITEM.name = "9x21mm 'Gyurza' SP-12"
ITEM.model = "models/lostsignalproject/items/ammo/9x19.mdl"
ITEM.ammo = "9x21MM -HP-" // type of the ammo
ITEM.ammoAmount = 60 // amount of the ammo
ITEM.description = ""
ITEM.quantdesc =  "A box that contains %s rounds of 9x21mm Gyurza SP-12 ammo. "
ITEM.longdesc = "The SP-12 is a bullet designed for maximum expansion, making it very effective against softer targets, however it lacks the armor piercing punch of the other Gyurza types."
ITEM.price = 750
ITEM.img = ix.util.GetMaterial("cotz/icons/ammo/ammo_short_7_2.png")

ITEM.weight = 0.007
ITEM.flatweight = 0.05

function ITEM:GetWeight()
  return self.flatweight + (self.weight * self:GetData("quantity", self.ammoAmount))
end