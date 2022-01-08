ITEM.name = "9x19mm Hollow-Point"
ITEM.model = "models/lostsignalproject/items/ammo/9x19.mdl"
ITEM.ammo = "9x19MM -HP-" // type of the ammo
ITEM.ammoAmount = 60 // amount of the ammo
ITEM.description = ""
ITEM.quantdesc =  "A box that contains %s rounds of Hollow-Point 9x19mm ammo. "
ITEM.longdesc = "This basic 9x19 caliber round with a jacketed bullet has good characteristics while being simple to produce. The round is popular due to the fact that international conventions prohibit the use of expanding ammunition in combat. "
ITEM.price = 750
ITEM.img = ix.util.GetMaterial("cotz/icons/ammo/ammo_short_4_2.png")

ITEM.weight = 0.007
ITEM.flatweight = 0.05

function ITEM:GetWeight()
  return self.flatweight + (self.weight * self:GetData("quantity", self.ammoAmount))
end