ITEM.name = "9x21mm Gyurza SP-11 (7N28)"
ITEM.model = "models/lostsignalproject/items/ammo/9x19.mdl"
ITEM.ammo = "9x21MM" // type of the ammo
ITEM.ammoAmount = 60 // amount of the ammo
ITEM.description = ""
ITEM.quantdesc =  "A box that contains %s rounds of 9x21mm Gyurza SP-11 (7N28) ammo."
ITEM.longdesc = "A variant of the Gyurza bullet type, featuring a regular FMJ bullet with a lead core. It is the most versatile of the Gyurza line, but this of course means that the other variants can be more effective in different situations."
ITEM.price = 750
ITEM.busflag = {"ammo1"}
ITEM.img = ix.util.GetMaterial("cotz/icons/ammo/ammo_short_7_3.png")

ITEM.weight = 0.008
ITEM.flatweight = 0.05

function ITEM:GetWeight()
  return self.flatweight + (self.weight * self:GetData("quantity", self.ammoAmount))
end