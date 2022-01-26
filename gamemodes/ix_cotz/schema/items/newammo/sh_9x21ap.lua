ITEM.name = "9x21mm Gyurza SP-10 (7N29)"
ITEM.model = "models/lostsignalproject/items/ammo/9x19_p.mdl"
ITEM.ammo = "9x21MM -AP-" // type of the ammo
ITEM.ammoAmount = 60 // amount of the ammo
ITEM.description = ""
ITEM.quantdesc =  "A box that contains %s rounds of 9x21mm Gyurza SP-10 (7N29) ammo. "
ITEM.longdesc = "An overpressure cartridge sporting a hardened steel core, with the outer layer being seperated by a polyethylene layer. This allows it to be effective against both armored and unarmored targets, as if it hits an unarmored target, the polyethylene layer will keep the outer jacket and steel core together resulting in larger wounds. However, if striking an armored target, the outer sleeve will be stripped away by the armor and allow the hardened steel core to penetrate by itself."
ITEM.price = 750
ITEM.busflag = {"ammo1"}
ITEM.img = ix.util.GetMaterial("cotz/icons/ammo/ammo_short_7_1.png")

ITEM.weight = 0.010
ITEM.flatweight = 0.05

function ITEM:GetWeight()
  return self.flatweight + (self.weight * self:GetData("quantity", self.ammoAmount))
end