ITEM.name = ".357 Magnum JHP"
ITEM.model = "models/lostsignalproject/items/ammo/357.mdl"
ITEM.ammo = ".357 Magnum -HP-" // type of the ammo
ITEM.ammoAmount = 60 // amount of the ammo
ITEM.description = ""
ITEM.quantdesc =  "A box that contains %s rounds of Hollow-Point .357 Magnum ammo. "
ITEM.longdesc = "This large-bore .357 Magnum cartridge was originally designed for revolvers, but quickly adopted by rifles and carbines."
ITEM.price = 1000
ITEM.width = 2
ITEM.img = ix.util.GetMaterial("cotz/icons/ammo/ammo_long_2_2.png")

ITEM.weight = 0.021
ITEM.flatweight = 0.03

function ITEM:GetWeight()
  return self.flatweight + (self.weight * self:GetData("quantity", self.ammoAmount))
end