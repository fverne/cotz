ITEM.name = "7.62x39mm Zone-Loaded"
ITEM.model = "models/lostsignalproject/items/ammo/762x39.mdl"
ITEM.width = 2
ITEM.height = 1
ITEM.ammo = "7.62x39MM -ZL-" // type of the ammo
ITEM.ammoAmount = 100 // amount of the ammo
ITEM.description= "A box that contains %s rounds of zone-loaded 7.62x39mm ammo. "
ITEM.longdesc = "7.62x39 Full Metal Jacket is one the most commonly used types of ammunition, especially in Africa and in the Middle East. Some nicknamed it the 'Round of the Revolution' due to its favored use by both terrorist and criminal organizations. Due to the sheer power of the round most military organizations have turned to using additional steel plates to counter 7.62x39 as there is a high probability of encountering it in combat situations."
ITEM.price = 1700
ITEM.img = Material("vgui/hud/762x39zl.png")

ITEM.weight = 0.018
ITEM.flatweight = 0.05

function ITEM:GetWeight()
  return self.flatweight + (self.weight * self:GetData("quantity", self.ammoAmount))
end