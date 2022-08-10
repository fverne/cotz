--[[

	PLUGIN.mapdata[mapname] = {
		serverip = server ip,

		loadzones[loadzone] = {
		pos = Vector,
		ang = Angle,
		desc = description,
		}
	}
--]]



PLUGIN.mapdata["rp_marsh_cs"] = {}
PLUGIN.mapdata["rp_marsh_cs"].name = "Great Marsh"
PLUGIN.mapdata["rp_marsh_cs"].serverip = "176.23.99.100:27015"
PLUGIN.mapdata["rp_marsh_cs"].loadzones = PLUGIN.mapdata["rp_marsh_cs"].loadzones or {}

PLUGIN.mapdata["rp_marsh_cs"].loadzones["fromoutskirts"] = {
	pos = Vector(-5776.200684, 12873.084961, 192.307175), --edit me
	ang = Angle(12.539946, -143.615875, 0.000000), --edit me
	desc = "The area ahead leads to the swamps."
}

PLUGIN.mapdata["rp_salvation_2_haven"] = {}
PLUGIN.mapdata["rp_salvation_2_haven"].name = "Outskirts"
PLUGIN.mapdata["rp_salvation_2_haven"].serverip = "176.23.99.100:27016"
PLUGIN.mapdata["rp_salvation_2_haven"].loadzones = PLUGIN.mapdata["rp_salvation_2_haven"].loadzones or {}

PLUGIN.mapdata["rp_salvation_2_haven"].loadzones["fromwaystation"] = {
	pos = Vector(2308.856201, 10894.163086, 197.129257), --edit me
	ang = Angle(3.531969, -144.119522, 0.000000), --edit me
	desc = "The area ahead leads to the Outskirts."
}
PLUGIN.mapdata["rp_salvation_2_haven"].loadzones["frommarsh"] = {
	pos = Vector(-10179.993164, -6402.410645, -7.968750), --edit me
	ang = Angle(5.907976, -33.262821, 0.000000), --edit me
	desc = "The area ahead leads to the Outskirts."
}


PLUGIN.mapdata["rp_waystation"] = {}
PLUGIN.mapdata["rp_waystation"].name = "Waystation"
PLUGIN.mapdata["rp_waystation"].serverip = "176.23.99.100:27017"
PLUGIN.mapdata["rp_waystation"].loadzones = PLUGIN.mapdata["rp_waystation"].loadzones or {}

PLUGIN.mapdata["rp_waystation"].loadzones["fromoutskirts"] = {
	pos = Vector(-8569.341797, 483.034058, 328.446228), --edit me
	ang = Angle(89.000000, 39.314655, 0.000000), --edit me
	desc = "The area ahead leads to the waystation."
}
