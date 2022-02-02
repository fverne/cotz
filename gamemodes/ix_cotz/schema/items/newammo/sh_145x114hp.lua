ITEM.name = "14.5x114mm BZT"
ITEM.model = "models/lostsignalproject/items/ammo/127x55.mdl"
ITEM.ammo = "14.5x114MM -HP-" // type of the ammo
ITEM.ammoAmount = 60 // amount of the ammo
ITEM.description = ""
ITEM.quantdesc =  "A box that contains %s rounds of Hollow-Point 14.5x114mm ammo. "
ITEM.longdesc = "The 14.5x114mm round was originally developed for the PTRS and PTRD anti-tank rifles, but was later used as the basis for the KPV heavy machine gun that formed the basis of the ZPU series anti-aircraft guns that is also the main armament of the BTR series of armoured personnel carriers from the BTR-%s to the BTR-80."
ITEM.price = 8000
ITEM.flag = "0"
ITEM.width = 2
ITEM.height = 1
ITEM.img = ix.util.GetMaterial("cotz/icons/ammo/ammo_long_41_2.png")


ITEM.weight = 0.190
ITEM.flatweight = 0.1

function ITEM:GetWeight()
  return self.flatweight + (self.weight * self:GetData("quantity", self.ammoAmount))
end
