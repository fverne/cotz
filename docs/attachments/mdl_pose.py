"""Sample bone matrices from a Source .mdl animation without running the game.

Usage:
    python3 docs/attachments/mdl_pose.py MODEL.mdl SEQUENCE BONE [--samples 16]

Prints a JSON list (or a Lua table with --format lua) of bone matrices in model space, one per evenly spaced cycle, matching what
ClientsideModel:SetCycle + GetBoneMatrix return for a model at the origin. Each matrix has `pos` and the
`forward`, `left` and `up` axes. Supports MDL versions 44-49 with animations stored in the .mdl itself.
"""

import argparse
import json
import math
import struct
import sys

BONE_SIZE = 216
ANIMDESC_SIZE = 100
SEQDESC_SIZE = 212

ANIM_RAWPOS = 0x01
ANIM_RAWROT = 0x02
ANIM_ANIMPOS = 0x04
ANIM_ANIMROT = 0x08
ANIM_DELTA = 0x10
ANIM_RAWROT2 = 0x20


class MdlError(Exception):
    pass


def _cstring(data, offset):
    return data[offset:data.index(b"\0", offset)].decode("latin-1")


def _half(bits):
    return struct.unpack("<e", struct.pack("<H", bits))[0]


def quat_from_euler(x, y, z):
    sy, cy = math.sin(z * 0.5), math.cos(z * 0.5)
    sp, cp = math.sin(y * 0.5), math.cos(y * 0.5)
    sr, cr = math.sin(x * 0.5), math.cos(x * 0.5)
    return (
        sr * cp * cy - cr * sp * sy,
        cr * sp * cy + sr * cp * sy,
        cr * cp * sy - sr * sp * cy,
        cr * cp * cy + sr * sp * sy,
    )


def quat_matrix(q):
    x, y, z, w = q
    return [
        [1 - 2 * y * y - 2 * z * z, 2 * x * y - 2 * w * z, 2 * x * z + 2 * w * y],
        [2 * x * y + 2 * w * z, 1 - 2 * x * x - 2 * z * z, 2 * y * z - 2 * w * x],
        [2 * x * z - 2 * w * y, 2 * y * z + 2 * w * x, 1 - 2 * x * x - 2 * y * y],
    ]


def quat_blend(a, b, t):
    if sum(i * j for i, j in zip(a, b)) < 0:
        b = tuple(-v for v in b)
    q = tuple(i * (1 - t) + j * t for i, j in zip(a, b))
    length = math.sqrt(sum(v * v for v in q)) or 1
    return tuple(v / length for v in q)


