#!/usr/bin/env python3
"""Build particles/cotz_anomalies.pcf, the field anomaly effects, from the particle packs in cotz_general.

Each output system copies one source system and its children under a cotz_anom_* name, so the anomalies no
longer depend on which of the overlapping wick_* files the engine loaded last. The copy also repoints
materials the packs reference but do not ship, and can enlarge or recolour a system to make a variant.
The build fails if an output material exists neither in the content addon nor in the base game.

Run from the repository root, then restart the game so the new file is loaded:
    python3 tools/anomaly_pcf.py ../cotz_general
The file is written to <content>/particles/cotz_anomalies.pcf; publish the content addon afterwards.
"""

import copy
import os
import struct
import sys
import uuid

from poltergeist_orbs_pcf import (ARRAY_OFFSET, ELEMENT, FLOAT, UNSCALED_OPERATORS, VECTOR3, attribute,
	read, reachable, write)

OUTPUT = "particles/cotz_anomalies.pcf"
COLOR = 8

# (output name, source file, source system, changes). "scale" multiplies lengths and speeds; "color"
# replaces the RGB of every definition and random colour initializer, keeping their alpha.
SYSTEMS = [
	("cotz_anom_burner_idle", "wick_stalker_anomaly_fire.pcf", "wick_pfx_jarka_inactive", {}),
	("cotz_anom_burner_flame", "wick_stalker_anomaly_fire.pcf", "wick_pfx_jarka_active", {}),
	("cotz_anom_steam_idle", "wick_stalker_anomaly_fire.pcf", "wick_pfx_par_zone", {}),
	("cotz_anom_steam_jet", "wick_stalker_anomaly_fire.pcf", "wick_pfx_par_active", {}),
	("cotz_anom_electra_idle", "wick_stalker_anomaly_electra.pcf", "wick_anomaly_electra_static", {}),
	("cotz_anom_electra_idle_2", "wick_stalker_anomaly_electra.pcf", "wick_anomaly_electra_static_2", {}),
	("cotz_anom_electra_blast", "wick_stalker_anomaly_electra.pcf", "wick_anomaly_electra_activated", {}),
	("cotz_anom_electra_blast_2", "wick_new_pfx_anoms.pcf", "wick_pfx_electra_activated", {}),
	("cotz_anom_electra_hit", "wick_new_pfx_anoms.pcf", "wick_pfx_electra_hit_small", {}),
	("cotz_anom_fruitpunch_idle", "wick_stalker_anomaly_acid.pcf", "wick_anomaly_gazirovka_static", {}),
	("cotz_anom_kisel_idle", "wick_stalker_anomaly_acid.pcf", "wick_anomaly_kisel_static", {}),
	("cotz_anom_acid_burst", "stalker_anomaly.pcf", "gazirovka_activated", {}),
	("cotz_anom_bubble_idle", "anarchycell_gravity_anomaly.pcf", "anarchycell_mincer_static", {}),
	("cotz_anom_bubble_idle_2", "wick_stalker_anomaly_gravity.pcf", "wick_anomaly_tramplin_static_2", {}),
	("cotz_anom_gravity_shield", "wick_stalker_anomaly_gravity.pcf", "wick_anomaly_gravity_shield_part_1", {}),
	("cotz_anom_vortex_idle", "anarchycell_gravity_anomaly.pcf", "anarchycell_voronka_static", {}),
	("cotz_anom_vortex_blast", "anarchycell_gravity_anomaly.pcf", "anarchycell_voronka_blast", {}),
	("cotz_anom_karusel_idle", "wick_stalker_anomaly_gravity.pcf", "wick_anomaly_karusel_static", {}),
	# The charge also holds the Karusel's release: its burst plays six seconds in.
	("cotz_anom_karusel_charge", "wick_stalker_anomaly_gravity.pcf", "wick_anomaly_karusel_activated", {}),
	("cotz_anom_karusel_swirl", "wick_stalker_anomaly_gravity.pcf", "wick_anomaly_karusel_activated_idle", {}),
	("cotz_anom_springboard_idle", "anarchycell_gravity_anomaly.pcf", "anarchycell_tramplin_static_2", {}),
	("cotz_anom_tramplin_blast", "anarchycell_gravity_anomaly.pcf", "anarchycell_tramplin_blast", {}),
	("cotz_anom_tesla_idle", "wick_stalker_anomaly_electra.pcf", "wick_anomaly_zone_emi_static", {}),
	("cotz_anom_tesla_charge", "wick_stalker_anomaly_electra.pcf", "wick_anomaly_zone_emi_start", {}),
	("cotz_anom_tesla_blast", "wick_stalker_anomaly_electra.pcf", "wick_anomaly_zone_emi_blast", {}),
	("cotz_anom_psy_idle", "wick_stalker_anomaly_psy.pcf", "wick_stalker_psyzone_static", {}),
	("cotz_anom_psy_glow", "wick_stalker_anom.pcf", "wick_stalker_zone_emi_static", {"color": (170, 92, 235)}),
	("cotz_anom_psy_pulse", "wick_stalker_anomaly_electra.pcf", "wick_anomaly_zone_emi_blast",
		{"color": (170, 92, 235)}),
	("cotz_anom_zone_fire", "wick_stalker_anomaly_zones.pcf", "wick_stalker_firezone_static", {}),
	("cotz_anom_zone_acid", "wick_stalker_anomaly_zones.pcf", "wick_stalker_acid_zone_static", {}),
	("cotz_anom_zone_electro", "wick_stalker_anomaly_zones.pcf", "wick_stalker_electro_zone_static", {}),
	("cotz_anom_comet_fire", "stalker_anomaly.pcf", "kometa", {}),
	("cotz_anom_comet_electra", "stalker_anomaly.pcf", "kometa_electra", {}),
]

