#!/usr/bin/env python3
"""Build particles/cotz_poltergeist_orbs.pcf, enlarged copies of two wick artefact effects.

Garry's Mod cannot resize a particle system at runtime. The fire and telekinetic poltergeist orbs use
artefact-sized effects, while the electric orb is anomaly-sized, so this copies those two systems and their
children and multiplies every spatial value. Materials stay the ones shipped with cotz_general.

Run from the repository root, then restart the game so the new file is loaded:
    python3 tools/poltergeist_orbs_pcf.py <cotz_general>/particles/wick_stalker_artefacts.pcf
"""

import struct
import sys
import uuid

HEADER = b"<!-- dmx encoding binary 2 format pcf 1 -->\n\0"
OUTPUT = "particles/cotz_poltergeist_orbs.pcf"

# The electric orb's sprites are about 60-78 units in radius; the sources' largest are about 20.
SCALE = 3.5
SYSTEMS = {"wick_stalker_art_fire": "cotz_orb_fire", "wick_stalker_art_gravi": "cotz_orb_gravity"}

ELEMENT, INT, FLOAT, BOOL, STRING, BINARY, VECTOR3 = 1, 2, 3, 4, 5, 6, 10
ARRAY_OFFSET = 14
FIXED_SIZES = {ELEMENT: 4, INT: 4, FLOAT: 4, BOOL: 1, 7: 4, 8: 4, 9: 8, VECTOR3: 12, 11: 16, 12: 12,
	13: 16, 14: 64}

DEFINITION_FIELDS = ("radius", "bounding_box_min", "bounding_box_max")
OPERATOR_FIELDS = {
	"Radius Random": ("radius_min", "radius_max"),
	"Position Within Box Random": ("min", "max"),
	"Movement Basic": ("gravity",),
}
# Operators without lengths or speeds. Anything else must be classified before it can be copied.
UNSCALED_OPERATORS = {
	"render_animated_sprites", "emit_continuously", "emit_instantaneously", "Lifetime Random",
	"Rotation Random", "Alpha Random", "Color Random", "Alpha Fade and Decay", "Radius Scale",
	"Lifespan Decay", "Rotation Spin Roll",
}


class Reader:
	def __init__(self, data):
		self.data, self.position = data, len(HEADER)

	def take(self, size):
		chunk = self.data[self.position:self.position + size]
		self.position += size
		return chunk

	def unpack(self, form):
		return struct.unpack(form, self.take(struct.calcsize(form)))[0]

	def string(self):
		end = self.data.index(b"\0", self.position)
		text = self.data[self.position:end]
		self.position = end + 1
		return text.decode("latin1")

	def value(self, kind):
		if kind == STRING:
			return self.string()
		if kind == BINARY:
			return self.take(self.unpack("<i"))
		if kind == ELEMENT:
			index = self.unpack("<i")
			assert index >= -1, "external element references are not supported"
			return index
		return self.take(FIXED_SIZES[kind])


def read(data):
	assert data.startswith(HEADER), "expected a binary 2 PCF"
	reader = Reader(data)
	table = [reader.string() for _ in range(reader.unpack("<H"))]
	elements = []
	for _ in range(reader.unpack("<i")):
		element_type = table[reader.unpack("<H")]
		name = reader.string()
		elements.append({"type": element_type, "name": name, "id": reader.take(16), "attributes": []})
	for element in elements:
		for _ in range(reader.unpack("<i")):
			name = table[reader.unpack("<H")]
			kind = reader.unpack("<B")
			if kind > ARRAY_OFFSET:
				value = [reader.value(kind - ARRAY_OFFSET) for _ in range(reader.unpack("<i"))]
			else:
				value = reader.value(kind)
			element["attributes"].append([name, kind, value])
	assert reader.position == len(data), "unread bytes after the last element"
	return table, elements


def encode(kind, value):
	if kind == STRING:
		return value.encode("latin1") + b"\0"
	if kind == BINARY:
		return struct.pack("<i", len(value)) + value
	if kind == ELEMENT:
		return struct.pack("<i", value)
	return value


