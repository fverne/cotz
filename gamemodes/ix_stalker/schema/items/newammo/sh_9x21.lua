ITEM.name = "9x21mm"
ITEM.model = "models/lostsignalproject/items/ammo/9x19.mdl"
ITEM.ammo = "9x21MM" // type of the ammo
ITEM.ammoAmount = 60 // amount of the ammo
ITEM.description= "A box that contains %s rounds of 9x21mm ammo. "
ITEM.longdesc = "PLACEHOLDER"
ITEM.price = 750
ITEM.busflag = {"ammo1"}
ITEM.img = Material("vgui/hud/9x19.png")

ITEM.weight = 0.008
ITEM.flatweight = 0.05

function ITEM:GetWeight()
  return self.flatweight + (self.weight * self:GetData("quantity", self.ammoAmount))
end