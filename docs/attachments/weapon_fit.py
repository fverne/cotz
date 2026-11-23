"""Audit and repair attachment bones and third-person fits of CW weapons without running the game.

Usage (from the repository root):
    python3 docs/attachments/weapon_fit.py bones  CLASS... | all
    python3 docs/attachments/weapon_fit.py rebone CLASS --to BONE [--from BONE] [--write]
    python3 docs/attachments/weapon_fit.py world  CLASS... | all [--write]

`bones` lists each attachment bone's drift from the receiver across every viewmodel sequence. A bone that
stays put while the receiver recoils, reloads or is drawn leaves the sights floating in place.

`rebone` moves the attachment models that sit on one bone onto another, recomputing `pos` and `angle` so each
model keeps its exact pose in the idle sequence (where CW samples third-person mounts and where aims are fitted).

`world` fits the third-person display. CW maps each attachment from the viewmodel muzzle frame into the
worldmodel muzzle frame. The two meshes of an Anomaly pair are the same gun at a uniform scale, so the fit
compares the gun-only meshes in each muzzle frame and reports SWEP.WorldAttachmentScale, WorldAttachmentShift
and, when the muzzle frames face opposite ways, WorldAttachmentAngle. See docs/attachment-placement.md.

Without --write, nothing is changed. Models are read from the sibling addons.
"""

import argparse
import math
import re
import struct
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))

import mdl_pose  # noqa: E402
from apply_placements import (  # noqa: E402
    entry_span, find_table, format_number, format_triple, mask, replace_in_span,
)

REPO_ROOT = Path(__file__).resolve().parents[2]
WEAPONS = REPO_ROOT / "lua" / "weapons"
DEFAULT_MUZZLE_SCALE_LIMITS = (0.5, 1.5)

# Bones that do not belong to the gun body when measuring a mesh or choosing the receiver.
NON_RECEIVER = ("bip", "valve", "l_", "r_", "finger", "hand", "arm", "clav", "wrist", "thumb", "twist", "magaz",
    "launcher", "grenad", "patron", "silenc", "lock", "bullet", "gilza", "ammo", "trigger", "joint", "shell")

# Fit acceptance: widths of both meshes must agree with the length ratio, and the correction must matter.
WIDTH_TOLERANCE = 0.08
MIN_DISPLACEMENT = 1.0
MIN_SHIFT = 0.25
SIGHT_DISTANCE_SHARE = 0.45

TURNS = {
    "none": ((1, 1, 1), None),
    "roll": ((1, -1, -1), (0, 0, 180)),
    "pitch": ((-1, 1, -1), (180, 0, 0)),
    "yaw": ((-1, -1, 1), (0, 180, 0)),
}


class FitError(Exception):
    pass


# ---- vectors and Source angle matrices (columns: forward, left, up) ----

def add(a, b):
    return [x + y for x, y in zip(a, b)]


def sub(a, b):
    return [x - y for x, y in zip(a, b)]


def scale(a, factor):
    return [x * factor for x in a]


def dot(a, b):
    return sum(x * y for x, y in zip(a, b))


def rotate(matrix, vector):
    return [sum(matrix[column][row] * vector[column] for column in range(3)) for row in range(3)]


def unrotate(matrix, vector):
    return [dot(column, vector) for column in matrix]


def angle_matrix(pitch, yaw, roll):
    """Source AngleMatrix as columns forward, left and up."""
    sp, cp = math.sin(math.radians(pitch)), math.cos(math.radians(pitch))
    sy, cy = math.sin(math.radians(yaw)), math.cos(math.radians(yaw))
    sr, cr = math.sin(math.radians(roll)), math.cos(math.radians(roll))
    forward = [cp * cy, cp * sy, -sp]
    right = [-sr * sp * cy + cr * sy, -sr * sp * sy - cr * cy, -sr * cp]
    up = [cr * sp * cy + sr * sy, cr * sp * sy - sr * cy, cr * cp]
    return [forward, scale(right, -1), up]


def matrix_angle(matrix):
    forward, left, up = matrix
    xy = math.hypot(forward[0], forward[1])
    pitch = math.degrees(math.atan2(-forward[2], xy))
    if xy > 0.001:
        return [pitch, math.degrees(math.atan2(forward[1], forward[0])), math.degrees(math.atan2(left[2], up[2]))]
    return [pitch, math.degrees(math.atan2(-left[0], left[1])), 0.0]


