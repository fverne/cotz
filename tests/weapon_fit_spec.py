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


if __name__ == "__main__":
    unittest.main()
