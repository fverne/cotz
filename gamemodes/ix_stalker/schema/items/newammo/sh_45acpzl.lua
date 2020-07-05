ITEM.name = ".45 ACP Zone-Loaded"
ITEM.model = "models/kek1ch/ammo_1143x23_fmj.mdl"
ITEM.ammo = ".45 ACP -ZL-" // type of the ammo
ITEM.ammoAmount = 100 // amount of the ammo
ITEM.description= "A box that contains %s rounds of zone-loaded .45 ACP ammo. "
ITEM.longdesc = "The .45 caliber full metal jacket round has enjoyed popularity for a hundred years thanks to its ballistic performance and a relatively small propelling charge. As a result, the bullet in this round is relatively slow but highly accurate and provides considerable stopping power."
ITEM.price = 950
ITEM.width = 2
ITEM.img = Material("vgui/hud/45acpzl.png")

ITEM.weight = 0.017
ITEM.flatweight = 0.05

function ITEM:GetWeight()
  return self.flatweight + (self.weight * self:GetData("quantity", self.ammoAmount))
end