def bone_frame(sample):
    return sample["pos"], [sample["forward"], sample["left"], sample["up"]]


def cw_to_world(frame, pos, angle):
    """Where CW draws an attachment: offsetAttachment on the bone matrix. CW's y is the bone's right (-left)."""
    origin, matrix = frame
    world = add(origin, add(add(scale(matrix[0], pos[0]), scale(matrix[1], -pos[1])), scale(matrix[2], pos[2])))
    child = angle_matrix(-angle[0], angle[1], angle[2])
    return world, [rotate(matrix, column) for column in child]


def world_to_cw(frame, world, rotation):
    origin, matrix = frame
    delta = sub(world, origin)
    pos = [dot(delta, matrix[0]), -dot(delta, matrix[1]), dot(delta, matrix[2])]
    local = [unrotate(matrix, column) for column in rotation]
    pitch, yaw, roll = matrix_angle(local)
    return pos, [-pitch, yaw, roll]


def rebone_pose(old_frame, new_frame, pos, angle):
    """`pos` and `angle` on the new bone that draw the attachment exactly where the old pair did."""
    world, rotation = cw_to_world(old_frame, pos, angle)
    return world_to_cw(new_frame, world, rotation)


# ---- weapon files and models ----

def find_model(model):
    for root in [REPO_ROOT] + sorted(path for path in REPO_ROOT.parent.iterdir() if path.is_dir()):
        candidate = root / model
        if candidate.exists():
            return candidate
    raise FitError("model %s not found in the sibling addons" % model)


def weapon_path(weapon_class):
    path = WEAPONS / weapon_class / "shared.lua"
    if not path.exists():
        raise FitError("%s has no shared.lua" % weapon_class)
    return path


def weapon_info(weapon_class):
    text = weapon_path(weapon_class).read_text(encoding="utf-8", errors="replace")
    code = mask(text)

    def string(name):
        match = re.search(r'^[ \t]*SWEP\.%s\s*=\s*"([^"]+)"' % name, code, re.M)
        return match.group(1) if match else None

    def number(name, default):
        match = re.search(r"^[ \t]*SWEP\.%s\s*=\s*(\d+)" % name, code, re.M)
        return int(match.group(1)) if match else default

    idle = re.search(r'(?:\["idle"\]|\bidle)\s*=\s*"([^"]+)"', code)
    return {
        "class": weapon_class, "text": text, "code": code,
        "viewmodel": string("ViewModel"), "worldmodel": string("WorldModel"),
        "idle": idle.group(1) if idle else None,
        "muzzle": string("MuzzleAttachmentName") or "1", "muzzleIndex": number("MuzzleAttachment", 1),
        "worldMuzzleIndex": number("WorldMuzzleAttachmentID", 1),
        "flipped": re.search(r"^[ \t]*SWEP\.ViewModelFlip\s*=\s*true", code, re.M) is not None,
    }


def attachment_point(model, name, index, sequence, cycles=1):
    """Muzzle-style attachment as CW looks it up: by name, else by index."""
    try:
        attachment = model.attachment(name)
    except mdl_pose.MdlError:
        if not 0 < index <= len(model.attachments):
            raise FitError("no attachment %s" % name)
        attachment = model.attachments[index - 1]
    return model.sample_attachment(sequence, attachment["name"], cycles)[0]


def first_sequence(model):
    return next(iter(model.sequences))


# ---- bones ----

def receiver_bone(path, model):
    """The non-arm bone that carries the most vertex weight."""
    data = Path(str(path)[:-4] + ".vvd").read_bytes()
    count = struct.unpack_from("<i", data, 16)[0]
    start = struct.unpack_from("<i", data, 56)[0]
    weight = [0.0] * len(model.bones)
    for index in range(count):
        base = start + index * 48
        weights = struct.unpack_from("<3f", data, base)
        bones = data[base + 12:base + 15]
        for slot in range(max(1, min(data[base + 15], 3))):
            if bones[slot] < len(weight):
                weight[bones[slot]] += weights[slot]
    names = [bone["name"].lower() for bone in model.bones]
    for number in sorted(range(len(weight)), key=lambda item: -weight[item]):
        if not any(token in names[number] for token in NON_RECEIVER):
            return model.bones[number]["name"]
    return model.bones[0]["name"]


