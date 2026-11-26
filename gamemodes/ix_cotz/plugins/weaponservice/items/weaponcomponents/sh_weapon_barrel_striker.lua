ITEM.name = "Striker Barrel"
ITEM.description = "A replacement barrel prepared for the Striker."
ITEM.longdesc = "The mounting surfaces are cut for the Striker. A technician fits this barrel together with a matching receiver to rebuild the weapon."

ITEM.model = "models/illusion/eftcontainers/weaponparts.mdl"

ITEM.price = 150
ITEM.width = 2
ITEM.height = 1
ITEM.flatweight = 0.35

ITEM.weaponID = "striker"
ITEM.componentKind = "barrel"
ITEM.commissionRate = 0.2
ITEM.recipe = {
	value_controller = 1,
	value_handdrill = 1,
	value_tools_advwrench = 1,
	value_tools_ratchetwrench = 1,
	value_wrench = 1,
	weapon_parts_shotgun = 6,
}