# Materials the packs reference but do not ship, mapped to the closest shipped texture.
MATERIAL_FIXES = {
	"wick/stalker/effects/wick_pfx_smoke_1.vmt": "wick/particles/wick_new_pfx_smoke_1.vmt",
	"wick/stalker/effects/wick_pfx_smoke_2.vmt": "wick/particles/wick_new_pfx_smoke_2.vmt",
	"mph_glow.vmt": "wick/particles/wick_new_pfx_fire_glow1.vmt",
	"particle/leaves_r_spin.vmt": "wick/particles/wick_new_pfx_leave.vmt",
	"effects/pfx_lightning_01.vmt": "wick/particles/wick_pfx_lightning_01.vmt",
}
# Shipped with Half-Life 2 or Garry's Mod, so absent from the content addon.
BASE_GAME_MATERIALS = {"effects/spark.vmt", "vgui/white", "sprites/heatwave.vmt"}

SCALED_FIELDS = {
	"Radius Random": ("radius_min", "radius_max"),
	"Position Within Box Random": ("min", "max"),
	"Movement Basic": ("gravity",),
	"Position Within Sphere Random": ("distance_min", "distance_max", "speed_min", "speed_max",
		"speed_in_local_coordinate_system_min", "speed_in_local_coordinate_system_max"),
}
UNSCALED = UNSCALED_OPERATORS | {"Movement Lock to Control Point", "Alpha Fade In Random", "Alpha Fade Out Random"}


def normal_material(path):
	return path.replace("\\", "/").lower()


def scale_fields(element, fields, factor):
	for name in fields:
		entry = attribute(element, name)
		if entry is None:
			continue
		assert entry[1] in (FLOAT, VECTOR3), "unexpected type for " + name
		count = len(entry[2]) // 4
		numbers = struct.unpack("<%df" % count, entry[2])
		entry[2] = struct.pack("<%df" % count, *(number * factor for number in numbers))


def recolor(element, rgb, names):
	for name in names:
		entry = attribute(element, name)
		if entry is not None and entry[1] == COLOR:
			entry[2] = bytes(rgb) + entry[2][3:]


def rename(old, source, target):
	if old == source:
		return target
	if old.startswith(source + "_"):
		return target + old[len(source):]
	return target + "_" + (old[5:] if old.startswith("wick_") else old)


