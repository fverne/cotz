"""Audit and repair attachment bones and third-person fits of CW weapons without running the game.

Usage (from the repository root):
    python3 docs/attachments/weapon_fit.py bones  CLASS... | all
    python3 docs/attachments/weapon_fit.py rebone CLASS --to BONE [--from BONE] [--write]
    python3 docs/attachments/weapon_fit.py world  CLASS... | all [--write]
    python3 docs/attachments/weapon_fit.py fallback CLASS... | all [--write]

`bones` lists each attachment bone's drift from the receiver across every viewmodel sequence. A bone that
stays put while the receiver recoils, reloads or is drawn leaves the sights floating in place.

`rebone` moves the attachment models that sit on one bone onto another, recomputing `pos` and `angle` so each
model keeps its exact pose in the idle sequence (where CW samples third-person mounts and where aims are fitted).

`world` fits the third-person display. CW maps each attachment from the viewmodel muzzle frame into the
worldmodel muzzle frame. The two meshes of an Anomaly pair are the same gun at a uniform scale, so the fit
compares the gun-only meshes in each muzzle frame and reports SWEP.WorldAttachmentScale, WorldAttachmentShift
and, when the muzzle frames face opposite ways, WorldAttachmentAngle. See docs/attachment-placement.md.

`fallback` checks lua/cotz/weapon_attachment_poses.lua against each viewmodel's idle pose, with the bodygroups
the weapon sets at startup. Sights with no gun under their mount move along the line of sight to the nearest
flat stretch of the gun's top and are seated on it; their aim height follows. Suppressors standing in front of
the barrel move back onto it.

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

FALLBACK_POSES = REPO_ROOT / "lua" / "cotz" / "weapon_attachment_poses.lua"
FALLBACK_SUPPRESSORS = ("md_cobram2", "md_pbs1", "md_saker", "md_tundra9mm")

# Arm and hand bones across the CW, Anomaly, KHR and TFA rigs. Gun parts such as a charging handle stay in.
ARM_BONE = re.compile(
    r"(^|[^a-z0-9])[lr]([^a-z0-9]|$)|bip01|valvebiped|^left|^right|^bone\d|twist|wrist|elbow|clavicle|shoulder"
    r"|(^|[^a-z])(upper|fore)?arm|(^|[^a-z])(hand(?!guard|le)|finger|thumb|index|middle|ring|pinky)"
)

# Fallback sight seating. The middle share of a sight's length is its mount. A sight with less than
# MISPLACED_COVERAGE of its mount over the gun moves to the nearest flat stretch of the gun's top along its line
# of sight. Only the gun's longest continuous stretch counts, so parts posed away from the gun (a revolver's
# speedloader) cannot hold a sight. Scopes that merely overhang the end of a receiver stay where they are.
SURFACE_STEP = 0.1
MOUNT_SHARE = 0.5
MISPLACED_COVERAGE = 0.5
MOUNT_COVERAGE = 0.95
FLAT_TOLERANCE = 0.75
SURFACE_GAP = 0.5
MIN_SIGHT_MOVE = 0.05
# Side-mounted optics clamp to a dovetail beside the receiver rather than sitting on its top.
SIDE_MOUNTS = ("md_kobra", "md_pso1", "cw_anomaly_1p29", "cw_anomaly_mosin")

# A suppressor whose rear stands this far in front of the barrel moves back to overlap it slightly.
SUPPRESSOR_GAP = 0.3
SUPPRESSOR_OVERLAP = 0.15

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
    for path in (WEAPONS / weapon_class / "shared.lua", WEAPONS / (weapon_class + ".lua")):
        if path.exists():
            return path
    raise FitError("%s has no shared.lua" % weapon_class)


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
        "viewmodel": string("ViewModel"), "worldmodel": string("WM") or string("WorldModel"),
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


def legacy_vertices(path, model, sequence, viewmodel, bodygroups=None):
    """Use the visible model variant instead of measuring every alternate stock and barrel."""
    vertices = mdl_pose.posed_vertices(str(path), sequence)
    indices = {index for face in mdl_pose.triangles(str(path), bodygroups) for index in face if index < len(vertices)}
    if viewmodel:
        data = path.with_suffix(".vvd").read_bytes()
        start = struct.unpack_from("<i", data, 56)[0]
        excluded = NON_RECEIVER + ("left ", "right ", "l-", "r-", "clavicle", "elbow")
        gun_bones = {
            index for index, bone in enumerate(model.bones)
            if not any(part in bone["name"].lower() for part in excluded)
        }
        indices = {
            index for index in indices
            if data[start + index * 48 + 12] in gun_bones
        }
    if not indices:
        raise FitError("no visible gun geometry in %s" % path.name)
    return [vertices[index] for index in indices]


def barrel_frame(points, muzzle):
    """Legacy models use different muzzle rolls. Recover a common barrel-forward, top-up frame."""
    low, high = bounds(points)
    lengths = sub(high, low)
    axis = max(range(2), key=lambda i: lengths[i])
    length = lengths[axis]
    if length <= lengths[2] or length == 0:
        raise FitError("could not identify the barrel axis")

    if muzzle:
        position = muzzle[axis]
        front = 1 if position > (low[axis] + high[axis]) / 2 else -1
        if low[axis] + length * 0.37 < position < high[axis] - length * 0.37:
            raise FitError("muzzle is too far from either end of the mesh")
    else:
        # On a model without muzzle metadata, accept only a clear, narrow barrel tip.
        def section_size(edge):
            section = [p for p in points if abs(p[axis] - edge) <= length * 0.15]
            section_low, section_high = bounds(section)
            return max(section_high[2] - section_low[2], section_high[1 - axis] - section_low[1 - axis])

        rear, tip = section_size(low[axis]), section_size(high[axis])
        if max(rear, tip) < 1.6 * min(rear, tip) or rear == tip:
            raise FitError("no authored muzzle and neither end is clearly the barrel tip")
        front = 1 if tip < rear else -1

    edge = high[axis] if front > 0 else low[axis]
    tip_low, tip_high = bounds([p for p in points if abs(p[axis] - edge) <= min(1.0, length * 0.05)])
    origin = scale(add(tip_low, tip_high), 0.5)
    origin[axis] = edge
    angles = angle_matrix(0, (0 if front > 0 else 180) if axis == 0 else 90 * front, 0)
    tip_size = sub(tip_high, tip_low)
    return origin, angles, (length, lengths[1 - axis], lengths[2]), (tip_size[1 - axis], tip_size[2])


def legacy_world_fields(info):
    view_path = find_model(info.get("handsModel") or info["viewmodel"])
    world_path = find_model(info["worldmodel"])
    view, world = mdl_pose.Model(view_path), mdl_pose.Model(world_path)
    idle, world_idle = info["idle"], first_sequence(world)
    view_muzzle, view_axes = bone_frame(attachment_point(view, info["muzzle"], info["muzzleIndex"], idle))
    world_bone = None
    try:
        world_origin, world_axes = bone_frame(attachment_point(world, "muzzle", info["worldMuzzleIndex"], world_idle))
    except FitError:
        root = world.bones[0]
        world_bone = root["name"]
        try:
            world_origin, world_axes = bone_frame(world.sample(world_idle, world_bone, 1)[0])
        except (mdl_pose.MdlError, IndexError, struct.error):
            # Static props can have an empty animation. posed_vertices also uses their bind pose.
            world_origin, world_axes = root["pos"], list(zip(*mdl_pose.quat_matrix(root["quat"])))

    initialize = re.search(r"^function SWEP:IndividualInitialize\(\).*?^end", info["code"], re.M | re.S)
    bodygroups = {
        int(group): int(value)
        for group, value in re.findall(r"self:setBodygroup\(\s*(\d+)\s*,\s*(\d+)\s*\)",
            initialize[0] if initialize else "")
    }
    view_tip, view_barrel, view_dimensions, view_tip_size = barrel_frame(
        legacy_vertices(view_path, view, idle, True, bodygroups), view_muzzle,
    )
    world_tip, world_barrel, world_dimensions, world_tip_size = barrel_frame(
        legacy_vertices(world_path, world, world_idle, False), world_origin if world_bone is None else None,
    )
    length, width, height = [b / max(a, 1e-6) for a, b in zip(view_dimensions, world_dimensions)]
    model_scale = length
    if min(abs(width - length), abs(height - length)) > length * 0.25:
        # A stock or handguard variant changes the overall length. A matching narrow muzzle can still size the mount.
        ratios = [b / max(a, 1e-6) for a, b in zip(view_tip_size, world_tip_size)]
        if (min(*view_tip_size, *world_tip_size) < 0.1
                or max(view_tip_size) > view_dimensions[0] * 0.15
                or max(world_tip_size) > world_dimensions[0] * 0.15
                or min(ratios) < max(ratios) * 0.8):
            raise FitError("mesh sizes disagree (length %.2f, width %.2f, height %.2f)" % (length, width, height))
        model_scale = sum(ratios) / len(ratios)
    if not 0.55 <= model_scale <= 1.65:
        raise FitError("implausible model scale %.2f" % model_scale)

    def turn(vector):
        return rotate(world_barrel, unrotate(view_barrel, vector))

    # Map from the viewmodel attachment frame into the live world attachment or bone frame.
    shift = unrotate(world_axes, sub(add(world_tip, scale(turn(sub(view_muzzle, view_tip)), model_scale)), world_origin))
    angles = matrix_angle([unrotate(world_axes, turn(column)) for column in view_axes])
    fields = ["SWEP.WorldAttachmentScale = %s" % format_number(round(model_scale, 3))]
    if world_bone:
        fields.append('SWEP.WorldAttachmentBone = "%s"' % world_bone)
    if math.dist(shift, (0, 0, 0)) >= 0.1:
        fields.append("SWEP.WorldAttachmentShift = " + format_triple("Vector", [round(value, 2) for value in shift]))
    if math.dist(angles, (0, 0, 0)) >= 0.1:
        fields.append("SWEP.WorldAttachmentAngle = " + format_triple("Angle", [round(value, 2) for value in angles]))
    return fields


def write_world_fields(info, lines):
    text = info["text"]
    text = re.sub(r"^[ \t]*SWEP\.WorldAttachment(?:Scale|Shift|Angle|Bone)\s*=.*\n", "", text, flags=re.M)
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


def fitted_hand_models():
    path = REPO_ROOT / "lua/cotz_weapon_chands/sh_rigged_models.lua"
    return dict(re.findall(r'\["(models/[^"]+)"\]\s*=\s*{\s*model\s*=\s*"([^"]+)"', path.read_text()))


def command_legacy_world(classes, write):
    hands = (REPO_ROOT / "lua/cotz_weapon_chands/sh_definitions.lua").read_text(encoding="utf-8")
    hands_models = dict(re.findall(r'\["(cw_\w+)"\]\s*=\s*{\s*model\s*=\s*"([^"]+)"', hands))
    fitted = fitted_hand_models()
    for weapon_class in classes:
        info = weapon_info(weapon_class)
        if not info["viewmodel"] or "models/flaymi/anomaly/" in info["viewmodel"] or not attachment_bones(info):
            continue
        info["handsModel"] = hands_models.get(weapon_class)
        if info["handsModel"] in fitted:
            model = fitted[info["handsModel"]]
            if (REPO_ROOT.parent / "cotz_general" / model).is_file():
                info["handsModel"] = model
        try:
            fields = legacy_world_fields(info)
        except (FitError, mdl_pose.MdlError, struct.error, OSError, IndexError) as error:
            print("%-18s skipped: %s" % (weapon_class, error))
            continue

        print("%-18s %s" % (weapon_class, "; ".join(fields)))
        if write:
            write_world_fields(info, fields)


# ---- fallback poses ----

POSE_ENTRY = re.compile(r"^(\t\t\t)(\w+) = \{([^}]*)\},$")


def read_fallback_poses(text):
    """Models and per-weapon entries of weapon_attachment_poses.lua, with each value list's line number."""
    lines = text.split("\n")
    models, weapons, current = {}, {}, None
    for number, line in enumerate(lines):
        model = re.match(r'^\t\t(\w+) = "([^"]+)",$', line)
        start = re.match(r"^\t\t(\w+) = \{$", line)
        bone = re.match(r'^\t\t\tbone = "([^"]+)",$', line)
        values = POSE_ENTRY.match(line)
        if model:
            models[model.group(1)] = model.group(2)
        elif start:
            current = weapons[start.group(1)] = {"bone": None, "items": {}}
        elif bone and current:
            current["bone"] = bone.group(1)
        elif values and current:
            current["items"][values.group(2)] = {
                "line": number, "values": [float(value) for value in values.group(3).split(",")],
            }
    return models, weapons


