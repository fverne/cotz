from pathlib import Path
import sys
import tempfile
import unittest

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
import balance
from acquisition import build_audit, worldspawn_scope


class AcquisitionTests(unittest.TestCase):
    def test_worldspawn_numbers_are_map_pairs_not_six_difficulty_levels(self):
        for group, expected in {
            'worldspawn_1': (1, 'Marsh', 'Normal'),
            'worldspawn_2': (1, 'Marsh', 'Hard to find'),
            'worldspawn_3': (2, 'Waystation', 'Normal'),
            'worldspawn_4': (2, 'Waystation', 'Hard to find'),
            'worldspawn_5': (3, 'Pripyat', 'Normal'),
            'worldspawn_6': (3, 'Pripyat', 'Hard to find'),
            'reward_consumable': (None, '', 'Non-world route'),
        }.items():
            with self.subTest(group=group):
                self.assertEqual(worldspawn_scope(group), expected)

    def test_weight_probabilities_quantities_poaching_and_cooking(self):
        with tempfile.TemporaryDirectory() as folder:
            root = Path(folder)
            item_dir = root / 'gamemodes/ix_cotz/schema/items/valuable'
            item_dir.mkdir(parents=True)
            (item_dir / 'sh_nuts.lua').write_text('''function ITEM:OnInstanced()
self:SetData("quantity", math.random(3,8)) end''')
            (item_dir / 'sh_meat.lua').write_text('ITEM.meal = "meal"')
            for name in ('meal', 'part'):
                (item_dir / f'sh_{name}.lua').write_text('')
            loot = root / 'gamemodes/ix_cotz/plugins/randomitem/libs'
            loot.mkdir(parents=True)
            (loot / 'worldspawn_1.lua').write_text('''
-- ix.randomitems.tables["fake"] = {{1000, {"nuts"}}}
ix.randomitems.tables["worldspawn_1"] = {{2000, {"nuts", {["quantity"] = 4}}}, {1000, {"unrequested"}}}
''')
            poaching = root / 'gamemodes/ix_cotz/plugins/mutantpoaching'
            poaching.mkdir(parents=True)
            (poaching / 'sv_plugin.lua').write_text('''
ix.poaching.MutantParts = {["dog"] = {["meattype"] = "meat", ["parts"] = {{"part", 20}}}}
''')
            entities = [{'tab': 'Items', 'id': name, 'name': name,
                         'source': (item_dir / f'sh_{name}.lua').relative_to(root).as_posix(),
                         'fields': {}} for name in ('nuts', 'meat', 'meal', 'part')]
            pools = {'test': {'candidates': [{'item': name} for name in ('nuts', 'meat', 'meal', 'part')]}}
            rows, warnings = build_audit(root, entities, pools, balance.tokenize, balance.lua_string)
            self.assertEqual(warnings, [])
            nuts = next(r for r in rows[1:] if r[0] == 'nuts')
            self.assertEqual(nuts[5:7], [2000, 3000])
            self.assertAlmostEqual(nuts[7], 2 / 3)
            self.assertEqual(nuts[8:11], [4, 3, 8])
            part = next(r for r in rows[1:] if r[0] == 'part')
            self.assertAlmostEqual(part[7], 20 / 101)
            meal = next(r for r in rows[1:] if r[0] == 'meal')
            self.assertEqual(meal[3], 'Harvest and cooking')
            self.assertIn('meat', meal[-1])


if __name__ == '__main__':
    unittest.main()
