"""Run from the repository root: python3 tests/attachment_apply_spec.py"""

import sys
import tempfile
import unittest
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1] / "docs" / "attachments"))

import apply_placements as apply  # noqa: E402

WEAPON = '''AddCSLuaFile()

if CLIENT then
\tSWEP.PrintName = "Test"
\tSWEP.IronsightPos = Vector(-1, -2, 1)
\tSWEP.IronsightAng = Vector(0, 0, 0)

\tSWEP.KobraPos = Vector(-1, -3, 0.5)
\t-- SWEP.EoTechPos = Vector(9, 9, 9)

\tSWEP.AttachmentModelsVM = {
\t\t["md_kobra"] = {model = "models/cw2/attachments/kobra.mdl", bone = "body", pos = Vector(0, 1, 2), angle = Angle(0, 0, -90), size = Vector(1, 1, 1)},
\t\t-- ["md_eotech"] = {model = "x.mdl"},
\t\t["md_pbs1"] = {model = "models/cw2/attachments/pbs1.mdl", bone = "body", pos = Vector(1, 2, 3), angle = Angle(0, 0, 0), size = Vector(1, 1, 1)}
\t}
end

--SWEP.Attachments = {[1] = {header = "Sight", atts = {"md_old"}}}
SWEP.Attachments = {[1] = {header = "Sight", offset = {800, -300}, atts = {"md_kobra"}},
\t[2] = {header = "Barrel", offset = {-450, -300}, atts = {"md_pbs1"}},
\t["+reload"] = {header = "Ammo", offset = {-450, 100}, atts = {"am_hollowpoint"}}}
'''

BARE_WEAPON = '''AddCSLuaFile()

if CLIENT then
\tSWEP.PrintName = "Bare"
end

SWEP.Attachments = {
\t["+reload"] = {header = "Ammo", offset = {700, 325}, atts = {"am_slugrounds"}}
}
'''

ITEM = '''ITEM.name = "Test"
ITEM.class = "cw_test"
ITEM.width = 4
ITEM.height = 2
ITEM.canAttach = false
ITEM.validAttachments = {"md_pbs1", "md_kobra"}
'''

EXPORT = {
    "version": 1,
    "class": "cw_test",
    "slot": {"key": 1, "header": "Sight", "create": False, "offset": [800, -300]},
    "models": [
        {"id": "md_kobra", "model": "models/cw2/attachments/kobra.mdl", "bone": "body",
            "pos": [0, 1.5, 2], "angle": [0, 0, -90], "size": [1, 1, 1], "new": False},
        {"id": "md_eotech", "model": "models/wystan/attachments/2otech557sight.mdl", "bone": "body",
            "pos": [0.25, -1.0000004, 3.125], "angle": [0, 90, 0], "size": [0.5, 0.5, 0.5], "new": True},
    ],
    "fields": [
        {"name": "KobraPos", "kind": "vector", "value": [-1, -3, 0.25]},
        {"name": "EoTechPos", "kind": "vector", "value": [-1.5, -3, 0.75]},
        {"name": "EoTechAng", "kind": "vector", "value": [0, 0, 0]},
        {"name": "SightWithRail", "kind": "bool", "value": True},
    ],
    "attachments": ["md_eotech"],
    "skipped": [],
}


class WeaponTests(unittest.TestCase):
    def test_updates_existing_and_inserts_new_models(self):
        text = apply.apply_weapon(WEAPON, EXPORT)
        self.assertIn('["md_kobra"] = {model = "models/cw2/attachments/kobra.mdl", bone = "body", '
            'pos = Vector(0, 1.5, 2), angle = Angle(0, 0, -90)', text)
        self.assertIn('\t\t["md_pbs1"] = {model = "models/cw2/attachments/pbs1.mdl", bone = "body", '
            'pos = Vector(1, 2, 3), angle = Angle(0, 0, 0), size = Vector(1, 1, 1)},\n'
            '\t\t["md_eotech"] = {model = "models/wystan/attachments/2otech557sight.mdl", bone = "body", '
            'pos = Vector(0.25, -1, 3.125), angle = Angle(0, 90, 0), size = Vector(0.5, 0.5, 0.5)},\n\t}', text)
        self.assertIn('-- ["md_eotech"] = {model = "x.mdl"},', text)

    def test_sets_fields_after_ironsights_and_ignores_comments(self):
        text = apply.apply_weapon(WEAPON, EXPORT)
        self.assertIn("\tSWEP.KobraPos = Vector(-1, -3, 0.25)\n", text)
        self.assertIn("\tSWEP.IronsightAng = Vector(0, 0, 0)\n\n\tSWEP.EoTechPos = Vector(-1.5, -3, 0.75)\n"
            "\tSWEP.EoTechAng = Vector(0, 0, 0)\n\tSWEP.SightWithRail = true\n", text)
        self.assertIn("-- SWEP.EoTechPos = Vector(9, 9, 9)", text)

    def test_registers_ids_in_the_active_sight_slot(self):
        text = apply.apply_weapon(WEAPON, EXPORT)
        self.assertIn('[1] = {header = "Sight", offset = {800, -300}, atts = {"md_kobra", "md_eotech"}}', text)
        self.assertIn('--SWEP.Attachments = {[1] = {header = "Sight", atts = {"md_old"}}}', text)

    def test_is_idempotent(self):
        once = apply.apply_weapon(WEAPON, EXPORT)
        self.assertEqual(once, apply.apply_weapon(once, EXPORT))

    def test_creates_model_table_and_sight_slot_on_bare_weapons(self):
        export = dict(EXPORT, slot={"key": 1, "header": "Sight", "create": True, "offset": [800, -300]},
            models=EXPORT["models"][1:], fields=EXPORT["fields"][1:3])
        text = apply.apply_weapon(BARE_WEAPON, export)
        self.assertIn("if CLIENT then\n\tSWEP.EoTechPos = Vector(-1.5, -3, 0.75)\n\tSWEP.EoTechAng = Vector(0, 0, 0)\n\n"
            "\tSWEP.AttachmentModelsVM = {\n\t\t[\"md_eotech\"] = {\n"
            "\t\t\tmodel = \"models/wystan/attachments/2otech557sight.mdl\",\n", text)
        self.assertIn('SWEP.Attachments = {\n\t[1] = {header = "Sight", offset = {800, -300}, atts = {"md_eotech"}},\n'
            '\t["+reload"]', text)
        self.assertEqual(text, apply.apply_weapon(text, export))


