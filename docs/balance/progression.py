"""Read-only progression workbook views. Lua is inspected, never executed."""
from collections import Counter, defaultdict


TAB_NAMES = (
    "Progression overview", "Progression steps", "Progression hand-ins",
    "Progression unlocks", "Progression item demand",
)

SERVICE_SOURCES = {
    "plugins/dialogue/dialogue/sh_owlnpc.lua": "Storage dialogue access",
    "plugins/dialogue/dialogue/sh_technpc.lua": "Suit painting dialogue access",
    "plugins/blowout/sh_plugin.lua": "Personal blowout warnings",
    "plugins/eventcontroller/sh_plugin.lua": "Personal event broadcasts",
}


def entries(tokens):
    """Split table entries without mistaking callback bodies for configuration."""
    if not tokens or (tokens[0].value, tokens[-1].value) not in {("{", "}"), ("(", ")")}:
        raise ValueError("Expected a literal table or argument list")
    result, start, depth, blocks, pending_do = [], 1, 0, [], 0
    for i, token in enumerate(tokens[1:-1], 1):
        value = token.value
        if value in {",", ";"} and depth == 0 and not blocks:
            if start < i:
                result.append(tokens[start:i])
            start = i + 1
        elif value in {"(", "[", "{"}:
            depth += 1
        elif value in {")", "]", "}"}:
            depth -= 1
        elif value in {"function", "if", "for", "while", "repeat"}:
            blocks.append(value)
            if value in {"for", "while"}:
                pending_do += 1
        elif value == "do":
            if pending_do:
                pending_do -= 1
            else:
                blocks.append(value)
        elif value in {"end", "until"}:
            if not blocks:
                raise ValueError("Unbalanced callback")
            blocks.pop()
    if depth or blocks or pending_do:
        raise ValueError("Unbalanced table")
    if start < len(tokens) - 1:
        result.append(tokens[start:-1])
    return result


def table_end(tokens, start, opening="{", closing="}"):
    depth = 0
    for i in range(start, len(tokens)):
        if tokens[i].value == opening:
            depth += 1
        elif tokens[i].value == closing:
            depth -= 1
            if depth == 0:
                return i + 1
    raise ValueError("Unterminated table")


def fields(tokens, decode):
    result = {}
    for entry in entries(tokens):
        if len(entry) >= 3 and entry[0].kind == "identifier" and entry[1].value == "=":
            key, value = entry[0].value, entry[2:]
        elif (len(entry) >= 5 and entry[0].value == "[" and entry[1].kind == "string"
              and [t.value for t in entry[2:4]] == ["]", "="]):
            key, value = decode(entry[1].value), entry[4:]
        else:
            raise ValueError("Unsupported named table entry")
        if key in result:
            raise ValueError(f"Repeated field {key}")
        result[key] = value
    return result


def scalar(tokens, decode, constants=None):
    if len(tokens) == 1:
        token = tokens[0]
        if token.kind == "string":
            return decode(token.value)
        if token.kind == "number":
            return float(token.value)
        if token.value in {"true", "false", "nil"}:
            return {"true": True, "false": False, "nil": None}[token.value]
        if constants and token.value in constants:
            return constants[token.value]
    # Support the concatenated prose produced by the GLua formatting pass.
    parts = [t for t in tokens if t.value not in {"(", ")"}]
    if parts and all(t.kind == "string" if i % 2 == 0 else t.value == ".."
                     for i, t in enumerate(parts)) and len(parts) % 2:
        return "".join(decode(t.value) for t in parts[::2])
    raise ValueError("Computed expression; inspect source")


def array(tokens, decode):
    result = []
    for entry in entries(tokens):
        if (len(entry) >= 5 and entry[0].value == "[" and entry[1].kind == "number"
                and [t.value for t in entry[2:4]] == ["]", "="]):
            if float(entry[1].value) != len(result) + 1:
                raise ValueError("Non-sequential array indices")
            entry = entry[4:]
        result.append(scalar(entry, decode))
    return result


def requirements(tokens, decode):
    """Accept only a plain returned requirement table, with no executable changes."""
    values = [t.value for t in tokens]
    if values[:4] == ["function", "(", ")", "return"]:
        start, variable = 4, None
    elif len(values) > 6 and values[:4] == ["function", "(", ")", "local"]:
        variable = values[4]
        if values[5] != "=":
            raise ValueError("Unsupported requirements function")
        start = 6
    else:
        raise ValueError("Unsupported requirements function")
    end = table_end(tokens, start)
    expected = ["return", variable, "end"] if variable else ["end"]
    if values[end:] != expected:
        raise ValueError("Requirements include executable behavior")
    result = {}
    for item, value in fields(tokens[start:end], decode).items():
        amount = scalar(value, decode)
        if isinstance(amount, bool) or not isinstance(amount, (int, float)) or amount <= 0 or amount % 1:
            raise ValueError(f"Non-positive/non-integer requirement: {item}")
        result[item] = int(amount)
    return result


