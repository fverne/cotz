"""Reproducible, source-based pacing estimates; scores are not elapsed minutes.

Run with --apply to write literal slot quantities and task thresholds. Saved
character assignments remain authoritative and are never migrated by this tool.
"""
from collections import defaultdict
import argparse
import math
from pathlib import Path
import re

import acquisition
import balance
import progression

MAP_TIERS = {"rp_marsh_cs": 1, "rp_waystation": 2, "rp_pripyat_remaster": 3}
MAP_EFFORT = {1: 1.0, 2: 1.5, 3: 2.25}
RARITY_EFFORT = {"common": 1, "uncommon": 3, "rare": 8, "exceptional": 16, "fixed": 1}
MUTANT_ALIASES = {"tushkano": "rodent", "pseudogiant": "pseudogiant_slow",
                  "pseudogiantfast": "pseudogiant_fast", "electrochimera": "chimera_electro",
                  "swampcontroller": "controller_swamp", "electrocontroller": "controller_electro",
                  "fastcontroller": "controller_fast"}
# Abilities that raw health/melee values do not describe: invisibility, psychic
# attacks, phantoms, and the chimera's leap. Multipliers are tuning assumptions.
ABILITY_EFFORT = {"bloodsucker": 1.5, "burer": 1.5, "psydog": 1.5, "karlik": 1.5,
                  "controller": 2, "swampcontroller": 2, "electrocontroller": 2,
                  "fastcontroller": 2, "chimera": 1.5, "electrochimera": 1.75}
GROWTH = 1.25
JOB_EFFORT = 8


def mutant_effort(root, mutant):
    name = MUTANT_ALIASES.get(mutant, mutant)
    path = root / f"lua/entities/npc_mutant_{name}/init.lua"
    if not path.is_file():
        raise ValueError(f"Missing mutant danger source: {mutant} ({path})")
    source = path.read_text(encoding="utf-8-sig")

    def number(pattern, default):
        found = re.search(pattern, source)
        return float(found[1]) if found else default

    health = number(r"ENT\.hp\s*=\s*([\d.]+)", 100)
    resistance = number(r"ENT\.BR\s*=\s*([\d.]+)", 0)
    damage = max([float(n) for n in re.findall(r"\.damage\[\d+\]\s*=\s*([\d.]+)", source)] or [20])
    return max(1, math.sqrt(health / 100) * (1 + resistance / 50)
               * (1 + damage / 100) * ABILITY_EFFORT.get(mutant, 1))


def pool_efforts(root, pools):
    entities, _ = balance.scan(root)
    audit, warnings = acquisition.build_audit(root, entities, pools, balance.tokenize, balance.lua_string)
    if warnings:
        raise ValueError(warnings)
    sources = defaultdict(list)
    for row in audit[1:]:
        sources[row[0]].append(row)
    costs = {}
    for ceiling in (1, 2, 3):
        for ident, pool in pools.items():
            candidates = []
            for candidate in pool['candidates']:
                routes = []
                for row in sources[candidate['item']]:
                    route, group, chance = row[3], row[4], row[7]
                    if row[13] and row[13] <= ceiling:
                        quantity = row[8] or (row[9] + row[10]) / 2
                        # Hard-to-find points receive half the ordinary availability.
                        frequency = 0.5 if row[15] == 'Hard to find' else 1
                        routes.append(MAP_EFFORT[row[13]] * math.sqrt(1 / (4 * chance * quantity * frequency)))
                    elif route in ('Guaranteed harvest', 'Poaching trophy'):
                        routes.append(math.sqrt(mutant_effort(root, group) / chance))
                    elif route == 'Harvest and cooking':
                        routes.append(math.sqrt(min(mutant_effort(root, m) for m in group.split('; '))) + 0.5)
                    elif route == 'Anomaly field tier':
                        tier = group.split(': ')[-1]
                        routes.append({'commonArtifacts': 4, 'rareArtifacts': 10, 'veryRareArtifacts': 20}[tier])
                # Reward/cache tables have no encounter frequency. Do not treat a
                # conditional cache probability as free, always-available loot.
                fallback = 16 if ident == 'detector' else RARITY_EFFORT[pool['tier']]
                candidates.append(max(1, min(routes)) if routes else fallback)
            costs[ceiling, ident] = sum(candidates) / len(candidates)
    return costs