def write_fallback_values(text, changes):
    """Replace the value lists of changed entries, keeping every other line as it was."""
    lines = text.split("\n")
    for number, values in changes.items():
        match = POSE_ENTRY.match(lines[number])
        numbers = ", ".join(format_number(round(value, 3)) for value in values)
        lines[number] = "%s%s = {%s}," % (match.group(1), match.group(2), numbers)
    return "\n".join(lines)


def resolved_weapon_info(weapon_class):
    """weapon_info, filling the viewmodel and idle animation from SWEP.Base where the class inherits them."""
    info = weapon_info(weapon_class)
    info["codes"] = [info["code"]]
    seen, current = {weapon_class}, info
    while not (info["viewmodel"] and info["idle"]):
        base = re.search(r'^[ \t]*SWEP\.Base\s*=\s*"([^"]+)"', current["code"], re.M)
        if not base or base.group(1) in seen:
            break
        seen.add(base.group(1))
        try:
            current = weapon_info(base.group(1))
        except FitError:
            break
        info["codes"].append(current["code"])
        info["viewmodel"] = info["viewmodel"] or current["viewmodel"]
        info["idle"] = info["idle"] or current["idle"]
        info["flipped"] = info["flipped"] or current["flipped"]
    return info


def startup_bodygroups(codes):
    """Bodygroups a weapon sets in IndividualInitialize or IndividualThink, such as a longer barrel or a rail."""
    groups = {}
    for code in codes:
        tables = {
            name: {key: int(value) for key, value in re.findall(r"(\w+)\s*=\s*(\d+)", body)}
            for name, body in re.findall(r"^[ \t]*SWEP\.(\w+)\s*=\s*\{([^}]*)\}", code, re.M)
        }

        def resolve(token):
            if token.isdigit():
                return int(token)
            field = re.fullmatch(r"self\.(\w+)\.(\w+)", token)
            return field and tables.get(field.group(1), {}).get(field.group(2))

        for body in re.findall(r"^function SWEP:Individual(?:Initialize|Think)\(\).*?^end", code, re.M | re.S):
            for group, value in re.findall(r"self:setBodygroup\(\s*([\w.]+)\s*,\s*([\w.]+)\s*\)", body):
                group, value = resolve(group), resolve(value)
                if group is not None and value is not None:
                    groups.setdefault(group, value)
    return groups


