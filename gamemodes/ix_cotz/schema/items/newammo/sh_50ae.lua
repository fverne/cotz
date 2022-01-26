ITEM.name = ".50AE"
ITEM.model = "models/lostsignalproject/items/ammo/50cal_hs.mdl"
ITEM.ammo = ".50 AE" // type of the ammo
ITEM.ammoAmount = 60 // amount of the ammo
ITEM.description = ""
ITEM.quantdesc =  "A box that contains %s rounds of .50 AE ammo. "
ITEM.longdesc = "The .50 Action Express is a large caliber handgun cartridge. Developed in 1988 by American Evan Whildin of Action Arms, the .50 AE is one of the most powerful pistol cartridges in production."
ITEM.price = 1750
--ITEM.busflag = "SPECIAL8_1"
ITEM.img = ix.util.GetMaterial("cotz/icons/ammo/ammo_long_37_3.png")


ITEM.weight = 0.028
ITEM.flatweight = 0.05

function ITEM:GetWeight()
  return self.flatweight + (self.weight * self:GetData("quantity", self.ammoAmount))
end