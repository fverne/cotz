"""Offline FTS supply estimates. Run from the repository root; never deploys map data."""
from __future__ import annotations

import argparse
from collections import Counter, defaultdict
import json
from pathlib import Path
import subprocess

ROOT = Path(__file__).resolve().parents[3]
OUT = ROOT / "docs/npc-overhaul"
MAPS = ("rp_marsh_cs", "rp_garbage_cotz", "rp_waystation", "rp_pripyat_remaster")
WORLD_CHANCE = 25 / 101
WORLD_CAP = 76  # Runtime checks > 75 before the next attempt.
BOX_CAP = 51  # Runtime checks > 50.


def snapshot():
    result = subprocess.run(
        ["luatex", "--luaonly", "docs/npc-overhaul/tools/fts_loot_snapshot.lua"],
        cwd=ROOT, check=True, text=True, capture_output=True,
    )
    return json.loads(result.stdout)


def distribution(rows, data):
    """Expected item entities and hand-in units per positive weighted selection."""
    total = sum(row[0] for row in rows if row[0] > 0)
    result = defaultdict(lambda: [0.0, 0.0])
    for weight, entry in rows:
        if weight <= 0:
            continue
        item = entry[0]
        state = entry[1] if len(entry) > 1 else {}
        quantity = state.get("quantity")
        if quantity is None:
            quantity = data["batches"].get(item, [data["items"].get(item, {}).get("quantity", 1)])
        if isinstance(quantity, list):
            quantity = sum(quantity) / len(quantity)
        probability = weight / total
        result[item][0] += probability
        result[item][1] += probability * quantity
    return result


def estimate(data):
    rates = {region: defaultdict(lambda: defaultdict(lambda: [0.0, 0.0])) for region in MAPS}
    counts = {}
    missing = set()

    def add(region, source, pool, rolls):
        if pool not in data["loot"]:
            missing.add(pool)
            # Installed GetRandomItemFromPool falls back to its library-local default.
            rows = [[2000, ["food_bread"]], [50, ["mp5"]], [200, ["9x19", {"quantity": 25}]]]
        else:
            rows = data["loot"][pool]
        for item, values in distribution(rows, data).items():
            for index, value in enumerate(values):
                rates[region][item][source][index] += rolls * value

    for region, preset in data["presets"].items():
        plugins = preset["plugindata"]
        world = Counter(point[1] for point in plugins["worlditemspawner"])
        boxes = plugins["boxspawner"]
        cyclic = Counter(c["cyclicalCategory"] for c in preset["containers"] if c["cyclicalCategory"])
        passive = Counter(c["spawnCategory"] for c in preset["containers"] if c["spawnCategory"])
        counts[region] = {
            "world": dict(world), "boxes": dict(Counter(str(p[1]) for p in boxes)),
            "cyclic": dict(cyclic), "passive": dict(passive),
            "hidden": len(plugins["hidestashspawner"]), "anomalies": len(plugins["anomalycontroller"]),
        }
        points = sum(world.values())
        # Uniform point sampling approximation under the shared world cap.
        world_rolls = min(points * WORLD_CHANCE, WORLD_CAP) * 12
        for pool, count in world.items():
            add(region, "world", pool, world_rolls * count / points)
        box_scale = min(1, BOX_CAP / len(boxes)) if boxes else 0
        for point in boxes:
            choices = [("ix_entbox_drops", 4 / 6)] if point[1] != 2 else [
                ("ix_wood_entbox_drops", 0.5), ("ix_paper_entbox_drops", 1 / 3),
            ]
            for pool, rolls in choices:
                add(region, "boxes", point[2] if len(point) > 2 else pool, rolls * box_scale * 12)
        for category, count in cyclic.items():
            definition = data["cyclic"]["categoryDefs"][category]
            types = definition["allowedStashTypes"]
            rolls = count * 3600 / definition["disappearTime"] / len(types)
            for stash in types:
                for pool in data["cyclic"]["stashTypes"][stash]:
                    add(region, "cyclic", pool, rolls)
        # Passive containers depend on player count, capacity and iteration order; count, do not mix into index.
    return rates, counts, sorted(missing)


def totals(rates):
    result = defaultdict(lambda: [0.0, 0.0])
    for items in rates.values():
        for item, sources in items.items():
            for values in sources.values():
                for index, value in enumerate(values):
                    result[item][index] += value
    return result