def gun_faces(path, model, sequence, bodygroups):
    """Posed triangles of the visible gun, without the arms and hands."""
    vertices = mdl_pose.posed_vertices(str(path), sequence)
    data = path.with_suffix(".vvd").read_bytes()
    start = struct.unpack_from("<i", data, 56)[0]
    gun = {index for index, bone in enumerate(model.bones) if not ARM_BONE.search(bone["name"].lower())}

    def on_gun(index):
        return index < len(vertices) and data[start + index * 48 + 12] in gun

    return [[vertices[index] for index in face] for face in mdl_pose.triangles(str(path), bodygroups)
        if all(on_gun(index) for index in face)]


def placed_box(frame, values, extent):
    """Model origin, scaled axes and bounding box of a placed attachment model in viewmodel space."""
    world, rotation = cw_to_world(frame, values[0:3], values[3:6])
    axes = [scale(rotation[axis], values[6 + axis]) for axis in range(3)]
    corners = [[(extent["min"], extent["max"])[(corner >> axis) & 1][axis] for axis in range(3)] for corner in range(8)]
    points = [add(world, add(add(scale(axes[0], c[0]), scale(axes[1], c[1])), scale(axes[2], c[2]))) for c in corners]
    return world, axes, bounds(points)


class SurfaceProfile:
    """Top height of the gun's main body along a line of sight at a fixed lateral offset, every SURFACE_STEP."""

    def __init__(self, faces, y):
        band = [face for face in faces if min(v[1] for v in face) <= y <= max(v[1] for v in face)]
        self.start = min((v[0] for face in band for v in face), default=0.0)
        end = max((v[0] for face in band for v in face), default=0.0)
        tops = []
        for step in range(int((end - self.start) / SURFACE_STEP) + 1):
            x = self.start + step * SURFACE_STEP
            column = [face for face in band if min(v[0] for v in face) <= x <= max(v[0] for v in face)]
            hits = mdl_pose._ray_hits(column, x, y)
            tops.append(max(hits) if hits else None)
        self.tops = [None] * len(tops)
        first, last = main_stretch(tops)
        self.tops[first:last + 1] = tops[first:last + 1]

    def mount(self, low, high):
        """Coverage and flatness of the gun's top under a mount spanning low..high."""
        first = math.ceil((low - self.start) / SURFACE_STEP)
        last = math.floor((high - self.start) / SURFACE_STEP)
        inside = range(max(first, 0), min(last, len(self.tops) - 1) + 1)
        tops = [self.tops[index] for index in inside if self.tops[index] is not None]
        if not tops:
            return 0.0, None
        return len(tops) / max(1, last - first + 1), max(tops) - min(tops)

    def misses(self, low, high):
        return self.mount(low, high)[0] < MISPLACED_COVERAGE

    def supports(self, low, high):
        coverage, flatness = self.mount(low, high)
        return coverage >= MOUNT_COVERAGE and flatness <= FLAT_TOLERANCE


