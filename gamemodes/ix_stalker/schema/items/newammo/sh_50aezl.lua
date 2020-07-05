ITEM.name = ".50AE Zone-Loaded"
ITEM.model = "models/kek1ch/ammo_50_ae.mdl"
ITEM.ammo = ".50 AE -ZL-" // type of the ammo
ITEM.ammoAmount = 100 // amount of the ammo
ITEM.description= "A box that contains %s rounds of zone-loaded .50 AE ammo. "
ITEM.longdesc = "The .50 Action Express is a large caliber handgun cartridge. Developed in 1988 by American Evan Whildin of Action Arms, the .50 AE is one of the most powerful pistol cartridges in production."
ITEM.price = 1750
ITEM.img = Material("vgui/hud/50aezl.png")

ITEM.weight = 0.27
ITEM.flatweight = 0.05

function ITEM:GetWeight()
  return self.flatweight + (self.weight * self:GetData("quantity", self.ammoAmount))
end