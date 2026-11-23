"""Run from the repository root: python3 tests/anomaly_reskin_spec.py"""

import sys
import unittest
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1] / "docs" / "anomaly"))

import reskin_weapons as reskin  # noqa: E402

COTZ = '''AddCSLuaFile()

if CLIENT then
\tSWEP.PrintName = "Test"
\tSWEP.IronsightPos = Vector(1, 2, 3)
\tSWEP.IronsightAng = Vector(0, 0, 0)
\t-- Hand-tuned for the old sight.
\tSWEP.KobraPos = Vector(1, 1, 1)
\tSWEP.ACOGAxisAlign = {right = 0, up = 0, forward = 0}
\tSWEP.AttachmentModelsVM = {
\t\t["md_kobra"] = {model = "kobra.mdl", bone = "body", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0)},
\t}
\tSWEP.ViewModelMovementScale = 1.15
end

SWEP.MagBGs = {main = 4, regular = 0}
SWEP.Attachments = {[1] = {header = "Sight", atts = {"md_kobra"}}}
SWEP.Animations = {fire = "fire1", reload = "reload"}
SWEP.ViewModel = "models/old.mdl"
SWEP.Damage = 78
SWEP.FireSound = "CW_OLD_FIRE"
SWEP.ReloadSpeed = 0.5
SWEP.ReloadHalt = 2

function SWEP:IndividualInitialize()
\tself:setBodygroup(1, 2)
end

function SWEP:fireAnimFunc()
\tself:sendWeaponAnim("fire1")
end
'''

ANOMALY = '''SWEP.Base = "cw_anomaly_gun_base"
SWEP.ViewModel = "models/new.mdl"
SWEP.IronsightPos = Vector(4, 5, 6)
SWEP.Animations = {
\t["fire"] = "anm_shots",
}
SWEP.ReloadSpeed = 1
SWEP.FireSound = "TFA_ANOMALY.TEST.FIRE"
SWEP.ReloadHalt = 6
SWEP.Damage = 999

if CLIENT then
\tSWEP.SelectIcon = surface.GetTextureID("vgui/entities/new")
end
'''

VARIANT = '''SWEP.Base = "cw_anomaly_test"
SWEP.PrintName = "Test (VM recoil)"
SWEP.LuaViewmodelRecoil = true

if CLIENT then
\tSWEP.BoltBone = "zatvor"
\tkillicon.Add("cw_anomaly_test_vmrecoil",
\t\t"vgui/killicons/new", Color(255, 255, 255))
end

function SWEP:fireAnimFunc()
end
'''

ITEM = '''ITEM.name = "Test"
ITEM.model = "models/old_w.mdl"
ITEM.class = "cw_test"

ITEM.iconCam = {
\tpos = Vector(1, 2, 3),
\tang = Angle(0, 0, 0),
\tfov = 10,
}

ITEM.pacData = {[1] = {["self"] = {["Model"] = "models/old_w.mdl"}}}
'''

RESKINNED_ITEM = '''ITEM.model = "models/new_w.mdl"

ITEM.iconCam = {
\tpos = Vector(0.6, -205, -0.4),
\tang = Angle(0, 90, 0),
\tfov = 7,
}
'''


class WeaponTests(unittest.TestCase):
    def setUp(self):
        self.text = reskin.reskin_weapon(COTZ, ANOMALY, VARIANT, "cw_anomaly_test", {"KobraPos", "KobraAng"})

    def test_removes_old_model_fields(self):
        for removed in ("models/old.mdl", "KobraPos", "ACOGAxisAlign", "AttachmentModelsVM", "MagBGs",
                "Hand-tuned", "setBodygroup", 'sendWeaponAnim("fire1")', "IndividualInitialize"):
            self.assertNotIn(removed, self.text)

    def test_keeps_balance_and_slots(self):
        self.assertIn("SWEP.Damage = 78", self.text)
        self.assertNotIn("999", self.text)
        self.assertIn('SWEP.Attachments = {[1] = {header = "Sight", atts = {"md_kobra"}}}', self.text)
        self.assertIn("SWEP.ViewModelMovementScale = 1.15", self.text)

    def test_appends_anomaly_presentation(self):
        self.assertIn('SWEP.ViewModel = "models/new.mdl"', self.text)
        self.assertIn("SWEP.IronsightPos = Vector(4, 5, 6)", self.text)
        self.assertIn('\t["fire"] = "anm_shots",', self.text)
        self.assertIn("SWEP.LuaViewmodelRecoil = true", self.text)
        self.assertIn('SWEP.FireSound = "TFA_ANOMALY.TEST.FIRE"', self.text)
        self.assertNotIn("CW_OLD_FIRE", self.text)
        self.assertIn('\tSWEP.SelectIcon = surface.GetTextureID("vgui/entities/new")\n\tSWEP.BoltBone = "zatvor"\nend',
            self.text)
        self.assertNotIn("killicon.Add(\"cw_anomaly", self.text)
        self.assertNotIn("Test (VM recoil)", self.text)
        self.assertTrue(self.text.rstrip().endswith("function SWEP:fireAnimFunc()\nend"))

    def test_uses_the_anomaly_reload_speed(self):
        # Reload sounds are timed for the Anomaly animation at its own speed.
        self.assertIn("SWEP.ReloadSpeed = 1\n", self.text)
        self.assertNotIn("SWEP.ReloadSpeed = 0.5", self.text)


class ItemTests(unittest.TestCase):
    def test_uses_anomaly_world_model_and_icon(self):
        text = reskin.reskin_item(ITEM, "models/new_w.mdl", RESKINNED_ITEM)
        self.assertIn('ITEM.model = "models/new_w.mdl"', text)
        self.assertIn('["Model"] = "models/new_w.mdl"', text)
        self.assertIn("\tpos = Vector(0.6, -205, -0.4),\n\tang = Angle(0, 90, 0),\n\tfov = 7,\n}", text)
        self.assertNotIn("old_w", text)


if __name__ == "__main__":
    unittest.main()