class Model:
    def __init__(self, path):
        with open(path, "rb") as handle:
            self.data = data = handle.read()
        if data[:4] != b"IDST":
            raise MdlError("%s is not a studio model" % path)
        self.version = struct.unpack_from("<i", data, 4)[0]
        if not 44 <= self.version <= 49:
            raise MdlError("unsupported MDL version %d" % self.version)

        count, index = struct.unpack_from("<ii", data, 156)
        self.bones = []
        for number in range(count):
            base = index + number * BONE_SIZE
            name_index, parent = struct.unpack_from("<ii", data, base)
            self.bones.append({
                "name": _cstring(data, base + name_index),
                "parent": parent,
                "pos": struct.unpack_from("<3f", data, base + 32),
                "quat": struct.unpack_from("<4f", data, base + 44),
                "rot": struct.unpack_from("<3f", data, base + 60),
                "posscale": struct.unpack_from("<3f", data, base + 72),
                "rotscale": struct.unpack_from("<3f", data, base + 84),
                # Rows of the model-space to bone-space bind matrix the vertices are skinned with.
                "pose_to_bone": [struct.unpack_from("<4f", data, base + 96 + row * 16) for row in range(3)],
            })

        count, index = struct.unpack_from("<ii", data, 240)
        self.attachments = []
        for number in range(count):
            base = index + number * 92
            name_index, _, bone = struct.unpack_from("<iIi", data, base)
            rows = [struct.unpack_from("<4f", data, base + 12 + row * 16) for row in range(3)]
            self.attachments.append({"name": _cstring(data, base + name_index), "bone": bone, "rows": rows})

        self.anim_count, self.anim_index, seq_count, seq_index = struct.unpack_from("<iiii", data, 180)
        self.sequences = {}
        for number in range(seq_count):
            base = seq_index + number * SEQDESC_SIZE
            label = _cstring(data, base + struct.unpack_from("<i", data, base + 4)[0])
            anim_index_index = struct.unpack_from("<i", data, base + 60)[0]
            self.sequences[label.lower()] = struct.unpack_from("<h", data, base + anim_index_index)[0]

    def bone_index(self, name):
        for number, bone in enumerate(self.bones):
            if bone["name"].lower() == name.lower():
                return number
        raise MdlError("no bone named %s" % name)

    def _anim(self, number):
        base = self.anim_index + number * ANIMDESC_SIZE
        data = self.data
        frames = struct.unpack_from("<i", data, base + 16)[0]
        block, index = struct.unpack_from("<ii", data, base + 52)
        section_index, section_frames = struct.unpack_from("<ii", data, base + 80)
        return {"base": base, "frames": max(frames, 1), "block": block, "index": index,
            "section_index": section_index, "section_frames": section_frames}

    def _anim_data(self, anim, frame):
        """Return (offset of the first mstudioanim_t, frame within that block)."""
        block, index = anim["block"], anim["index"]
        if anim["section_frames"]:
            frames, per = anim["frames"], anim["section_frames"]
            if frames > per and frame == frames - 1:
                section, frame = frames // per + 1, 0
            else:
                section = frame // per
                frame -= section * per
            block, index = struct.unpack_from("<ii", self.data, anim["base"] + anim["section_index"] + section * 8)
        if block != 0:
            raise MdlError("animation data stored in an external .ani block")
        return anim["base"] + index, frame

    def _value(self, pointer, frame, scale):
        """ExtractAnimValue over run-length encoded mstudioanimvalue_t entries."""
        data = self.data
        k = frame
        while True:
            valid, total = data[pointer], data[pointer + 1]
            if total == 0:
                return 0.0
            if total > k:
                break
            k -= total
            pointer += (valid + 1) * 2
        slot = k + 1 if valid > k else valid
        return struct.unpack_from("<h", data, pointer + slot * 2)[0] * scale

    def _value_triplet(self, pointer, frame, scales):
        offsets = struct.unpack_from("<3h", self.data, pointer)
        return [self._value(pointer + offset, frame, scales[axis]) if offset else 0.0
            for axis, offset in enumerate(offsets)]

    def local_pose(self, anim_number, frame):
        """Bone-local (quaternion, position) pairs for one integer frame."""
        anim = self._anim(anim_number)
        frame = max(0, min(frame, anim["frames"] - 1))
        pose = [(bone["quat"], bone["pos"]) for bone in self.bones]
        data = self.data
        pointer, local_frame = self._anim_data(anim, frame)
        while True:
            bone_number, flags, next_offset = struct.unpack_from("<BBh", data, pointer)
            bone = self.bones[bone_number]
            cursor = pointer + 4
            delta = flags & ANIM_DELTA

            if flags & ANIM_RAWROT:
                x, y, zw = struct.unpack_from("<HHH", data, cursor)
                qx, qy, qz = (x - 32768) / 32768.0, (y - 32768) / 32768.0, ((zw & 0x7FFF) - 16384) / 16384.0
                qw = math.sqrt(max(0.0, 1 - qx * qx - qy * qy - qz * qz)) * (-1 if zw & 0x8000 else 1)
                quat = (qx, qy, qz, qw)
                cursor += 6
            elif flags & ANIM_RAWROT2:
                packed = struct.unpack_from("<Q", data, cursor)[0]
                qx = ((packed & 0x1FFFFF) - 1048576) / 1048576.5
                qy = (((packed >> 21) & 0x1FFFFF) - 1048576) / 1048576.5
                qz = (((packed >> 42) & 0x1FFFFF) - 1048576) / 1048576.5
                qw = math.sqrt(max(0.0, 1 - qx * qx - qy * qy - qz * qz)) * (-1 if packed >> 63 else 1)
                quat = (qx, qy, qz, qw)
                cursor += 8
            elif flags & ANIM_ANIMROT:
                angles = self._value_triplet(cursor, local_frame, bone["rotscale"])
                if not delta:
                    angles = [angle + base for angle, base in zip(angles, bone["rot"])]
                quat = quat_from_euler(*angles)
                cursor += 6
            else:
                quat = (0.0, 0.0, 0.0, 1.0) if delta else bone["quat"]

            if flags & ANIM_RAWPOS:
                pos = tuple(_half(bits) for bits in struct.unpack_from("<3H", data, cursor))
            elif flags & ANIM_ANIMPOS:
                pos = self._value_triplet(cursor, local_frame, bone["posscale"])
                if not delta:
                    pos = tuple(value + base for value, base in zip(pos, bone["pos"]))
            else:
                pos = (0.0, 0.0, 0.0) if delta else bone["pos"]

            pose[bone_number] = (tuple(quat), tuple(pos))
            if next_offset == 0:
                break
            pointer += next_offset
        return pose

    def attachment(self, name):
        """Find an attachment by name, or by its 1-based index as CW numbers them."""
        for attachment in self.attachments:
            if attachment["name"].lower() == str(name).lower():
                return attachment
        if str(name).isdigit() and 0 < int(name) <= len(self.attachments):
            return self.attachments[int(name) - 1]
        raise MdlError("no attachment named %s" % name)

    def sample_attachment(self, sequence, name, count=16):
        """Model-space matrices of an attachment point at evenly spaced cycles of a sequence."""
        attachment = self.attachment(name)
        rows = attachment["rows"]
        local = [[rows[r][c] for c in range(3)] for r in range(3)]
        offset = [rows[r][3] for r in range(3)]
        samples = []
        for bone in self.sample(sequence, self.bones[attachment["bone"]]["name"], count):
            axes = [bone["forward"], bone["left"], bone["up"]]
            rotation = [[axes[c][r] for c in range(3)] for r in range(3)]
            pos = [bone["pos"][r] + sum(rotation[r][k] * offset[k] for k in range(3)) for r in range(3)]
            combined = [[sum(rotation[r][k] * local[k][c] for k in range(3)) for c in range(3)] for r in range(3)]
            column = lambda c: [combined[r][c] for r in range(3)]
            samples.append({"pos": pos, "forward": column(0), "left": column(1), "up": column(2)})
        return samples

    def sample(self, sequence, bone_name, count=16):
        """Model-space matrices of one bone at `count` evenly spaced cycles of a sequence."""
        anim_number = self.sequences.get(sequence.lower())
        if anim_number is None:
            # Matches the placement tool, which falls back to sequence 0 like the engine.
            anim_number = next(iter(self.sequences.values()), None)
        if anim_number is None:
            raise MdlError("model has no sequences")
        target = self.bone_index(bone_name)
        frames = self._anim(anim_number)["frames"]
        samples = []
        for step in range(count):
            position = step / count * (frames - 1)
            first = int(math.floor(position))
            weight = position - first
            poses = (self.local_pose(anim_number, first), self.local_pose(anim_number, min(first + 1, frames - 1)))
            local = [(quat_blend(a[0], b[0], weight), tuple(i * (1 - weight) + j * weight for i, j in zip(a[1], b[1])))
                for a, b in zip(*poses)]
            samples.append(self._world(local, target))
        return samples

    def _world(self, local, target):
        chain = []
        number = target
        while number >= 0:
            chain.append(number)
            number = self.bones[number]["parent"]
        rotation = [[1, 0, 0], [0, 1, 0], [0, 0, 1]]
        translation = [0.0, 0.0, 0.0]
        for number in reversed(chain):
            quat, pos = local[number]
            child = quat_matrix(quat)
            translation = [translation[r] + sum(rotation[r][c] * pos[c] for c in range(3)) for r in range(3)]
            rotation = [[sum(rotation[r][k] * child[k][c] for k in range(3)) for c in range(3)] for r in range(3)]
        column = lambda c: [rotation[r][c] for r in range(3)]
        return {"pos": translation, "forward": column(0), "left": column(1), "up": column(2)}


