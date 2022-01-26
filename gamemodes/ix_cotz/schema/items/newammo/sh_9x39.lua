ITEM.name = "9x39mm"
ITEM.model = "models/lostsignalproject/items/ammo/9x39.mdl"
ITEM.width = 2
ITEM.height = 1
ITEM.ammo = "9x39MM" // type of the ammo
ITEM.ammoAmount = 60 // amount of the ammo
ITEM.description = ""
ITEM.quantdesc =  "A box that contains %s rounds of 9x39mm ammo. "
ITEM.longdesc = "The SP-5 is a subsonic 9x39mm rifle round with a bimetallic casing. The round contains a steel core with a gap behind it that is filled with lead. Requires a suppressor for stealth firing. Used by special services of Warsaw Pact countries."
ITEM.price = 1900
ITEM.img = ix.util.GetMaterial("cotz/icons/ammo/ammo_long_13_3.png")

ITEM.weight = 0.023
ITEM.flatweight = 0.08

function ITEM:GetWeight()
  return self.flatweight + (self.weight * self:GetData("quantity", self.ammoAmount))
end