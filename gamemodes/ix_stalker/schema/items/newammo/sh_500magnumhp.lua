ITEM.name = ".500 Magnum Hollow Point"
ITEM.model = "models/lostsignalproject/items/ammo/357.mdl"
ITEM.ammo = ".500 Magnum -HP-" // type of the ammo
ITEM.ammoAmount = 30 // amount of the ammo
ITEM.description= "A box that contains %s rounds of .500 Magnum ammo. "
ITEM.longdesc = "PLACEHOLDER."
ITEM.price = 1000
ITEM.busflag = {"ammo1_1"}
ITEM.width = 2
ITEM.img = Material("vgui/hud/44magnum.png")

ITEM.weight = 0.019
ITEM.flatweight = 0.03

function ITEM:GetWeight()
  return self.flatweight + (self.weight * self:GetData("quantity", self.ammoAmount))
end