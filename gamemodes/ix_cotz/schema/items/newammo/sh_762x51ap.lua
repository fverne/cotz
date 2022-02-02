ITEM.name = "7.62x51mm M993 AP"
ITEM.model = "models/lostsignalproject/items/ammo/762x51.mdl"
ITEM.width = 2
ITEM.height = 1
ITEM.ammo = "7.62x51MM -AP-" // type of the ammo
ITEM.ammoAmount = 60 // amount of the ammo
ITEM.description = ""
ITEM.quantdesc =  "A box that contains %s rounds of Armor-Piercing 7.62x51mm ammo. "
ITEM.longdesc = "The 7.62x51 NATO round is a military variant of the .308 round which was used as a standard-issue by the NATO forces until 5.56 ammunition was introduced in the '70s in the Vietnam War. At present, it is most commonly employed by private military contractors all over the world. The 7.62x51 round is a very common machine gun caliber, and can also be used in sniper rifles."
ITEM.price = 1950
ITEM.img = ix.util.GetMaterial("cotz/icons/ammo/ammo_long_28_1.png")

ITEM.weight = 0.025
ITEM.flatweight = 0.05

function ITEM:GetWeight()
  return self.flatweight + (self.weight * self:GetData("quantity", self.ammoAmount))
end