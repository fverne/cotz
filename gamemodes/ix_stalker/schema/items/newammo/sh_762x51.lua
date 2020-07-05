ITEM.name = "7.62x51mm"
ITEM.model = "models/kek1ch/ammo_762x54_7h1.mdl"
ITEM.width = 2
ITEM.height = 1
ITEM.ammo = "7.62x51MM" // type of the ammo
ITEM.ammoAmount = 100 // amount of the ammo
ITEM.description= "A box that contains %s rounds of 7.62x51mm ammo. "
ITEM.longdesc = "The 7.62x51 NATO round is a military variant of the .308 round which was used as a standard-issue by the NATO forces until 5.56 ammunition was introduced in the '70s in the Vietnam War. At present, it is most commonly employed by private military contractors all over the world. The 7.62x51 round is a very common machine gun caliber, and can also be used in sniper rifles."
ITEM.price = 1950
--ITEM.busflag = "SPECIAL8_1"
ITEM.img = Material("vgui/hud/762x51.png")

ITEM.weight = 0.026
ITEM.flatweight = 0.05

function ITEM:GetWeight()
  return self.flatweight + (self.weight * self:GetData("quantity", self.ammoAmount))
end