"""Verify both reload cases for the item-backed firearm catalogue."""

import re
import sys
import unittest
from functools import lru_cache
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
ITEMS = ROOT / "gamemodes/ix_cotz/schema/items/newweapons"
WEAPONS = ROOT / "lua/weapons"
sys.path.insert(0, str(ROOT / "docs/anomaly"))

from reskin_weapons import mask, statements  # noqa: E402


@lru_cache(maxsize=None)
def reload_definition(weapon_class):
    if weapon_class == "cw_base":
        return {"ReloadSpeed": "1"}

    source = WEAPONS / f"{weapon_class}.lua"
    if not source.is_file():
        source = WEAPONS / weapon_class / "shared.lua"

    code = mask(source.read_text())
    fields = {name: code[start:end].split("=", 1)[1].strip() for name, start, end in statements(code)}
    parent = fields["Base"].strip('"')
    return {**reload_definition(parent), **fields}


class WeaponReloadCatalogueSpec(unittest.TestCase):
    def test_regular_mp5_uses_authored_bolt_release_only_from_empty(self):
        source = reload_definition("cw_mp5")
        self.assertRegex(source["Animations"], r'\["reload"\]\s*=\s*"anm_reload"')
        self.assertRegex(source["Animations"], r'\["reload_empty"\]\s*=\s*"anm_reload_empty"')
        self.assertRegex(source["Sounds"], r'(?s)\["anm_reload"\].*?"TFA_ANOMALY\.MP5\.Reload"')
        self.assertRegex(source["Sounds"], r'(?s)\["anm_reload_empty"\].*?"TFA_ANOMALY\.MP5\.ReloadEmpty"')
        self.assertGreater(float(source["ReloadHalt_Empty"]), float(source["ReloadHalt"]))
        self.assertNotIn("ReloadChamberCuts", source)

    def test_reload_sequences_and_timings_for_inventory_firearms(self):
        items = sorted(ITEMS.glob("sh_*.lua"))
        self.assertTrue(items)
        for item in items:
            with self.subTest(item=item.stem):
                source = mask(item.read_text())
                weapon_class = re.search(r'\bITEM\.class\s*=\s*"([^"]+)"', source)[1]
                definition = reload_definition(weapon_class)
                animations = {
                    indexed or bare: sequence
                    for indexed, bare, sequence in re.findall(
                        r'(?:\["(\w+)"\]|\b(\w+))\s*=\s*"([^"]+)"',
                        definition["Animations"],
                    )
                }

                timings = ["ReloadSpeed"]
                if definition.get("ShotgunReload") == "true":
                    self.assertTrue({"reload_start", "insert", "reload_end"} <= animations.keys())
                    timings += ["ReloadStartTime", "InsertShellTime", "ReloadFinishWait"]
                    if "reload_start_empty" in animations:
                        timings.append("ReloadStartTime_Empty")
                    if "reload_end_empty" in animations:
                        timings.append("ReloadFinishWait_Empty")
                else:
                    self.assertIn("reload", animations)
                    timings += ["ReloadTime", "ReloadTime_Empty", "ReloadHalt", "ReloadHalt_Empty"]
                    if animations.get("reload_empty", animations["reload"]) == animations["reload"]:
                        for field in ("ReloadTime", "ReloadHalt"):
                            self.assertEqual(float(definition[field]), float(definition[field + "_Empty"]))

                for field in timings:
                    self.assertGreater(float(definition[field]), 0, field)


if __name__ == "__main__":
    unittest.main()