def main_stretch(tops):
    """Indices of the longest run of samples that hit the gun, bridging gaps up to SURFACE_GAP."""
    best, start, misses = (0, -1), None, 0
    for index, top in enumerate(tops + [None] * (int(SURFACE_GAP / SURFACE_STEP) + 1)):
        if top is not None:
            start = index if start is None else start
            misses = 0
            if index - start > best[1] - best[0]:
                best = (start, index)
        elif start is not None:
            misses += 1
            if misses * SURFACE_STEP > SURFACE_GAP:
                start, misses = None, 0
    return best


def mount_span(box):
    middle, length = (box[0][0] + box[1][0]) / 2, box[1][0] - box[0][0]
    return middle - length * MOUNT_SHARE / 2, middle + length * MOUNT_SHARE / 2


def nearest_mount(profile, box):
    """Forward shift that puts the sight's mount on the nearest supported stretch of the gun, or None."""
    low, high = mount_span(box)
    end = profile.start + len(profile.tops) * SURFACE_STEP
    reach = max(end - low, high - profile.start, 0.0)
    for step in range(int(reach / SURFACE_STEP) + 1):
        for shift in (step * SURFACE_STEP, -step * SURFACE_STEP):
            if profile.supports(low + shift, high + shift):
                return shift
    return None


