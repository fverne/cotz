ITEM.name = "9x39mm SP-6"
ITEM.model = "models/lostsignalproject/items/ammo/9x39.mdl"
ITEM.width = 2
ITEM.height = 1
ITEM.ammo = "9x39MM -AP-" // type of the ammo
ITEM.ammoAmount = 60 // amount of the ammo
ITEM.description = ""
ITEM.quantdesc =  "A box that contains %s rounds of Armor-Piercing 9x39mm ammo. "
ITEM.longdesc = "The SP-5 is a subsonic 9x39mm rifle round with a bimetallic casing. The round contains a steel core with a gap behind it that is filled with lead. Requires a suppressor for stealth firing. Used by special services of Warsaw Pact countries."
ITEM.price = 1900
ITEM.img = ix.util.GetMaterial("cotz/icons/ammo/ammo_long_13_1.png")

ITEM.weight = 0.015
ITEM.flatweight = 0.08

function ITEM:GetWeight()
  return self.flatweight + (self.weight * self:GetData("quantity", self.ammoAmount))
end

function ITEM:PopulateTooltip(tooltip)
  if (!self.entity) then
      ix.util.PropertyDesc(tooltip, "Armor-Piercing Ammunition", Color(64, 224, 208))
  end
end