def _rigid(quat, pos):
    return quat_matrix(quat), list(pos)


def _compose(parent, child):
    rotation = [[sum(parent[0][r][k] * child[0][k][c] for k in range(3)) for c in range(3)] for r in range(3)]
    translation = [parent[1][r] + sum(parent[0][r][k] * child[1][k] for k in range(3)) for r in range(3)]
    return rotation, translation


def _apply(transform, point):
    return [transform[1][r] + sum(transform[0][r][k] * point[k] for k in range(3)) for r in range(3)]


def _bind_inverse(bone):
    rows = bone["pose_to_bone"]
    return [[rows[r][c] for c in range(3)] for r in range(3)], [rows[r][3] for r in range(3)]


def _invert(transform):
    rotation = [[transform[0][c][r] for c in range(3)] for r in range(3)]
    return rotation, [-sum(rotation[r][k] * transform[1][k] for k in range(3)) for r in range(3)]


def posed_vertices(path, sequence=None):
    """LOD 0 vertex positions skinned to the first frame of a sequence (default: the first sequence)."""
    model = Model(path)
    anim = model.sequences.get((sequence or "").lower())
    if anim is None and model.sequences:
        anim = next(iter(model.sequences.values()))
    try:
        local = model.local_pose(anim, 0) if anim is not None else None
    except (IndexError, struct.error, MdlError):
        local = None
    rest, posed = [], []
    for number, bone in enumerate(model.bones):
        parent = bone["parent"]
        rest_local = _rigid(bone["quat"], bone["pos"])
        posed_local = _rigid(*local[number]) if local else rest_local
        rest.append(_compose(rest[parent], rest_local) if parent >= 0 else rest_local)
        posed.append(_compose(posed[parent], posed_local) if parent >= 0 else posed_local)
    skinning = [_compose(posed[number], _bind_inverse(model.bones[number])) for number in range(len(model.bones))]

    vvd = path[:-4] + ".vvd"
    with open(vvd, "rb") as handle:
        data = handle.read()
    if data[:4] != b"IDSV":
        raise MdlError("%s is not a vertex file" % vvd)
    count = struct.unpack_from("<i", data, 16)[0]
    start = struct.unpack_from("<i", data, 56)[0]
    vertices = []
    for index in range(count):
        base = start + index * 48
        weights = struct.unpack_from("<3f", data, base)
        bones = data[base + 12:base + 15]
        used = data[base + 15]
        position = struct.unpack_from("<3f", data, base + 16)
        point = [0.0, 0.0, 0.0]
        total = 0.0
        for slot in range(max(1, min(used, 3))):
            if bones[slot] < len(skinning):
                moved = _apply(skinning[bones[slot]], position)
                point = [a + b * weights[slot] for a, b in zip(point, moved)]
                total += weights[slot]
        vertices.append([value / total for value in point] if total > 0 else list(position))
    return vertices


