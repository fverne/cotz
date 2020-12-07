ITEM.name = ".22LR Armor-Piercing"
ITEM.model = "models/lostsignalproject/items/ammo/9x19.mdl"
ITEM.ammo = ".22LR -AP-" // type of the ammo
ITEM.ammoAmount = 60 // amount of the ammo
ITEM.description= "A box that contains %s rounds of Armor-Piercing .22LR ammo. "
ITEM.longdesc = "This small .22LR round is primarily used for pest control, but also sports shooting and entry-level shooting."
ITEM.price = 450
ITEM.img = Material("vgui/hud/22lrzl.png")

ITEM.weight = 0.017
ITEM.flatweight = 0.05

function ITEM:GetWeight()
  return self.flatweight + (self.weight * self:GetData("quantity", self.ammoAmount))
end