def drift(model, receiver, bone, samples=6):
    """Largest travel of `bone` relative to `receiver` in any sequence, compared with the first sequence."""
    reference = None
    worst = (0.0, "")
    for sequence in model.sequences:
        try:
            first, second = model.sample(sequence, receiver, samples), model.sample(sequence, bone, samples)
        except (mdl_pose.MdlError, IndexError, struct.error):
            continue
        for a, b in zip(first, second):
            matrix = [a["forward"], a["left"], a["up"]]
            relative = unrotate(matrix, sub(b["pos"], a["pos"]))
            reference = reference or relative
            travel = math.dist(relative, reference)
            if travel > worst[0]:
                worst = (travel, sequence)
    return worst


def attachment_bones(info):
    table = find_table(info["text"], r"SWEP\.AttachmentModelsVM")
    if table is None:
        return []
    return sorted(set(re.findall(r'\bbone\s*=\s*"([^"]+)"', info["code"][table[0]:table[1]])))


def command_bones(classes):
    for weapon_class in classes:
        info = weapon_info(weapon_class)
        bones = attachment_bones(info)
        if not bones or not info["viewmodel"]:
            continue
        try:
            path = find_model(info["viewmodel"])
            model = mdl_pose.Model(path)
            receiver = receiver_bone(path, model)
        except (FitError, mdl_pose.MdlError) as error:
            print("%-18s skipped: %s" % (weapon_class, error))
            continue
        names = {bone["name"].lower() for bone in model.bones}
        report = []
        for bone in bones:
            if bone.lower() not in names:
                report.append("%s: MISSING" % bone)
                continue
            travel, sequence = drift(model, receiver, bone)
            report.append("%s: %.2f%s" % (bone, travel, " (%s)" % sequence if travel > 0.5 else ""))
        print("%-18s receiver %-10s %s" % (weapon_class, receiver, "  ".join(report)))


def entry_fields(text, span):
    entry = text[span[0]:span[1]]
    bone = re.search(r'\bbone\s*=\s*"([^"]*)"', entry)
    pos = re.search(r"\bpos\s*=\s*Vector\(([^)]*)\)", entry)
    angle = re.search(r"\bangle\s*=\s*Angle\(([^)]*)\)", entry)
    if not (bone and pos and angle) or "staticBone" in entry:
        return None
    return bone.group(1), [float(v) for v in pos.group(1).split(",")], [float(v) for v in angle.group(1).split(",")]


def set_in_entry(text, entry_id, pattern, replacement):
    open_index, close_index = find_table(text, r"SWEP\.AttachmentModelsVM")
    span = entry_span(text, open_index, close_index, entry_id)
    text, found = replace_in_span(text, span[0], span[1], pattern, replacement)
    if not found:
        raise FitError("%s has no field matching %s" % (entry_id, pattern))
    return text


def command_rebone(weapon_class, target, source, write):
    info = weapon_info(weapon_class)
    if info["flipped"]:
        raise FitError("%s uses a flipped viewmodel; rebone does not handle mirrored bones" % weapon_class)
    model = mdl_pose.Model(find_model(info["viewmodel"]))
    old_name = source
    text = info["text"]
    table = find_table(text, r"SWEP\.AttachmentModelsVM")
    if table is None:
        raise FitError("no AttachmentModelsVM")
    ids = re.findall(r'\[\s*"([^"]+)"\s*\]\s*=\s*\{', info["code"][table[0] + 1:table[1]])
    frames = {}
    changed = []
    for entry_id in ids:
        open_index, close_index = find_table(text, r"SWEP\.AttachmentModelsVM")
        span = entry_span(text, open_index, close_index, entry_id)
        fields = entry_fields(text, span) if span else None
        if not fields or (old_name and fields[0].lower() != old_name.lower()) or fields[0].lower() == target.lower():
            continue
        bone, pos, angle = fields
        for name in (bone, target):
            if name not in frames:
                frames[name] = bone_frame(model.sample(info["idle"], name, 1)[0])
        new_pos, new_angle = rebone_pose(frames[bone], frames[target], pos, angle)
        check = cw_to_world(frames[target], new_pos, new_angle)
        expect = cw_to_world(frames[bone], pos, angle)
        error = max(math.dist(check[0], expect[0]), max(math.dist(a, b) for a, b in zip(check[1], expect[1])))
        if error > 1e-3:
            raise FitError("%s does not round-trip (error %.5f)" % (entry_id, error))
        text = set_in_entry(text, entry_id, r'\bbone\s*=\s*"[^"]*"', 'bone = "%s"' % target)
        text = set_in_entry(text, entry_id, r"\bpos\s*=\s*Vector\([^)]*\)", "pos = " + format_triple("Vector", new_pos))
        text = set_in_entry(text, entry_id, r"\bangle\s*=\s*Angle\([^)]*\)",
            "angle = " + format_triple("Angle", new_angle))
        changed.append(entry_id)
    print("%-18s %s -> %s: %s" % (weapon_class, old_name or "any", target, ", ".join(changed) or "nothing to move"))
    if write and changed:
        weapon_path(weapon_class).write_text(text, encoding="utf-8")


