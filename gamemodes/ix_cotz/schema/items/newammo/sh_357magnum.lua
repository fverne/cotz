ITEM.name = ".357 Magnum"
ITEM.model = "models/lostsignalproject/items/ammo/357.mdl"
ITEM.ammo = ".357 Magnum" // type of the ammo
ITEM.ammoAmount = 60 // amount of the ammo
ITEM.description = ""
ITEM.quantdesc =  "A box that contains %s rounds of .357 Magnum ammo. "
ITEM.longdesc = "This large-bore .357 Magnum cartridge was originally designed for revolvers, but quickly adopted by rifles and carbines."
ITEM.price = 1000
ITEM.busflag = {"ammo1_1"}
ITEM.width = 2
ITEM.img = ix.util.GetMaterial("cotz/icons/ammo/ammo_long_2_3.png")

ITEM.weight = 0.017
ITEM.flatweight = 0.03

function ITEM:GetWeight()
  return self.flatweight + (self.weight * self:GetData("quantity", self.ammoAmount))
end