THEMES = {
    "trail": ["field_maintenance", "cleaning", "fuel", "canned_food", "valuables_equipment_pouches",
              "valuables_protective_textiles", "valuables_transit_cases", "valuables_survey_equipment"],
    "kitchen": ["canned_food", "valuables_provisions", "local_refreshments", "mre"],
    "medical": ["town_medical", "valuables_clinical_supplies", "valuables_trauma_supplies",
                "valuables_medical_equipment", "valuables_research_injectors_a", "valuables_filtration"],
    "workshop": ["fasteners", "workshop_supplies", "repair_electrical", "adhesives", "basic_tools",
                 "valuables_workshop_tools", "valuables_drivers_wrenches", "valuables_repair_parts",
                 "valuables_cutting_tools", "valuables_instruments"],
    "electronics": ["small_electronics", "batteries", "repair_electrical", "valuables_electronic_components",
                    "valuables_radio_components", "valuables_radio_equipment", "valuables_flash_media",
                    "valuables_computer_parts", "valuables_control_electronics", "valuables_portable_computers"],
    "utilities": ["cleaning", "fuel", "fasteners", "repair_electrical", "valuables_filtration",
                  "valuables_electrical_supplies", "valuables_portable_power", "valuables_repair_parts"],
    "trade": ["local_refreshments", "canned_food", "valuables_personal_effects", "valuables_provisions",
              "valuables_equipment_pouches", "small_valuables", "valuables_decorative_valuables"],
    "records": ["administrative_documents", "documents_field", "documents_technical", "documents_research",
                "valuables_office_records", "valuables_field_records", "valuables_printed_material",
                "valuables_technical_records", "valuables_data_archives", "valuables_recording_equipment"],
    "military": ["town_ammunition", "town_ammunition_military", "valuables_equipment_pouches",
                 "valuables_military_cases", "valuables_ordnance_salvage", "valuables_armour_panels",
                 "valuables_protective_textiles", "valuables_secured_cases"],
    "research": ["batteries", "small_electronics", "valuables_sample_carriers", "valuables_survey_equipment",
                 "valuables_research_samples", "valuables_filtration", "valuables_instruments",
                 "valuables_research_injectors_a", "valuables_research_injectors_b"],
    "textiles": ["town_textiles", "valuables_textile_supplies", "valuables_protective_textiles",
                 "valuables_equipment_pouches", "valuables_armour_panels", "valuables_transit_cases",
                 "valuables_reinforced_cases"],
    "collectibles": ["small_valuables", "statues", "valuables_decorative_valuables",
                     "valuables_personal_effects", "valuables_printed_material", "valuables_field_records"],
}
CONTACT_THEMES = {
    "old-timer": "trail", "spoor": "trail", "wake": "medical", "arena-master": "medical",
    "spicy-lemon": "kitchen", "jitters": "medical", "technut": "workshop", "latch": "workshop",
    "mute": "electronics", "spool": "electronics", "smartass": "electronics", "gasket": "utilities",
    "cleaner": "trail", "haggler": "trade", "carbon": "records", "ledger": "records", "boss": "military",
    "brass": "military", "quartermaster": "military", "egghead": "research", "intern": "research",
    "beanstalk": "research", "atlas": "research", "vesper": "research", "suture": "textiles",
    "ballast": "textiles", "the-original": "collectibles",
}


def starting_region(contact, slug, data, rates):
    home = contact["map"]
    candidates = {row["item"] for pool in THEMES[CONTACT_THEMES[slug]]
                  for row in data["pools"][pool]["candidates"]}
    return home if any(rates[home].get(item) for item in candidates) else "rp_marsh_cs"


