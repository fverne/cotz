ITEM.name = ".45 ACP"
ITEM.model = "models/lostsignalproject/items/ammo/45cal.mdl"
ITEM.ammo = ".45 ACP" // type of the ammo
ITEM.ammoAmount = 60 // amount of the ammo
ITEM.description = ""
ITEM.quantdesc =  "A box that contains %s rounds of .45 ACP ammo. "
ITEM.longdesc = "The .45 caliber full metal jacket round has enjoyed popularity for a hundred years thanks to its ballistic performance and a relatively small propelling charge. As a result, the bullet in this round is relatively slow but highly accurate and provides considerable stopping power."
ITEM.price = 950
--ITEM.busflag = "SPECIAL8"
ITEM.width = 2
ITEM.img = ix.util.GetMaterial("cotz/icons/ammo/ammo_long_3_3.png")

ITEM.weight = 0.020
ITEM.flatweight = 0.05

function ITEM:GetWeight()
  return self.flatweight + (self.weight * self:GetData("quantity", self.ammoAmount))
end