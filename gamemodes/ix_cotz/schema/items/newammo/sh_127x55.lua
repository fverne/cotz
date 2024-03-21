ITEM.name = "12.7x55mm"
ITEM.model = "models/lostsignalproject/items/ammo/127x55.mdl"
ITEM.width = 2
ITEM.height = 1
ITEM.ammo = "12.7x55mm" // type of the ammo
ITEM.ammoAmount = 30 // amount of the ammo
ITEM.description = ""
ITEM.quantdesc =  "A box that contains %s rounds of 12.7x55mm ammo. "
ITEM.longdesc = "The 12.7x55mm is a cartridge used in some Russian firearms such as the VSSK bullpup sniper rifle. The high penetration VSSK round can penetrate up to 16 mm (0.63 in) of steel at 200 metres (220 yd) or body armor up to GOST 5 or NIJ III at 100 metres (110 yd). The accuracy of this cartridge when loaded with precision VSSK bullets is claimed to be one MOA at 100 metres (110 yd) up to the effective range limit of 600 metres (660 yd)."
ITEM.price = 3500
--ITEM.busflag = "SPECIAL8_1"
ITEM.img = ix.util.GetMaterial("cotz/icons/ammo/ammo_long_35_1.png")

ITEM.weight = 0.017
ITEM.flatweight = 0.05

function ITEM:GetWeight()
  return self.flatweight + (self.weight * self:GetData("quantity", self.ammoAmount))
end