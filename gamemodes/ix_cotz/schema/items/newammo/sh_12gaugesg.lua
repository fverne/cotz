ITEM.name = "12g Slug"
ITEM.model = "models/lostsignalproject/items/ammo/12x70.mdl"
ITEM.width = 2
ITEM.height = 1
ITEM.ammo = "12 Gauge -SG-" // type of the ammo
ITEM.ammoAmount = 30 // amount of the ammo
ITEM.description = ""
ITEM.quantdesc =  "A box that contains %s 12 gauge slug shells. "
ITEM.longdesc = "This heavy 12-caliber slug round is normally used for hunting big game, but is also good for other purposes."
ITEM.price = 700
ITEM.busflag = {"ammo2_1"}
ITEM.img = ix.util.GetMaterial("cotz/icons/ammo/ammo_long_23_1.png")

ITEM.weight = 0.036
ITEM.flatweight = 0.03

function ITEM:GetWeight()
  return self.flatweight + (self.weight * self:GetData("quantity", self.ammoAmount))
end