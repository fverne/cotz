ITEM.name = "9x19mm Zone-Loaded"
ITEM.model = "models/lostsignalproject/items/ammo/9x19.mdl"
ITEM.ammo = "9x19MM -ZL-" // type of the ammo
ITEM.ammoAmount = 60 // amount of the ammo
ITEM.description= "A box that contains %s rounds of zone-loaded 9x19mm ammo. "
ITEM.longdesc = "This basic 9x19 caliber round with a jacketed bullet has good characteristics while being simple to produce. The round is popular due to the fact that international conventions prohibit the use of expanding ammunition in combat. "
ITEM.price = 750
ITEM.img = Material("vgui/hud/9x19zl.png")

ITEM.weight = 0.007
ITEM.flatweight = 0.05

function ITEM:GetWeight()
  return self.flatweight + (self.weight * self:GetData("quantity", self.ammoAmount))
end