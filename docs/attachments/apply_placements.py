"""Apply attachment placement exports from the in-game CW placement tool to weapon and item files.

Usage (from the repository root):
    python3 docs/attachments/apply_placements.py [--dry-run] [EXPORT.json ...]

Without paths, every export in garrysmod/data/cotz_attachment_placement/ is applied. Applying an export
twice is a no-op. See docs/attachment-placement.md.
"""

import argparse
import json
import re
import sys
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parents[2]
DEFAULT_EXPORT_DIR = REPO_ROOT.parents[1] / "data" / "cotz_attachment_placement"
ITEM_ROOT = Path("gamemodes/ix_cotz/schema/items")
EXPORT_VERSION = 1
# New single-line ID lists wrap beyond this many characters (AGENTS.md targets about 110).
MAX_LIST_WIDTH = 80


class ApplyError(Exception):
    pass


def _long_bracket(text, index):
    """Return the end index of a [[...]] or [==[...]==] block starting at index, or None."""
    match = re.match(r"\[(=*)\[", text[index:])
    if not match:
        return None
    close = "]" + match.group(1) + "]"
    end = text.find(close, index + match.end())
    return len(text) if end < 0 else end + len(close)


def scan(text):
    """Yield (start, end, kind) spans for strings and comments in Lua source."""
    index = 0
    length = len(text)
    while index < length:
        char = text[index]
        if text.startswith("--", index):
            end = _long_bracket(text, index + 2)
            if end is None:
                newline = text.find("\n", index)
                end = length if newline < 0 else newline
            yield index, end, "comment"
            index = end
        elif char in "\"'":
            end = index + 1
            while end < length and text[end] != char and text[end] != "\n":
                end += 2 if text[end] == "\\" else 1
            yield index, min(end + 1, length), "string"
            index = end + 1
        elif char == "[" and _long_bracket(text, index) is not None:
            end = _long_bracket(text, index)
            yield index, end, "string"
            index = end
        else:
            index += 1


def mask(text, kinds=("comment",)):
    """Blank out comments (and optionally strings) while preserving offsets and newlines."""
    chars = list(text)
    for start, end, kind in scan(text):
        if kind in kinds:
            for position in range(start, end):
                if chars[position] != "\n":
                    chars[position] = " "
    return "".join(chars)


def match_brace(text, open_index):
    """Return the index of the brace closing the one at open_index."""
    code = mask(text, ("comment", "string"))
    depth = 0
    for index in range(open_index, len(code)):
        if code[index] == "{":
            depth += 1
        elif code[index] == "}":
            depth -= 1
            if depth == 0:
                return index
    raise ApplyError("unbalanced braces after offset %d" % open_index)


def find_table(text, pattern, start=0, end=None):
    """Find `pattern = {` in code and return (open_index, close_index) or None."""
    code = mask(text)
    regex = re.compile(pattern + r"\s*=\s*\{")
    match = regex.search(code, start, len(code) if end is None else end)
    if not match:
        return None
    open_index = match.end() - 1
    return open_index, match_brace(text, open_index)


def line_indent(text, index):
    line_start = text.rfind("\n", 0, index) + 1
    return re.match(r"[ \t]*", text[line_start:]).group(0)


def format_number(value):
    text = ("%.6f" % value).rstrip("0").rstrip(".")
    return "0" if text in ("-0", "") else text


def format_triple(name, values):
    return "%s(%s)" % (name, ", ".join(format_number(value) for value in values))


def format_field(field):
    kind = field["kind"]
    value = field["value"]
    if kind == "vector":
        return format_triple("Vector", value)
    if kind == "align":
        return "{right = %s, up = %s, forward = %s}" % tuple(
            format_number(value[key]) for key in ("right", "up", "forward"))
    if kind == "bool":
        return "true" if value else "false"
    raise ApplyError("unknown field kind %r" % kind)


def format_id_list(ids, indent):
    """Format a new ID list, one ID per line when a single line would pass the line-length target."""
    single = "{%s}" % ", ".join(json.dumps(item_id) for item_id in ids)
    if len(indent.expandtabs(4)) + len(single) <= MAX_LIST_WIDTH:
        return single
    lines = ["%s\t%s," % (indent, json.dumps(item_id)) for item_id in ids]
    return "{\n" + "\n".join(lines) + "\n" + indent + "}"


def lua_key(key):
    return "[%d]" % key if isinstance(key, int) else "[%s]" % json.dumps(key)


