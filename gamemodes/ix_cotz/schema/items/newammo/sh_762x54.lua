ITEM.name = "7.62x54mm"
ITEM.model = "models/lostsignalproject/items/ammo/762x54.mdl"
ITEM.width = 2
ITEM.height = 1
ITEM.ammo = "7.62x54MMR" // type of the ammo
ITEM.ammoAmount = 60 // amount of the ammo
ITEM.description = ""
ITEM.quantdesc =  "A box that contains %s rounds of 7.62x54mm ammo. "
ITEM.longdesc = "Cheap 7.62 PP (also known as 7.62 R) is a dated rifle caliber introduced in the Soviet Empire at the turn of the 19th century and was still used by the USSR after World War II. It was originally designed for the Mosin-Nagant standard-issue infantry rifle and is quite common in the Zone due to the popularity of the rifle. The round is relatively cheap but has surprisingly good penetrative capabilities, even in comparison to more modern ammo types. It can also be used as a cheaper solution in the PKM machine gun."
ITEM.price = 2100
ITEM.busflag = {"ammo4"}
ITEM.width = 2
ITEM.height = 1
ITEM.img = ix.util.GetMaterial("cotz/icons/ammo/ammo_long_12_3.png")

ITEM.weight = 0.022
ITEM.flatweight = 0.05

function ITEM:GetWeight()
  return self.flatweight + (self.weight * self:GetData("quantity", self.ammoAmount))
end