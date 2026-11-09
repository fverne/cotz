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
POLICY = 4


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
    # Opening Marsh work must never roll a later-map-only item, including on short branches.
    if home == "rp_marsh_cs" and (index < 2 or phase < 0.45):
        return [home]
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

    def get_pool(items, label, maps, band):
        key = (tuple(sorted(items)), label, tuple(maps), band)
        if key not in lookup:
            identifier = "town_expansion_" + hashlib.sha256(json.dumps(key).encode()).hexdigest()[:12]
            lookup[key] = identifier
            pools[identifier] = {
                "name": label + " (" + ", ".join(MAP_LABELS[m] for m in maps) + ")",
                "tier": ("common", "uncommon", "rare", "rare")[band],
                "candidates": [{"item": item} for item in sorted(items)],
            }
        return lookup[key]

    def select_group(names, maps, band, used, seed, variant):
        for offset in range(len(names)):
            name = names[(seed + offset) % len(names)]
            candidates = {row["item"] for row in data["pools"][name]["candidates"]}
            candidates = [item for item in candidates - used if item in sources
                          and sources[item]["kind"] == "valuable"
                          and any(m in sources[item]["maps"] for m in maps)]
            if not candidates:
                continue
            def score(item):
                return sum(sum(v[0] for v in rates[m].get(item, {}).values()) for m in maps)
            candidates.sort(key=lambda item: (-score(item), item))
            width = max(1, min(8, (len(candidates) + 3) // 4))
            start = (len(candidates) * band // 4 + variant) % len(candidates)
            items = set(candidates[start:start + width])
            return items, data["pools"][name]["name"]
        return set(), ""

    for slug, contact in sorted(data["contacts"].items()):
        if not contact["progression"]:
            continue
        identity = contact["progressionIdentity"]
        assert identity["core"] and identity["support"], slug
        for name in identity["core"] + identity["support"]:
            assert name in data["pools"], (slug, name)
        previous_by_branch = {}
        for ordinal, step in enumerate(contact["progression"]):
            maps = step["acquisitionMaps"]
            original_index, length = step["branchIndex"] - 1, step["branchLength"]
            phase = original_index / max(1, length - 1)
            cap = 0 if original_index == 0 else (2 if phase >= 0.75 else 1)
            count = len(step["requirements"])
            expanded = min(cap, count)
            science = slug in SCIENCE and not step.get("intermissionFor")
            attempts = max(len(identity["core"]), len(identity["support"]))
            for attempt in range(attempts * 8):
                used, slots, signature = set(), [], []
                for index, slot in enumerate(step["requirements"]):
                    slot_maps = maps if index >= count - expanded else [contact["map"]]
                    artifact_pool = None
                    if science:
                        artifact_pool = slot.get("artifactPool", slot["pool"])
                        items = {c["item"] for c in data["pools"][artifact_pool]["candidates"]
                                 if c["item"] in sources
                                 and any(m in sources[c["item"]]["maps"] for m in slot_maps)}
                        assert items and all(sources[i]["kind"] == "artifact" for i in items)
                        label = data["pools"][artifact_pool]["name"]
                    else:
                        # Core work owns every high-quantity slot. Only the smallest slot may borrow support.
                        names = identity["support"] if count >= 3 and index == count - 1 else identity["core"]
                        seed, variant = ordinal + index + attempt, attempt // attempts
                        items, label = select_group(names, slot_maps, index, used, seed, variant)
                        if not items and names is identity["support"]:
                            items, label = select_group(identity["core"], slot_maps, index, used, seed, variant)
                        if not items:
                            break
                    used.update(items)
                    pool = get_pool(items, identity["name"] + ": " + label, slot_maps, index)
                    requirement = {"pool": pool, "quantity": slot["quantity"]}
                    if artifact_pool:
                        requirement["artifactPool"] = artifact_pool
                    slots.append(requirement)
                    signature.append((tuple(sorted(items)), slot["quantity"]))
                if len(slots) == count and signature != previous_by_branch.get(step["branch"]):
                    break
            else:
                raise ValueError(f"No varied, disjoint specialty request for {slug}: {step['id']}")
            step["requirements"] = slots
            previous_by_branch[step["branch"]] = signature
    referenced = {slot["pool"] for contact in data["contacts"].values()
                  for step in contact["progression"] for slot in step["requirements"]}
    return {name: pool for name, pool in pools.items() if name in referenced}


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