def insert_list_item(text, open_index, close_index, item):
    """Insert `item` as the last element of the table spanning open_index..close_index."""
    code = mask(text)
    last = close_index - 1
    while last > open_index and code[last].isspace():
        last -= 1
    if last == open_index:
        # Multi-line items start with a newline; keep the closing brace on its own line.
        closing = "\n" + line_indent(text, open_index) if item.startswith("\n") else ""
        return text[:open_index + 1] + item + closing + text[close_index:]
    separator = "" if code[last] == "," else ","
    return text[:last + 1] + separator + item + text[last + 1:]


def add_string_items(text, open_index, close_index, ids):
    """Append missing string IDs to a single-line list table."""
    present = set(re.findall(r'"([^"]+)"', text[open_index:close_index]))
    for item_id in ids:
        if item_id in present:
            continue
        span_has_items = bool(present)
        text = insert_list_item(text, open_index, close_index, (" " if span_has_items else "") + json.dumps(item_id))
        close_index = match_brace(text, open_index)
        present.add(item_id)
    return text


def entry_span(text, open_index, close_index, item_id):
    """Return the (open, close) braces of `[\"id\"] = {` or `id = {` inside a table, or None."""
    key = r'(?:\[\s*"%s"\s*\]|(?<![\w.])%s)' % (re.escape(item_id), re.escape(item_id))
    return find_table(text, key, open_index + 1, close_index)


def format_model(model, indent, multiline):
    fields = [
        ("model", json.dumps(model["model"])),
        ("bone", json.dumps(model["bone"])),
        ("pos", format_triple("Vector", model["pos"])),
        ("angle", format_triple("Angle", model["angle"])),
        ("size", format_triple("Vector", model["size"])),
    ]
    key = '[%s]' % json.dumps(model["id"])
    if not multiline:
        return "%s%s = {%s}," % (indent, key, ", ".join("%s = %s" % field for field in fields))
    lines = ["%s%s = {" % (indent, key)]
    lines += ["%s\t%s = %s," % ((indent,) + field) for field in fields]
    lines.append(indent + "},")
    return "\n".join(lines)


def replace_in_span(text, start, end, pattern, replacement):
    code = mask(text)
    match = re.compile(pattern).search(code, start, end)
    if not match:
        return text, False
    return text[:match.start()] + replacement + text[match.end():], True


def apply_models(text, models):
    if not models:
        return text

    table = find_table(text, r"SWEP\.AttachmentModelsVM")
    if table is None:
        anchor = re.compile(r"^SWEP\.Attachments\s*=", re.M).search(mask(text))
        block = "if CLIENT then\n\tSWEP.AttachmentModelsVM = {\n\t}\nend\n"
        if anchor:
            text = text[:anchor.start()] + block + "\n" + text[anchor.start():]
        else:
            text = text.rstrip("\n") + "\n\n" + block
        table = find_table(text, r"SWEP\.AttachmentModelsVM")

    for model in models:
        open_index, close_index = table
        span = entry_span(text, open_index, close_index, model["id"])
        if span:
            for name, pattern in (("pos", "Vector"), ("angle", "Angle"), ("size", "Vector")):
                text, found = replace_in_span(text, span[0], span[1], r"\b%s\s*=\s*%s\([^)]*\)" % (name, pattern),
                    "%s = %s" % (name, format_triple(pattern, model[name])))
                span = entry_span(text, open_index, match_brace(text, open_index), model["id"])
                if not found and name != "size":
                    raise ApplyError("%s has no %s field to update" % (model["id"], name))
        else:
            first = re.compile(r"(\[\s*\"[^\"]+\"\s*\]|\w+)\s*=\s*\{").search(mask(text), open_index + 1, close_index)
            if first:
                first_close = match_brace(text, first.end() - 1)
                multiline = "\n" in text[first.end():first_close]
                indent = line_indent(text, first.start())
            else:
                multiline = True
                indent = line_indent(text, open_index) + "\t"
            text = insert_list_item(text, open_index, close_index, "\n" + format_model(model, indent, multiline))
        table = find_table(text, r"SWEP\.AttachmentModelsVM")
    return text


