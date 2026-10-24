"""Read-only progression extraction must reflect source without running Lua."""
from pathlib import Path
import sys
import tempfile
import math
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
        vendor = next(row for row in unlocks if row[2] == "Vendor catalog item")
        self.assertIn("Initial stock (base): 5", vendor[7])
        self.assertIn("Maximum stock (base): 5", vendor[7])
        self.assertIn("Restock interval (hours): 1", vendor[7])
        self.assertIn("Restock amount (base): 5", vendor[7])
        self.assertIn("VendorStockMult", vendor[7])
        self.assertIn("Storage dialogue access", {row[2] for row in unlocks})
        self.assertIn("Full NPC dialogue and services", {row[2] for row in unlocks})

    def test_item_demand_includes_unused_items_and_missing_references(self):
        entities = [
            {"tab": "Items", "id": "nuts", "name": "Nuts"},
            {"tab": "Items", "id": "unused", "name": "Unused item"},
            {"tab": "Items", "id": "unused", "name": "Duplicate unused item"},
            {"tab": "Items", "id": "another", "name": "Another item"},
            {"tab": "Item bases", "id": "base", "name": "Base"},
        ]
        tabs, warnings = progression.build_tabs(self.root, entities, balance.tokenize, balance.lua_string)
        self.assertEqual(warnings, [])
        rows = tabs["Progression item demand"][1:]
        self.assertEqual([row[0] for row in rows], ["nuts", "paper", "another", "unused"])
        demand = {row[0]: row for row in rows}
        self.assertEqual(demand["another"][1:], ["Another item", 0, 0, 0, "", "", "Found"])
        self.assertEqual(demand["unused"][1:], ["unused", 0, 0, 0, "", "", "Duplicate definitions"])
        self.assertEqual(demand["paper"][2:5], [1, 15, 15])
        self.assertEqual(demand["paper"][-1], "Not found in scanned items")

    def test_duplicate_ids_and_missing_successors_are_visible(self):
        (self.folder / "sh_extra.lua").write_text('''
ix.progression.Register("intro", {name = "Duplicate", keyNpc = "Guide", progMap = "map_a",
defaultActive = false, nextProgressions = {"missing"}, progressthresholds = {1}})
''')
        _, warnings = progression.build_tabs(self.root, [], balance.tokenize, balance.lua_string)
        self.assertTrue(any("Duplicate progression ID" in message for _, message in warnings))
        self.assertTrue(any("unknown successor missing" in message for _, message in warnings))


