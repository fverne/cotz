#!/usr/bin/env python3
"""Generate/check the town reward ledger from Lua definitions and their actual compiled gates."""
import argparse
import json
import re
from pathlib import Path
import subprocess

ROOT = Path(__file__).resolve().parents[3]
LEDGER = ROOT / "docs/npc-overhaul/unlock-ledger.md"
DEFINITIONS = ROOT / "gamemodes/ix_cotz/plugins/townnpcs/definitions"
# Existing consumers check these exact milestones. These are functional, not future services.
SERVICES = {}
KINDS = {"passage", "cosmetic", "storage", "barter", "supplyExchange", "information", "recipe"}


def snapshot():
    result = subprocess.run(
        ["luatex", "--luaonly", "docs/npc-overhaul/tools/reward_snapshot.lua"],
        cwd=ROOT, text=True, capture_output=True, check=True,
    )
    return json.loads(result.stdout)


def disabled_suggestions(slug):
    source = (DEFINITIONS / ("sh_" + slug.replace("-", "_") + ".lua")).read_text()
    block = re.search(r'\tdisabledItems = \{(.*?)\n\t\}', source, re.S)
    if not block:
        return set()
    return set(re.findall(r'^\s*(\w+) = true', block[1], re.M)) | set(
        re.findall(r'^\s*\["([^"\n]+)"\] = true', block[1], re.M))


def progression_id(contact, step):
    return f"cotz/town/{contact}/{step}"


def stock_items(stock):
    return stock.get("items", [stock["item"]] if "item" in stock else [])


def rewards(data, contact, step):
    compiled = data["compiled"][progression_id(contact, step["id"])]
    live = ["Purchase: " + u["args"][0] for u in compiled.get("vendorUnlocks", [])]
    live += ["Conversion: " + item for item in compiled.get("variantUnlocks", [])]
    if step.get("stock"):
        stock = step["stock"]
        live += [f"Stock: {item} +{stock['bonus']} total" for item in stock_items(stock)]
    if step.get("capacity"):
        capacity = step["capacity"]
        live.append(f"Carried capacity: +{capacity['amount']} {capacity['kind']}")
    live += [f"{d['service']} discount: {d['fraction'] * 100:g}%" for d in step.get("discounts", [])]
    live += [service["name"] for service in step.get("services", [])]
    if step.get("ammoExchange"):
        exchange = step["ammoExchange"]
        live.append(f"Barter: {exchange['boxes']} boxes {exchange['input']} for one box {exchange['output']}")
    if (contact, step["id"]) in SERVICES:
        live.append(SERVICES[contact, step["id"]])
    return sorted(live), step.get("plannedUnlocks", [])


