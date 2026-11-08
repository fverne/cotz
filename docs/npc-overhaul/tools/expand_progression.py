"""Author/check town stock intermissions and region-bounded valuable requirement pools.

Uses offline source snapshots only. Never loads a server, edits saves or runs FTS.
"""
from __future__ import annotations

import argparse
from collections import defaultdict
import json
import hashlib
import math
import re

import fts_delivery_balance as supply
import progression_rewards as rewards

ROOT = rewards.ROOT
POOL_FILE = ROOT / "gamemodes/ix_cotz/plugins/progression/definitions/sh_requirementpools.lua"
MARKER = "-- Generated town expansion pools; see docs/npc-overhaul/tools/expand_progression.py.\n"
SCIENCE = {"intern", "egghead", "beanstalk"}
MAP_LABELS = supply.REGION_LABELS
POLICY = 3


def lua(value, indent=0):
    if isinstance(value, str):
        return json.dumps(value, ensure_ascii=False)
    if isinstance(value, bool):
        return str(value).lower()
    if isinstance(value, (int, float)):
        return str(value)
    if not value:
        return "{}"
    if isinstance(value, dict) and all(not isinstance(v, (dict, list)) for v in value.values()):
        inline = "{" + ", ".join(k + " = " + lua(v) for k, v in value.items()) + "}"
        if len(inline) + indent * 4 <= 100:
            return inline
    if isinstance(value, list):
        if all(not isinstance(v, (dict, list)) for v in value):
            inline = "{" + ", ".join(lua(v) for v in value) + "}"
            if len(inline) + indent * 4 <= 85:
                return inline
        entries = [lua(v, indent + 1) for v in value]
    else:
        entries = [(k if re.fullmatch(r"[A-Za-z_]\w*", k) else "[" + lua(k) + "]")
                   + " = " + lua(v, indent + 1) for k, v in value.items()]
    return "{\n" + "\n".join("\t" * (indent + 1) + e + "," for e in entries) + "\n" + "\t" * indent + "}"


def eligible_items():
    """Resolve the actual inherited base, not an item's filename prefix."""
    definitions = {}
    for path in (ROOT / "gamemodes/ix_cotz").rglob("sh_*.lua"):
        if "/items/" not in str(path):
            continue
        source = path.read_text()
        identifier = path.stem[3:]
        base = re.search(r'ITEM.base\s*=\s*"([^"]+)"', source)
        definitions[identifier if path.parent.name != "base" else "base_" + identifier] = (
            base[1] if base else "base_" + path.parent.name, path, source)

    def inherits(identifier, family, seen=None):
        if identifier == family:
            return True
        seen = set() if seen is None else seen
        if identifier in seen or identifier not in definitions:
            return False
        seen.add(identifier)
        return inherits(definitions[identifier][0], family, seen)

    result = {}
    for identifier, (_, path, source) in definitions.items():
        if path.parent.name in {"base", "zquests", "quests", "jobcargo"}:
            continue
        if 'ITEM.base = "base_jobcargo"' in source or "value_currency_" in identifier:
            continue
        if inherits(identifier, "base_valuable"):
            result[identifier] = "valuable"
        elif inherits(identifier, "base_artifacts"):
            result[identifier] = "artifact"
    return result


def allowed_maps(home, index, length):
    if index == 0 or length == 1:
        return [home]
    phase = index / (length - 1)
    maps = {home, "rp_marsh_cs", "rp_garbage_cotz"}
    if phase >= 0.45:
        maps.add("rp_waystation")
    if phase >= 0.75:
        maps.add("rp_pripyat_remaster")
    return [m for m in supply.MAPS if m in maps]


def stock_items(stock):
    return stock.get("items", [stock["item"]] if "item" in stock else [])


