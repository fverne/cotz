ITEM.name = "5.7x28mm FN R37.F"
ITEM.model = "models/lostsignalproject/items/ammo/57x28.mdl"
ITEM.ammo = "5.7x28MM -HP-" // type of the ammo
ITEM.ammoAmount = 60 // amount of the ammo
ITEM.description = ""
ITEM.quantdesc =  "A box that contains %s rounds of Hollow-Point 5.7x28mm ammo. "
ITEM.longdesc = "The FN 5.7x28mm is a high velocity cartridge designed and manufactured by FN Herstal. It is a bottlenecked centerfire cartridge that is somewhat similar to the .22 Hornet or .22 K-Hornet. The 5.7x28mm was developed in conjunction with the FN P90 personal defense weapon (PDW) and FN Five-seven pistol, in response to NATO requests for a replacement for the 9x19mm Parabellum cartridge."
ITEM.price = 850
ITEM.img = ix.util.GetMaterial("cotz/icons/ammo/ammo_short_5_2.png")

ITEM.weight = 0.0055
ITEM.flatweight = 0.06

function ITEM:GetWeight()
  return self.flatweight + (self.weight * self:GetData("quantity", self.ammoAmount))
end