def validate(data):
    errors = []
    items = {p.stem[3:] for p in (ROOT / "gamemodes/ix_cotz").rglob("sh_*.lua") if "/items/" in str(p)}
    compiled = data["compiled"]
    visiting, ancestors = set(), {}

    def closure(identifier):
        if identifier in ancestors:
            return ancestors[identifier]
        if identifier in visiting:
            raise ValueError("Progression cycle: " + identifier)
        visiting.add(identifier)
        result = set()
        for parent in compiled[identifier]["prerequisites"]:
            result.add(parent)
            result.update(closure(parent))
        visiting.remove(identifier)
        ancestors[identifier] = result
        return result

    for identifier in compiled:
        closure(identifier)
    planned_ids, kinds = set(), set()
    total = 0
    for slug, contact in data["contacts"].items():
        path = DEFINITIONS / ("sh_" + slug.replace("-", "_") + ".lua")
        source = path.read_text().split("\tretiredProgression = {")[0]
        # A comment immediately precedes each metadata entry, not merely its containing table.
        todo_entries = len(re.findall(r"-- TODO:[^\n]+\n\t{4}\{\n", source))
        placeholder_count = sum(len(s.get("plannedUnlocks", [])) for s in contact["progression"])
        if todo_entries != placeholder_count:
            errors.append(slug + ": each planned unlock needs an adjacent TODO")
        disabled = disabled_suggestions(slug)
        if disabled != set(contact.get("disabledItems", {})):
            errors.append(slug + ": disabledItems must match the commented-out suggestions")
        if disabled & (set(contact["catalogue"]) | set(contact["supplies"])):
            errors.append(slug + ": disabled suggestion restored to catalogue or supplies")
        for item, allocation in contact["catalogue"].items():
            if item not in items or len(allocation["terms"]) != 6:
                errors.append(slug + ": invalid catalogue item/terms: " + item)
            if allocation.get("unlockContact"):
                errors.append(slug + ": purchase route is not local: " + item)
        for step in contact["progression"]:
            total += 1
            if step.get("benefits", {}).get("items"):
                errors.append(progression_id(slug, step["id"]) + ": progression item gifts are disabled")
            identifier = progression_id(slug, step["id"])
            live, planned = rewards(data, slug, step)
            if not live:
                errors.append(identifier + ": no implemented unlock")
            for p in planned:
                if p.get("kind") not in KINDS or p.get("status") != "unimplemented" or p.get("provider") != slug:
                    errors.append(identifier + ": invalid planned unlock")
                if not p.get("id") or p["id"] in planned_ids or not p.get("name") or not p.get("effect"):
                    errors.append(identifier + ": invalid/duplicate planned identity")
                planned_ids.add(p["id"])
                kinds.add(p["kind"])
                terms = list(p.get("inputs", [])) + list(p.get("outputs", []))
                terms += [p[key] for key in ("output", "fuel") if key in p]
                for term in terms:
                    if term["item"] not in items or term["quantity"] <= 0:
                        errors.append(identifier + ": invalid planned item terms")
                if p["kind"] == "barter" and len({t["item"] for t in p.get("inputs", [])}) < 2:
                    errors.append(identifier + ": barter needs distinct input items")
                if p["kind"] == "supplyExchange" and len(p.get("inputs", [])) != 1:
                    errors.append(identifier + ": supply exchange needs one input")
                if p["kind"] == "recipe" and (not p.get("inputs") or not p.get("output") or not p.get("fuel")):
                    errors.append(identifier + ": recipe needs ingredients, output and fuel")
                if p.get("baseSuit") and p["baseSuit"] not in items:
                    errors.append(identifier + ": invalid cosmetic suit")
                if p["kind"] == "storage":
                    maximum = {"width": 10, "height": 8}.get(p.get("dimension"), 0)
                    if not 2 < p.get("target", 0) <= maximum:
                        errors.append(identifier + ": storage proposal exceeds default bounds")
            stock = step.get("stock")
            if stock:
                for item in stock_items(stock):
                    if item in disabled:
                        errors.append(identifier + ": disabled suggestion received stock")
                    if not 1 <= stock["bonus"] <= 4 or item not in items:
                        errors.append(identifier + ": invalid stock tier")
                    if item not in contact["supplies"] and item not in contact["catalogue"]:
                        errors.append(identifier + ": stock target has no intended assortment route")
                    for earlier in contact["progression"]:
                        old = earlier.get("stock")
                        if (old and item in stock_items(old) and old["bonus"] >= stock["bonus"]
                                and progression_id(slug, earlier["id"]) in ancestors[identifier]):
                            errors.append(identifier + ": redundant stock improvement")
    return errors


def bundle(benefits):
    parts = []
    for service in benefits.get("services", []):
        parts.append(f"{service['amount']} {service['service']} credit at {service['npc']}")
    return parts


def text(value):
    return str(value).replace("|", "\\|").replace("\n", " ")


def validation_issues(data):
    try:
        return validate(data)
    except ValueError as error:
        return [str(error) + "; remaining graph-dependent checks could not run"]