def expand_contacts(contacts):
    count = 0
    for slug, contact in contacts.items():
        branches = defaultdict(list)
        for step in contact["progression"]:
            if not step.get("intermissionFor") and step["id"] != "v3/stalkernet/networkRemote":
                branches[step["branch"]].append(step)
        output = []
        ranks = defaultdict(int)
        for branch in branches.values():
            for index, step in enumerate(branch):
                step.pop("completionCash", None)
                step["requires"] = [p for p in step["requires"]
                                    if not p.endswith("/stock") and p != "v3/stalkernet/networkRemote"]
                if slug == "mute" and step["id"] == "v3/stalkernet/networkDossier":
                    step["requires"] = ["v3/stalkernet/networkLocation"]
                step["branchIndex"], step["branchLength"] = index + 1, len(branch)
                step["acquisitionMaps"] = allowed_maps(contact["map"], index, len(branch))
                step["requirementPolicy"] = POLICY
                previous = branch[index - 1] if index else None
                quantities = lambda s: [x["quantity"] for x in s["requirements"]]
                insert = previous and ((index >= 2 and (quantities(step) == quantities(previous)
                                                         or len(step["requirements"]) >= 3))
                                       or slug in SCIENCE)
                targets = sorted(item for item, allocation in contact["catalogue"].items()
                                 if previous and allocation["step"] == previous["id"]
                                 and all(allocation["terms"][i] > 0 for i in (3, 4, 5)))
                if not targets and previous and previous.get("stock"):
                    targets = stock_items(previous["stock"])
                if insert and targets:
                    bonus = min(4, 1 + max(ranks[item] for item in targets))
                    intermission = {
                        "id": step["id"] + "/stock", "branch": step["branch"],
                        "name": "Stock preparation: " + previous["name"], "kind": "delivery",
                        "requires": [previous["id"]], "briefing": step["briefing"],
                        "completion": step["completion"],
                        "requirements": [{"pool": slot["pool"], "quantity": math.ceil(slot["quantity"] / 2)}
                                         for slot in step["requirements"]],
                        "stock": {"items": targets, "bonus": bonus}, "intermissionFor": step["id"],
                        "branchIndex": index + 1, "branchLength": len(branch),
                        "acquisitionMaps": step["acquisitionMaps"], "requirementPolicy": POLICY,
                    }
                    for item in targets:
                        ranks[item] = bonus
                    output.append(intermission)
                    step["requires"].append(intermission["id"])
                    count += 1
                if step.get("stock"):
                    for item in stock_items(step["stock"]):
                        ranks[item] = max(ranks[item], step["stock"]["bonus"])
                output.append(step)
        contact["progression"] = output
    return count


def build_sources(data, rates, families):
    sources = {}
    for item, kind in sorted(families.items()):
        maps = [m for m in supply.MAPS if sum(v[0] for v in rates[m].get(item, {}).values()) > 0]
        if maps:
            sources[item] = {"kind": kind, "maps": maps}
    return sources


