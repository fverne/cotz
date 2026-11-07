#!/usr/bin/env python3
"""Report ammunition routes using the authored regularAmmoChain without rewriting it."""
import argparse
from fractions import Fraction
from pathlib import Path
import re
import runpy

ROOT = Path(__file__).resolve().parents[3]
REPORT = ROOT / "docs/npc-overhaul/ammo-progression.md"


def ammunition():
    result = {}
    for path in sorted((ROOT / "gamemodes/ix_cotz/schema/items/newammo").glob("sh_*.lua")):
        source = path.read_text()
        values = {}
        for field in ("price", "ammoAmount"):
            match = re.search(r"^ITEM\." + field + r"\s*=\s*(\d+(?:\.\d+)?)\s*(?://[^\n]*)?$",
                              source, re.M)
            if not match or Fraction(match[1]) <= 0:
                raise ValueError(f"{path.name}: expected positive literal {field}")
            values[field] = Fraction(match[1])
        item = path.stem[3:]
        regular = item[:-2] if item.endswith(("ap", "hp")) else item
        if item in {"12gaugedt", "12gaugesg", "12gaugemg", "12gaugetr"}:
            regular = "12gauge"
        result[item] = {**values, "cost": values["price"] / values["ammoAmount"], "regular": regular}
    return result


def regular_order(data, ammo):
    source = (ROOT / "gamemodes/ix_cotz/schema/libs/sh_weapontables.lua").read_text()
    ammo_types = dict(re.findall(r'ammotypes\["([^"]+)"\] = \{uID = "([^"]+)"', source))
    first_uses = {}
    for chain_index, chain in enumerate(data["chains"]):
        first = ROOT / f"gamemodes/ix_cotz/schema/items/newweapons/sh_{chain[0]}.lua"
        if len(chain) <= 2 or not first.exists():
            continue
        for position, item in enumerate(chain, 1):
            path = ROOT / f"gamemodes/ix_cotz/schema/items/newweapons/sh_{item}.lua"
            source = path.read_text()
            weapon_class = re.search(r'ITEM.class\s*=\s*"([^"]+)"', source)
            price = re.search(r"ITEM.price\s*=\s*(\d+)", source)
            if not weapon_class or not price:
                raise ValueError(f"{path}: expected literal weapon class and price")
            weapon = ROOT / f"lua/weapons/{weapon_class[1]}/shared.lua"
            default = re.search(r'SWEP.Primary.Ammo\s*=\s*"([^"]+)"', weapon.read_text())
            if not default:
                raise ValueError(f"{weapon}: expected literal primary ammunition")
            # .410 bore has its own item, despite being encoded as a .45 ACP attachment load.
            regular = "45acp41" if default[1] == ".45 ACP -41-" else ammo_types.get(default[1])
            if regular not in ammo or ammo[regular]["regular"] != regular:
                raise ValueError(f"{weapon}: unknown regular ammunition {default[1]}")
            key = (position, int(price[1]), chain_index, item)
            if regular not in first_uses or key < first_uses[regular]:
                first_uses[regular] = key
    regulars = {item for item, entry in ammo.items() if entry["regular"] == item}
    ordered = data["regularAmmoChain"]
    if len(ordered) != len(set(ordered)) or set(ordered) != regulars:
        raise ValueError("regularAmmoChain must contain each regular load exactly once")
    return ordered, first_uses


def allocations(data, ammo):
    routes, orders = {}, {}
    for slug, contact in data["contacts"].items():
        routes[slug] = {item: allocation["step"] for item, allocation in contact["catalogue"].items()
                        if item in ammo}
        order = [step["id"] for step in contact["progression"] if step["id"] in routes[slug].values()]
        if order:
            orders[slug] = order
    return routes, orders


def render(data, ammo, routes):
    regulars, first_uses = regular_order(data, ammo)
    ranks = {item: index for index, item in enumerate(regulars)}
    lines = ["# Authored ammunition progression", "",
             "Generated with `python3 docs/npc-overhaul/tools/ammo_progression.py --write`.", "",
             "`PLUGIN.regularAmmoChain` contains every regular load, excluding AP, HP and special shotgun variants.",
             "The manually authored regularAmmoChain is authoritative; gun first-use data is informational only.",
             "This report never rewrites equipment chains, calibre order or contact allocations.",
             "Brass owns regular-calibre and HP branches; Carbon owns the AP branch.",
             "Each HP milestone requires its matching regular milestone; AP requires the matching HP milestone at Brass.",
             "HP and AP have no town cash sale routes. Exchanges consume two or three regular boxes respectively.",
             "Boxes are measured using their standard round counts; partial stacks can be combined.",
             "Brass also starts with buckshot and slugs; special loads unlock in TR, DT, MG order after regular buckshot.",
             "Listed starter ammunition is ungated. Box prices, round counts and damage values are unchanged.", "",
             "The legacy ID `45acp41` is .410 bore, a separate cartridge rather than a .45 ACP upgrade.", "",
             "## Regular chain", "", " → ".join(regulars), "",
             "| Regular load | First gun | Position |", "| --- | --- | ---: |"]
    for item in regulars:
        first = first_uses.get(item)
        lines.append(f"| {item} | {first[3] if first else 'No gun in upgrade chains'} | {first[0] if first else '—'} |")
    lines += ["", "## Seller allocations", "",
             "| Item | Box price | Rounds | Price per round | Regular counterpart | Seller: milestone |",
             "| --- | ---: | ---: | ---: | --- | --- |"]
    for item, entry in sorted(ammo.items(), key=lambda pair: (ranks[pair[1]["regular"]], pair[1]["cost"], pair[0])):
        sellers = [f"{slug}: {r[item]}" for slug, r in sorted(routes.items()) if item in r]
        supplies = [slug + ": ungated" for slug, c in sorted(data["contacts"].items())
                    if item in c["supplies"] and item not in routes[slug]]
        barters = [f"{slug}: {step['id']} (barter {step['ammoExchange']['boxes']}:1)"
                   for slug, contact in sorted(data["contacts"].items()) for step in contact["progression"]
                   if step.get("ammoExchange", {}).get("output") == item]
        lines.append(f"| {item} | {entry['price']} | {entry['ammoAmount']} | {float(entry['cost']):.4f} | "
                     f"{entry['regular']} | {'; '.join(sellers + supplies + barters)} |")
    return "\n".join(lines) + "\n"


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    modes = parser.add_mutually_exclusive_group(required=True)
    modes.add_argument("--write", action="store_true")
    modes.add_argument("--check", action="store_true")
    args = parser.parse_args()
    ledger = runpy.run_path(str(ROOT / "docs/npc-overhaul/tools/progression_rewards.py"))
    data = ledger["snapshot"]()
    ammo = ammunition()
    regulars, _ = regular_order(data, ammo)
    routes, orders = allocations(data, ammo)
    errors = []
    report = render(data, ammo, routes)
    if args.write:
        REPORT.write_text(report)
    else:
        if REPORT.read_text() != report:
            errors.append("Ammunition progression report is stale")
        if errors:
            raise SystemExit("\n".join(errors))
    print(f"Checked {len(ammo)} ammunition definitions and {sum(map(len, routes.values()))} purchase routes")


if __name__ == "__main__":
    main()