def barrel_tip(faces, box):
    """Front of the gun inside a suppressor's bore, from the suppressor's placed bounding box."""
    center = [(box[0][axis] + box[1][axis]) / 2 for axis in range(3)]
    radius = min(box[1][1] - box[0][1], box[1][2] - box[0][2]) / 2
    tips = [v[0] for face in faces for v in face
        if (v[1] - center[1]) ** 2 + (v[2] - center[2]) ** 2 <= radius ** 2 and v[0] <= box[1][0]]
    return max(tips, default=None)


def bone_delta(frame, delta):
    """A viewmodel-space translation as a change of CW's bone-relative pos (forward, right, up)."""
    matrix = frame[1]
    return [dot(delta, matrix[0]), -dot(delta, matrix[1]), dot(delta, matrix[2])]


def fit_fallback(weapon_class, entry, models):
    """New value lists for misplaced fallback sights and suppressors of one weapon, and a report line for each."""
    info = resolved_weapon_info(weapon_class)
    if not (info["viewmodel"] and info["idle"]):
        raise FitError("needs a ViewModel and an idle animation")
    path = find_model(info["viewmodel"])
    model = mdl_pose.Model(path)
    try:
        model.bone_index(entry["bone"])
    except mdl_pose.MdlError:
        raise FitError("viewmodel has no %s bone (profile skips this model)" % entry["bone"])
    frame = bone_frame(model.sample(info["idle"], entry["bone"], 1)[0])
    faces = gun_faces(path, model, info["idle"], startup_bodygroups(info["codes"]))
    if not faces:
        raise FitError("no gun geometry")

    changes, notes, profiles = {}, [], {}
    for item_id, item in sorted(entry["items"].items()):
        values = item["values"]
        model_path = find_model(models[item_id])
        world, axes, box = placed_box(frame, values, mdl_pose.mesh_bounds(str(model_path)))
        if item_id in FALLBACK_SUPPRESSORS:
            tip = barrel_tip(faces, box)
            if tip is None or box[0][0] - tip <= SUPPRESSOR_GAP:
                continue
            delta = [tip - SUPPRESSOR_OVERLAP - box[0][0], 0.0, 0.0]
            notes.append("%s back %.2f to the barrel" % (item_id, -delta[0]))
        elif len(values) == 12 and item_id not in SIDE_MOUNTS:
            line = round((box[0][1] + box[1][1]) / 2, 1)
            profile = profiles.get(line) or profiles.setdefault(line, SurfaceProfile(faces, line))
            if not profile.misses(*mount_span(box)):
                continue
            shift = nearest_mount(profile, box)
            if shift is None:
                notes.append("%s: no flat mount along its line of sight" % item_id)
                continue
            moved = add(world, [shift, 0.0, 0.0])
            clearance = mdl_pose.face_clearances(faces, [{"model": str(model_path), "origin": moved, "axes": axes}])[0]
            if clearance is None:
                notes.append("%s: could not seat on the gun" % item_id)
                continue
            delta = [shift, 0.0, -clearance]
            if math.hypot(*delta) < MIN_SIGHT_MOVE:
                continue
            notes.append("%s %+.2f forward, %+.2f up" % (item_id, delta[0], delta[2]))
        else:
            continue

        moved = list(values)
        moved[0:3] = add(values[0:3], bone_delta(frame, delta))
        if len(values) == 12:
            # Fallback aims have no angle, so the eye line follows the lens straight up or down. Moving the
            # sight forward keeps the ironsight-relative eye relief the aim was built with.
            moved[11] = values[11] - delta[2]
        changes[item["line"]] = moved
    return changes, notes


