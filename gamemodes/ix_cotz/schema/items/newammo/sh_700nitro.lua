ITEM.name = ".700 Nitro Express"
ITEM.model = "models/items/ammo_500sw.mdl"
ITEM.ammo = ".700 Nitro Express" // type of the ammo
ITEM.ammoAmount = 8 // amount of the ammo
ITEM.description = ""
ITEM.quantdesc =  "A box that contains %s rounds of .700 Nitro Express. "
ITEM.longdesc = "The .700 Nitro Express (17.8×89mmR) is a big game rifle cartridge. The cartridge was introduced in 1988 by the boutique gunmakers Holland & Holland (H&H) of London, England. It was developed by Jim Bell and William Feldstein and built by H&H. Feldstein had tried unsuccessfully to get H&H to build a .600 Nitro Express for him, but they had already ceased production. However, when Bell and Feldstein produced an entirely new .700 Nitro Express cartridge, they were able to attract the interest of H&H, which was looking for a new big-bore cartridge. After production began, the backlog of orders was so great that it continued to 2007 and H&H restarted the production of .600 Nitro Express guns."
ITEM.price = 35000
ITEM.busflag = {"ammo1_1"}
ITEM.width = 2
ITEM.img = ix.util.GetMaterial("cotz/icons/ammo/ammo_long_39_1.png")

ITEM.weight = 0.120
ITEM.flatweight = 0.20

function ITEM:GetWeight()
  return self.flatweight + (self.weight * self:GetData("quantity", self.ammoAmount))
end