def triangles(path):
    """LOD 0 triangles of each body part's default model as vertex index triplets, from the .dx90.vtx."""
    with open(path, "rb") as handle:
        mdl = handle.read()
    vtx_path = path[:-4] + ".dx90.vtx"
    with open(vtx_path, "rb") as handle:
        vtx = handle.read()
    body_count, body_index = struct.unpack_from("<ii", mdl, 232)
    vtx_bodies, vtx_body_offset = struct.unpack_from("<ii", vtx, 28)
    result = []
    for body in range(min(body_count, vtx_bodies)):
        mdl_body = body_index + body * 16
        model_count, _, model_index = struct.unpack_from("<iii", mdl_body and mdl or mdl, mdl_body + 4)
        vtx_body = vtx_body_offset + body * 8
        vtx_models, vtx_model_offset = struct.unpack_from("<ii", vtx, vtx_body)
        if model_count < 1 or vtx_models < 1:
            continue
        # Only the default (first) model of each body part is drawn without bodygroup changes.
        mdl_model = mdl_body + model_index
        mesh_count, mesh_index, _, vertex_index = struct.unpack_from("<iiii", mdl, mdl_model + 72)
        vtx_model = vtx_body + vtx_model_offset
        lod_count, lod_offset = struct.unpack_from("<ii", vtx, vtx_model)
        vtx_lod = vtx_model + lod_offset
        vtx_meshes, vtx_mesh_offset = struct.unpack_from("<ii", vtx, vtx_lod)
        for mesh in range(min(mesh_count, vtx_meshes)):
            mdl_mesh = mdl_model + mesh_index + mesh * 116
            mesh_vertex_offset = struct.unpack_from("<i", mdl, mdl_mesh + 12)[0]
            base = vertex_index // 48 + mesh_vertex_offset
            vtx_mesh = vtx_lod + vtx_mesh_offset + mesh * 9
            group_count, group_offset = struct.unpack_from("<ii", vtx, vtx_mesh)
            for group in range(group_count):
                vtx_group = vtx_mesh + group_offset + group * 25
                vert_count, vert_offset, index_count, index_offset = struct.unpack_from("<iiii", vtx, vtx_group)
                originals = [struct.unpack_from("<H", vtx, vtx_group + vert_offset + vert * 9 + 4)[0]
                    for vert in range(vert_count)]
                indices = struct.unpack_from("<%dH" % index_count, vtx, vtx_group + index_offset)
                for start in range(0, index_count - 2, 3):
                    result.append(tuple(base + originals[indices[start + k]] for k in range(3)))
    return result


