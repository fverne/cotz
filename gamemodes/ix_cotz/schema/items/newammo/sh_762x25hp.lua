ITEM.name = "7.62x25mm Hollow-Point"
ITEM.model = "models/kek1ch/ammo_762x25_p.mdl"
ITEM.ammo = "7.62x25MM -HP-" // type of the ammo
ITEM.ammoAmount = 60 // amount of the ammo
ITEM.description = ""
ITEM.quantdesc =  "A box that contains %s rounds of Hollow-Point 7.62x25mm ammo. "
ITEM.longdesc = "The 7.62x25mm cartridge is a Russian bottle-necked pistol cartridge widely used in former Soviet satellite states, China and Pakistan among other countries. The cartridge is an enhanced Russian version of the 7.63x25mm Mauser. It has an excellent penetration and can easily defeat lighter ballistic vests as well as kevlar helmets. Although most firearms chambered in this caliber are obsolete and removed from military inventories, the cartridge still sees widespread use because of the large quantity of stored ammunition available."
ITEM.price = 500
ITEM.width = 1
ITEM.height = 1
ITEM.img = ix.util.GetMaterial("cotz/icons/ammo/ammo_short_1_2.png")

ITEM.weight = 0.0095
ITEM.flatweight = 0.03

function ITEM:GetWeight()
  return self.flatweight + (self.weight * self:GetData("quantity", self.ammoAmount))
end