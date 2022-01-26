ITEM.name = "9x18mm"
ITEM.model = "models/lostsignalproject/items/ammo/9x18.mdl"
ITEM.ammo = "9x18MM" // type of the ammo
ITEM.ammoAmount = 60 // amount of the ammo
ITEM.description = ""
ITEM.quantdesc =  "A box that contains %s rounds of 9x18mm ammo. "
ITEM.longdesc = "This 9x18mm round contains full metal jacket rounds with a steel penetrator and a lead core under a metal jacket."
ITEM.price = 600
ITEM.busflag = {"ammo"}
ITEM.img = ix.util.GetMaterial("cotz/icons/ammo/ammo_short_3_3.png")

ITEM.weight = 0.011
ITEM.flatweight = 0.05

function ITEM:GetWeight()
  return self.flatweight + (self.weight * self:GetData("quantity", self.ammoAmount))
end
