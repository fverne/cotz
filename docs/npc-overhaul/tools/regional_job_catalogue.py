"""Rebuild the static regional job catalogue without loading or changing a game world."""
import json
import math
import re
import statistics
from collections import defaultdict
from pathlib import Path

from fts_delivery_balance import estimate, snapshot

ROOT = Path(__file__).resolve().parents[3]
PLUGINS = ROOT / "gamemodes/ix_cotz/plugins"
MAPS = ["rp_marsh_cs", "rp_garbage_cotz", "rp_waystation", "rp_pripyat_remaster"]
PREFIXES = ["swamps", "garbage", "waystation", "pripyat"]


def uncomment(text):
    text = re.sub(r"--\[\[.*?\]\](?:--)?", "", text, flags=re.S)
    return re.sub(r"--[^\n]*", "", text)


def lua(value, depth=0):
    if isinstance(value, str):
        return json.dumps(value, ensure_ascii=False)
    if isinstance(value, (float, int)):
        return str(value)
    if isinstance(value, list):
        parts = [lua(x, depth + 1) for x in value]
        compact = "{" + ", ".join(parts) + "}"
        if len(compact) + depth * 4 <= 110 and "\n" not in compact:
            return compact
        indent = "\t" * depth
        return "{\n" + "\n".join(indent + "\t" + x + "," for x in parts) + "\n" + indent + "}"
    indent = "\t" * depth
    return "{\n" + "\n".join(
        indent + "\t[" + lua(k) + "] = " + lua(v, depth + 1) + ","
        for k, v in sorted(value.items())
    ) + "\n" + indent + "}"


def build():
    source = uncomment((PLUGINS / "eventcontroller/sh_eventdefs.lua").read_text())
    aliases = {"dog": "blinddog", "rodent": "tushkano", "pseudogiant_slow": "pseudogiant",
               "pseudogiant_fast": "pseudogiant", "chimera_electro": "electrochimera",
               "controller_swamp": "swampcontroller", "controller_electro": "electrocontroller",
               "controller_fast": "fastcontroller"}
    classes, packs, encounters = {}, defaultdict(lambda: defaultdict(list)), {m: [] for m in MAPS}
    pattern = r'PLUGIN.eventdefs\["([^"]+)"\] = \{(.*?)(?=\nPLUGIN.eventdefs|\Z)'
    for event, block in re.findall(pattern, source, re.S):
        entities = re.findall(r'\{\s*"(npc_[^"]+)"\s*,\s*(\d+)\s*\}', block)
        regions = {tag.split("_")[0] for tag in re.findall(
            r'"((?:swamps|garbage|waystation|pripyat)_[^"]+)"', block)}
        counts, mutants = defaultdict(int), []
        for cls, count in entities:
            count = int(count)
            if cls.startswith("npc_mutant_"):
                suffix = cls.removeprefix("npc_mutant_")
                species = "zombie" if suffix.startswith("classiczombie") else aliases.get(suffix, suffix)
                classes[cls] = species
                counts[species] += count
                mutants.append({"class": cls, "count": count})
            else:
                faction = next((x for x in ("bandit", "merc", "mili")
                                if cls.startswith("npc_human_" + x + "_")), None)
                if faction:
                    classes[cls] = faction
                    if not event.endswith("sniper"):
                        counts[faction] += count
        for prefix in regions:
            map_name = MAPS[PREFIXES.index(prefix)]
            for species, count in counts.items():
                packs[map_name][species].append(count)
            if mutants:
                encounters[map_name].append(mutants)
    baselines = {m: {s: (2 if s == "pseudodog" else math.ceil(statistics.median(v)))
                     for s, v in rows.items()} for m, rows in packs.items()}
    harvest = (PLUGINS / "mutantpoaching/sv_plugin.lua").read_text()
    harvest = harvest.split("ix.poaching.MutantParts = {", 1)[1]
    products = {}
    for key, block in re.findall(r'\["([^\"]+)"\] = \{(.*?)(?=\n\t\[|\n\})', harvest, re.S):
        meat = re.search(r'\["meattype"\] = "([^"]+)"', block)
        parts = re.findall(r'\{"(part_[^\"]+)"', block)
        if meat:
            species = {"dog": "blinddog", "classiczombie": "zombie",
                       "pseudogiantfast": "pseudogiant"}.get(key, key)
            meal = meat[1].replace("meat_", "meal_") if meat[1].startswith("meat_") else ""
            products[species] = {"meal": meal if meal != "meal_human" else "",
                                 "specimen": parts[0] if parts else ""}
    data = snapshot()
    rates, _, _ = estimate(data)
    batches = {item: bounds[0] for item, bounds in data["batches"].items()}
    for pool, rows in data["loot"].items():
        natural = (pool.startswith("worldspawn_") or pool.endswith("_entbox_drops")
                   or pool.endswith("_loot") or pool.startswith("cache_valuables_")
                   or pool.startswith("cache_documents_"))
        if not natural:
            continue
        for weight, entry in rows:
            if weight <= 0:
                continue
            item = entry[0]
            default = batches.get(item, data["items"].get(item, {}).get("quantity", 1))
            quantity = (entry[1] if len(entry) > 1 else {}).get("quantity", default)
            low = min(quantity) if isinstance(quantity, list) else quantity
            batches[item] = min(batches.get(item, low), low)
    disabled = set()
    for path in (PLUGINS / "townnpcs/definitions").glob("*.lua"):
        for block in re.findall(r"disabledItems = \{(.*?)\n\t\}", uncomment(path.read_text()), re.S):
            disabled.update(re.findall(r'\["([^"]+)"\] = true', block))
    values = {}
    for map_name, rows in rates.items():
        for item, sources in rows.items():
            if item in disabled or not item.startswith("value_") or "currency" in item or "money" in item:
                continue
            if sum(v[0] for v in sources.values()) <= 0:
                continue
            values.setdefault(item, {"maps": [], "batch": batches.get(item, 1)})["maps"].append(map_name)
    return {"maps": MAPS, "classes": classes, "packs": baselines,
            "encounters": encounters, "products": products, "valuables": values}


if __name__ == "__main__":
    target = PLUGINS / "jobsystem/definitions/sh_regionalcatalogue.lua"
    data = build()
    text = "-- Generated by docs/npc-overhaul/tools/regional_job_catalogue.py; edit sources, then rebuild.\n"
    text += "ix.jobs.regionalCatalogue = " + lua(data) + "\n"
    target.write_text(text)
    print(f"Wrote {len(data['classes'])} classes and {len(data['valuables'])} valuable candidates")
