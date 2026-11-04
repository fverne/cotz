"""Source acquisition evidence for progression pools; no live spawn-rate claims."""
from collections import defaultdict
import json
import re

from progression import array, entries, fields, scalar, table_end


def worldspawn_scope(group):
    match = re.fullmatch(r"worldspawn_([1-9][0-9]*)", group)
    if not match:
        return None, "", "Non-world route"
    number = int(match[1])
    tier = (number + 1) // 2
    name = {1: "Marsh", 2: "Waystation", 3: "Pripyat"}.get(tier, f"Map {tier}")
    return tier, name, "Normal" if number % 2 else "Hard to find"


def build_audit(root, entities, pools, tokenize, decode):
    grouped_items = defaultdict(list)
    for entity in entities:
        if entity["tab"] == "Items":
            grouped_items[entity["id"]].append(entity)
    items = {ident: rows[0] for ident, rows in grouped_items.items() if len(rows) == 1}
    wanted = {c["item"] for pool in pools.values() for c in pool["candidates"]}
    original = root / "docs/balance/progression/original-requirements.json"
    if original.is_file():
        wanted.update(item for req in json.loads(original.read_text()).values() for item in req)
    memberships = defaultdict(list)
    for ident, pool in pools.items():
        for candidate in pool["candidates"]:
            memberships[candidate["item"]].append(ident)
    rows, warnings, quantities = [], [], {}
    for ident in sorted(wanted):
        item = items.get(ident)
        if not item:
            reason = "Ambiguous item definitions" if ident in grouped_items else "Unknown candidate/original item"
            warnings.append(["Progression acquisition audit", f"{reason}: {ident}; instance quantity/source unresolved"])
            continue
        source = (root / item["source"]).read_text(encoding="utf-8-sig")
        quantity = item["fields"].get("quantity", {}).get("value", 1)
        match = re.search(r'SetData\("quantity",\s*math\.random\((\d+),\s*(\d+)\)', source)
        quantities[ident] = [int(match[1]), int(match[2])] if match else [quantity, quantity]

    def add(item, route, group, source, weight=None, total=None, chance=None, quantity=None, note=""):
        if item not in wanted:
            return
        limits = quantities.get(item, [None, None])
        rows.append([item, items.get(item, {}).get("name", item), "; ".join(memberships[item]), route,
                     group, weight, total, chance, quantity, limits[0], limits[1], source,
                     items.get(item, {}).get("source", ""), *worldspawn_scope(group), note])

    for path in sorted((root / "gamemodes/ix_cotz/plugins/randomitem").rglob("*.lua")):
        source = path.read_text(encoding="utf-8-sig")
        tokens = tokenize(source)
        for i in range(len(tokens) - 10):
            if [t.value for t in tokens[i:i + 6]] != ["ix", ".", "randomitems", ".", "tables", "["]:
                continue
            if tokens[i + 6].kind != "string" or [t.value for t in tokens[i + 7:i + 10]] != ["]", "=", "{"]:
                continue
            group = decode(tokens[i + 6].value)
            try:
                end = table_end(tokens, i + 9)
                drops = []
                for entry in entries(tokens[i + 9:end]):
                    data = entries(entry)
                    weight = scalar(data[0], decode)
                    values = entries(data[1])
                    item = scalar(values[0], decode)
                    quantity = None
                    if len(values) > 1:
                        extra = fields(values[1], decode)
                        if "quantity" in extra:
                            quantity = scalar(extra["quantity"], decode)
                    drops.append((item, weight, quantity))
                total = sum(weight for _, weight, _ in drops)
                for item, weight, quantity in drops:
                    add(item, "Weighted loot", group, path.relative_to(root).as_posix(), weight, total,
                        weight / total if total else None, quantity,
                        "Probability within this table only; map spawn-point frequencies and vendor access are not resolved.")
            except (ValueError, TypeError, IndexError, KeyError) as exc:
                warnings.append([path.relative_to(root).as_posix(), f"Acquisition pool {group} not inspected: {exc}"])

    harvests = defaultdict(list)
    path = root / "gamemodes/ix_cotz/plugins/mutantpoaching/sv_plugin.lua"
    if path.is_file():
        tokens = tokenize(path.read_text())
        for i in range(len(tokens) - 6):
            if [t.value for t in tokens[i:i + 6]] != ["ix", ".", "poaching", ".", "MutantParts", "="]:
                continue
            end = table_end(tokens, i + 6)
            for mutant, body in fields(tokens[i + 6:end], decode).items():
                data = fields(body, decode)
                meat = scalar(data["meattype"], decode)
                harvests[meat].append(mutant)
                add(meat, "Guaranteed harvest", mutant, path.relative_to(root).as_posix(), chance=1, quantity=1,
                    note="Conditional on harvesting this mutant; encounter frequency is not resolved.")
                for entry in entries(data["parts"]):
                    item, threshold = array(entry, decode)
                    add(item, "Poaching trophy", mutant, path.relative_to(root).as_posix(), chance=threshold / 101,
                        quantity=1, note=f"Source threshold {threshold:g}; math.random(0, 100) < threshold. "
                        "Encounter frequency and quarry difficulty require playtesting.")
            break
    for raw, mutants in harvests.items():
        item = items.get(raw)
        if not item:
            continue
        tokens = tokenize((root / item["source"]).read_text())
        for i in range(len(tokens) - 4):
            if [t.value for t in tokens[i:i + 4]] == ["ITEM", ".", "meal", "="]:
                meal = scalar(tokens[i + 4:i + 5], decode)
                add(meal, "Harvest and cooking", "; ".join(mutants), item["source"], quantity=1,
                    note=f"Cook {raw}; meat harvest is guaranteed for the listed quarry. Cooking fuel/time still applies.")
    for entity in entities:
        if entity["tab"] != "Anomaly fields":
            continue
        for tier in ("commonArtifacts", "rareArtifacts", "veryRareArtifacts"):
            for item in entity["fields"].get(tier, {}).get("value", []):
                add(item, "Anomaly field tier", entity["name"] + ": " + tier, entity["source"], quantity=1,
                    note="Tier membership only; overall anomaly spawn rates and map placement are not resolved.")
    found = {r[0] for r in rows}
    for item in sorted(wanted - found):
        add(item, "Manual source review", "", items.get(item, {}).get("source", ""),
            note="No direct weighted, harvest, cooking or anomaly route found. Review story vendors or bespoke sources.")
    header = ["Item ID", "Item", "Personal pools", "Acquisition route", "Loot pool / quarry / field tier",
              "Entry weight", "Table total weight", "Conditional probability", "Explicit spawn units",
              "Instance quantity min/default", "Instance quantity max/default", "Acquisition source", "Item source",
              "World map tier", "World map", "World spawn class", "Limitations"]
    return [header] + sorted(rows, key=lambda row: (row[0], row[3], row[4])), warnings
