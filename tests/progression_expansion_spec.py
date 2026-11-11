"""Run from the addon root: python3 tests/progression_expansion_spec.py."""
from pathlib import Path
from copy import deepcopy
import sys
import unittest

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "docs/npc-overhaul/tools"))
import expand_progression as expansion
import fts_delivery_balance as supply
import progression_rewards as rewards


class ProgressionExpansionTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.data = supply.snapshot()
        cls.rates, _, _ = supply.estimate(cls.data)
        cls.families = expansion.eligible_items()
        cls.compiled = rewards.snapshot()
        cls.batches = expansion.requirement_batch_sizes(cls.data, cls.families)

    def test_counts_and_regeneration(self):
        steps = [s for c in self.data["contacts"].values() for s in c["progression"]]
        self.assertEqual(len(steps), 631)
        self.assertEqual(sum(bool(s.get("intermissionFor")) for s in steps), 212)
        output, count = expansion.outputs()
        self.assertEqual(count, 212)
        for path, content in output.items():
            self.assertEqual(path.read_text(), content, str(path))

    def test_stock_dialogue_survives_regeneration_by_id(self):
        contacts = deepcopy(self.data["contacts"])
        expected = {}
        for slug, contact in contacts.items():
            for step in contact["progression"]:
                if not step.get("intermissionFor"):
                    continue
                step["briefing"] = "Reserve request: " + slug + "/" + step["id"]
                step["completion"] = "Reserve complete: " + slug + "/" + step["id"]
                expected[slug, step["id"]] = (step["briefing"], step["completion"])
        expansion.expand_contacts(contacts)
        actual = {(slug, step["id"]): (step["briefing"], step["completion"])
                  for slug, contact in contacts.items() for step in contact["progression"]
                  if step.get("intermissionFor")}
        self.assertEqual(actual, expected)

    def test_technut_suit_route_survives_regeneration_without_intermissions(self):
        contacts = deepcopy(self.data["contacts"])
        expected = deepcopy(contacts["technut"]["progression"])
        self.assertEqual(len(expected), 14)
        self.assertFalse(any(step["id"] == "v3/suits/suit_anorak" for step in expected))
        self.assertFalse(any(step.get("intermissionFor") for step in expected))
        expansion.expand_contacts(contacts)
        self.assertEqual(contacts["technut"]["progression"], expected)

    def test_local_introductions_and_explicit_boundary_examples(self):
        contacts = self.data["contacts"]
        for contact in contacts.values():
            for step in contact["progression"]:
                if step["branchIndex"] == 1:
                    self.assertEqual(step["acquisitionMaps"], [contact["map"]])
        intern = {s["name"]: s for s in contacts["intern"]["progression"] if not s.get("intermissionFor")}
        self.assertNotIn("rp_waystation", intern["Artifact Detector (Echo)"]["acquisitionMaps"])
        self.assertEqual(intern["Artifact Detector (Bear)"]["acquisitionMaps"], ["rp_marsh_cs"])
        self.assertNotIn("rp_pripyat_remaster", intern["Artifact Detector (Bear)"]["acquisitionMaps"])
        self.assertIn("rp_pripyat_remaster", intern["Artifact Detector (Veles)"]["acquisitionMaps"])
        self.assertEqual(contacts["ledger"]["difficultyMultiplier"], 3)

    def test_opening_marsh_work_never_rolls_later_map_only_inputs(self):
        protected = 0
        for slug, contact in self.data["contacts"].items():
            if contact["map"] != "rp_marsh_cs":
                continue
            for step in contact["progression"]:
                index, length = step["branchIndex"] - 1, step["branchLength"]
                if index >= 2 and index / max(1, length - 1) >= 0.45:
                    continue
                protected += 1
                self.assertEqual(step["acquisitionMaps"], ["rp_marsh_cs"], (slug, step["id"]))
                for slot in step["requirements"]:
                    for candidate in self.data["pools"][slot["pool"]]["candidates"]:
                        self.assertTrue(self.rates["rp_marsh_cs"].get(candidate["item"]),
                                        (slug, step["id"], candidate["item"]))
        self.assertGreater(protected, 100)

    def test_each_candidate_has_an_eligible_real_regional_source(self):
        for slug, contact in self.data["contacts"].items():
            for step in contact["progression"]:
                phase = (step["branchIndex"] - 1) / max(1, step["branchLength"] - 1)
                maximum = 0 if step["branchIndex"] == 1 else 2 if phase >= 0.75 else 1
                nonlocal_slots, used = 0, set()
                if step["id"] == "v3/hideout/access":
                    tool = {"ballast": "crowbar", "cleaner": "sledgehammer", "ledger": "fubar"}[slug]
                    self.assertEqual(len(step["requirements"]), 1)
                    slot = step["requirements"][0]
                    self.assertEqual(slot["quantity"], 1)
                    self.assertEqual(self.data["pools"][slot["pool"]]["candidates"], [{"item": tool}])
                    if slug == "ballast":
                        self.assertEqual(step["requirementAlternatives"], {"bat": "crowbar"})
                    else:
                        self.assertNotIn("requirementAlternatives", step)
                    continue
                for slot in step["requirements"]:
                    ids = {c["item"] for c in self.data["pools"][slot["pool"]]["candidates"]}
                    self.assertTrue(ids)
                    # Catalogues may overlap; each character's accepted subsets are partitioned at assignment.
                    if slot["mode"] == "any":
                        self.assertEqual("value_nuts" in ids, "value_bolts" in ids, step["id"])
                    used |= ids
                    nonlocal_slot = False
                    for item in ids:
                        self.assertIn(self.families.get(item), {"valuable", "artifact"}, item)
                        self.assertTrue(any(self.rates[m].get(item) for m in step["acquisitionMaps"]), item)
                        if not self.rates[contact["map"]].get(item):
                            nonlocal_slot = True
                    nonlocal_slots += nonlocal_slot
                self.assertLessEqual(nonlocal_slots, maximum, step["id"])

    def test_intermission_pacing_stock_and_dependencies(self):
        for slug, contact in self.data["contacts"].items():
            by_id = {s["id"]: s for s in contact["progression"]}
            for step in contact["progression"]:
                self.assertNotIn("completionCash", step)
                if not step.get("intermissionFor"):
                    continue
                target = by_id[step["intermissionFor"]]
                self.assertEqual(step["branchIndex"], target["branchIndex"])
                self.assertEqual(step["branchLength"], target["branchLength"])
                self.assertEqual(step["acquisitionMaps"], target["acquisitionMaps"])
                self.assertEqual([s["quantity"] for s in step["requirements"]],
                                 [(s["quantity"] + 1) // 2 for s in target["requirements"]])
                self.assertIn(step["id"], target["requires"])
                self.assertTrue(1 <= step["stock"]["bonus"] <= 4)
                identifier = rewards.progression_id(slug, step["id"])
                parents = self.compiled["compiled"][identifier]["prerequisites"]
                for item in expansion.stock_items(step["stock"]):
                    if item in contact["catalogue"]:
                        allocation = contact["catalogue"][item]
                        self.assertIn(rewards.progression_id(slug, allocation["step"]), parents)
                        self.assertTrue(all(allocation["terms"][i] > 0 for i in (3, 4, 5)))
                    else:
                        self.assertIn(item, contact["supplies"])

    def test_category_only_openings_and_later_specific_slots(self):
        any_count = random_count = 0
        for slug, contact in self.data["contacts"].items():
            opening = expansion.opening_steps(contact)
            for step in contact["progression"]:
                introductory = step.get("intermissionFor", step["id"]) in opening
                self.assertEqual(step["categoryOnly"], introductory, (slug, step["id"]))
                for index, slot in enumerate(step["requirements"]):
                    specific = not introductory and not step.get("intermissionFor") and index == len(step["requirements"]) - 1
                    self.assertEqual(slot["mode"], "random" if specific else "any", (slug, step["id"]))
                    if slot["mode"] == "any":
                        any_count += 1
                        if introductory and step["id"] != "v3/hideout/access":
                            self.assertGreaterEqual(len(self.data["pools"][slot["pool"]]["candidates"]), 2,
                                                    (slug, step["id"], "opening category is too narrow"))
                    else:
                        random_count += 1
        self.assertGreater(any_count, random_count)
        self.assertGreater(random_count, 100)
        technut = [s for s in self.data["contacts"]["technut"]["progression"] if s["branch"] == "suits"]
        self.assertEqual([s["name"] for s in technut if s["categoryOnly"]],
                         ["Mail Jacket", "Black Trenchcoat", "Sunrise STALKER Suit"])

    def test_batch_sizes_use_spawned_amounts_instead_of_stack_capacity(self):
        self.assertEqual(self.batches["value_nuts"], 3)
        self.assertEqual(self.batches["value_bolts"], 4)
        self.assertEqual(self.batches["value_capacitors"], 2)
        self.assertEqual(self.batches["value_9vbattery"], 2)
        self.assertEqual(self.batches["value_kerosene"], 2)
        self.assertNotIn("value_sparkplug", self.batches)

    def test_independent_unlocks_do_not_share_a_twenty_percent_budget(self):
        contact = {"progression": [
            {"id": "a", "branch": "shared", "requires": []},
            {"id": "b", "branch": "shared", "requires": []},
            {"id": "c", "branch": "shared", "requires": []},
            {"id": "d", "branch": "shared", "requires": []},
            {"id": "e", "branch": "shared", "requires": []},
            {"id": "f", "branch": "shared", "requires": []},
        ]}
        self.assertEqual(expansion.opening_steps(contact), {"a", "b", "c", "d", "e", "f"})
        contact["progression"][1]["requires"] = ["a"]
        self.assertEqual(expansion.opening_steps(contact), {"a", "c", "d", "e", "f"})
        for step in self.data["contacts"]["wake"]["progression"]:
            if step.get("capacity"):
                self.assertTrue(step["categoryOnly"], step["id"])

    def test_specific_pools_have_comparable_acquisition_frequency(self):
        for contact in self.data["contacts"].values():
            for step in contact["progression"]:
                for slot in step["requirements"]:
                    if slot["mode"] != "random" or slot.get("artifactPool"):
                        continue
                    batches = self.batches
                    scores = [sum(sum(v[1] for v in self.rates[m].get(candidate["item"], {}).values())
                                  for m in step["acquisitionMaps"]) / batches.get(candidate["item"], 1)
                              for candidate in self.data["pools"][slot["pool"]]["candidates"]]
                    self.assertLessEqual(max(scores), min(scores) * 3 + 1e-9, step["id"])

    def test_requests_stay_with_the_contact_specialty(self):
        for slug, contact in self.data["contacts"].items():
            if not contact["progression"]:
                continue
            identity = contact["progressionIdentity"]
            core = {c["item"] for name in identity["core"]
                    for c in self.data["pools"][name]["candidates"]}
            support = {c["item"] for name in identity["support"]
                       for c in self.data["pools"][name]["candidates"]}
            for step in contact["progression"]:
                if step["id"] == "v3/hideout/access" or slug in expansion.SCIENCE and not step.get("intermissionFor"):
                    continue
                core_units, total_units = 0, 0
                for index, slot in enumerate(step["requirements"]):
                    items = {c["item"] for c in self.data["pools"][slot["pool"]]["candidates"]}
                    self.assertLessEqual(items, core | support, (slug, step["id"]))
                    if index < len(step["requirements"]) - 1 or len(step["requirements"]) <= 2:
                        self.assertLessEqual(items, core, (slug, step["id"], "core slot"))
                    total_units += slot["quantity"]
                    if items <= core:
                        core_units += slot["quantity"]
                self.assertGreaterEqual(core_units / total_units, 0.75, (slug, step["id"]))

    def test_unrelated_npcs_no_longer_share_generic_shopping_lists(self):
        def requested(slug):
            return {c["item"] for step in self.data["contacts"][slug]["progression"]
                    for slot in step["requirements"] for c in self.data["pools"][slot["pool"]]["candidates"]}
        brass, medic = requested("brass"), requested("jitters")
        self.assertTrue(any(item.startswith("value_gunpowder_") for item in brass))
        self.assertNotIn("value_med_peroxide", brass)
        self.assertNotIn("value_gunpowder_green", medic)
        self.assertIn("value_med_peroxide", medic)
        self.assertNotIn("value_ballistic4", requested("spicy-lemon"))
        self.assertNotIn("value_coffee", requested("smartass"))
        self.assertNotIn("value_chemicalsample", requested("ledger"))
        # The broad all-theme rotation previously produced 45% mean roster overlap.
        from itertools import combinations
        sets = [requested(slug) for slug, contact in self.data["contacts"].items() if contact["progression"]]
        overlap = [len(a & b) / len(a | b) for a, b in combinations(sets, 2)]
        self.assertLess(sum(overlap) / len(overlap), 0.10)

    def test_snapshot_preserves_sparse_terms_and_numeric_object_keys(self):
        # Vendor terms start with nil; dropping that slot changes every policy field's meaning.
        terms = self.data["contacts"]["old-timer"]["catalogue"]["knife2"]["terms"]
        self.assertEqual(len(terms), 6)
        self.assertIsNone(terms[0])
        self.assertTrue(any(entity.get("bodygroups", {}).get("0") == 0
                            for preset in self.data["presets"].values()
                            for entity in preset.get("entities", [])))


if __name__ == "__main__":
    unittest.main(verbosity=2)