def make_bands(data, rates):
    """Rank within theme and home region; retain thematic breadth and bounded rare requests."""
    supply = totals(rates)
    bands = {}
    for slug, contact in data["contacts"].items():
        theme = CONTACT_THEMES[slug]
        home = starting_region(contact, slug, data, rates)
        key = (theme, home)
        if key in bands:
            continue
        def score(item):
            return sum(sum(values[0] for values in rates[region].get(item, {}).values())
                       * (1 if region == home else 0.1 if region == "rp_pripyat_remaster" else 0.3)
                       for region in MAPS)
        # Cap each existing category so, for example, research requests do not become all injectors.
        candidates = set()
        for pool in THEMES[theme]:
            members = [row["item"] for row in data["pools"][pool]["candidates"]
                       if supply[row["item"]][0] >= 0.1]
            members.sort(key=lambda item: (-score(item), item))
            candidates.update(members[:3])
        if theme == "kitchen":
            candidates.update(item for item in ["food_bread", "food_raisins", "food_can_tushonka",
                              "food_sausage_1", "food_sausage_2", "lowtiercookerfuel", "value_soap",
                              "value_detergent", "value_bleach"] if supply[item][0] >= 0.1)
        candidates = sorted(candidates, key=lambda item: (-score(item), item))
        assert len(candidates) >= 8, (theme, len(candidates))
        groups = [candidates[len(candidates) * i // 4:len(candidates) * (i + 1) // 4] for i in range(4)]
        # Every introductory roll must have a source in the selected starting region.
        local = [item for item in groups[0] if rates[home].get(item)]
        assert local, key
        groups[0] = local
        bands[key] = groups
    return bands



LABELS = {
    "trail": "Trail supplies", "kitchen": "Kitchen supplies", "medical": "Medical supplies",
    "workshop": "Workshop supplies", "electronics": "Electronic supplies", "utilities": "Utility supplies",
    "trade": "Trading stock", "records": "Records and recording equipment", "military": "Military supplies",
    "research": "Research supplies", "textiles": "Textiles and protective materials", "collectibles": "Collectible finds",
}
REGION_LABELS = {"rp_marsh_cs": "Marsh", "rp_garbage_cotz": "Garbage", "rp_waystation": "Waystation",
                 "rp_pripyat_remaster": "Pripyat"}
QUANTITIES = ((1,), (2, 1), (3, 2, 1), (4, 3, 2, 1))


def band_key(theme, home, tier):
    region = {"rp_marsh_cs": "marsh", "rp_garbage_cotz": "garbage", "rp_waystation": "waystation"}[home]
    return f"town_delivery_{theme}_{region}_{tier}"


def contact_plan(contact):
    steps = {step["id"]: step for step in contact["progression"]}
    if not steps:
        return {}
    depths = {}
    def depth(identifier):
        if identifier not in depths:
            depths[identifier] = 1 + max((depth(parent) for parent in steps[identifier]["requires"]), default=0)
        return depths[identifier]
    maximum = max(depth(identifier) for identifier in steps)
    result = {}
    for identifier, step in steps.items():
        if step["kind"] == "delivery":
            progress = (depth(identifier) - 1) / max(1, maximum - 1)
            tier = 1 if progress < 0.2 else 2 if progress < 0.45 else 3 if progress < 0.75 else 4
            result[identifier] = (tier, depth(identifier), maximum)
    return result


def batch_units(items, supply):
    # One early request never exceeds one mean acquisition batch for any candidate in its band.
    return max(1, int(min(supply[item][1] / supply[item][0] for item in items)))


def lua_text(key, text, indent=3):
    import textwrap
    prefix = "\t" * indent
    chunks = textwrap.wrap(text, 96, break_long_words=False, break_on_hyphens=False)
    if len(prefix + key + " = " + json.dumps(text) + ",") <= 120:
        return prefix + key + " = " + json.dumps(text) + ","
    return prefix + key + " = (\n" + "\n".join(
        prefix + "\t" + ("" if index == 0 else ".. ") + json.dumps(chunk + (" " if index < len(chunks)-1 else ""))
        for index, chunk in enumerate(chunks)) + "\n" + prefix + "),"


def apply_plan(data, rates, bands):
    import re
    if any(step.get("branch") for contact in data["contacts"].values() for step in contact["progression"]):
        raise ValueError("Branch requirements are authored directly. Use --inspect to review availability; legacy --write is disabled.")
    supply = totals(rates)
    pool_path = ROOT / "gamemodes/ix_cotz/plugins/progression/definitions/sh_requirementpools.lua"
    source = pool_path.read_text().split("\n\t-- FTS delivery availability bands.")[0].rstrip()
    if source.endswith("}"):
        source = source[:-1].rstrip()
    source += "\n\n\t-- FTS delivery availability bands. Rebuild with docs/npc-overhaul/tools/fts_delivery_balance.py.\n"
    for (theme, home), groups in sorted(bands.items()):
        for tier, items in enumerate(groups, 1):
            key = band_key(theme, home, tier)
            source += f'\t{key} = {{\n\t\tname = "{LABELS[theme]} ({REGION_LABELS[home]}, band {tier})",\n'
            source += f'\t\ttier = "{("common", "uncommon", "rare", "rare")[tier-1]}",\n'
            source += '\t\tevidence = "FTS point counts and weighted supply; see docs/npc-overhaul/delivery-balance.md.",\n'
            source += '\t\tcandidates = {\n' + ''.join(f'\t\t\t{{item = "{item}"}},\n' for item in items)
            source += '\t\t},\n\t},\n'
    pool_path.write_text(source + "}\n")
    manifests = {}
    for slug, contact in data["contacts"].items():
        theme = CONTACT_THEMES[slug]
        home = starting_region(contact, slug, data, rates)
        groups = bands[(theme, home)]
        plan = contact_plan(contact)
        if not plan:
            continue
        path = ROOT / f"gamemodes/ix_cotz/plugins/townnpcs/definitions/sh_{slug.replace('-', '_')}.lua"
        source = path.read_text()
        example = next(step for step in contact["progression"] if step.get("retiredCommission"))
        briefing = example["briefing"].split(" This request is for ")[0].split(" Bring everything on the list")[0]
        if slug == "mute":
            briefing = "** He lays a supply list beside the equipment and underlines every entry before sliding it towards you. **"
        else:
            briefing += " Bring everything on the list back here; I need the full delivery."
        completion = example["completion"]
        manifests[slug] = {}
        def revise(match):
            block = match[0]
            identifier = re.search(r'id = "(.*?)"', block)[1]
            if identifier not in plan:
                return block
            tier, depth, maximum = plan[identifier]
            current = next(step for step in contact["progression"] if step["id"] == identifier)
            if any(not slot["pool"].startswith("town_delivery_") for slot in current["requirements"]):
                manifests[slug][identifier] = {"tier": tier, "depth": depth, "max_depth": maximum,
                                              "requirements": current["requirements"]}
                return block
            requirements = []
            for index, amount in enumerate(QUANTITIES[tier-1]):
                items = groups[index]
                quantity = amount * batch_units(items, supply)
                requirements.append({"pool": band_key(theme, home, index+1), "quantity": quantity})
            manifests[slug][identifier] = {"tier": tier, "depth": depth, "max_depth": maximum,
                                          "requirements": requirements}
            block = re.sub(r'\n\t\t\trequirements = \{.*?\n\t\t\t\},',
                           '\n\t\t\trequirements = {\n' + ''.join(
                               '\t\t\t\t{\n' + f'\t\t\t\t\tpool = "{slot["pool"]}",\n'
                               + f'\t\t\t\t\tquantity = {slot["quantity"]},\n\t\t\t\t}},\n'
                               for slot in requirements) + '\t\t\t},', block, flags=re.S)
            block = re.sub(r'\n\t\t\tbriefing = .*?(?=\n\t\t\tcompletion =)',
                           '\n'+lua_text("briefing", briefing), block, flags=re.S)
            block = re.sub(r'\n\t\t\tcompletion = .*?(?=\n\t\t\trequirements =)',
                           '\n'+lua_text("completion", completion), block, flags=re.S)
            objective = f"Bring all {tier} listed item types to this contact. The request shows each selected item and required units."
            objective = objective.replace("1 listed item types", "1 listed item type")
            if '\n\t\t\tobjective = ' in block:
                block = re.sub(r'\n\t\t\tobjective = .*?(?=\n\t\t\trequires =)',
                               '\n'+lua_text("objective", objective), block, flags=re.S)
            if 'retiredCommission = true' in block:
                title = ["A small delivery", "Restocking", "Building the reserve", "A full supply order"][tier-1]
                block = re.sub(r'\n\t\t\tname = [^\n]+', '\n'+lua_text("name", title), block)
            return block
        source = re.sub(r'\t\t\{\n\t\t\tid = .*?\n\t\t\},', revise, source, flags=re.S)
        path.write_text(source)
    return manifests


def build_report(data, rates, counts, missing, bands, manifests):
    supply = totals(rates)
    lines = ["# FTS item availability and delivery balance", "",
             "Generated from the checked-in FTS presets and active loot definitions. No FTS command is run.", "",
             "## Spawnpoint inventory", "",
             "| Map | Loose regular / rare | Small / big boxes | Cycling containers | Hidden locations | Anomaly points |",
             "| --- | ---: | ---: | ---: | ---: | ---: |"]
    for region in MAPS:
        row = counts[region]
        regular = sum(n for pool, n in row["world"].items() if pool in ("worldspawn_1", "worldspawn_3", "worldspawn_5", "worldspawn_garbage_regular"))
        rare = sum(row["world"].values())-regular
        lines.append(f'| {REGION_LABELS[region]} | {regular} / {rare} | {row["boxes"].get("1",0)} / {row["boxes"].get("2",0)} | {sum(row["cyclic"].values())} | {row["hidden"]} | {row["anomalies"]} |')
    lines += ["", f"Garbage has {sum(counts["rp_garbage_cotz"]["world"].values())} loose-item points and "
              f"{sum(counts["rp_garbage_cotz"]["boxes"].values())} box points. Box custom pools are included in its supply.",
              "Contacts use local thematic sources where configured; themes without local sources use Marsh for introductory acquisition.",
              "Live saved map data can differ from FTS and overrides these estimates.", "", "## Estimation method", "",
              "For each item and pool: P(item) = summed positive item weights / summed positive pool weights.",
              "An item's loose-point exposure is the sum of point count × P(item), not its raw row weight.",
              "Rows with comments are not executed. Duplicate item rows and quantity variants are summed.", "",
              "The supply index adds three modeled source rates (item entities, not pickup units):", "",
              "- Loose items: 25/101 chance per eligible point every 300 seconds; a cleared-map refill is capped at 76 items.",
              "  Approximate uniform point sampling gives 12 × min(points × 25/101, 76) selections per modeled hour.",
              "- Boxes: 51-box cap, uniformly sampled FTS points, all boxes broken each five-minute refill.",
              "  Small metal and paper boxes average 4/6 items; wood averages 4/4; big points choose wood/paper equally.",
              "  Custom point pools override the material's default pool.",
              "- Cycling containers: each appearance chooses a stash type uniformly, then rolls each listed pool once.",
              "  The installed scheduler advances the appearance by disappearTime, so its mean period is disappearTime",
              "  (not appearTime + disappearTime). Every appearance is assumed collected.", "",
              "These are comparative full-collection opportunities, **not predicted player earnings or guaranteed drops/hour**.",
              "World/box clearance radii, shared temporary items, map caps, blocked sites, competition and missed cache windows",
              "reduce real supply. Combining isolated caps is an optimistic comparison, not a simultaneous throughput simulation.",
              "Passive containers are counted separately but omitted from rates: their chance depends on player count and occupancy.",
              "Hidden-stash locations are destinations, not independent loot rolls. They have no location-based spawn rate.",
              "Human drops, harvests, event rewards and anomaly artifacts are not assigned invented encounter rates.",
              "New finite hand-in pools use only items with positive quantified world/box/cycling exposure.", "",
              "Hand-in units use row quantity overrides, configured OnInstanced yield bounds, then item quantity/ammoAmount.",
              "The index counts entities for search rarity; batch size is considered separately when setting quantities.", "",
              "Missing referenced pool names use the installed randomitem default fallback; these are reported rather than fixed:",
              "`" + "`, `".join(missing) + "`.", "", "### FTS pool point counts", "",
              "| Map | Pool | Points |", "| --- | --- | ---: |"]
    for region in MAPS:
        for pool, count in sorted(counts[region]["world"].items()):
            lines.append(f"| {REGION_LABELS[region]} | `{pool}` | {count} |")
    lines += ["", "### Cycling categories", "", "| Map | Category | Locations | Mean appearance interval (seconds) |",
              "| --- | --- | ---: | ---: |"]
    for region in MAPS:
        for category, count in sorted(counts[region]["cyclic"].items()):
            period = data["cyclic"]["categoryDefs"][category]["disappearTime"]
            lines.append(f"| {REGION_LABELS[region]} | `{category}` | {count} | {period} |")
    lines += ["", "## Relative rarity examples", "",
              "Rates below sum the configured map presets at equal full-collection effort.",
              "Ratios are item-entity frequency ratios; a loose ammo box and one round are not treated as the same unit.", "",
              "| Item | Entity supply index | Relative to bolts | Source maps |", "| --- | ---: | ---: | --- |"]
    for item in ["value_bolts", "value_battery", "value_wire_copper", "medic_bandage_1", "value_airfilter",
                 "food_can_beans", "value_sensor_a", "value_controller", "value_pcpart_laptop",
                 "value_med_surgicaltools", "value_goldchain"]:
        rate = supply[item][0]
        regions = ", ".join(REGION_LABELS[m] for m in MAPS if rates[m].get(item))
        lines.append(f"| `{item}` | {rate:.3f} | {supply['value_bolts'][0]/rate:.1f}× rarer | {regions} |")
    lines += ["", "The full per-item/per-map/source estimates and quantities are in [fts-item-availability.json](fts-item-availability.json).", "",
              "## Delivery difficulty", "",
              "All 327 finite delivery milestones are retuned; repeatable jobs, field commissions and arena bouts keep their mechanics.",
              "Local prerequisite depth / deepest storyline node determines the phase, so optional sibling branches are not assumed complete.",
              "Cross-contact gates remain unchanged; depth measures only the contact's own prerequisite graph.", "",
              "| Storyline depth | Distinct requested items | Common → specialist batch multiples |", "| --- | ---: | --- |",
              "| First 20% | 1 | 1 |", "| 20–45% | 2 | 2 + 1 |", "| 45–75% | 3 | 3 + 2 + 1 |",
              "| Final 25% | 4 | 4 + 3 + 2 + 1 |", "",
              "Every theme/home-map pair has four disjoint pools. Availability score weights the home region 1.0,",
              "the other early region 0.3, and Pripyat 0.1 to account for travel. These planning factors are explicit design choices,",
              "not measured travel times. Candidates are sorted by that score and divided into four bands.",
              "A maximum of three candidates from each source category preserves thematic variety. Categories can overlap; IDs are deduplicated.",
              "Candidates with less than 0.1 aggregate entity opportunities per modeled hour are excluded from mandatory requests.",
              "Every introductory candidate has a source in its starting region. Themes without local sources use Marsh as a proxy.",
              "Later pools extend to less available and more distant material; rare bands are added at low quantity while common stock grows.",
              "Each band quantity is its batch multiple times the smallest mean natural unit batch among that band's candidates, rounded down",
              "with a one-unit minimum. This preserves meaningful ammunition counts without demanding full-capacity salvage stacks.", "",
              "Progression IDs, prerequisites, payouts, benefits and accepted requirement rolls are preserved. Existing saved requirements",
              "are not rerolled; the retuning applies when an unassigned milestone first receives its saved item selections.", "",
              "## Availability bands", "", "| Theme / starting region | Band | Candidates (item IDs) |",
              "| --- | ---: | --- |"]
    for (theme, home), groups in sorted(bands.items()):
        for tier, items in enumerate(groups, 1):
            lines.append(f"| {theme} / {REGION_LABELS[home]} | {tier} | " + ", ".join(f"`{i}`" for i in items) + " |")
    lines += ["", "## Current finite delivery requirements", "", "| Contact | Milestone | Phase | Pool × required units |",
              "| --- | --- | ---: | --- |"]
    for slug, steps in sorted(manifests.items()):
        for identifier, plan in sorted(steps.items()):
            slots = "; ".join(f'`{s["pool"]}` × {s["quantity"]}' for s in plan["requirements"])
            lines.append(f'| {slug} | {identifier} | {plan["tier"]} | {slots} |')
    lines += ["", "Rebuild with `python3 docs/npc-overhaul/tools/fts_delivery_balance.py --write`.",
              "Inspect candidates without changing files using `--inspect`. Multiplayer acquisition and economy testing remain required.", ""]
    (OUT / "delivery-balance.md").write_text("\n".join(lines))
    serialized = {region: {item: dict(sources) for item, sources in sorted(items.items())}
                  for region, items in rates.items()}
    (OUT / "fts-item-availability.json").write_text(json.dumps({"counts": counts,
        "rates": serialized, "rate_values": ["entity_index", "hand_in_unit_index"],
        "fallback_pools": missing}, indent=2, sort_keys=True) + "\n")

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--inspect", action="store_true")
    parser.add_argument("--write", action="store_true")
    args = parser.parse_args()
    data = snapshot()
    rates, counts, missing = estimate(data)
    bands = make_bands(data, rates)
    supply = totals(rates)
    if args.inspect:
        for theme, groups in bands.items():
            print(theme)
            for tier, items in enumerate(groups, 1):
                print(tier, [(item, round(supply[item][0], 3)) for item in items])
        print("fallback pools:", missing)
        return
    if not args.write:
        parser.error("select --inspect or --write")
    manifests = apply_plan(data, rates, bands)
    build_report(data, rates, counts, missing, bands, manifests)
    print(f"Wrote {sum(len(v) for v in manifests.values())} delivery milestones and {len(bands)*4} availability pools")


if __name__ == "__main__":
    main()
