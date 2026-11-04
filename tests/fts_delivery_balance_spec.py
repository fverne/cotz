"""Run from the repository root: python3 tests/fts_delivery_balance_spec.py."""
import importlib.util
from pathlib import Path
import unittest

ROOT = Path(__file__).resolve().parents[1]
SPEC = importlib.util.spec_from_file_location(
    "fts_delivery_balance", ROOT / "docs/npc-overhaul/tools/fts_delivery_balance.py"
)
balance = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(balance)


class FTSDeliveryBalanceTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.data = balance.snapshot()
        cls.rates, cls.counts, cls.missing = balance.estimate(cls.data)
        cls.bands = balance.make_bands(cls.data, cls.rates)

    def test_positive_weights_duplicate_rows_and_units(self):
        data = {"items": {"test": {"quantity": 20}}, "batches": {"test": [2, 6]}}
        result = balance.distribution([[2, ["test"]], [3, ["test", {"quantity": 10}]],
                                       [0, ["disabled"]], [5, ["other"]]], data)
        self.assertAlmostEqual(result["test"][0], 0.5)
        self.assertAlmostEqual(result["test"][1], 3.8)
        self.assertNotIn("disabled", result)

    def test_fts_counts_and_garbage_sources(self):
        self.assertEqual(sum(self.counts["rp_marsh_cs"]["world"].values()), 607)
        self.assertEqual(sum(self.counts["rp_waystation"]["world"].values()), 159)
        self.assertEqual(sum(self.counts["rp_pripyat_remaster"]["world"].values()), 525)
        self.assertTrue(self.rates["rp_garbage_cotz"])
        self.assertGreater(sum(self.counts["rp_garbage_cotz"]["boxes"].values()), 0)

    def test_world_population_cap_is_shared_between_pools(self):
        for region in balance.MAPS:
            points = sum(self.counts[region]["world"].values())
            expected = min(points * 25 / 101, 76) * 12
            actual = sum(sources.get("world", [0])[0] for sources in self.rates[region].values())
            self.assertAlmostEqual(actual, expected)

    def test_pool_weights_are_normalized_per_source(self):
        # Multiplying every weight in one pool cannot change its item distribution.
        rows = self.data["loot"]["worldspawn_1"]
        scaled = [[row[0] * 7, row[1]] for row in rows]
        before = balance.distribution(rows, self.data)
        after = balance.distribution(scaled, self.data)
        for item in before:
            self.assertAlmostEqual(before[item][0], after[item][0])
            self.assertAlmostEqual(before[item][1], after[item][1])

    def test_custom_box_pool_overrides_both_big_box_materials(self):
        fixture = {
            "presets": {"rp_garbage_cotz": {"containers": [], "plugindata": {
                "worlditemspawner": [], "boxspawner": [[[0, 0, 0], 2, "custom"]],
                "hidestashspawner": [], "anomalycontroller": [],
            }}},
            "loot": {"custom": [[1, ["a"]], [3, ["b"]]]},
            "items": {}, "batches": {}, "cyclic": {},
        }
        rates, _, missing = balance.estimate(fixture)
        self.assertAlmostEqual(rates["rp_garbage_cotz"]["a"]["boxes"][0], 2.5)
        self.assertAlmostEqual(rates["rp_garbage_cotz"]["b"]["boxes"][0], 7.5)
        self.assertEqual(missing, [])

    def test_cyclic_types_and_repeated_pool_rolls(self):
        fixture = {
            "presets": {"rp_marsh_cs": {"containers": [
                {"spawnCategory": "", "cyclicalCategory": "test"},
            ], "plugindata": {
                "worlditemspawner": [], "boxspawner": [], "hidestashspawner": [], "anomalycontroller": [],
            }}},
            "loot": {"custom": [[1, ["a"]]]}, "items": {}, "batches": {},
            "cyclic": {"categoryDefs": {"test": {
                "appearTime": 600, "disappearTime": 3600, "allowedStashTypes": ["one", "two"],
            }}, "stashTypes": {"one": ["custom"], "two": ["custom", "custom", "custom"]}},
        }
        rates, _, _ = balance.estimate(fixture)
        self.assertAlmostEqual(rates["rp_marsh_cs"]["a"]["cyclic"][0], 2)

    def test_bands_are_disjoint_obtainable_and_get_harder(self):
        for (theme, home), groups in self.bands.items():
            seen = set()
            previous = float("inf")
            for tier, items in enumerate(groups, 1):
                self.assertTrue(items)
                self.assertFalse(seen.intersection(items), (theme, home, tier))
                scores = []
                for item in items:
                    self.assertTrue(any(region.get(item) for region in self.rates.values()))
                    if tier == 1:
                        self.assertTrue(self.rates[home].get(item))
                    score = sum(sum(v[0] for v in self.rates[region].get(item, {}).values())
                                * (1 if region == home else 0.1 if region == "rp_pripyat_remaster" else 0.3)
                                for region in balance.MAPS)
                    scores.append(score)
                self.assertLessEqual(max(scores), previous)
                previous = min(scores)
                seen.update(items)

    def test_current_definitions_match_depth_plan(self):
        deliveries = 0
        for slug, contact in self.data["contacts"].items():
            plan = balance.contact_plan(contact)
            if not plan:
                self.assertFalse(contact["progression"], slug)
                continue
            home = balance.starting_region(contact, slug, self.data, self.rates)
            theme = balance.CONTACT_THEMES[slug]
            phases = set()
            for step in contact["progression"]:
                if step["kind"] != "delivery":
                    continue
                deliveries += 1
                tier, _, _ = plan[step["id"]]
                phases.add(tier)
                self.assertEqual(len(step["requirements"]), tier, (slug, step["id"]))
                if slug in {"beanstalk", "egghead", "intern"}:
                    for slot in step["requirements"]:
                        self.assertTrue(all(candidate["item"].startswith("artifact_")
                                            for candidate in self.data["pools"][slot["pool"]]["candidates"]))
                    continue
                for index, slot in enumerate(step["requirements"]):
                    key = balance.band_key(theme, home, index + 1)
                    self.assertEqual(slot["pool"], key)
                    group = self.bands[(theme, home)][index]
                    expected = balance.QUANTITIES[tier - 1][index] * balance.batch_units(
                        group, balance.totals(self.rates)
                    )
                    self.assertEqual(slot["quantity"], expected)
                    actual = [c["item"] for c in self.data["pools"][key]["candidates"]]
                    self.assertEqual(actual, group)
            self.assertEqual(phases, {1, 2, 3, 4}, slug)
        self.assertEqual(deliveries, 307)

    def test_rarity_examples_are_not_raw_pool_weights(self):
        supply = balance.totals(self.rates)
        ratio = supply["value_bolts"][0] / supply["value_med_surgicaltools"][0]
        self.assertGreater(ratio, 40)
        self.assertLess(ratio, 55)
        self.assertIn("worldspawn_garbage_regular", self.counts["rp_garbage_cotz"]["world"])
        self.assertIn("worldspawn_", self.missing)


if __name__ == "__main__":
    unittest.main(verbosity=2)
