ITEM.name = "9x18mm +P"
ITEM.model = "models/lostsignalproject/items/ammo/9x18.mdl"
ITEM.ammo = "9x18MM -HP-" // type of the ammo
ITEM.ammoAmount = 60 // amount of the ammo
ITEM.description = ""
ITEM.quantdesc =  "A box that contains %s rounds of Hollow-Point 9x18mm ammo. "
ITEM.longdesc = "This repurposed 9x18mm round contains full metal jacket rounds with a steel penetrator and a lead core under a metal jacket."
ITEM.price = 600
ITEM.img = ix.util.GetMaterial("cotz/icons/ammo/ammo_short_3_2.png")

ITEM.weight = 0.010
ITEM.flatweight = 0.05

function ITEM:GetWeight()
  return self.flatweight + (self.weight * self:GetData("quantity", self.ammoAmount))
end