def author_requirements(data, rates, sources):
    pools, lookup = {}, {}
    themes = {theme: {row["item"] for pool in ids for row in data["pools"][pool]["candidates"]
                      if row["item"] in sources and sources[row["item"]]["kind"] == "valuable"}
              for theme, ids in supply.THEMES.items()}
    # Borrow practical local supplies before specialist themes on Garbage.
    primary = {"wake": "textiles", "spool": "workshop", "vesper": "military"}

    def get_pool(items, theme, maps, band):
        key = (tuple(sorted(items)), theme, tuple(maps), band)
        if key not in lookup:
            identifier = "town_expansion_" + hashlib.sha256(json.dumps(key).encode()).hexdigest()[:12]
            lookup[key] = identifier
            pools[identifier] = {
                "name": supply.LABELS[theme] + " (" + ", ".join(MAP_LABELS[m] for m in maps) + ")",
                "tier": ("common", "uncommon", "rare", "rare")[band],
                "candidates": [{"item": item} for item in sorted(items)],
            }
        return lookup[key]

    for slug, contact in sorted(data["contacts"].items()):
        previous_by_branch = {}
        for ordinal, step in enumerate(contact["progression"]):
            maps = step["acquisitionMaps"]
            original_index, length = step["branchIndex"] - 1, step["branchLength"]
            phase = original_index / max(1, length - 1)
            cap = 0 if original_index == 0 else (2 if phase >= 0.75 else 1)
            count = len(step["requirements"])
            expanded = min(cap, count)
            used, slots = set(), []
            # Direct equipment science milestones retain artifact identities and quantities.
            science = slug in SCIENCE and not step.get("intermissionFor")
            theme = primary.get(slug, supply.CONTACT_THEMES[slug])
            cycle = list(dict.fromkeys([theme] + sorted(themes)))
            for index, slot in enumerate(step["requirements"]):
                slot_maps = maps if index >= count - expanded else [contact["map"]]
                if science:
                    # On regeneration use the original family stored beside the generated pool.
                    source_pool = slot.get("artifactPool", slot["pool"])
                    items = {c["item"] for c in data["pools"][source_pool]["candidates"]
                             if c["item"] in sources and any(m in sources[c["item"]]["maps"] for m in slot_maps)}
                    assert items and all(sources[i]["kind"] == "artifact" for i in items)
                    pool = get_pool(items, "research", slot_maps, index)
                    slots.append({"pool": pool, "quantity": slot["quantity"], "artifactPool": source_pool})
                    used.update(items)
                    continue
                items = set()
                for offset in range(len(cycle)):
                    candidate_theme = cycle[(ordinal + index + offset) % len(cycle)]
                    candidates = [i for i in themes[candidate_theme] - used
                                  if any(m in sources[i]["maps"] for m in slot_maps)]
                    if not candidates:
                        continue
                    def score(item):
                        return sum(sum(v[0] for v in rates[m].get(item, {}).values()) for m in slot_maps)
                    candidates.sort(key=lambda item: (-score(item), item))
                    start = len(candidates) * index // 4
                    end = max(start + 1, len(candidates) * (index + 1) // 4)
                    items = set(candidates[start:end][:8])
                    # A repeated single-slot request must actually offer different materials.
                    previous = previous_by_branch.get(step["branch"])
                    if count == 1 and previous == items:
                        continue
                    break
                assert items, (slug, step["id"], index)
                used.update(items)
                slots.append({"pool": get_pool(items, candidate_theme, slot_maps, index),
                              "quantity": slot["quantity"]})
            step["requirements"] = slots
            previous_by_branch[step["branch"]] = used
    return pools


def render_contact(source, steps):
    order = ["id", "branch", "name", "kind", "requires", "crossRequires", "briefing", "completion",
             "requirements", "stock", "capacity", "services", "ammoExchange", "variantBase",
             "intermissionFor", "branchIndex", "branchLength", "acquisitionMaps", "requirementPolicy"]
    steps = [{key: step[key] for key in order + sorted(set(step) - set(order)) if key in step} for step in steps]
    block = "\tprogression = " + lua(steps, 1) + ","
    match = re.search(r"\n\tprogression = \{.*?\n\t\},", source, re.S)
    assert match
    return source[:match.start()] + "\n" + block + source[match.end():]


def outputs():
    data = supply.snapshot()
    rates, _, _ = supply.estimate(data)
    count = expand_contacts(data["contacts"])
    sources = build_sources(data, rates, eligible_items())
    pools = author_requirements(data, rates, sources)
    output = {}
    for slug, contact in data["contacts"].items():
        if not contact["progression"]:
            continue
        path = rewards.DEFINITIONS / ("sh_" + slug.replace("-", "_") + ".lua")
        output[path] = render_contact(path.read_text(), contact["progression"])
    original = POOL_FILE.read_text().split(MARKER)[0].rstrip()
    generated = [original, MARKER.rstrip(), "ix.progression.townRequirementSources = " + lua(sources)]
    for name, pool in pools.items():
        generated.append("ix.progression.itemPools." + name + " = " + lua(pool))
    output[POOL_FILE] = "\n\n".join(generated) + "\n"
    return output, count


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    action = parser.add_mutually_exclusive_group(required=True)
    action.add_argument("--write", action="store_true")
    action.add_argument("--check", action="store_true")
    args = parser.parse_args()
    generated, count = outputs()
    for path, content in generated.items():
        if args.write:
            path.write_text(content)
        elif path.read_text() != content:
            raise SystemExit(f"Stale expansion: {path.relative_to(ROOT)}")
    print(f"{count} stock intermissions; regional pools and town definitions verified")


if __name__ == "__main__":
    main()
