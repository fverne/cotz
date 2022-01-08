ITEM.name = ".410 Magnum Buck"
ITEM.model = "models/lostsignalproject/items/ammo/12x76_jhp.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.ammo = ".45 ACP -41-" // type of the ammo
ITEM.ammoAmount = 20 // amount of the ammo
ITEM.description = ""
ITEM.quantdesc =  "A box that contains %s .410 bore shells. "
ITEM.longdesc = "The .410 bore, is the second-smallest caliber of shotgun shell commonly available. A .410 bore shotgun loaded with shot shells is well suited for small game hunting and pest control."
ITEM.price = 600
ITEM.busflag = {"ammo2"}
ITEM.img = ix.util.GetMaterial("vgui/hud/410buck.png")

ITEM.weight = 0.015
ITEM.flatweight = 0.07

function ITEM:GetWeight()
  return self.flatweight + (self.weight * self:GetData("quantity", self.ammoAmount))
end