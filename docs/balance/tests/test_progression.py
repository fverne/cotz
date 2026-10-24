"""Read-only progression extraction must reflect source without running Lua."""
from pathlib import Path
import sys
import tempfile
import unittest

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
import balance
import progression


class ProgressionTests(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory(prefix="cotz-progression-docs-")
        self.addCleanup(self.temp.cleanup)
        self.root = Path(self.temp.name)
        self.folder = self.root / "gamemodes/ix_cotz/plugins/progression"
        self.folder.mkdir(parents=True)
        (self.folder / "libs").mkdir()
        (self.folder / "libs/sh_progression.lua").write_text('''
ix.progression.npcRequirements = {["Trader"] = "intro"}
''')
        self.source = '''
-- ix.progression.Register("commented", {})
local decoy = "ix.progression.Register(fake)"
local MAP = "map_a"
ix.progression.Register("intro", {
    name = ("An " .. "introduction"), description = "Complete jobs", keyNpc = "Guide",
    progMap = MAP, defaultActive = true,
    progressthresholds = {[1] = 15, [2] = 30},
    nextProgressions = {"delivery"},
    worldNPC = {template = "trader", pos = Vector(1, 2, 3), ang = Angle(0, 90, 0)},
    progressfunctions = {[1] = {OnRun = function(self, character)
        if character then
            for i = 1, 3 do Notify("name = decoy") end
        end
        error("This function must never execute")
    end}},
})
MAP = "map_b"
ix.progression.Register("delivery", {
    name = "Supplies", keyNpc = "Trader", progMap = MAP, defaultActive = false,
    GetItemIds = function()
        local requirements = {["nuts"] = 90, ["paper"] = 15}
        return requirements
    end,
    vendorUnlocks = {{npc = "Trader", args = {"weapon", nil, 5, "SELLANDBUY", 5, 1, 5}}},
    OnComplete = function() error("Do not run Lua") end,
})
function ix.progression.Register(id, data) end
'''
        (self.folder / "sh_definitions.lua").write_text(self.source)

    def collect(self):
        return progression.collect(self.root, balance.tokenize, balance.lua_string)

    def test_steps_maps_thresholds_callbacks_and_literal_requirements(self):
        steps, gates, warnings = self.collect()
        self.assertEqual(warnings, [])
        self.assertEqual(len(steps), 2)
        intro, delivery = steps
        self.assertEqual(intro["name"], "An introduction")
        self.assertEqual(intro["progMap"], "map_a")
        self.assertEqual(delivery["progMap"], "map_b")
        self.assertEqual(intro["thresholds"], [15, 30])
        self.assertEqual(delivery["requirements"], {"nuts": 90, "paper": 15})
        self.assertEqual(delivery["vendor"][0][1], ["weapon", None, 5, "SELLANDBUY", 5, 1, 5])
        self.assertEqual(gates, {"Trader": "intro"})
        self.assertEqual(intro["world"], {"template": "trader", "pos": "Vector(1, 2, 3)", "ang": "Angle(0, 90, 0)"})

    def test_computed_requirements_are_reported_without_inventing_counts(self):
        source = self.source.replace('return requirements', 'requirements["nuts"] = GetCount()\n return requirements')
        (self.folder / "sh_definitions.lua").write_text(source)
        steps, _, warnings = self.collect()
        self.assertEqual(len(steps), 2)
        self.assertEqual(steps[1]["requirements"], {})
        self.assertIn("Unsupported hand-in", steps[1]["kind"])
        self.assertTrue(any("executable behavior" in message for _, message in warnings))

    def test_overview_edges_demand_names_world_and_service_scope(self):
        service = self.root / "gamemodes/ix_cotz/plugins/dialogue/dialogue/sh_owlnpc.lua"
        service.parent.mkdir(parents=True)
        service.write_text('''if ix.progression.IsCompleted(client:GetCharacter(), "intro") then OpenStorage() end''')
        entities = [{"tab": "Items", "id": "nuts", "name": "Nuts"}]
        tabs, warnings = progression.build_tabs(self.root, entities, balance.tokenize, balance.lua_string)
        self.assertEqual(warnings, [])
        self.assertEqual(tuple(tabs), progression.TAB_NAMES)
        steps = tabs["Progression steps"]
        headers = steps[0]
        delivery = next(row for row in steps[1:] if row[0] == "delivery")
        self.assertEqual(delivery[headers.index("Activated by completion of (any)")], "intro")
        self.assertEqual(delivery[headers.index("NPC access milestone")], "intro")
        self.assertEqual(delivery[headers.index("Total raw units")], 105)
        handins = tabs["Progression hand-ins"]
        self.assertEqual(len(handins), 3)
        nuts = next(row for row in handins[1:] if row[4] == "nuts")
        self.assertEqual(nuts[5:8], ["Nuts", 90, "Found"])
        paper = next(row for row in handins[1:] if row[4] == "paper")
        self.assertEqual(paper[7], "Not found in scanned items")
        demand = next(row for row in tabs["Progression item demand"][1:] if row[0] == "nuts")
        self.assertEqual(demand[2:5], [1, 90, 90])
        unlocks = tabs["Progression unlocks"][1:]
        self.assertIn("Global on first completion", {row[3] for row in unlocks})
        self.assertIn("Personal access and stock", {row[3] for row in unlocks})
        self.assertIn("Storage dialogue access", {row[2] for row in unlocks})
        self.assertIn("Full NPC dialogue and services", {row[2] for row in unlocks})

    def test_duplicate_ids_and_missing_successors_are_visible(self):
        (self.folder / "sh_extra.lua").write_text('''
ix.progression.Register("intro", {name = "Duplicate", keyNpc = "Guide", progMap = "map_a",
defaultActive = false, nextProgressions = {"missing"}, progressthresholds = {1}})
''')
        _, warnings = progression.build_tabs(self.root, [], balance.tokenize, balance.lua_string)
        self.assertTrue(any("Duplicate progression ID" in message for _, message in warnings))
        self.assertTrue(any("unknown successor missing" in message for _, message in warnings))


if __name__ == "__main__":
    unittest.main()