def surface_heights(path, sequence, windows, step=0.2):
    """Top surface height under each window {x0, x1, y, half_width}. Rays cast down at points along the
    window's centre line hit the model's triangles; the median of the highest hits ignores short posts such
    as iron sights."""
    vertices = posed_vertices(path, sequence)
    faces = [[vertices[index] for index in face] for face in triangles(path)
        if max(face) < len(vertices)]
    heights = []
    for window in windows:
        y = window["y"]
        nearby = [face for face in faces
            if min(v[0] for v in face) <= window["x1"] and max(v[0] for v in face) >= window["x0"]
            and min(v[1] for v in face) <= y <= max(v[1] for v in face)]
        tops = []
        x = window["x0"]
        while x <= window["x1"]:
            best = None
            for a, b, c in nearby:
                denominator = (b[1] - c[1]) * (a[0] - c[0]) + (c[0] - b[0]) * (a[1] - c[1])
                if abs(denominator) < 1e-9:
                    continue
                u = ((b[1] - c[1]) * (x - c[0]) + (c[0] - b[0]) * (y - c[1])) / denominator
                v = ((c[1] - a[1]) * (x - c[0]) + (a[0] - c[0]) * (y - c[1])) / denominator
                if u < -1e-6 or v < -1e-6 or u + v > 1 + 1e-6:
                    continue
                z = u * a[2] + v * b[2] + (1 - u - v) * c[2]
                best = z if best is None else max(best, z)
            if best is not None:
                tops.append(best)
            x += step
        tops.sort()
        heights.append(tops[len(tops) // 2] if tops else None)
    return heights


def _ray_hits(faces, x, y):
    """Heights where a vertical line at (x, y) crosses the given triangles."""
    hits = []
    for a, b, c in faces:
        denominator = (b[1] - c[1]) * (a[0] - c[0]) + (c[0] - b[0]) * (a[1] - c[1])
        if abs(denominator) < 1e-9:
            continue
        u = ((b[1] - c[1]) * (x - c[0]) + (c[0] - b[0]) * (y - c[1])) / denominator
        v = ((c[1] - a[1]) * (x - c[0]) + (a[0] - c[0]) * (y - c[1])) / denominator
        if u < -1e-6 or v < -1e-6 or u + v > 1 + 1e-6:
            continue
        hits.append(u * a[2] + v * b[2] + (1 - u - v) * c[2])
    return hits


def _placed_faces(sight):
    """Triangles of a placed mesh; `min_model_z` drops parts lying wholly below that model-space height."""
    local = posed_vertices(sight["model"])
    origin, axes = sight["origin"], sight["axes"]
    floor = sight.get("min_model_z")
    moved = [[origin[r] + axes[0][r] * v[0] + axes[1][r] * v[1] + axes[2][r] * v[2] for r in range(3)] for v in local]
    return [[moved[index] for index in face] for face in triangles(sight["model"]) if max(face) < len(moved)
        and (floor is None or max(local[index][2] for index in face) >= floor)]


def contact_clearances(gun_path, sequence, sights, step=0.1, strip=0.2, contact_share=0.15, extras=()):
    """Vertical clearance between each placed sight's underside and the gun's top surface.

    Each sight is {model, origin, axes}: its mesh is posed by its first sequence and moved into viewmodel
    space as origin + axes[0] * x + axes[1] * y + axes[2] * z (axes include the scale). Rays on a grid under
    the sight find its lowest surface and the gun's highest surface at the same point; the smallest gap is
    how far the sight can move down before it touches the gun. Rays stay within `strip` of the sight's centre
    line, where a clamp's channel meets the rail top: clamp jaws hook under the rail's lips at the sides and
    would otherwise read as a collision. The clearance is the `contact_share` quantile of the per-ray gaps,
    so narrow features such as a recoil lug dropping into a rail slot, or an iron sight post under a long
    scope, do not hold the sight up. None means no overlapping surfaces.
    """
    gun_vertices = posed_vertices(gun_path, sequence)
    gun_faces = [[gun_vertices[index] for index in face] for face in triangles(gun_path) if max(face) < len(gun_vertices)]
    # Placed mounts (rail adapters, spacers) count as part of the gun's surface.
    for extra in extras:
        gun_faces += _placed_faces(extra)
    results = []
    for sight in sights:
        faces = _placed_faces(sight)
        if not faces:
            results.append(None)
            continue
        low = [min(v[k] for f in faces for v in f) for k in range(3)]
        high = [max(v[k] for f in faces for v in f) for k in range(3)]
        nearby = [face for face in gun_faces
            if min(v[0] for v in face) <= high[0] and max(v[0] for v in face) >= low[0]
            and min(v[1] for v in face) <= high[1] and max(v[1] for v in face) >= low[1]]
        gaps = []
        x = low[0] + step / 2
        while x < high[0]:
            column = [face for face in faces if min(v[0] for v in face) <= x <= max(v[0] for v in face)]
            gun_column = [face for face in nearby if min(v[0] for v in face) <= x <= max(v[0] for v in face)]
            middle = (low[1] + high[1]) / 2
            y = middle - strip
            while y <= middle + strip + 1e-9:
                under = _ray_hits(column, x, y)
                top = _ray_hits(gun_column, x, y)
                if under and top:
                    gaps.append(min(under) - max(top))
                y += step
            x += step
        gaps.sort()
        results.append(gaps[int(len(gaps) * contact_share)] if gaps else None)
    return results


def mount_widths(path, sequence, sites):
    """Measure receiver width just below each mount's seating surface in the idle pose.

    Each site holds (x, y, z) at a mount's center. Horizontal slices below the top hit the
    receiver shoulder while avoiding bevels, screw heads and rail lugs. Use the median of
    several slices; narrow posts and tangencies are common in the triangle mesh.
    """
    from statistics import median

    vertices = posed_vertices(path, sequence)
    faces = [[(vertices[index][0], vertices[index][2], vertices[index][1]) for index in face]
             for face in triangles(path) if max(face) < len(vertices)]
    widths = []
    for x, y, z in sites:
        nearby = [face for face in faces if min(v[0] for v in face) <= x + 0.6
                  and max(v[0] for v in face) >= x - 0.6
                  and min(v[1] for v in face) <= z + 0.15 and max(v[1] for v in face) >= z - 0.65]
        samples = []
        for offset in (-0.6, -0.3, 0, 0.3, 0.6):
            for depth in (0.15, 0.30, 0.50):
                hits = _ray_hits(nearby, x + offset, z - depth)
                left = [hit for hit in hits if y - 1.8 < hit < y - 0.20]
                right = [hit for hit in hits if y + 0.20 < hit < y + 1.8]
                if left and right:
                    samples.append(min(right) - max(left))
        widths.append(median(samples) if samples else None)
    return widths


def mesh_bounds(path):
    """Bounds of the LOD 0 vertices as rendered in the first sequence's first frame.

    Some attachment models rotate their root bone in that sequence, so raw .vvd positions can face a
    different way than the model does in game. Models whose animation cannot be read use the bind pose.
    """
    model = Model(path)
    rest, posed = [], []
    try:
        local = model.local_pose(next(iter(model.sequences.values())), 0) if model.sequences else None
    except (IndexError, struct.error, MdlError):
        local = None
    for number, bone in enumerate(model.bones):
        parent = bone["parent"]
        rest_local = _rigid(bone["quat"], bone["pos"])
        posed_local = _rigid(*local[number]) if local else rest_local
        rest.append(_compose(rest[parent], rest_local) if parent >= 0 else rest_local)
        posed.append(_compose(posed[parent], posed_local) if parent >= 0 else posed_local)
    skinning = [_compose(posed[number], _bind_inverse(model.bones[number])) for number in range(len(model.bones))]

    vvd = path[:-4] + ".vvd"
    with open(vvd, "rb") as handle:
        data = handle.read()
    if data[:4] != b"IDSV":
        raise MdlError("%s is not a vertex file" % vvd)
    count = struct.unpack_from("<i", data, 16)[0]
    start = struct.unpack_from("<i", data, 56)[0]
    low, high = [float("inf")] * 3, [float("-inf")] * 3
    for index in range(count):
        base = start + index * 48
        bone = data[base + 12]
        position = struct.unpack_from("<3f", data, base + 16)
        if bone < len(skinning):
            position = _apply(skinning[bone], position)
        low = [min(a, b) for a, b in zip(low, position)]
        high = [max(a, b) for a, b in zip(high, position)]
    return {"min": low, "max": high}


def to_lua(samples):
    """Format samples as a Lua table literal for the offline placement runner."""
    triple = lambda values: "{%s}" % ", ".join(repr(float(value)) for value in values)
    rows = ["{pos = %s, forward = %s, left = %s, up = %s}" % tuple(triple(sample[key])
        for key in ("pos", "forward", "left", "up")) for sample in samples]
    return "{" + ", ".join(rows) + "}"


def main(argv=None):
    parser = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument("model")
    parser.add_argument("sequence")
    parser.add_argument("bone")
    parser.add_argument("--samples", type=int, default=16)
    parser.add_argument("--format", choices=("json", "lua"), default="json")
    parser.add_argument("--attachment", action="store_true", help="treat BONE as an attachment name or index")
    parser.add_argument("--bounds", action="store_true", help="print the mesh bounds instead of a pose")
    parser.add_argument("--surface", metavar="JSON", help="print surface heights under windows [[x0, x1, y, w], ...]")
    parser.add_argument("--skin-bone", action="store_true", help="print the bone most vertices are skinned to")
    parser.add_argument("--contact", metavar="JSON",
        help='print clearances for placed sights [{"model": path, "origin": [...], "axes": [[...] x3]}, ...]')
    parser.add_argument("--mount-widths", metavar="JSON", help="measure width at each mount site [[x, y, z], ...]")
    args = parser.parse_args(argv)
    try:
        if args.skin_bone:
            model = Model(args.model)
            with open(args.model[:-4] + ".vvd", "rb") as handle:
                data = handle.read()
            count, start = struct.unpack_from("<i", data, 16)[0], struct.unpack_from("<i", data, 56)[0]
            counts = {}
            for index in range(count):
                bone = data[start + index * 48 + 12]
                counts[bone] = counts.get(bone, 0) + 1
            print(model.bones[max(counts, key=counts.get)]["name"] if counts else "")
            return 0
        if args.contact:
            request = json.loads(args.contact)
            if isinstance(request, dict):
                clearances = contact_clearances(args.model, args.sequence, request["sights"], extras=request.get("extras", []))
            else:
                clearances = contact_clearances(args.model, args.sequence, request)
            print(json.dumps(clearances) if args.format == "json" else
                "{" + ", ".join("false" if c is None else repr(c) for c in clearances) + "}")
            return 0
        if args.mount_widths:
            widths = mount_widths(args.model, args.sequence, json.loads(args.mount_widths))
            print(json.dumps(widths) if args.format == "json" else
                "{" + ", ".join("false" if width is None else repr(width) for width in widths) + "}")
            return 0
        if args.surface:
            windows = [{"x0": a, "x1": b, "y": c, "half_width": d} for a, b, c, d in json.loads(args.surface)]
            heights = surface_heights(args.model, args.sequence, windows)
            print(json.dumps(heights) if args.format == "json" else
                "{" + ", ".join("false" if h is None else repr(h) for h in heights) + "}")
            return 0
        if args.bounds:
            bounds = mesh_bounds(args.model)
            print(json.dumps(bounds) if args.format == "json" else
                "{min = {%s}, max = {%s}}" % (", ".join(map(repr, bounds["min"])), ", ".join(map(repr, bounds["max"]))))
            return 0
        model = Model(args.model)
        sampler = model.sample_attachment if args.attachment else model.sample
        samples = sampler(args.sequence, args.bone, args.samples)
        print(json.dumps(samples) if args.format == "json" else to_lua(samples))
    except (MdlError, OSError) as error:
        print("error: %s" % error, file=sys.stderr)
        return 1
    return 0


if __name__ == "__main__":
    sys.exit(main())