def copy_system(sources, target, file_name, source, changes):
	table, elements = sources[file_name]
	definitions = {element["name"]: index for index, element in enumerate(elements)
		if element["type"] == "DmeParticleSystemDefinition"}
	assert source in definitions, "%s has no system %s" % (file_name, source)
	kept = sorted(reachable(elements, definitions[source]))
	copies = {index: copy.deepcopy(elements[index]) for index in kept}

	for element in copies.values():
		if element["type"] == "DmeParticleSystemDefinition":
			element["name"] = rename(element["name"], source, target)
			material = attribute(element, "material")
			if material is not None and material[2]:
				fixed = MATERIAL_FIXES.get(normal_material(material[2]))
				material[2] = fixed.replace("/", "\\") if fixed else material[2]
			if "color" in changes:
				# Systems without a colour initializer draw in the definition's colour.
				recolor(element, changes["color"], ("color",))
			if "scale" in changes:
				scale_fields(element, ("radius", "bounding_box_min", "bounding_box_max"), changes["scale"])
		elif element["type"] == "DmeParticleOperator":
			function = attribute(element, "functionName")[2]
			if "scale" in changes:
				assert function in SCALED_FIELDS or function in UNSCALED, "unclassified: " + function
				scale_fields(element, SCALED_FIELDS.get(function, ()), changes["scale"])
			if "color" in changes and function == "Color Random":
				recolor(element, changes["color"], ("color1", "color2"))

	return table, kept, copies, definitions[source]


def build(content):
	files = {entry[1] for entry in SYSTEMS}
	sources = {}
	for name in files:
		with open(os.path.join(content, "particles", name), "rb") as handle:
			data = handle.read()
		table, elements = read(data)
		assert write(table, elements) == data, name + " does not survive a round trip"
		sources[name] = (table, elements)

	root = copy.deepcopy(sources[SYSTEMS[0][1]][1][0])
	result, strings, listing = [root], set(sources[SYSTEMS[0][1]][0]), []
	for target, file_name, source, changes in SYSTEMS:
		table, kept, copies, top = copy_system(sources, target, file_name, source, changes)
		strings |= set(table)
		offset = len(result)
		new_index = {old: offset + position for position, old in enumerate(kept)}
		for old in kept:
			element = copies[old]
			# Fresh IDs: the engine can resolve child systems by ID, which must not match the pack originals.
			element["id"] = uuid.uuid5(uuid.NAMESPACE_URL, "cotz-anomalies/%s/%d" % (target, old)).bytes
			for entry in element["attributes"]:
				if entry[1] == ELEMENT and entry[2] >= 0:
					entry[2] = new_index[entry[2]]
				elif entry[1] == ELEMENT + ARRAY_OFFSET:
					entry[2] = [new_index[index] if index >= 0 else index for index in entry[2]]
			result.append(element)
			if element["type"] == "DmeParticleSystemDefinition":
				listing.append(new_index[old])
		assert result[new_index[top]]["name"] == target

	attribute(root, "particleSystemDefinitions")[2] = listing
	names = [result[index]["name"] for index in listing]
	assert len(names) == len(set(names)), "duplicate system names in the output"
	return write(sorted(strings), result), names, result


def check_materials(content, elements):
	shipped = set()
	for folder, _, files in os.walk(os.path.join(content, "materials")):
		for name in files:
			if name.lower().endswith(".vmt"):
				relative = os.path.relpath(os.path.join(folder, name), os.path.join(content, "materials"))
				shipped.add(normal_material(relative))
	missing = set()
	for element in elements:
		material = attribute(element, "material") if element["type"] == "DmeParticleSystemDefinition" else None
		if material is not None and material[2]:
			path = normal_material(material[2])
			if path not in shipped and path not in BASE_GAME_MATERIALS:
				missing.add(path)
	assert not missing, "materials missing from the content addon: " + ", ".join(sorted(missing))


def main():
	if len(sys.argv) != 2:
		sys.exit(__doc__)
	content = sys.argv[1]
	output, names, elements = build(content)
	check_materials(content, elements)
	read(output)
	path = os.path.join(content, OUTPUT)
	with open(path, "wb") as target:
		target.write(output)
	tops = [entry[0] for entry in SYSTEMS]
	print("wrote %s (%d bytes, %d systems): %s" % (path, len(output), len(names), " ".join(tops)))


if __name__ == "__main__":
	main()