class PersonalRequirementTests(unittest.TestCase):
    def test_pool_slots_export_alternatives_instead_of_a_combined_shopping_list(self):
        with tempfile.TemporaryDirectory() as folder:
            root = Path(folder)
            base = root / 'gamemodes/ix_cotz/plugins/progression'
            base.mkdir(parents=True)
            (base / 'sh_requirementpools.lua').write_text('''
ix.progression.itemPools = {
 fasteners = {name = "Fasteners", tier = "common", evidence = "Equal weights; different stack sizes",
 candidates = {{item = "nuts"}, {item = "bolts"}}},
}
''')
            (base / 'sh_definitions.lua').write_text('''
ix.progression.Register("delivery", {name = "Hardware", keyNpc = "Trader", progMap = "map",
 defaultActive = true, requirementSlots = {{pool = "fasteners", quantity = 2}}})
''')
            pools = progression.collect_pools(root, balance.tokenize, balance.lua_string)
            self.assertEqual(pools['fasteners']['candidates'][0], {'item': 'nuts'})
            tabs, warnings = progression.build_tabs(root, [], balance.tokenize, balance.lua_string)
            self.assertEqual(warnings, [])
            rows = tabs['Progression hand-ins']
            self.assertEqual(len(rows), 3)
            self.assertEqual([row[6] for row in rows[1:]], [2, 2])
            self.assertEqual([row[10] for row in rows[1:]], [1, 1])
            self.assertTrue(all('alternatives' in row[13] for row in rows[1:]))
            steps = tabs['Progression steps']
            self.assertEqual(steps[1][steps[0].index('Item types required')], 1)
            self.assertEqual(steps[1][steps[0].index('Total raw units')], 2)
            self.assertEqual(steps[1][-3:-1], [2, 2])

    def test_all_current_steps_have_valid_reduced_personal_requirements(self):
        import json
        root = Path(__file__).resolve().parents[3]
        steps, _, warnings = progression.collect(root, balance.tokenize, balance.lua_string)
        pools = progression.collect_pools(root, balance.tokenize, balance.lua_string)
        original = json.loads((root / 'docs/balance/progression/original-requirements.json').read_text())
        entities, _ = balance.scan(root)
        item_ids = {e['id'] for e in entities if e['tab'] == 'Items'}
        self.assertEqual(warnings, [])
        tasks = json.loads((root / 'docs/balance/progression/original-task-requirements.json').read_text())
        self.assertEqual(tasks, {
            'oldTimerKillIntro': [15], 'boss_dataTasks': [50], 'smartass_rfTasks': [60],
            'intern_gasAnalyzerReadings': [90], 'computer_artifactTasks': [100],
        })
        current_tasks = {s['id']: s['thresholds'] for s in steps if s['thresholds']}
        self.assertEqual(current_tasks, {ident: [math.ceil(n / 16) for n in counts]
                                         for ident, counts in tasks.items()})
        personal = {s['id']: s for s in steps if s['slots']}
        self.assertEqual(set(personal), set(original))
        for ident, step in personal.items():
            with self.subTest(progression=ident):
                self.assertLessEqual(len(step['slots']), 6)
                if sum(original[ident].values()) > 1:
                    self.assertGreaterEqual(len(step['slots']), 2)
                maximum = 0
                previous = set()
                for slot in step['slots']:
                    self.assertGreater(slot['quantity'], 0)
                    self.assertEqual(slot['quantity'] % 1, 0)
                    pool = pools[slot['pool']]
                    self.assertTrue(pool['evidence'])
                    candidates = pool['candidates']
                    self.assertTrue(candidates)
                    current = {c['item'] for c in candidates}
                    self.assertTrue(current <= item_ids)
                    self.assertFalse(previous & current, 'Slot overlap would make assignment order affect difficulty')
                    previous.update(current)
                    maximum += slot['quantity']
                budget = max(len(step['slots']), math.ceil(sum(original[ident].values()) / 16))
                self.assertEqual(maximum, budget)
                quantities = [slot['quantity'] for slot in step['slots']]
                share, remainder = divmod(budget, len(quantities))
                self.assertEqual(quantities, [share + (i < remainder) for i in range(len(quantities))])
        self.assertEqual(personal['quarterMasterDelivery_activateItem']['slots'], [{'pool': 'flashdrive', 'quantity': 1}])
        self.assertEqual(pools['flashdrive']['candidates'], [{'item': 'quest_flashdrive'}])

    def test_requested_items_are_used_and_hard_detector_covers_anomaly_families(self):
        from collections import Counter
        root = Path(__file__).resolve().parents[3]
        steps, _, warnings = progression.collect(root, balance.tokenize, balance.lua_string)
        pools = progression.collect_pools(root, balance.tokenize, balance.lua_string)
        self.assertEqual(warnings, [])
        used = {c['item'] for step in steps for slot in step['slots']
                for c in pools[slot['pool']]['candidates']}
        requested = {f'value_documents_{i}' for i in (1, 2, 3, 6, 8)} | {
            'value_pcpart_fpga', 'value_pcpart_lcd', 'value_powerbank', 'value_tape_heavy',
        }
        self.assertTrue(requested <= used)
        self.assertNotIn('value_personal', used)
        memberships = Counter(c['item'] for pool in pools.values() for c in pool['candidates'])
        for item in ('value_pcpart_fpga', 'value_pcpart_lcd', 'value_powerbank',
                     'value_tape_heavy', 'value_gunoil', 'value_wire_light'):
            self.assertGreater(memberships[item], 1, item)

        detector = next(step for step in steps if step['id'] == 'eggheadItemDelivery_Detector3')
        expected = {
            'exceptional_artifacts', 'bubble_artifacts', 'burner_artifacts',
            'rare_electrical_artifacts', 'chemical_artifacts', 'gravitational_artifacts',
        }
        self.assertEqual({slot['pool'] for slot in detector['slots']}, expected)
        self.assertTrue(all(slot['quantity'] == 1 for slot in detector['slots']))
        entities, _ = balance.scan(root)
        fields = {entity['name']: entity for entity in entities if entity['tab'] == 'Anomaly fields'}
        families = {
            'bubble_artifacts': ('Bubble', 'Bubble 2'),
            'burner_artifacts': ('Burner', 'Burner 2'),
            'rare_electrical_artifacts': ('Electro', 'Electro 2'),
            'chemical_artifacts': ('Fruitpunch', 'Fruitpunch 2'),
            'gravitational_artifacts': ('Whirlgig',),
        }
        for pool, names in families.items():
            source_items = {item for name in names for tier in ('rareArtifacts', 'veryRareArtifacts')
                            for item in fields[name]['fields'][tier]['value']}
            self.assertTrue({c['item'] for c in pools[pool]['candidates']} <= source_items, pool)

    def test_early_low_tier_deliveries_exclude_later_map_world_loot(self):
        from collections import defaultdict, deque
        from acquisition import build_audit
        root = Path(__file__).resolve().parents[3]
        steps, _, warnings = progression.collect(root, balance.tokenize, balance.lua_string)
        pools = progression.collect_pools(root, balance.tokenize, balance.lua_string)
        entities, _ = balance.scan(root)
        audit, audit_warnings = build_audit(root, entities, pools, balance.tokenize, balance.lua_string)
        self.assertEqual(warnings + audit_warnings, [])
        world = defaultdict(set)
        tier_column = audit[0].index('World map tier')
        for row in audit[1:]:
            if row[tier_column]:
                world[row[0]].add(row[tier_column])
        by_id = {step['id']: step for step in steps}
        depth = {step['id']: 0 for step in steps if step['defaultActive']}
        queue = deque(depth)
        while queue:
            ident = queue.popleft()
            for successor in by_id[ident]['next']:
                if successor not in depth or depth[successor] > depth[ident] + 1:
                    depth[successor] = depth[ident] + 1
                    queue.append(successor)
        low_npcs = {"'Old Timer'", "'Haggler'", "'Technut'", "'Mute'", "'Jitters'", "'Spicy Lemon'"}
        early_story = {
            'oldTimerItemDelivery_mainMeat', 'technutItemDelivery_Main',
            'oldTimerItemDelivery_mainStatue', 'stalkerNetAdminDelivery_mainRadioTower',
        }
        for step in steps:
            if not step['slots']:
                continue
            with self.subTest(progression=step['id']):
                cap = step['lootMapTier']
                self.assertIn(cap, (1, 2, 3))
                if (step['keyNpc'] in low_npcs and depth[step['id']] <= 2) or step['id'] in early_story:
                    self.assertEqual(cap, 1)
                for slot in step['slots']:
                    for candidate in pools[slot['pool']]['candidates']:
                        tiers = world[candidate['item']]
                        if tiers:
                            self.assertLessEqual(min(tiers), cap, candidate['item'])
        # Map-1 hard-to-find loot is valid locally; a later-map reward route is not an exemption.
        self.assertEqual(world['value_phone_new'], {1})
        self.assertEqual(world['value_powerbank'], {2})
        self.assertEqual(world['drink_energydrink_4'], {3})
        self.assertEqual({c['item'] for c in pools['heavy_electrical_map1']['candidates']},
                         {'value_carbattery', 'value_wire_heavy', 'value_tape_heavy'})
        for pool in ('local_beer', 'local_refreshments'):
            for candidate in pools[pool]['candidates']:
                self.assertTrue(any(row[0] == candidate['item'] and row[4] == 'reward_consumable'
                                    for row in audit[1:]))
        stash_path = root / 'gamemodes/ix_cotz/plugins/cycliccontainer/sh_stashtypes.lua'
        tokens = balance.tokenize(stash_path.read_text())
        start = next(i for i, token in enumerate(tokens) if token.value == '{')
        end = progression.table_end(tokens, start)
        stashes = progression.fields(tokens[start:end], balance.lua_string)
        for number in (1, 4, 5, 6):
            tables = progression.array(stashes[f'normal_cache_assorted_map1_{number}'], balance.lua_string)
            self.assertIn('reward_consumable', tables)


if __name__ == "__main__":
    unittest.main()