# ---- third-person fit ----

def gun_points(path, model, sequence, frame):
    """Gun-only vertices of a model in the coordinates of a muzzle frame (x forward, y left, z up)."""
    vertices = mdl_pose.posed_vertices(str(path), sequence)
    data = Path(str(path)[:-4] + ".vvd").read_bytes()
    start = struct.unpack_from("<i", data, 56)[0]
    names = [bone["name"].lower() for bone in model.bones]
    origin, matrix = frame
    points = []
    for index, vertex in enumerate(vertices):
        bone = data[start + index * 48 + 12]
        if bone < len(names) and not any(token in names[bone] for token in NON_RECEIVER):
            points.append(unrotate(matrix, sub(vertex, origin)))
    if not points:
        raise FitError("no gun vertices in %s" % path)
    return points


def bounds(points):
    return [[min(p[i] for p in points) for i in range(3)], [max(p[i] for p in points) for i in range(3)]]


def overlap(first, second):
    volume = 1.0
    for axis in range(3):
        low, high = max(first[0][axis], second[0][axis]), min(first[1][axis], second[1][axis])
        volume *= max(high - low, 0.01)
    return volume


def best_flip(view_bounds, world_bounds):
    """The proper 180-degree turn (or none) that best lays the viewmodel's muzzle frame over the worldmodel's."""
    best = None
    for name, (signs, _) in TURNS.items():
        corners = [[view_bounds[0][i] * signs[i], view_bounds[1][i] * signs[i]] for i in range(3)]
        flipped = [[min(c) for c in corners], [max(c) for c in corners]]
        score = overlap(flipped, world_bounds)
        if best is None or score > best[0] * 1.05:
            best = (score, name, flipped)
    return best[1], best[2]


def game_scale(view, world, info, view_frame, world_frame):
    """What CW computes without overrides: muzzle-to-wpn_body distance ratio, or 1 when a model lacks the bone."""
    try:
        view_body = view.sample(info["idle"], "wpn_body", 1)[0]["pos"]
        world_body = world.sample(first_sequence(world), "wpn_body", 1)[0]["pos"]
    except mdl_pose.MdlError:
        return 1.0
    distance = math.dist(view_frame[0], view_body)
    if distance <= 0:
        return 1.0
    low, high = DEFAULT_MUZZLE_SCALE_LIMITS
    return max(low, min(high, math.dist(world_frame[0], world_body) / distance))


def world_fit(weapon_class):
    info = weapon_info(weapon_class)
    if not (info["viewmodel"] and info["worldmodel"] and info["idle"]):
        raise FitError("needs ViewModel, WorldModel and an idle animation")
    view_path, world_path = find_model(info["viewmodel"]), find_model(info["worldmodel"])
    view, world = mdl_pose.Model(view_path), mdl_pose.Model(world_path)
    world_sequence = first_sequence(world)
    view_frame = bone_frame(attachment_point(view, info["muzzle"], info["muzzleIndex"], info["idle"]))
    world_frame = bone_frame(attachment_point(world, "muzzle", info["worldMuzzleIndex"], world_sequence))
    view_box = bounds(gun_points(view_path, view, info["idle"], view_frame))
    world_box = bounds(gun_points(world_path, world, world_sequence, world_frame))

    flip, flipped = best_flip(view_box, world_box)
    length = (world_box[1][2] - world_box[0][2]) / (flipped[1][2] - flipped[0][2])
    width = (world_box[1][0] - world_box[0][0]) / max(flipped[1][0] - flipped[0][0], 1e-6)
    fitted = {
        "scale": length,
        "shift": [
            0.5 * (world_box[0][0] + world_box[1][0]) - length * 0.5 * (flipped[0][0] + flipped[1][0]),
            world_box[1][1] - length * flipped[1][1],
            world_box[0][2] - length * flipped[0][2],
        ],
        "flip": flip,
    }
    estimate = game_scale(view, world, info, view_frame, world_frame)

    # Distance a sight roughly halfway down the gun moves when the fit replaces CW's estimate.
    probe = [0.0, 0.0, SIGHT_DISTANCE_SHARE * (flipped[1][2] - flipped[0][2]) + flipped[0][2]]
    signs = TURNS[flip][0]
    placed = [length * probe[i] * signs[i] + fitted["shift"][i] for i in range(3)]
    displacement = math.dist(placed, [estimate * value for value in probe])
    # Opposite muzzle frames put every sight on the wrong side of the muzzle, so the turn is applied even when
    # a worldmodel carries extra geometry that widens its mesh.
    consistent = abs(width - length) <= WIDTH_TOLERANCE * length or (flip != "none" and 0.5 < length < 1.5)
    return info, fitted, estimate, width, displacement, consistent


