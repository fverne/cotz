ITEM.name = "9x21mm Hollow-Point"
ITEM.model = "models/lostsignalproject/items/ammo/9x19.mdl"
ITEM.ammo = "9x21MM -HP-" // type of the ammo
ITEM.ammoAmount = 60 // amount of the ammo
ITEM.description= "A box that contains %s rounds of Hollow-Point 9x21mm ammo. "
ITEM.longdesc = "PLACEHOLDER."
ITEM.price = 750
ITEM.img = Material("vgui/hud/9x19zl.png")

ITEM.weight = 0.007
ITEM.flatweight = 0.05

function ITEM:GetWeight()
  return self.flatweight + (self.weight * self:GetData("quantity", self.ammoAmount))
end