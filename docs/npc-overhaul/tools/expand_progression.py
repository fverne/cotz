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
    # Opening Swamps work must never roll a later-map-only item, including on short branches.
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
        if contact.get("preserveProgression"):
            count += sum(bool(step.get("intermissionFor")) for step in contact["progression"])
            continue
        branches = defaultdict(list)
        existing = {step["id"]: step for step in contact["progression"]}
        authored = [s for s in contact["progression"] if s["id"] == "v3/hideout/access"]
        for step in contact["progression"]:
            if step in authored:
                continue
            if not step.get("intermissionFor") and step["id"] != "v3/stalkernet/networkRemote":
                branches[step["branch"]].append(step)
        output = list(authored)
        ranks = defaultdict(int)
        for branch in branches.values():
            for index, step in enumerate(branch):
                step.pop("completionCash", None)
                step["requires"] = [p for p in step["requires"]
                                    if not p.endswith("/stock") and p != "v3/stalkernet/networkRemote"]
                if slug == "mute" and step["id"] == "v3/stalkernet/networkDossier":
                    step["requires"] = ["v3/stalkernet/networkLocation"]
                step["branchIndex"], step["branchLength"] = index + 1, len(branch)
                if slug != "mute":
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
                        "name": previous["name"].removesuffix(" stock increase") + " stock increase",
                        "kind": "delivery",
                        "requires": [previous["id"]], "briefing": step["briefing"],
                        "completion": step["completion"],
                        "requirements": [{"pool": slot["pool"], "quantity": math.ceil(slot["quantity"] / 2)}
                                         for slot in step["requirements"]],
                        "stock": {"items": targets, "bonus": bonus}, "intermissionFor": step["id"],
                        "branchIndex": index + 1, "branchLength": len(branch),
                        "acquisitionMaps": step["acquisitionMaps"], "requirementPolicy": POLICY,
                    }
                    # Rebuilding requirements must not replace an authored stock conversation.
                    authored_text = existing.get(intermission["id"], {})
                    for field in ("briefing", "completion"):
                        if field in authored_text:
                            intermission[field] = authored_text[field]
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


def opening_steps(contact):
    """Count connected unlock chains, not intermissions or labels shared by independent side branches."""
    steps = {step["id"]: step for step in contact["progression"]}
    unlocks = {key: step for key, step in steps.items() if not step.get("intermissionFor")}
    neighbours = {key: set() for key in unlocks}
    for key, step in unlocks.items():
        pending, visited = list(step["requires"]), set()
        while pending:
            parent = pending.pop()
            if parent in visited or parent not in steps:
                continue
            visited.add(parent)
            if steps[parent].get("intermissionFor"):
                pending.extend(steps[parent]["requires"])
            elif parent in unlocks and unlocks[parent]["branch"] == step["branch"]:
                neighbours[key].add(parent)
                neighbours[parent].add(key)
    opening, visited = set(), set()
    for key in unlocks:
        if key in visited:
            continue
        component, pending = set(), [key]
        while pending:
            current = pending.pop()
            if current in component:
                continue
            component.add(current)
            pending.extend(neighbours[current] - component)
        visited.update(component)
        ordered = [key for key in unlocks if key in component]
        opening.update(ordered[:math.ceil(len(ordered) / 5)])
    return opening


def requirement_batch_sizes(data, families):
    sizes = {}
    for item, kind in families.items():
        if kind != "valuable":
            continue
        bounds = data["batches"].get(item, [data["items"].get(item, {}).get("quantity", 1)])
        size = min(bounds)
        for rows in data["loot"].values():
            for weight, entry in rows:
                if weight > 0 and entry[0] == item and len(entry) > 1 and "quantity" in entry[1]:
                    size = min(size, entry[1]["quantity"])
        if size > 1:
            sizes[item] = int(size)
    return sizes