def collect(root, tokenize, decode):
    folder = root / "gamemodes/ix_cotz/plugins/progression"
    steps, gates, notices = [], {}, []
    library = folder / "libs/sh_progression.lua"
    if library.is_file():
        source = library.read_text(encoding="utf-8")
        tokens = tokenize(source)
        for i in range(len(tokens) - 6):
            if [t.value for t in tokens[i:i + 6]] == ["ix", ".", "progression", ".", "npcRequirements", "="]:
                try:
                    end = table_end(tokens, i + 6)
                    gates = {key: scalar(value, decode) for key, value in
                             fields(tokens[i + 6:end], decode).items()}
                except ValueError as exc:
                    notices.append([library.relative_to(root).as_posix(), str(exc)])
                break
    for path in sorted(folder.glob("sh_*.lua")):
        source = path.read_text(encoding="utf-8")
        tokens = tokenize(source)
        constants, skip_until = {}, 0
        for i in range(len(tokens) - 9):
            if i < skip_until:
                continue
            if (tokens[i].kind == "identifier" and tokens[i + 1].value == "="
                    and tokens[i + 2].kind == "string"
                    and (i == 0 or tokens[i - 1].value not in {".", ":", "["})):
                constants[tokens[i].value] = decode(tokens[i + 2].value)
            if [t.value for t in tokens[i:i + 6]] != ["ix", ".", "progression", ".", "Register", "("]:
                continue
            if i and tokens[i - 1].value == "function":
                continue
            relative = path.relative_to(root).as_posix()
            if tokens[i + 6].kind != "string" or tokens[i + 7].value != "," or tokens[i + 8].value != "{":
                notices.append([relative, "Computed progression registration; inspect source"])
                continue
            ident = decode(tokens[i + 6].value)
            try:
                end = table_end(tokens, i + 8)
                skip_until = end
                data = fields(tokens[i + 8:end], decode)
                step = {"id": ident, "source": relative,
                        "line": source.count("\n", 0, tokens[i].start) + 1,
                        "requirements": {}, "next": [], "vendor": [], "world": {}}
                for name in ("name", "description", "keyNpc", "defaultActive", "progMap"):
                    step[name] = scalar(data[name], decode, constants) if name in data else ""
                step["next"] = array(data["nextProgressions"], decode) if "nextProgressions" in data else []
                step["thresholds"] = array(data["progressthresholds"], decode) if "progressthresholds" in data else []
                step["kind"] = "Item hand-in" if "GetItemIds" in data else "Job completions"
                if "GetItemIds" in data:
                    try:
                        step["requirements"] = requirements(data["GetItemIds"], decode)
                    except ValueError as exc:
                        step["kind"] = "Unsupported hand-in (see Coverage)"
                        notices.append([relative, f"{ident}: {exc}"])
                if "worldNPC" in data:
                    world = fields(data["worldNPC"], decode)
                    step["world"] = {"template": scalar(world["template"], decode)}
                    for name in ("pos", "ang"):
                        value = world.get(name, [])
                        step["world"][name] = source[value[0].start:value[-1].end] if value else ""
                for entry in entries(data["vendorUnlocks"]) if "vendorUnlocks" in data else []:
                    unlock = fields(entry, decode)
                    step["vendor"].append((scalar(unlock["npc"], decode), array(unlock["args"], decode)))
                steps.append(step)
            except (ValueError, KeyError, IndexError) as exc:
                notices.append([relative, f"{ident}: could not inspect progression: {exc}"])
    return steps, gates, notices


