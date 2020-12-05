ITEM.name = "9x39mm Zone-Loaded"
ITEM.model = "models/lostsignalproject/items/ammo/9x39.mdl"
ITEM.width = 2
ITEM.height = 1
ITEM.ammo = "9x39MM -ZL-" // type of the ammo
ITEM.ammoAmount = 60 // amount of the ammo
ITEM.description= "A box that contains %s rounds of zone-loaded 9x39mm ammo. "
ITEM.longdesc = "The SP-5 is a subsonic 9x39mm rifle round with a bimetallic casing. The round contains a steel core with a gap behind it that is filled with lead. Requires a suppressor for stealth firing. Used by special services of Warsaw Pact countries."
ITEM.price = 1900
ITEM.img = Material("vgui/hud/9x39zl.png")

ITEM.weight = 0.015
ITEM.flatweight = 0.08

function ITEM:GetWeight()
  return self.flatweight + (self.weight * self:GetData("quantity", self.ammoAmount))
end