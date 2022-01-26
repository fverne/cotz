ITEM.name = ".338 Lapua Armor-Piercing"
ITEM.model = "models/kek1ch/ammo_86x70_fmj.mdl"
ITEM.width = 2
ITEM.height = 1
ITEM.ammo = ".338 Lapua -AP-" // type of the ammo
ITEM.ammoAmount = 60 // amount of the ammo
ITEM.description = ""
ITEM.quantdesc =  "A box that contains %s rounds of Armor-Piercing .338 Lapua ammo. "
ITEM.longdesc = "The .338 Lapua Magnum is a specialized rimless bottlenecked centerfire cartridge developed for military long-range sniper rifles. The Afghanistan War and Iraq War made it a combat-proven round with ready and substantial ammunition availability. The .338 Lapua is a dual-purpose anti-personnel and anti-materiel round, but its anti-materiel potential is limited."
ITEM.price = 3500
ITEM.img = ix.util.GetMaterial("cotz/icons/ammo/ammo_long_1_1.png")

ITEM.weight = 0.016
ITEM.flatweight = 0.05

function ITEM:GetWeight()
  return self.flatweight + (self.weight * self:GetData("quantity", self.ammoAmount))
end