def build_tabs(root, entities, tokenize, decode):
    steps, gates, notices = collect(root, tokenize, decode)
    items = defaultdict(list)
    for entity in entities:
        if entity["tab"] == "Items":
            items[entity["id"]].append(entity)

    def item_name(ident):
        found = items[ident]
        return found[0]["name"] if len(found) == 1 else ident

    def item_status(ident):
        return "Found" if len(items[ident]) == 1 else "Duplicate definitions" if items[ident] else "Not found in scanned items"

    previous = defaultdict(list)
    for step in steps:
        for successor in step["next"]:
            previous[successor].append(step["id"])
    ids = Counter(s["id"] for s in steps)
    for step in steps:
        if ids[step["id"]] > 1:
            notices.append([step["source"], f"Duplicate progression ID {step['id']}; inspect runtime include order"])
        for successor in step["next"]:
            if successor not in ids:
                notices.append([step["source"], f"{step['id']}: unknown successor {successor}"])
    steps.sort(key=lambda s: (s["keyNpc"], s["source"], s["line"]))
    tabs = {name: [] for name in TAB_NAMES}
    tabs["Progression overview"] = [["NPC", "Total steps", "Hand-in steps", "Job steps", "Initially active definitions",
                                      "NPC access milestone", "Maps", "Scope / reading notes"]]
    tabs["Progression steps"] = [["Progression ID", "Name", "NPC", "Type", "Map", "Initially active definition",
                                   "Activated by completion of (any)", "NPC access milestone", "Next steps",
                                   "Item types required", "Total raw units", "Job thresholds", "Description", "Source", "Line"]]
    tabs["Progression hand-ins"] = [["Progression ID", "Step", "NPC", "Map", "Item ID", "Item", "Required units",
                                      "Item definition status", "Source", "Line"]]
    tabs["Progression unlocks"] = [["Progression ID", "Step", "Unlock type", "Scope", "Target NPC / template",
                                     "Item / next step", "Name", "Details", "Source", "Line"]]
    tabs["Progression item demand"] = [["Item ID", "Item", "Steps requesting item", "Total raw units across all steps",
                                         "Largest single requirement", "NPCs", "Progression IDs", "Item definition status"]]
    grouped = defaultdict(list)
    demand = defaultdict(list)
    for step in steps:
        grouped[step["keyNpc"]].append(step)
        ident, req = step["id"], step["requirements"]
        tabs["Progression steps"].append([
            ident, step["name"], step["keyNpc"], step["kind"], step["progMap"], step["defaultActive"],
            "; ".join(previous[ident]), gates.get(step["keyNpc"], ""), "; ".join(step["next"]),
            len(req) if step["kind"] == "Item hand-in" else None,
            sum(req.values()) if step["kind"] == "Item hand-in" else None,
            "; ".join(f"{value:g}" for value in step["thresholds"]), step["description"], step["source"], step["line"],
        ])
        for item, amount in sorted(req.items()):
            tabs["Progression hand-ins"].append([
                ident, step["name"], step["keyNpc"], step["progMap"], item, item_name(item), amount,
                item_status(item), step["source"], step["line"],
            ])
            demand[item].append((step, amount))

        def unlock(kind, scope, target, value, name="", details=""):
            tabs["Progression unlocks"].append([
                ident, step["name"], kind, scope, target, value, name, details, step["source"], step["line"],
            ])

        for successor in step["next"]:
            unlock("Activate next step", "Personal", "", successor)
        for npc, milestone in sorted(gates.items()):
            if milestone == ident:
                unlock("Full NPC dialogue and services", "Personal", npc, "",
                       details="Other characters receive limited dialogue; their own milestone is required.")
        for npc, args in step["vendor"]:
            unlock("Vendor catalog item", "Personal access and stock", npc, args[0], item_name(args[0]),
                   "Source AddItemToList args: " + str(args))
        if step["world"]:
            world = step["world"]
            unlock("NPC arrival", "Global on first completion", world["template"], "",
                   details=f"Map: {step['progMap']}; {world['pos']}; {world['ang']}")
    # These consumers gate services outside declarative vendor/world unlocks.
    by_id = {s["id"]: s for s in steps}
    for suffix, service in SERVICE_SOURCES.items():
        path = root / "gamemodes/ix_cotz" / suffix
        if not path.is_file():
            continue
        source = path.read_text(encoding="utf-8")
        tokens = tokenize(source)
        seen = set()
        for i in range(len(tokens) - 6):
            if [t.value for t in tokens[i:i + 6]] != ["ix", ".", "progression", ".", "IsCompleted", "("]:
                continue
            try:
                end = table_end(tokens, i + 5, "(", ")")
                args = entries(tokens[i + 5:end])
                milestone = scalar(args[1], decode)
                if milestone not in by_id or milestone in seen:
                    continue
                seen.add(milestone)
                step = by_id[milestone]
                tabs["Progression unlocks"].append([
                    milestone, step["name"], service, "Personal", "", "", "",
                    "Completion gate inspected in consumer; other service conditions may also apply.",
                    path.relative_to(root).as_posix(), source.count("\n", 0, tokens[i].start) + 1,
                ])
            except (ValueError, IndexError):
                notices.append([path.relative_to(root).as_posix(), "Computed service completion gate; inspect source"])
    for npc, rows in sorted(grouped.items()):
        tabs["Progression overview"].append([
            npc, len(rows), sum(s["kind"] == "Item hand-in" for s in rows),
            sum(s["kind"] == "Job completions" for s in rows),
            "; ".join(s["id"] for s in rows if s["defaultActive"] is True), gates.get(npc, ""),
            "; ".join(sorted({s["progMap"] for s in rows})),
            "Progress is personal. Initially active still requires NPC access. "
            "Units are not loot finds or a playthrough total; branches may be alternatives. "
            "Callbacks and external gates require source review.",
        ])
    for item, rows in sorted(demand.items(), key=lambda pair: (-len(pair[1]), pair[0])):
        tabs["Progression item demand"].append([
            item, item_name(item), len(rows), sum(amount for _, amount in rows), max(amount for _, amount in rows),
            "; ".join(sorted({s["keyNpc"] for s, _ in rows})), "; ".join(s["id"] for s, _ in rows), item_status(item),
        ])
    return tabs, notices