def format_world_fields(fitted):
    shift = [0.0 if abs(value) < MIN_SHIFT else round(value, 2) for value in fitted["shift"]]
    lines = ["SWEP.WorldAttachmentScale = %s" % format_number(round(fitted["scale"], 3))]
    if any(shift):
        lines.append("SWEP.WorldAttachmentShift = " + format_triple("Vector", shift))
    angle = TURNS[fitted["flip"]][1]
    if angle:
        lines.append("SWEP.WorldAttachmentAngle = " + format_triple("Angle", angle))
    return lines


def write_world_fields(info, lines):
    text = info["text"]
    text = re.sub(r"^[ \t]*SWEP\.WorldAttachment(?:Scale|Shift|Angle)\s*=.*\n", "", text, flags=re.M)
    code = mask(text)
    anchor = (re.search(r"^([ \t]*)SWEP\.MuzzleAttachmentName\s*=.*$", code, re.M)
        or re.search(r"^([ \t]*)SWEP\.WorldModel\s*=.*$", code, re.M))
    if not anchor:
        raise FitError("%s has no SWEP.MuzzleAttachmentName or SWEP.WorldModel line to follow" % info["class"])
    insertion = "".join("\n%s%s" % (anchor.group(1), line) for line in lines)
    text = text[:anchor.end()] + insertion + text[anchor.end():]
    weapon_path(info["class"]).write_text(text, encoding="utf-8")


def command_world(classes, write, explicit):
    for weapon_class in classes:
        if not explicit and not attachment_bones(weapon_info(weapon_class)):
            continue
        try:
            info, fitted, estimate, width, displacement, consistent = world_fit(weapon_class)
        except (FitError, mdl_pose.MdlError, struct.error, OSError, IndexError) as error:
            print("%-18s skipped: %s" % (weapon_class, error))
            continue
        needed = displacement >= MIN_DISPLACEMENT
        verdict = "apply" if needed and consistent else "keep estimate" if consistent else "inconsistent meshes"
        print("%-18s CW estimate %.2f, fit %.3f (width %.2f) shift %s turn %s moves a sight %.1f: %s" % (
            weapon_class, estimate, fitted["scale"], width, [round(v, 1) for v in fitted["shift"]], fitted["flip"],
            displacement, verdict))
        if write and needed and consistent and attachment_bones(info):
            write_world_fields(info, format_world_fields(fitted))


def all_classes():
    return sorted(path.parent.name for path in WEAPONS.glob("cw_*/shared.lua") if path.parent.name != "cw_base")


def main(argv=None):
    parser = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    commands = parser.add_subparsers(dest="command", required=True)
    for name in ("bones", "world"):
        sub_parser = commands.add_parser(name)
        sub_parser.add_argument("classes", nargs="+")
        if name == "world":
            sub_parser.add_argument("--write", action="store_true")
    rebone = commands.add_parser("rebone")
    rebone.add_argument("weapon_class")
    rebone.add_argument("--to", required=True, dest="target")
    rebone.add_argument("--from", dest="source")
    rebone.add_argument("--write", action="store_true")
    args = parser.parse_args(argv)

    try:
        if args.command == "rebone":
            command_rebone(args.weapon_class, args.target, args.source, args.write)
        else:
            classes = all_classes() if args.classes == ["all"] else args.classes
            if args.command == "bones":
                command_bones(classes)
            else:
                command_world(classes, args.write, args.classes != ["all"])
    except (FitError, mdl_pose.MdlError) as error:
        print("error: %s" % error, file=sys.stderr)
        return 1
    return 0


if __name__ == "__main__":
    sys.exit(main())