def plan(root):
    steps, gates, warnings = progression.collect(root, balance.tokenize, balance.lua_string)
    if warnings:
        raise ValueError(warnings)
    pools = progression.collect_pools(root, balance.tokenize, balance.lua_string)
    costs = pool_efforts(root, pools)
    by_id = {s['id']: s for s in steps}
    parents = defaultdict(set)
    for step in steps:
        for successor in step['next']:
            parents[successor].add(step['id'])
        gate = gates.get(step['keyNpc'])
        if gate and gate != step['id']:
            parents[step['id']].add(gate)
    # These traders form one equipment progression across two maps.
    haggler_ends = {s['id'] for s in steps if s['id'].startswith('hagglerItemDelivery_') and not s['next']}
    for ident in ('quartermasterItemDelivery_1', 'quartermasterItemDelivery_2'):
        parents[ident].update(haggler_ends)
    result = {}

    def visit(ident, visiting):
        if ident in result:
            return result[ident]
        if ident in visiting:
            raise ValueError(f'Cyclic progression pacing dependency: {ident}')
        step = by_id[ident]
        before = [visit(p, visiting | {ident}) for p in sorted(parents[ident])]
        depth = max((p['depth'] + 1 for p in before), default=0)
        map_factor = MAP_EFFORT[MAP_TIERS[step['progMap']]]
        target = max(8 * map_factor * GROWTH ** depth,
                     max((p['effort'] * GROWTH for p in before), default=0))
        fixed = bool(step['slots']) and all(pools[s['pool']]['tier'] == 'fixed' for s in step['slots'])
        quantities, thresholds = [], []
        if fixed:
            quantities = [1] * len(step['slots'])
            # Access keys are narrative gates; carry pacing forward without bulk keys.
            effort = max((p['effort'] for p in before), default=0)
        elif step['slots']:
            unit_costs = [costs[step['lootMapTier'], s['pool']] * map_factor for s in step['slots']]
            scalable = [i for i, slot in enumerate(step['slots']) if pools[slot['pool']]['tier'] != 'fixed']
            quantities = [max(1, math.floor(target / len(unit_costs) / cost)) if i in scalable else 1
                          for i, cost in enumerate(unit_costs)]
            effort = sum(q * c for q, c in zip(quantities, unit_costs))
            while effort + 1e-9 < target:
                # Give the next unit to the category with least assigned effort.
                index = min(scalable, key=lambda i: (quantities[i] * unit_costs[i], i))
                quantities[index] += 1
                effort = sum(q * c for q, c in zip(quantities, unit_costs))
        else:
            thresholds = [max(i + 1, math.ceil(target / (JOB_EFFORT * map_factor)))
                          for i, _ in enumerate(step['thresholds'])]
            effort = thresholds[-1] * JOB_EFFORT * map_factor
        result[ident] = dict(depth=depth, target=target, effort=effort, quantities=quantities,
                             thresholds=thresholds, fixed=fixed, parents=sorted(parents[ident]),
                             unitEfforts=[] if fixed or not step['slots'] else unit_costs)
        return result[ident]

    for ident in sorted(by_id):
        visit(ident, set())
    return steps, result


def apply(root, steps, planned):
    grouped = defaultdict(list)
    for step in steps:
        grouped[step['source']].append(step)
    for relative, definitions in grouped.items():
        path = root / relative
        source = path.read_text()
        for step in sorted(definitions, key=lambda s: s['line'], reverse=True):
            start = source.index(f'ix.progression.Register("{step["id"]}"')
            end = source.find('ix.progression.Register(', start + 1)
            end = len(source) if end < 0 else end
            block = source[start:end]
            data = planned[step['id']]
            if step['slots']:
                values = iter(data['quantities'])
                block, count = re.subn(r'(pool = "[^"\n]+", quantity = )\d+',
                                       lambda m: m[1] + str(next(values)), block)
                assert count == len(step['slots'])
            else:
                assert len(data['thresholds']) == 1
                block, count = re.subn(r'(progressthresholds\s*=\s*\{\s*(?:\[1\]\s*=\s*)?)\d+',
                                       lambda m: m[1] + str(data['thresholds'][0]), block)
                assert count == 1
            source = source[:start] + block + source[end:]
        path.write_text(source)


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--apply', action='store_true')
    args = parser.parse_args()
    root = Path(__file__).resolve().parents[2]
    steps, planned = plan(root)
    if args.apply:
        apply(root, steps, planned)
        report = ["# Progression pacing estimates\n",
                  "Generated by `progression_pacing.py --apply`. Scores are relative effort, not minutes.",
                  "See [the model assumptions](README.md#quantity-and-effort-decisions).\n",
                  "| Step | Depth including access gates | Estimated effort | Quantities / jobs |",
                  "| --- | ---: | ---: | --- |"]
        for step in steps:
            data = planned[step['id']]
            effort = 'Access key' if data['fixed'] else f"{data['effort']:.1f}"
            amounts = data['quantities'] or data['thresholds']
            report.append(f"| {step['id']} | {data['depth']} | {effort} | {', '.join(map(str, amounts))} |")
        (root / 'docs/balance/progression/pacing.md').write_text('\n'.join(report) + '\n')
    for step in steps:
        data = planned[step['id']]
        print(f"{step['id']}: depth {data['depth']}, effort {data['effort']:.1f}, "
              f"quantities {data['quantities'] or data['thresholds']}")
