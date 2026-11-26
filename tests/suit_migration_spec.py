"""Run the saved-suit conversion's real SQL against SQLite. Run from the repository root."""
import json
import sqlite3
import subprocess
import tempfile
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]

PRINTER = """
PLUGIN = {}
dofile("gamemodes/ix_cotz/plugins/suits/sv_migration.lua")
for _, query in ipairs(PLUGIN:GetSuitMigrationQueries(arg[#arg])) do print(query) end
"""


def queries(adapter):
    with tempfile.TemporaryDirectory() as directory:
        script = Path(directory) / "printer.lua"
        script.write_text(PRINTER)
        output = subprocess.run(["luatex", "--luaonly", str(script), adapter], cwd=ROOT, check=True,
                                capture_output=True, text=True).stdout

    return [line for line in output.splitlines() if line.startswith("UPDATE ")]


class SuitMigrationSpec(unittest.TestCase):
    def setUp(self):
        self.db = sqlite3.connect(":memory:")
        self.db.execute("CREATE TABLE ix_items (item_id INTEGER PRIMARY KEY, unique_id TEXT, data TEXT)")

    def migrate(self):
        for query in queries("sqlite"):
            self.db.execute(query)

    def add(self, item_id, unique_id, data):
        self.db.execute("INSERT INTO ix_items VALUES (?, ?, ?)", (item_id, unique_id, data))

    def row(self, item_id):
        unique_id, data = self.db.execute(
            "SELECT unique_id, data FROM ix_items WHERE item_id = ?", (item_id,)).fetchone()

        return unique_id, data

    def test_coats_merge_and_keep_colour_and_saved_state(self):
        saved = {"durability": 41, "equip": True, "attachments": {"exteriorSlots": ["kevlar_1"]}}
        for item_id, colour in enumerate(("black", "brown", "green", "tan"), 1):
            self.add(item_id, "suit_trenchcoat_" + colour, json.dumps(saved))
        self.migrate()
        for item_id, skin in enumerate((1, 0, 4, 6), 1):
            unique_id, data = self.row(item_id)
            self.assertEqual(unique_id, "suit_trenchcoat")
            self.assertEqual(json.loads(data), dict(saved, legacyCoatSkin=skin))

    def test_coats_without_saved_data_still_keep_their_colour(self):
        for item_id, data in enumerate(("[]", "{}", "", None), 1):
            self.add(item_id, "suit_trenchcoat_green", data)
        self.migrate()
        for item_id in range(1, 5):
            unique_id, data = self.row(item_id)
            self.assertEqual((unique_id, json.loads(data)), ("suit_trenchcoat", {"legacyCoatSkin": 4}))

    def test_old_sky_three_becomes_sky_five_but_new_sky_three_stays(self):
        self.add(1, "suit_cs3", '{"durability":80}')
        self.add(2, "suit_cs3_ecologist", None)
        self.add(3, "suit_cs3", '{"durability":100,"skyLineVersion":2}')
        self.add(4, "suit_cs3_ecologist", '{"skyLineVersion":2}')
        self.add(5, "suit_cs3_authority", "{}")
        self.add(6, "suit_cs2", "{}")
        self.migrate()
        self.assertEqual([self.row(i)[0] for i in range(1, 7)], [
            "suit_cs5", "suit_cs5_ecologist", "suit_cs3", "suit_cs3_ecologist", "suit_cs3_authority", "suit_cs2"])
        self.assertEqual(self.row(1)[1], '{"durability":80}')

    def test_running_again_changes_nothing(self):
        self.add(1, "suit_trenchcoat_tan", '{"durability":12}')
        self.add(2, "suit_cs3", '{"durability":80}')
        self.add(3, "suit_cs3", '{"skyLineVersion":2}')
        self.migrate()
        first = self.db.execute("SELECT * FROM ix_items ORDER BY item_id").fetchall()
        self.migrate()
        self.assertEqual(self.db.execute("SELECT * FROM ix_items ORDER BY item_id").fetchall(), first)

    def test_mysql_uses_concat_and_no_select(self):
        statements = queries("mysqloo")
        self.assertEqual(len(statements), 6)
        self.assertTrue(all(s.startswith("UPDATE ix_items SET ") and "SELECT" not in s for s in statements))
        self.assertTrue(all("CONCAT(" in s and "||" not in s for s in statements[:4]))

    def test_new_sky_three_definitions_carry_the_marker(self):
        for name in ("sh_suit_cs3.lua", "sh_suit_cs3_ecologist.lua"):
            source = (ROOT / "gamemodes/ix_cotz/schema/items/suit" / name).read_text()
            self.assertIn("ITEM.skyLineVersion = 2", source)
        base = (ROOT / "gamemodes/ix_cotz/schema/items/base/sh_suit.lua").read_text()
        self.assertIn('self:SetData("skyLineVersion", self.skyLineVersion)', base)


if __name__ == "__main__":
    unittest.main()