def render(data, issues=None):
    if issues is None:
        issues = validation_issues(data)
    summaries, rows, details, purchases, conversions = [], [], [], [], []
    total_steps = total_live = total_planned_only = total_multiple = 0
    for slug, contact in sorted(data["contacts"].items()):
        live_count = planned_only = multiple = 0
        for step in contact["progression"]:
            live, planned = rewards(data, slug, step)
            live_count += bool(live)
            planned_only += bool(planned and not live)
            multiple += len(live) + len(planned) > 1
            extra = ["60% of accepted hand-in value on completion"] + bundle(step.get("benefits", {}))
            extra += ["Sources: " + ", ".join(step.get("acquisitionMaps", []))]
            if step.get("recognition"):
                extra.append("Recognition: " + step["recognition"])
            rows.append(f"| {slug} | {step['id']} | {text('; '.join(live) or '—')} | "
                        f"{text('; '.join(p['name'] for p in planned) or '—')} | {text('; '.join(extra))} |")
            for p in planned:
                terms = {k: v for k, v in p.items() if k not in {"id", "provider", "status", "name", "effect", "kind"}}
                details.append(f"| {p['id']} | {p['kind']} | {text(p['effect'])} | "
                               f"{text(json.dumps(terms, ensure_ascii=False, sort_keys=True))} |")
        summaries.append(f"| {slug} | {len(contact['progression'])} | {live_count} | {planned_only} | {multiple} |")
        total_steps += len(contact["progression"])
        total_live += live_count
        total_planned_only += planned_only
        total_multiple += multiple
        for item, allocation in sorted(contact["catalogue"].items()):
            canonical = data["canonical"].get(item, "local")
            purchases.append(f"| {item} | {slug} | {allocation['step']} | {canonical} |")
    for item, allocation in sorted(data["variants"].items()):
        conversions.append(f"| {item} | {allocation['contact']} | {allocation['step']} | {allocation['base']} |")
    missing = total_steps - total_live - total_planned_only
    if issues:
        validation = ("## Validation findings\n\n"
                      "This is a current-definition snapshot generated with `--write --allow-invalid`.\n"
                      "The runtime configuration has unresolved errors; `--check` remains strict.\n\n"
                      + "\n".join("- " + text(issue) for issue in issues) + "\n")
    else:
        validation = "Validation passed.\n"
    header = f"""# Current progression unlock ledger

Generated from authoritative town definitions and their compiled purchase prerequisites.
Regenerate: `python3 docs/npc-overhaul/tools/progression_rewards.py --write`.
Verify: `python3 docs/npc-overhaul/tools/progression_rewards.py --check`.

**{total_steps} active steps; {total_live} have functional unlocks; {total_planned_only} have TODO-only unlock plans;
{total_multiple} have multiple assigned unlocks; {missing} have no assigned unlock.**

Purchase access is local to the seller. Canonical owners define equipment tier dependencies, not shared shop access.
Medicine uses independent family branches. Listed starter supplies are available immediately.
Stock values are total bonuses above the future base capacity, not additive grants or automatic refills.
Default vendor quantities, prices and refill policy are outside this allocation pass.

TODO entries are authoring metadata only: no entitlement, menu, payout or system is implemented for them.
Their proposed terms require implementation and balance review before activation. Progression item gifts,
town service credits and discounts are disabled. Each active step grants an implemented unlock; cash comes only from accepted hand-in value.
TODO plans alone never satisfy reward coverage. Empty steps are reported without restoring excluded items. Each cosmetic finish remains appearance-only.

{validation}
## Coverage by contact

| Contact | Steps | Functional coverage | Placeholder-only | Multiple unlocks |
| --- | ---: | ---: | ---: | ---: |
"""
    specialties = [f"| {slug} | {text(contact['progressionIdentity']['name'])} | "
                   f"{text(', '.join(contact['progressionIdentity']['core']))} | "
                   f"{text(', '.join(contact['progressionIdentity']['support']))} |"
                   for slug, contact in sorted(data["contacts"].items()) if contact["progression"]]
    sections = [header + "\n".join(summaries),
                "## Request specialties\n\n"
                "At least 75% of requested units stay with the contact's core work. Only the smallest slot "
                "of three-/four-slot requests may use related support goods. Scientist equipment research "
                "retains its artifact requirements. Marsh openings remain fully locally obtainable.\n\n"
                "| Contact | Specialty | Core pools | Related support pools |\n| --- | --- | --- | --- |\n"
                + "\n".join(specialties),
                "## Every progression step\n\n| Contact | Step | Functional unlocks | TODO unlocks | Supplementary rewards |\n"
                "| --- | --- | --- | --- | --- |\n" + "\n".join(rows),
                "## Purchase catalogue\n\n| Item | Seller | Local milestone | Canonical tier owner |\n"
                "| --- | --- | --- | --- |\n" + "\n".join(purchases),
                "## Suit conversion unlocks\n\nBoth canonical base-suit and exact variant milestones are required.\n\n"
                "| Variant | Contact | Milestone | Base suit |\n| --- | --- | --- | --- |\n" + "\n".join(conversions),
                "## Unimplemented unlock terms\n\nEvery entry has an adjacent TODO in its contact definition.\n\n"
                "| ID | Kind | Intended effect | Proposed terms |\n| --- | --- | --- | --- |\n" + "\n".join(details)]
    return "\n\n".join(sections).rstrip() + "\n"


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    action = parser.add_mutually_exclusive_group(required=True)
    action.add_argument("--write", action="store_true")
    action.add_argument("--check", action="store_true")
    parser.add_argument("--allow-invalid", action="store_true",
                        help="Write a current snapshot with validation findings; only valid with --write")
    args = parser.parse_args()
    if args.allow_invalid and not args.write:
        parser.error("--allow-invalid requires --write")
    data = snapshot()
    errors = validation_issues(data)
    if errors and not args.allow_invalid:
        raise SystemExit("\n".join(errors))
    result = render(data, errors)
    if args.write:
        LEDGER.write_text(result)
    elif LEDGER.read_text() != result:
        raise SystemExit("Reward ledger is stale; regenerate with --write")
    print(result.split("**")[1].replace("\n", " "))
    if errors:
        print("Snapshot written with unresolved validation findings:\n" + "\n".join(errors))


if __name__ == "__main__":
    main()