def apply_fields(text, fields):
    pending = []
    for field in fields:
        value = format_field(field)
        regex = re.compile(r"^([ \t]*SWEP\.%s[ \t]*=[ \t]*)(.*)$" % re.escape(field["name"]), re.M)
        match = regex.search(mask(text))
        if match:
            old_end = match.start(2) + len(match.group(2).rstrip())
            text = text[:match.start(2)] + value + text[old_end:]
        else:
            pending.append("SWEP.%s = %s" % (field["name"], value))

    if not pending:
        return text

    code = mask(text)
    anchor = re.compile(r"^[ \t]*SWEP\.IronsightAng\b.*$", re.M).search(code)
    if anchor:
        indent = line_indent(text, anchor.start())
        insertion = "\n\n" + "\n".join(indent + line for line in pending)
        return text[:anchor.end()] + insertion + text[anchor.end():]

    anchor = re.compile(r"^[ \t]*SWEP\.AttachmentModelsVM\s*=", re.M).search(code)
    if not anchor:
        raise ApplyError("no client block to hold " + ", ".join(pending))
    indent = line_indent(text, anchor.start())
    insertion = "\n".join(indent + line for line in pending) + "\n\n"
    line_start = text.rfind("\n", 0, anchor.start()) + 1
    return text[:line_start] + insertion + text[line_start:]


def top_level_entries(text, open_index, close_index):
    """Yield (open, close) for each table value directly inside the given table."""
    code = mask(text, ("comment", "string"))
    index = open_index + 1
    while index < close_index:
        if code[index] == "{":
            close = match_brace(text, index)
            yield index, close
            index = close + 1
        else:
            index += 1


def remove_entry(text, open_index, close_index):
    """Remove a table entry (`key = {...},`) and its line when nothing else shares it."""
    code = mask(text)
    start = open_index
    key = re.search(r"(\[[^\]]*\]|\w+)\s*=\s*$", code[:open_index])
    if key:
        start = key.start()
    end = close_index + 1
    trailing = re.match(r"\s*,", code[end:])
    if trailing:
        end += trailing.end()
    line_start = text.rfind("\n", 0, start) + 1
    if not text[line_start:start].strip():
        start = line_start
        newline = text.find("\n", end)
        if newline >= 0 and not text[end:newline].strip():
            end = newline + 1
    return text[:start] + text[end:]


def apply_slot(text, slot, ids):
    """Add IDs to the slot with the export's header, or set its list exactly when `replace` is set."""
    replace = slot.get("replace")
    if not ids and not replace:
        return text

    table = find_table(text, r"SWEP\.Attachments")
    if table is None:
        raise ApplyError("no SWEP.Attachments table")

    header = re.compile(r"\bheader\s*=\s*%s" % re.escape(json.dumps(slot["header"])))
    for open_index, close_index in top_level_entries(text, *table):
        if header.search(text, open_index, close_index):
            if replace and not ids:
                return remove_entry(text, open_index, close_index)
            atts = find_table(text, r"\batts", open_index, close_index)
            if atts is None:
                raise ApplyError("%s slot has no atts list" % slot["header"])
            if replace:
                indent = line_indent(text, open_index) if "\n" in text[atts[0]:atts[1]] else ""
                indent = indent.expandtabs(4).replace("    ", "\t")
                return text[:atts[0]] + format_id_list(ids, indent) + text[atts[1] + 1:]
            return add_string_items(text, atts[0], atts[1], ids)

    if not ids:
        return text

    entry = "\n\t%s = {header = %s, offset = {%s}, atts = %s}," % (
        lua_key(slot["key"]), json.dumps(slot["header"]), ", ".join(str(value) for value in slot["offset"]),
        format_id_list(ids, "\t"))
    open_index = table[0]
    return text[:open_index + 1] + entry + text[open_index + 1:]


def remove_from_slots(text, ids):
    """Remove IDs from every attachment slot, dropping slots left empty."""
    if not ids:
        return text
    while True:
        table = find_table(text, r"SWEP\.Attachments")
        if table is None:
            return text
        for open_index, close_index in top_level_entries(text, *table):
            atts = find_table(text, r"\batts", open_index, close_index)
            if atts is None:
                continue
            present = set(re.findall(r'"([^"]+)"', text[atts[0]:atts[1]]))
            doomed = [item_id for item_id in ids if item_id in present]
            if not doomed:
                continue
            if present <= set(ids):
                text = remove_entry(text, open_index, close_index)
            else:
                text = remove_string_items(text, atts[0], atts[1], doomed)
            break
        else:
            return text