def author_requirements(data, rates, sources):
    pools, lookup = {}, {}
    batches = requirement_batch_sizes(data, eligible_items())

    def get_pool(items, label, maps, band, tier=None):
        key = (tuple(sorted(items)), label, tuple(maps), band)
        if key not in lookup:
            identifier = "town_expansion_" + hashlib.sha256(json.dumps(key).encode()).hexdigest()[:12]
            lookup[key] = identifier
            frequency = sum(sum(v[0] for v in rates[m].get(item, {}).values()) for m in maps for item in items)
            rarity = "common" if frequency >= 4 else "uncommon" if frequency >= 1 else "rare" if frequency >= 0.1 else "exceptional"
            pools[identifier] = {
                "name": label + " (" + ", ".join(MAP_LABELS[m] for m in maps) + ")",
                "tier": tier or rarity,
                "candidates": [{"item": item} for item in sorted(items)],
            }
        return lookup[key]

    def select_group(names, maps, mode, used, remaining, phase, category_limit=16):
        candidates = {row["item"] for name in names for row in data["pools"][name]["candidates"]}
        candidates = [item for item in candidates - used if item in sources
                      and sources[item]["kind"] == "valuable"
                      and any(m in sources[item]["maps"] for m in maps)]
        def score(item):
            units = sum(sum(v[1 if mode == "random" else 0] for v in rates[m].get(item, {}).values()) for m in maps)
            return units / batches.get(item, 1) if mode == "random" else units
        candidates.sort(key=lambda item: (-score(item), item))
        if not candidates:
            return set()
        if mode == "any":
            # Leave enough accessible candidates for disjoint three-item subsets in the other categories.
            width = category_limit
            start = 0
        else:
            width = min(8, max(1, len(candidates) // (remaining + 1)))
            start = min(len(candidates) - 1, int(phase * (len(candidates) - 1) * 0.6))
            # A specific-item roll must not mix a common find with a much rarer alternative.
            best = score(candidates[start])
            candidates = [item for item in candidates[start:] if score(item) >= best / 3]
            start = 0
        items = set(candidates[start:start + width])
        if mode == "any" and bool("value_nuts" in items) != bool("value_bolts" in items):
            items -= {"value_nuts", "value_bolts"}
        return items

    for slug, contact in sorted(data["contacts"].items()):
        if not contact["progression"]:
            continue
        identity = contact["progressionIdentity"]
        assert identity["core"] and identity["support"], slug
        for name in identity["core"] + identity["support"] + identity.get("opening", []):
            assert name in data["pools"], (slug, name)
        opening = opening_steps(contact)
        for step in contact["progression"]:
            category_only = step.get("intermissionFor", step["id"]) in opening
            step["categoryOnly"] = category_only
            opening_pools = identity.get("opening") if category_only else None
            if opening_pools:
                # Refresh saved opening categories once, retaining counters, deliveries and earned credit.
                step["requirementModesVersion"] = 3
            if step["id"] == "v3/hideout/access":
                slot = step["requirements"][0]
                step["requirements"][0] = {"pool": slot["pool"], "quantity": slot["quantity"], "mode": "any"}
                continue
            maps = step["acquisitionMaps"]
            original_index, length = step["branchIndex"] - 1, step["branchLength"]
            phase = original_index / max(1, length - 1)
            cap = 0 if original_index == 0 else (2 if phase >= 0.75 else 1)
            count = len(step["requirements"])
            expanded = min(cap, count)
            science = slug in SCIENCE and not step.get("intermissionFor")
            used, slots = set(), []
            for index, slot in enumerate(step["requirements"]):
                mode = "random" if not category_only and not step.get("intermissionFor") and index == count - 1 else "any"
                slot_maps = maps if index >= count - expanded else [contact["map"]]
                artifact_pool = None
                if science:
                    artifact_pool = slot.get("artifactPool", slot["pool"])
                    items = {c["item"] for c in data["pools"][artifact_pool]["candidates"]
                             if c["item"] in sources and any(m in sources[c["item"]]["maps"] for m in slot_maps)}
                    assert items and all(sources[i]["kind"] == "artifact" for i in items)
                    label = data["pools"][artifact_pool]["name"]
                else:
                    support = count >= 3 and index == count - 1
                    names = identity["support"] if support else identity["core"]
                    if opening_pools:
                        names = opening_pools
                    remaining = max(0, count - index - (2 if count >= 3 and not support else 1))
                    limit = 6 if category_only and count == 1 else 16
                    items = select_group(names, slot_maps, mode, used, remaining, phase, limit)
                    if not items and support:
                        items = select_group(identity["core"], slot_maps, mode, used, 0, phase, limit)
                    assert items, (slug, step["id"], index, "No distinct local specialty supplies")
                    label = identity["name"] + (": supporting supplies" if support else ": general supplies")
                    if opening_pools:
                        label = identity["openingName"]
                if mode == "random":
                    used.update(items)
                pool = get_pool(items, label, slot_maps, index,
                                data["pools"][artifact_pool]["tier"] if artifact_pool else None)
                requirement = {"pool": pool, "quantity": slot["quantity"], "mode": mode}
                if artifact_pool:
                    requirement["artifactPool"] = artifact_pool
                slots.append(requirement)
            step["requirements"] = slots
    referenced = {slot["pool"] for contact in data["contacts"].values()
                  for step in contact["progression"] for slot in step["requirements"]}
    for name in referenced:
        if name.startswith("town_expansion_") and name not in pools:
            pools[name] = data["pools"][name]
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
        source = path.read_text()
        output[path] = render_contact(source, contact["progression"])
    original = POOL_FILE.read_text().split(MARKER)[0].rstrip()
    generated = [original, MARKER.rstrip(), "ix.progression.townRequirementSources = " + lua(sources),
                 "ix.progression.requirementBatchSizes = " + lua(requirement_batch_sizes(data, eligible_items()))]
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
