"""Run from the repository root: python3 tests/weapon_grips_spec.py

Checks the c_hands grips against the installed viewmodels: every grip source bone must be evaluated by the
engine, and every converted arm must keep a plausible elbow. Skips when the content addon is not installed.
"""

import math
import re
import struct
import sys
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "docs" / "attachments"))

import mdl_pose  # noqa: E402
import weapon_fit  # noqa: E402

BONE_SIZE = 216
BONE_USED_BY_BONE_MERGE = 0x00040000
MIN_SEGMENT = 6  # Source units; a c_hands arm segment is about 11.

GRIPS = ROOT / "lua" / "cotz_weapon_chands" / "cl_grips.lua"
DEFINITIONS = ROOT / "lua" / "cotz_weapon_chands" / "sh_definitions.lua"


def read_grips():
    profiles = {}
    for path, body in re.findall(r'^\t\["(models/[^"]+)"\] = \{\n(.*?)^\t\},', GRIPS.read_text(), re.M | re.S):
        poses = {}
        for side, block in re.findall(r"^\t\t\t(left|right) = \{(.*?)^\t\t\t\},", body, re.M | re.S):
            for part, source, angle, pos in re.findall(
                    r'(\w+) = pose\("([^"]+)", Angle\(([^)]+)\)(?:, Vector\(([^)]+)\))?\)', block):
                angles = [float(v) for v in angle.split(",")]
                offset = [float(v) for v in pos.split(",")] if pos else [0, 0, 0]
                poses[side[0].upper(), part] = (source, angles, offset)
        profiles[path] = poses
    return profiles


def bone_flags(model):
    count, index = struct.unpack_from("<ii", model.data, 156)
    return [struct.unpack_from("<I", model.data, index + i * BONE_SIZE + 160)[0] for i in range(count)]


def evaluated(model, flags, bone):
    while bone >= 0:
        if not flags[bone] & BONE_USED_BY_BONE_MERGE:
            return False
        bone = model.bones[bone]["parent"]
    return True


def angle_matrix(pitch, yaw, roll):
    sp, cp = math.sin(math.radians(pitch)), math.cos(math.radians(pitch))
    sy, cy = math.sin(math.radians(yaw)), math.cos(math.radians(yaw))
    sr, cr = math.sin(math.radians(roll)), math.cos(math.radians(roll))
    return [
        [cp * cy, sr * sp * cy - cr * sy, cr * sp * cy + sr * sy],
        [cp * sy, sr * sp * sy + cr * cy, cr * sp * sy - sr * cy],
        [-sp, sr * cp, cr * cp],
    ]


def multiply(a, b):
    return [[sum(a[i][k] * b[k][j] for k in range(3)) for j in range(3)] for i in range(3)]


def transform(rotation, point):
    return [sum(rotation[i][k] * point[k] for k in range(3)) for i in range(3)]


def compose(parent, local):
    (rot_a, pos_a), (rot_b, pos_b) = parent, local
    moved = transform(rot_a, pos_b)
    return multiply(rot_a, rot_b), [pos_a[i] + moved[i] for i in range(3)]


def world_pose(model, sequence, frame):
    world = []
    for bone, (quat, pos) in zip(model.bones, model.local_pose(model.sequences[sequence], frame)):
        local = (mdl_pose.quat_matrix(quat), list(pos))
        world.append(compose(world[bone["parent"]], local) if bone["parent"] >= 0 else local)
    return world


def idle_sequence(model):
    return next((name for name in model.sequences if "idle" in name.lower()), next(iter(model.sequences)))


def converted_models():
    pattern = r'model = "(models/cotz/chands/[^"]+)"'
    return sorted(set(re.findall(pattern, DEFINITIONS.read_text())))


def load(path):
    return mdl_pose.Model(str(weapon_fit.find_model(path)))


MODELS_INSTALLED = (ROOT.parent / "cotz_general" / "models" / "cotz" / "chands").is_dir()
FITTED = weapon_fit.fitted_hand_models()


def installed_fitted(path):
    target = FITTED.get(path)
    return target and (ROOT.parent / "cotz_general" / target).is_file()


@unittest.skipUnless(MODELS_INSTALLED, "converted viewmodels are not installed")
class WeaponGrips(unittest.TestCase):
    def test_grip_sources_are_evaluated_in_game(self):
        # cl_hands.lua reads only bones the bonemerge sets up; any other source falls back to the converted pose.
        for path, poses in read_grips().items():
            if installed_fitted(path):
                continue
            model = load(path)
            names = {bone["name"]: index for index, bone in enumerate(model.bones)}
            flags = bone_flags(model)
            for (side, part), (source, _, _) in poses.items():
                with self.subTest(model=path, side=side, part=part):
                    self.assertIn(source, names)
                    self.assertTrue(evaluated(model, flags, names[source]), f"{source} is never evaluated")

    def test_converted_arms_keep_their_elbows(self):
        grips = read_grips()
        for path in converted_models():
            if installed_fitted(path):
                continue
            model = load(path)
            names = {bone["name"]: index for index, bone in enumerate(model.bones)}
            world = world_pose(model, idle_sequence(model), 0)
            poses = grips.get(path, {})

            def position(side, part):
                entry = poses.get((side, part))
                if entry:
                    source, angles, offset = entry
                    return compose(world[names[source]], (angle_matrix(*angles), offset))[1]
                return world[names[f"ValveBiped.Bip01_{side}_{part}"]][1]

            for side in "LR":
                with self.subTest(model=path, side=side):
                    hand, forearm = position(side, "Hand"), position(side, "Forearm")
                    upper_arm = position(side, "UpperArm")
                    self.assertGreater(math.dist(hand, forearm), MIN_SEGMENT, "the forearm starts at the hand")
                    self.assertGreater(math.dist(forearm, upper_arm), MIN_SEGMENT, "the upper arm covers the forearm")
                    self.assertGreater(math.dist(hand, upper_arm), math.dist(hand, forearm))

    def test_named_viewmodels_have_matching_sidecars_and_hand_bones(self):
        for original, path in FITTED.items():
            if not installed_fitted(original):
                continue
            with self.subTest(model=path):
                file = weapon_fit.find_model(path)
                model = mdl_pose.Model(str(file))
                name = path.removeprefix("models/").encode()
                self.assertEqual(model.data[12:76].split(b"\0")[0], name)
                self.assertEqual(file.with_suffix(".vvd").read_bytes()[8:12], model.data[8:12])
                self.assertEqual(file.with_suffix(".dx90.vtx").read_bytes()[16:20], model.data[8:12])
                flags = bone_flags(model)
                names = {bone["name"].lower(): i for i, bone in enumerate(model.bones)}
                for side in "lr":
                    for part in ("hand", "forearm", "finger0", "finger1", "finger2", "finger3", "finger4"):
                        self.assertTrue(flags[names[f"valvebiped.bip01_{side}_{part}"]] & BONE_USED_BY_BONE_MERGE)


if __name__ == "__main__":
    unittest.main()