def apply_weapon(text, export):
    text = apply_models(text, export.get("models", []))
    text = apply_fields(text, export.get("fields", []))
    text = apply_slot(text, export["slot"], export.get("attachments", []))
    removed = [item_id for item_id in export.get("removeAttachments", []) if item_id not in export.get("attachments", [])]
    return remove_from_slots(text, removed)


def remove_string_items(text, open_index, close_index, ids):
    """Remove string IDs from a list table, keeping the list's layout."""
    for item_id in ids:
        body = text[open_index + 1:close_index]
        updated = re.sub(r'\s*%s\s*,?' % re.escape(json.dumps(item_id)), "", body, count=1)
        if updated != body:
            # A removed last element can leave a dangling separator.
            updated = re.sub(r",(\s*)$", r"\1", updated) if not body.rstrip().endswith(",") else updated
            if "\n" not in updated:
                updated = updated.strip()
            text = text[:open_index + 1] + updated + text[close_index:]
            close_index = match_brace(text, open_index)
    return text


def apply_item(text, ids, removed=()):
    table = find_table(text, r"(?m)^ITEM\.validAttachments")
    if table and removed:
        text = remove_string_items(text, table[0], table[1], removed)
    if not ids:
        return text

    table = find_table(text, r"(?m)^ITEM\.validAttachments")
    if table:
        text = add_string_items(text, table[0], table[1], ids)
    else:
        code = mask(text)
        anchor = (re.compile(r"^ITEM\.height\b.*$", re.M).search(code)
            or re.compile(r"^ITEM\.class\b.*$", re.M).search(code))
        line = "ITEM.validAttachments = " + format_id_list(ids, "")
        text = text[:anchor.end()] + "\n" + line + text[anchor.end():]

    return re.sub(r"^(ITEM\.canAttach\s*=\s*)false\b", r"\1true", text, flags=re.M)


def item_files(root, weapon_class):
    pattern = re.compile(r'^ITEM\.class\s*=\s*"%s"' % re.escape(weapon_class), re.M)
    return [path for path in sorted((root / ITEM_ROOT).rglob("*.lua"))
        if pattern.search(mask(path.read_text(encoding="utf-8")))]


def load_export(path):
    export = json.loads(Path(path).read_text(encoding="utf-8"))
    if export.get("version") != EXPORT_VERSION:
        raise ApplyError("%s: unsupported export version %r" % (path, export.get("version")))
    if not re.fullmatch(r"[a-z0-9_]+", export.get("class", "")):
        raise ApplyError("%s: invalid weapon class" % path)
    return export


def apply_export(root, export, dry_run=False):
    """Apply one export and return the repository-relative paths that changed."""
    weapon_path = root / "lua/weapons" / export["class"] / "shared.lua"
    if not weapon_path.exists():
        raise ApplyError("%s does not exist" % weapon_path)

    targets = [(weapon_path, lambda text: apply_weapon(text, export))]
    attachments = export.get("attachments", [])
    removed = [item_id for item_id in export.get("removeAttachments", []) if item_id not in attachments]
    for path in item_files(root, export["class"]) if attachments or removed else []:
        targets.append((path, lambda text: apply_item(text, attachments, removed)))

    changed = []
    for path, transform in targets:
        original = path.read_text(encoding="utf-8")
        updated = transform(original)
        if updated != original:
            changed.append(str(path.relative_to(root)))
            if not dry_run:
                path.write_text(updated, encoding="utf-8")
    return changed


def main(argv=None):
    parser = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument("exports", nargs="*", type=Path)
    parser.add_argument("--root", type=Path, default=REPO_ROOT)
    parser.add_argument("--dry-run", action="store_true")
    args = parser.parse_args(argv)

    paths = args.exports or sorted(DEFAULT_EXPORT_DIR.glob("*.json"))
    if not paths:
        print("No exports found in %s" % DEFAULT_EXPORT_DIR)
        return 1

    status = 0
    for path in paths:
        try:
            export = load_export(path)
            changed = apply_export(args.root, export, args.dry_run)
        except (ApplyError, OSError, ValueError, KeyError) as error:
            print("FAIL %s: %s" % (path, error))
            status = 1
            continue
        if export.get("skipped"):
            print("  %s skipped without aim: %s" % (export["class"], ", ".join(export["skipped"])))
        print("%s %s: %s" % ("WOULD CHANGE" if args.dry_run else "OK", export["class"],
            ", ".join(changed) if changed else "already applied"))
    return status


if __name__ == "__main__":
    sys.exit(main())
