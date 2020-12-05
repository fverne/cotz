ITEM.name = "12g Birdshot"
ITEM.model = "models/lostsignalproject/items/ammo/12x70.mdl"
ITEM.width = 2
ITEM.height = 1
ITEM.ammo = "12 Gauge -BD-" // type of the ammo
ITEM.ammoAmount = 30 // amount of the ammo
ITEM.description= "A box that contains %s 12 gauge birdshot shells. "
ITEM.longdesc = "Birdshot 12 gauge shell filled with 3 mm shot. Highly lethal at close range, but has poor armor piercing capabilities. Only suitable for use with smoothbore weapons."
ITEM.price = 650
ITEM.busflag = {"ammo"}
ITEM.img = Material("vgui/hud/12gaugezl.png")

ITEM.weight = 0.034
ITEM.flatweight = 0.03

function ITEM:GetWeight()
  return self.flatweight + (self.weight * self:GetData("quantity", self.ammoAmount))
end