def command_fallback(classes, write):
    text = FALLBACK_POSES.read_text(encoding="utf-8")
    models, weapons = read_fallback_poses(text)
    changes = {}
    for weapon_class in classes:
        entry = weapons.get(weapon_class)
        if not entry or not entry["items"]:
            continue
        try:
            fitted, notes = fit_fallback(weapon_class, entry, models)
        except (FitError, mdl_pose.MdlError, struct.error, OSError, IndexError, KeyError) as error:
            print("%-36s skipped: %s" % (weapon_class, error))
            continue
        changes.update(fitted)
        for note in notes:
            print("%-36s %s" % (weapon_class, note))
    print("%d fallback placements to change" % len(changes))
    if write and changes:
        FALLBACK_POSES.write_text(write_fallback_values(text, changes), encoding="utf-8")


def main(argv=None):
    parser = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    commands = parser.add_subparsers(dest="command", required=True)
    for name in ("bones", "world", "legacy-world", "fallback"):
        sub_parser = commands.add_parser(name)
        sub_parser.add_argument("classes", nargs="+")
        if name in ("world", "legacy-world", "fallback"):
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
        elif args.command == "fallback":
            every = sorted(read_fallback_poses(FALLBACK_POSES.read_text(encoding="utf-8"))[1])
            command_fallback(every if args.classes == ["all"] else args.classes, args.write)
        else:
            classes = all_classes() if args.classes == ["all"] else args.classes
            if args.command == "bones":
                command_bones(classes)
            elif args.command == "legacy-world":
                command_legacy_world(classes, args.write)
            else:
                command_world(classes, args.write, args.classes != ["all"])
    except (FitError, mdl_pose.MdlError) as error:
        print("error: %s" % error, file=sys.stderr)
        return 1
    return 0


if __name__ == "__main__":
    sys.exit(main())