def write(table, elements):
	indices = {text: index for index, text in enumerate(table)}
	chunks = [HEADER, struct.pack("<H", len(table))]
	chunks += [encode(STRING, text) for text in table]
	chunks.append(struct.pack("<i", len(elements)))
	for element in elements:
		chunks += [struct.pack("<H", indices[element["type"]]), encode(STRING, element["name"]), element["id"]]
	for element in elements:
		chunks.append(struct.pack("<i", len(element["attributes"])))
		for name, kind, value in element["attributes"]:
			chunks.append(struct.pack("<HB", indices[name], kind))
			if kind > ARRAY_OFFSET:
				chunks.append(struct.pack("<i", len(value)))
				chunks += [encode(kind - ARRAY_OFFSET, item) for item in value]
			else:
				chunks.append(encode(kind, value))
	return b"".join(chunks)


def attribute(element, name):
	for entry in element["attributes"]:
		if entry[0] == name:
			return entry


def references(element):
	for _, kind, value in element["attributes"]:
		if kind == ELEMENT and value >= 0:
			yield value
		elif kind == ELEMENT + ARRAY_OFFSET:
			yield from (index for index in value if index >= 0)


def reachable(elements, start):
	found, pending = set(), [start]
	while pending:
		index = pending.pop()
		if index not in found:
			found.add(index)
			pending.extend(references(elements[index]))
	return found


def scale(element, fields):
	for name in fields:
		entry = attribute(element, name)
		if entry is None:
			continue
		assert entry[1] in (FLOAT, VECTOR3), "unexpected type for " + name
		count = len(entry[2]) // 4
		numbers = struct.unpack("<%df" % count, entry[2])
		entry[2] = struct.pack("<%df" % count, *(number * SCALE for number in numbers))


def build(data):
	table, elements = read(data)
	assert write(table, elements) == data, "the source does not survive a round trip"
	definitions = {element["name"]: index for index, element in enumerate(elements)
		if element["type"] == "DmeParticleSystemDefinition"}

	keep = set()
	for source in SYSTEMS:
		keep |= reachable(elements, definitions[source])
	kept_definitions = sorted(index for index in definitions.values() if index in keep)

	renames = {}
	for index in kept_definitions:
		old = elements[index]["name"]
		source = next(source for source in SYSTEMS if old == source or old.startswith(source + "_"))
		renames[old] = SYSTEMS[source] + old[len(source):]

	root = elements[0]
	listing = attribute(root, "particleSystemDefinitions")
	listing[2] = kept_definitions
	order = [0] + sorted(keep - {0})
	new_index = {old: new for new, old in enumerate(order)}

	result = []
	for old in order:
		element = elements[old]
		if element["type"] == "DmeParticleSystemDefinition":
			scale(element, DEFINITION_FIELDS)
		elif element["type"] == "DmeParticleOperator":
			function = attribute(element, "functionName")[2]
			assert function in OPERATOR_FIELDS or function in UNSCALED_OPERATORS, "unclassified: " + function
			scale(element, OPERATOR_FIELDS.get(function, ()))
		element["name"] = renames.get(element["name"], element["name"])
		# Fresh IDs: the engine can resolve child systems by ID, which must not match the small originals.
		element["id"] = uuid.uuid5(uuid.NAMESPACE_URL, "cotz-poltergeist-orbs/%d" % new_index[old]).bytes
		for entry in element["attributes"]:
			if entry[1] == ELEMENT and entry[2] >= 0:
				entry[2] = new_index[entry[2]]
			elif entry[1] == ELEMENT + ARRAY_OFFSET:
				entry[2] = [new_index[index] if index >= 0 else index for index in entry[2]]
		result.append(element)

	used = {element["type"] for element in result}
	used |= {entry[0] for element in result for entry in element["attributes"]}
	return write([text for text in table if text in used], result), sorted(renames.values())


def main():
	if len(sys.argv) != 2:
		sys.exit(__doc__)
	with open(sys.argv[1], "rb") as source:
		output, names = build(source.read())
	with open(OUTPUT, "wb") as target:
		target.write(output)
	print("wrote %s (%d bytes): %s" % (OUTPUT, len(output), " ".join(names)))


if __name__ == "__main__":
	main()
