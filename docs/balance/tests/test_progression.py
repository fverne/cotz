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
        (self.folder / "definitions").mkdir(parents=True)
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
        (self.folder / "definitions/sh_definitions.lua").write_text(self.source)

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
        (self.folder / "definitions/sh_definitions.lua").write_text(source)
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
        self.assertIn("Initial stock: 5", vendor[7])
        self.assertIn("Maximum stock: 5", vendor[7])
        self.assertIn("Restock interval (hours): 1", vendor[7])
        self.assertIn("Restock amount: 5", vendor[7])
        self.assertIn("Stock counts are absolute (no multiplier)", vendor[7])
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
        (self.folder / "definitions/sh_extra.lua").write_text('''
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
            (base / "definitions").mkdir(parents=True)
            (base / 'definitions/sh_requirementpools.lua').write_text('''
ix.progression.itemPools = {
 fasteners = {name = "Fasteners", tier = "common", evidence = "Equal weights; different stack sizes",
 candidates = {{item = "nuts"}, {item = "bolts"}}},
}
''')
            (base / 'definitions/sh_definitions.lua').write_text('''
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

    def test_expanded_segments_preserve_original_allocations_and_reward_budgets(self):
        import json
        from collections import Counter, defaultdict
        from progression_pacing import plan
        root = Path(__file__).resolve().parents[3]
        steps, gates, warnings = progression.collect(root, balance.tokenize, balance.lua_string)
        pools = progression.collect_pools(root, balance.tokenize, balance.lua_string)
        baseline = json.loads((root / 'docs/balance/progression/milestone-baseline.json').read_text())
        quantities = json.loads((root / 'docs/balance/progression/quantity-baseline.json').read_text())
        self.assertEqual(warnings, [])
        self.assertEqual(len(baseline), 139)
        self.assertEqual(len(steps), 229)
        self.assertEqual(len({s['keyNpc'] for s in steps}), 19)
        _, planned = plan(root)
        groups = defaultdict(list)
        for step in steps:
            groups[step['milestoneGroup'] or step['id']].append(step)
            self.assertEqual(planned[step['id']]['quantities'], [x['quantity'] for x in step['slots']])
            self.assertEqual(planned[step['id']]['thresholds'], step['thresholds'])
            self.assertLessEqual(len(step['slots']), 8)
            previous = set()
            for slot in step['slots']:
                self.assertGreater(slot['quantity'], 0)
                self.assertEqual(slot['quantity'] % 1, 0)
                current = {c['item'] for c in pools[slot['pool']]['candidates']}
                self.assertFalse(previous & current)
                previous.update(current)
        corrections = {'steelplate_1': 'attachment_steelplate_1',
                       'ceramicplate_1': 'attachment_ceramicplate_1', 'fabricplate_1': 'attachment_fabric_1'}
        for ident, old in baseline.items():
            members = groups[ident]
            expected, actual = Counter(), Counter()
            for slot in old['slots']:
                expected[slot['pool']] += slot['quantity']
            for member in members:
                for slot in quantities.get(member['id'], []):
                    actual[slot['pool']] += slot['quantity']
                self.assertEqual(member['lootMapTier'], old['ceiling'])
            self.assertEqual(expected, actual, ident)
            old_rewards = Counter(corrections.get(args[0], args[0]) for _, args in old['vendor'])
            new_rewards = Counter(args[0] for m in members for _, args in m['vendor'])
            if ident == 'smartass_rfTasks':
                old_rewards['pso1'] += 1
            self.assertEqual(old_rewards, new_rewards, ident)
            if old['thresholds']:
                self.assertEqual(max(x for m in members for x in m['thresholds']), max(old['thresholds']))
        self.assertEqual(gates["'Intern'"], 'smartass_rfTasks')
        self.assertNotIn("'Quartermaster'", gates)

    def test_quantity_taper_preserves_early_steps_categories_and_fixed_inputs(self):
        from progression_pacing import tapered_quantities
        root = Path(__file__).resolve().parents[3]
        steps, gates, _ = progression.collect(root, balance.tokenize, balance.lua_string)
        pools = progression.collect_pools(root, balance.tokenize, balance.lua_string)
        baseline, planned = tapered_quantities(root, steps, gates, pools)
        by_depth = {}
        for step in steps:
            data = planned[step['id']]
            depth = data['logicalDepth']
            by_depth[depth] = data['multiplier']
            self.assertEqual([s['quantity'] for s in step['slots']], data['quantities'], step['id'])
            self.assertEqual([s['pool'] for s in step['slots']],
                             [s['pool'] for s in baseline.get(step['id'], [])])
            for old, amount in zip(baseline.get(step['id'], []), data['quantities']):
                self.assertGreaterEqual(amount, old['quantity'])
                self.assertLessEqual(amount, old['quantity'] * 6)
                if depth <= 2 or pools[old['pool']]['tier'] == 'fixed':
                    self.assertEqual(amount, old['quantity'], step['id'])
                elif depth == 12:
                    self.assertEqual(amount, old['quantity'] * 6, step['id'])
        self.assertEqual(by_depth[2], 1)
        self.assertEqual(by_depth[3], 1.5)
        self.assertEqual(by_depth[7], 3.5)
        self.assertEqual(by_depth[12], 6)
        self.assertEqual(sorted(by_depth.values()), [by_depth[d] for d in sorted(by_depth)])

    def test_authored_briefings_and_role_rewards_are_complete(self):
        root = Path(__file__).resolve().parents[3]
        steps, _, warnings = progression.collect(root, balance.tokenize, balance.lua_string)
        self.assertEqual(warnings, [])
        by_id = {step['id']: step for step in steps}
        entities, _ = balance.scan(root)
        item_ids = {entry['id'] for entry in entities if entry['tab'] == 'Items'}
        import json
        baseline = json.loads((root / 'docs/balance/progression/milestone-baseline.json').read_text())
        for step in steps:
            if step['id'] not in baseline:
                self.assertGreater(len(step['briefing']), 60, step['id'])
                self.assertTrue(step['completionMessage'], step['id'])
                self.assertNotIn('description =', step['briefing'])
            for _, args in step['vendor']:
                self.assertIn(args[0], item_ids, step['id'])
            for benefits in [step['benefits'], *step['checkpoints']]:
                for reward in benefits.get('items', []):
                    self.assertIn(reward['item'], item_ids, step['id'])
        self.assertEqual(by_id['smartass_rfTasks']['vendorThresholds'], [None, 3])
        self.assertEqual(by_id['arenaProgramme1']['benefits']['services'][0]['service'], 'treatment')
        self.assertEqual(by_id['arenaProgramme2']['benefits']['items'][0]['item'], 'medic_medkit_1')
        self.assertEqual(by_id['quartermasterFieldEquipment1']['prerequisites'],
                         ['quarterMasterDelivery_activateItem', 'quartermasterItemDelivery_1'])
        self.assertEqual(by_id['originalSurvival1']['benefits']['items'][0]['item'], 'food_can_tushonka')

    def test_progressions_are_loaded_from_their_contact_files(self):
        root = Path(__file__).resolve().parents[3]
        folder = root / 'gamemodes/ix_cotz/plugins/progression'
        steps, _, warnings = progression.collect(root, balance.tokenize, balance.lua_string)
        self.assertEqual(warnings, [])
        self.assertEqual(len(steps), len({step['id'] for step in steps}))
        plugin = (folder / 'sh_plugin.lua').read_text()
        contact_files = {
            "'Boss'": 'sh_bossprog.lua',
            "'Egghead'": 'sh_eggheadprog.lua',
            "'Haggler'": 'sh_hagglerprog.lua',
            "'Jitters'": 'sh_jittersprog.lua',
            "'Old Timer'": 'sh_oldtimerprog.lua',
            "'Quartermaster'": 'sh_quarterprog.lua',
            "'Spicy Lemon'": 'sh_spicylemonprog.lua',
            "'Technut'": 'sh_technutprog.lua',
            "'Mute'": 'sh_muteprog.lua',
            "'Computer'": 'sh_computerprog.lua',
            "'Intern'": 'sh_internprog.lua',
            "'The Original'": 'sh_originalprog.lua',
            "'Hoarder'": 'sh_hoarderprog.lua',
            "'???'": 'sh_noosphereprog.lua',
            'NPC': 'sh_communityprog.lua',
            "'Cleaner'": 'sh_cleanerprog.lua',
            "'Beanstalk'": 'sh_beanstalkprog.lua',
            "'Smartass'": 'sh_smartassprog.lua',
            "'Arena Master'": 'sh_arenaprog.lua',
        }
        for step in steps:
            if step['source'].endswith('sh_definitions.lua'):
                continue
            filename = contact_files[step['keyNpc']]
            self.assertTrue(step['source'].endswith('/' + filename), step['id'])
            self.assertEqual(plugin.count(f'ix.util.Include("definitions/{filename}")'), 1, filename)
        self.assertFalse((folder / 'definitions/sh_expansion.lua').exists())
        self.assertFalse((folder / 'definitions/sh_equipmentprog.lua').exists())

    def test_service_rewards_and_checkpoint_thresholds_are_exported(self):
        root = Path(__file__).resolve().parents[3]
        tabs, warnings = progression.build_tabs(root, [], balance.tokenize, balance.lua_string)
        self.assertEqual(warnings, [])
        rows = tabs['Progression unlocks'][1:]
        kinds = {row[2] for row in rows}
        for kind in ('Service credit', 'Checkpoint Service credit', 'Fixed item reward',
                     'Checkpoint Fixed item reward', 'Service discount', 'Recognition'):
            self.assertIn(kind, kinds)
        rf = [row for row in rows if row[0] == 'smartass_rfTasks' and row[2] == 'Vendor catalog item']
        self.assertTrue(any('Personal job threshold: 3' in str(row) and 'pso1' in row for row in rf))

    def test_effort_uses_loot_availability_and_mutant_danger(self):
        from progression_pacing import pool_efforts, mutant_effort
        root = Path(__file__).resolve().parents[3]
        pools = progression.collect_pools(root, balance.tokenize, balance.lua_string)
        costs = pool_efforts(root, pools)
        self.assertGreater(costs[1, 'heavy_components'], costs[1, 'fasteners'])
        self.assertGreater(costs[1, 'elite_hides'], costs[1, 'common_meat'])
        self.assertGreater(costs[1, 'elite_meals'], costs[1, 'common_meals'])
        self.assertGreater(mutant_effort(root, 'chimera'), mutant_effort(root, 'dog'))
        self.assertGreater(mutant_effort(root, 'controller'), mutant_effort(root, 'flesh'))

    def test_boss_logical_milestones_keep_cross_contact_equipment_comparisons(self):
        from progression_pacing import plan, GROWTH
        root = Path(__file__).resolve().parents[3]
        _, planned = plan(root)
        self.assertLess(planned['bossItemDelivery_1']['groupEffort'],
                        planned['technutItemDelivery_Suit4']['groupEffort'])
        for boss, technut in (('bossItemDelivery_2', 'technutItemDelivery_Suit5'),
                              ('bossItemDelivery_3', 'technutItemDelivery_Suit7')):
            self.assertGreaterEqual(planned[boss]['groupEffort'], planned[technut]['groupEffort'] * GROWTH)
        for number in range(3, 8):
            self.assertGreater(planned[f'bossItemDelivery_{number}']['groupEffort'],
                               planned['technutItemDelivery_Suit7']['groupEffort'])

    def test_stock_rewards_are_visible_in_export(self):
        root = Path(__file__).resolve().parents[3]
        steps, _, warnings = progression.collect(root, balance.tokenize, balance.lua_string)
        self.assertEqual(warnings, [])
        tabs, warnings = progression.build_tabs(root, [], balance.tokenize, balance.lua_string)
        self.assertEqual(warnings, [])
        kinds = {row[2] for row in tabs['Progression unlocks'][1:]}
        self.assertIn('Personal capacity', kinds)
        for step in steps:
            for reward in step['stock']:
                self.assertIn(reward['bonus'], (1, 2))

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
        self.assertTrue(expected <= {slot['pool'] for slot in detector['slots']})
        self.assertEqual(len(detector['slots']), 6)
        self.assertTrue(all(slot['quantity'] >= 1 for slot in detector['slots']))
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
