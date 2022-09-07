ITEM.name = "12g Magnum Buckshot"
ITEM.model = "models/lostsignalproject/items/ammo/12x70.mdl"
ITEM.width = 2
ITEM.height = 1
ITEM.ammo = "12 Gauge -MG-" // type of the ammo
ITEM.ammoAmount = 30 // amount of the ammo
ITEM.description = ""
ITEM.quantdesc =  "A box that contains %s 12 gauge Magnum Buckshot shells. "
ITEM.longdesc = "Magnum 12 gauge shell filled with 8.5 mm shot. An extra hot cartridge for when you need that extra punch."
ITEM.price = 750
--ITEM.busflag = "SPECIAL8_1"
ITEM.img = ix.util.GetMaterial("cotz/icons/ammo/ammo_long_22_1.png")

ITEM.weight = 0.04
ITEM.flatweight = 0.03

function ITEM:GetWeight()
  return self.flatweight + (self.weight * self:GetData("quantity", self.ammoAmount))
end