class ReplaceTests(unittest.TestCase):
    def test_replaces_the_sight_list(self):
        slot = dict(EXPORT["slot"], replace=True)
        text = apply.apply_slot(WEAPON, slot, ["md_eotech"])
        self.assertIn('[1] = {header = "Sight", offset = {800, -300}, atts = {"md_eotech"}},', text)
        self.assertEqual(text, apply.apply_slot(text, slot, ["md_eotech"]))

    def test_removes_an_emptied_sight_slot(self):
        text = apply.apply_slot(WEAPON, dict(EXPORT["slot"], replace=True), [])
        self.assertNotIn('header = "Sight", offset', text)
        self.assertIn('SWEP.Attachments = {\t[2] = {header = "Barrel"', text.replace("\n", ""))
        self.assertIn('--SWEP.Attachments = {[1] = {header = "Sight", atts = {"md_old"}}}', text)

    def test_removes_ids_from_every_slot(self):
        text = apply.apply_weapon(WEAPON, dict(EXPORT, models=[], fields=[], attachments=[],
            removeAttachments=["md_pbs1", "md_kobra"]))
        self.assertNotIn('header = "Barrel"', text)
        self.assertNotIn('header = "Sight", offset', text)
        self.assertIn('SWEP.Attachments = {\n\t["+reload"]', text)
        self.assertEqual(text, apply.apply_weapon(text, dict(EXPORT, models=[], fields=[], attachments=[],
            removeAttachments=["md_pbs1", "md_kobra"])))

    def test_removes_unplaced_ids_from_items(self):
        text = apply.apply_item(ITEM, [], ["md_kobra"])
        self.assertIn('ITEM.validAttachments = {"md_pbs1"}', text)
        text = apply.apply_item(ITEM, ["md_eotech"], ["md_pbs1"])
        self.assertIn('ITEM.validAttachments = {"md_kobra", "md_eotech"}', text)


class ItemTests(unittest.TestCase):
    def test_adds_ids_and_enables_attaching(self):
        text = apply.apply_item(ITEM, ["md_eotech", "md_kobra"])
        self.assertIn('ITEM.validAttachments = {"md_pbs1", "md_kobra", "md_eotech"}', text)
        self.assertIn("ITEM.canAttach = true", text)

    def test_creates_list_after_dimensions(self):
        source = ITEM.replace('ITEM.validAttachments = {"md_pbs1", "md_kobra"}\n', "")
        text = apply.apply_item(source, ["md_eotech"])
        self.assertIn('ITEM.height = 2\nITEM.validAttachments = {"md_eotech"}\n', text)


class ExportTests(unittest.TestCase):
    def test_applies_to_weapon_and_matching_items(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            weapon = root / "lua/weapons/cw_test/shared.lua"
            item = root / apply.ITEM_ROOT / "newweapons/sh_test.lua"
            other = root / apply.ITEM_ROOT / "newweapons/sh_other.lua"
            for path, text in ((weapon, WEAPON), (item, ITEM), (other, ITEM.replace("cw_test", "cw_other"))):
                path.parent.mkdir(parents=True, exist_ok=True)
                path.write_text(text, encoding="utf-8")

            self.assertEqual(apply.apply_export(root, EXPORT, dry_run=True),
                ["lua/weapons/cw_test/shared.lua", str(apply.ITEM_ROOT / "newweapons/sh_test.lua")])
            self.assertEqual(weapon.read_text(encoding="utf-8"), WEAPON)
            apply.apply_export(root, EXPORT)
            self.assertEqual(apply.apply_export(root, EXPORT), [])
            self.assertIn("md_eotech", item.read_text(encoding="utf-8"))
            self.assertNotIn("md_eotech", other.read_text(encoding="utf-8"))

    def test_rejects_unknown_versions(self):
        with tempfile.TemporaryDirectory() as directory:
            path = Path(directory) / "cw_test.json"
            path.write_text('{"version": 2, "class": "cw_test"}', encoding="utf-8")
            with self.assertRaises(apply.ApplyError):
                apply.load_export(path)


if __name__ == "__main__":
    unittest.main()
