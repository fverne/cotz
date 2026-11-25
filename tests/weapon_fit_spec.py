"""Run from the repository root: python3 tests/weapon_fit_spec.py"""

import math
import sys
import tempfile
import unittest
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1] / "docs" / "attachments"))

import weapon_fit as fit  # noqa: E402


def frame(origin, pitch, yaw, roll):
    return origin, fit.angle_matrix(pitch, yaw, roll)


class RebonePose(unittest.TestCase):
    def assertSamePose(self, old_frame, new_frame, pos, angle):
        new_pos, new_angle = fit.rebone_pose(old_frame, new_frame, pos, angle)
        before = fit.cw_to_world(old_frame, pos, angle)
        after = fit.cw_to_world(new_frame, new_pos, new_angle)
        self.assertLess(math.dist(before[0], after[0]), 1e-6)
        for old_axis, new_axis in zip(before[1], after[1]):
            self.assertLess(math.dist(old_axis, new_axis), 1e-6)
        return new_pos, new_angle

    def test_cw_offsets_follow_the_bones_right_vector(self):
        world, _ = fit.cw_to_world(frame([0, 0, 0], 0, 0, 0), [1, 2, 3], [0, 0, 0])
        self.assertEqual(world, [1, -2, 3])

    def test_same_bone_keeps_its_numbers(self):
        bone = frame([3, -4, 5], 10, 20, 30)
        new_pos, new_angle = self.assertSamePose(bone, bone, [1.5, -2, 0.25], [-12, 40, 75])
        for value, expected in zip(new_pos + new_angle, [1.5, -2, 0.25, -12, 40, 75]):
            self.assertAlmostEqual(value, expected, places=5)

    def test_moves_onto_a_shifted_and_tilted_bone(self):
        old_bone = frame([3, 3, -7.5], 0, 0, 0)
        new_bone = frame([16.6, -3.8, -7.3], -0.4, 0.43, 0.2)
        self.assertSamePose(old_bone, new_bone, [6.3, -1.4, -15.5], [-0.03, 0, -90.06])

    def test_upright_sight_survives_gimbal_lock(self):
        # CW sights placed at pitch -90 have no unique yaw and roll; the world pose must still match.
        old_bone = frame([0, 0, 0], 0, 0, 0)
        new_bone = frame([1, 2, 3], 0, 0.43, 0)
        self.assertSamePose(old_bone, new_bone, [7, -1.6, -10.6], [-90, 90, 0])

    def test_arbitrary_rotations_round_trip(self):
        old_bone = frame([1, 2, 3], 33, -140, 71)
        new_bone = frame([-4, 0.5, 9], -12, 85, -160)
        self.assertSamePose(old_bone, new_bone, [2, 7, -3], [15, 200, -45])


class WorldFit(unittest.TestCase):
    def test_legacy_barrel_frame_uses_model_mesh_and_muzzle_side(self):
        points = [[x, y, z] for x in (-2, 2) for y in (-10, 20) for z in (-1, 1)]
        origin, axes, dimensions, tip_size = fit.barrel_frame(points, [0, -10, 0])
        self.assertEqual(origin, [0, -10, 0])
        self.assertLess(math.dist(axes[0], [0, -1, 0]), 1e-6)
        self.assertEqual(dimensions, (30, 4, 2))
        self.assertEqual(tip_size, (4, 2))

    def test_legacy_barrel_frame_rejects_a_symmetric_mesh_without_a_muzzle(self):
        points = [[x, y, z] for x in (-10, 10) for y in (-2, 2) for z in (-1, 1)]
        with self.assertRaises(fit.FitError):
            fit.barrel_frame(points, None)

    def test_turns_pick_the_frame_that_overlaps(self):
        world = [[-1, -5, 0], [2, 1, 10]]
        view = [[-2, -1, -9], [1, 5, 0]]
        turn, flipped = fit.best_flip(view, world)
        self.assertEqual(turn, "roll")
        self.assertEqual(flipped, [[-2, -5, 0], [1, 1, 9]])

    def test_matching_frames_need_no_turn(self):
        box = [[-1, -5, 0], [2, 1, 10]]
        self.assertEqual(fit.best_flip(box, box)[0], "none")

    def test_fields_are_listed_only_when_they_matter(self):
        lines = fit.format_world_fields({"scale": 0.8441, "shift": [0.1, -0.1, 0.0], "flip": "none"})
        self.assertEqual(lines, ["SWEP.WorldAttachmentScale = 0.844"])
        lines = fit.format_world_fields({"scale": 1.0, "shift": [0, 0.61, 2.6], "flip": "pitch"})
        self.assertEqual(lines[1:], ["SWEP.WorldAttachmentShift = Vector(0, 0.61, 2.6)",
            "SWEP.WorldAttachmentAngle = Angle(180, 0, 0)"])

    def test_writing_replaces_earlier_fields_after_the_muzzle_name(self):
        text = 'SWEP.ViewModel = "v.mdl"\nSWEP.MuzzleAttachmentName = "muzzle"\nSWEP.WorldAttachmentScale = 2\n'
        with tempfile.TemporaryDirectory() as directory:
            weapons = Path(directory)
            (weapons / "cw_test").mkdir()
            (weapons / "cw_test" / "shared.lua").write_text(text, encoding="utf-8")
            original = fit.WEAPONS
            fit.WEAPONS = weapons
            try:
                fit.write_world_fields(fit.weapon_info("cw_test"), ["SWEP.WorldAttachmentScale = 0.5"])
                result = (weapons / "cw_test" / "shared.lua").read_text(encoding="utf-8")
            finally:
                fit.WEAPONS = original
        self.assertEqual(result, 'SWEP.ViewModel = "v.mdl"\nSWEP.MuzzleAttachmentName = "muzzle"\n'
            "SWEP.WorldAttachmentScale = 0.5\n")


