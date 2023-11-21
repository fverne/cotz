ITEM.name = "9.3x64mm 7N33"
ITEM.model = "models/lostsignalproject/items/ammo/127x55.mdl"
ITEM.width = 2
ITEM.height = 1
ITEM.ammo = "9.3x64MM" // type of the ammo
ITEM.ammoAmount = 30 // amount of the ammo
ITEM.description = ""
ITEM.quantdesc =  "A box that contains %s rounds of 9.3x64mm 7N33 ammo. "
ITEM.longdesc = "The 9.3x64mm 7N33 is a cartridge used primarily in the russian SVDK sniper rifle. The purpose of weapons chambered in this cartridge is to deal with targets which are too hard for standard 7.62x54mmR sniper rifles like SV-98 or SVD, such as assault troops in heavy body armor or enemy snipers behind cover. The 7N33 cartridge sports 40% more power than the 7.62x54 7N14 sniper bullet."
ITEM.price = 3500
--ITEM.busflag = "SPECIAL8_1"
ITEM.img = ix.util.GetMaterial("cotz/ui/icons/long_ammo_8.png")

ITEM.weight = 0.017
ITEM.flatweight = 0.05

function ITEM:GetWeight()
  return self.flatweight + (self.weight * self:GetData("quantity", self.ammoAmount))
end