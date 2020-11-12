ITEM.name = ".338 Lapua"
ITEM.model = "models/lostsignalproject/items/ammo/127x55.mdl"
ITEM.width = 2
ITEM.height = 1
ITEM.ammo = ".338 Lapua" // type of the ammo
ITEM.ammoAmount = 100 // amount of the ammo
ITEM.description= "A box that contains %s rounds of .338 Lapua ammo. "
ITEM.longdesc = "The .338 Lapua Magnum is a specialized rimless bottlenecked centerfire cartridge developed for military long-range sniper rifles. The Afghanistan War and Iraq War made it a combat-proven round with ready and substantial ammunition availability. The .338 Lapua is a dual-purpose anti-personnel and anti-materiel round, but its anti-materiel potential is limited."
ITEM.price = 3500
--ITEM.busflag = "SPECIAL8_1"
ITEM.img = Material("vgui/hud/338lapua.png")

ITEM.weight = 0.017
ITEM.flatweight = 0.05

function ITEM:GetWeight()
  return self.flatweight + (self.weight * self:GetData("quantity", self.ammoAmount))
end