def slab(x0, x1, z, y0=-1.0, y1=1.0):
    """Two triangles forming a flat horizontal surface."""
    return [[[x0, y0, z], [x1, y0, z], [x1, y1, z]], [[x0, y0, z], [x1, y1, z], [x0, y1, z]]]


class FallbackPoses(unittest.TestCase):
    def test_arm_bones_are_told_apart_from_gun_parts(self):
        arms = ["r_wrist", "l_armtwist_4", "Bip01 L Hand", "Right_L_Arm", "Left12", "Bone23", "twist_R01",
            "L_Forearm", "R_Index1", "ValveBiped.Bip01_R_Finger4", "RightArm_1stP"]
        guns = ["weapon", "Charging Handle", "pistol_rail_low", "f_frame", "lufa", "l1", "zatvor", "hammer",
            "firing_pin", "handguard", "sw500-gun"]
        for name in arms:
            self.assertTrue(fit.ARM_BONE.search(name.lower()), name)
        for name in guns:
            self.assertFalse(fit.ARM_BONE.search(name.lower()), name)

    def test_main_stretch_bridges_small_gaps_and_drops_stray_parts(self):
        tops = [0.0] * 5 + [None] * 10 + [1.0] * 8 + [None] * 3 + [1.0] * 6
        self.assertEqual(fit.main_stretch(tops), (15, 31))

    def test_sight_behind_the_gun_moves_to_the_nearest_flat_stretch(self):
        # A loose part behind the gun (a posed speedloader) must not hold the sight.
        faces = slab(0, 3, -10) + slab(10, 20, 0)
        profile = fit.SurfaceProfile(faces, 0.0)
        box = [[2, -0.5, -3], [4, 0.5, -1]]
        self.assertTrue(profile.misses(*fit.mount_span(box)))
        shift = fit.nearest_mount(profile, box)
        self.assertAlmostEqual(shift, 7.5, delta=fit.SURFACE_STEP + 1e-9)
        low, high = fit.mount_span(box)
        self.assertTrue(profile.supports(low + shift, high + shift))

    def test_a_step_under_the_mount_is_not_flat(self):
        faces = slab(0, 5, 0) + slab(5, 10, 2)
        profile = fit.SurfaceProfile(faces, 0.0)
        self.assertFalse(profile.misses(4, 6))
        self.assertFalse(profile.supports(4, 6))
        # A scope overhanging the rear of the receiver keeps its place.
        self.assertFalse(profile.misses(-1, 1.5))
        self.assertTrue(profile.supports(6, 8))

    def test_startup_bodygroups_resolve_numbers_and_named_tables(self):
        code = "\n".join([
            "SWEP.BarrelBGs = {main = 1, regular = 1, rail = 2}",
            "function SWEP:IndividualInitialize()",
            "\tself:setBodygroup( 3 , 1 )",
            "end",
            "function SWEP:IndividualThink()",
            "\tself:setBodygroup(self.BarrelBGs.main,self.BarrelBGs.rail)",
            "end",
            "function SWEP:Other()",
            "\tself:setBodygroup(4, 1)",
            "end",
        ])
        self.assertEqual(fit.startup_bodygroups([code]), {3: 1, 1: 2})

    def test_fallback_values_are_rewritten_in_place(self):
        text = "\n".join([
            "return {",
            "\tmodels = {",
            '\t\tmd_rmr = "models/rmr.mdl",',
            "\t},",
            "\tweapons = {",
            "\t\tcw_test = {",
            '\t\t\tbone = "weapon",',
            "\t\t\tmd_rmr = {0.1, -2, 3, 0, 90, 0, 0.85, 0.85, 0.85, -1, 2, 3e-05},",
            "\t\t},",
            "\t},",
            "}",
        ])
        models, weapons = fit.read_fallback_poses(text)
        self.assertEqual(models, {"md_rmr": "models/rmr.mdl"})
        item = weapons["cw_test"]["items"]["md_rmr"]
        self.assertEqual(weapons["cw_test"]["bone"], "weapon")
        self.assertEqual(item["values"][11], 3e-05)
        values = list(item["values"])
        values[1], values[11] = 2.12345, 1.0
        result = fit.write_fallback_values(text, {item["line"]: values})
        self.assertIn("\t\t\tmd_rmr = {0.1, 2.123, 3, 0, 90, 0, 0.85, 0.85, 0.85, -1, 2, 1},", result)
        self.assertEqual(result.count("\n"), text.count("\n"))

    def test_bone_delta_uses_cws_right_axis(self):
        bone = frame([0, 0, 0], 0, 90, 0)
        self.assertLess(math.dist(fit.bone_delta(bone, [0, 1, 0]), [1, 0, 0]), 1e-9)
        self.assertLess(math.dist(fit.bone_delta(bone, [1, 0, 0]), [0, 1, 0]), 1e-9)


if __name__ == "__main__":
    unittest.main()
