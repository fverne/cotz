"""Offline checks for the generated town progression allocation ledger."""
import copy
import importlib.util
from pathlib import Path
import re
import runpy
import unittest

ROOT = Path(__file__).resolve().parents[1]
SPEC = importlib.util.spec_from_file_location(
    "progression_rewards", ROOT / "docs/npc-overhaul/tools/progression_rewards.py"
)
rewards = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(rewards)


class ProgressionRewardsSpec(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.data = rewards.snapshot()

    def test_current_ledger_matches_authoritative_definitions(self):
        self.assertEqual(rewards.validate(self.data), [])
        self.assertEqual(rewards.LEDGER.read_text(), rewards.render(self.data))

    def test_every_placeholder_has_an_adjacent_todo(self):
        for slug, contact in self.data["contacts"].items():
            source = (rewards.DEFINITIONS / ("sh_" + slug.replace("-", "_") + ".lua")).read_text().split("\tretiredProgression = {")[0]
            entries = re.findall(r"-- TODO:[^\n]+\n\t{4}\{\n", source)
            planned = sum(len(s.get("plannedUnlocks", [])) for s in contact["progression"])
            self.assertEqual(len(entries), planned, slug)

    def test_todos_alone_do_not_satisfy_unlock_coverage(self):
        changed = copy.deepcopy(self.data)
        step = next(s for s in changed["contacts"]["carbon"]["progression"] if s["id"] == "CA07")
        step.pop("stock", None)
        self.assertTrue(any("CA07: no implemented unlock" in e for e in rewards.validate(changed)))

    def test_arena_has_no_active_progression_or_catalogue(self):
        arena = self.data["contacts"]["arena-master"]
        self.assertFalse(arena["progression"])
        self.assertFalse(arena["catalogue"])
        self.assertTrue(arena["retiredProgression"])

    def test_gasket_owns_lighting(self):
        catalogue = self.data["contacts"]["gasket"]["catalogue"]
        self.assertEqual(catalogue["flashlight"]["step"], "GK06")
        self.assertEqual(catalogue["headlamp"]["step"], "GK16")
        self.assertEqual(self.data["canonical"]["headlamp"], "gasket")

    def test_specialist_categories_are_redistributed(self):
        contacts = self.data["contacts"]
        for slug, items in {
            "technut": ["foregrip", "attachment_steelframe"],
            "suture": ["attachment_kevlar_1", "attachment_ceramicplate_1"],
            "latch": ["attachment_steelplate_1", "crowbar"],
            "haggler": ["mp5k", "striker"],
            "quartermaster": ["mp40", "m1928"],
            "jitters": ["drug_adrenaline", "medic_bandage_2"],
            "cleaner": ["pbssuppressor"],
            "egghead": ["artifact_battery"],
        }.items():
            for item in items:
                self.assertIn(item, contacts[slug]["catalogue"], (slug, item))
        planned = sum(len(s.get("plannedUnlocks", []))
                      for c in contacts.values()
                      for s in list(c["progression"]) + list(c.get("retiredProgression", [])))
        self.assertEqual(planned, 242)

    def test_character_theme_routes(self):
        contacts = self.data["contacts"]
        for item, former, seller in [
            ("c96carbine", "quartermaster", "haggler"),
            ("rugermini14", "quartermaster", "haggler"),
            ("saigasemi545", "quartermaster", "haggler"),
            ("obrezmalfunction", "quartermaster", "haggler"),
            ("sks", "quartermaster", "old-timer"),
            ("kobra", "smartass", "quartermaster"),
            ("aimpoint", "smartass", "quartermaster"),
            ("eotech", "smartass", "quartermaster"),
            ("microt1", "smartass", "quartermaster"),
            ("quest_computeraccess", "egghead", "smartass"),
        ]:
            self.assertNotIn(item, contacts[former]["catalogue"])
            if item in rewards.disabled_suggestions(seller):
                self.assertNotIn(item, contacts[seller]["catalogue"])
            else:
                self.assertIn(item, contacts[seller]["catalogue"])
        for item in ["makarov", "fort12", "mp5k"]:
            self.assertIn(item, contacts["cleaner"]["catalogue"])
        self.assertIn("cassette_standart", contacts["spool"]["catalogue"])
        for slug in ["carbon", "jitters", "wake", "beanstalk", "intern", "mute",
                     "spool", "smartass", "suture"]:
            contact = contacts[slug]
            self.assertNotIn("lowtiercookerfuel", contact["supplies"])
            self.assertNotIn("lowtiercookerfuel", contact["catalogue"])
            self.assertFalse(any(s.get("stock", {}).get("item") == "lowtiercookerfuel"
                                 for s in contact["progression"]), slug)

    def test_ammunition_price_order_and_parallel_upgrades(self):
        authoring = runpy.run_path(str(ROOT / "docs/npc-overhaul/tools/ammo_progression.py"))
        ammo = authoring["ammunition"]()
        routes, orders = authoring["allocations"](self.data, ammo)
        self.assertEqual(self.data["ammoOrder"], orders)
        for slug, expected in routes.items():
            catalogue = self.data["contacts"][slug]["catalogue"]
            for item, step in expected.items():
                self.assertEqual(catalogue[item]["step"], step, (slug, item))
            regulars = sorted((entry["cost"], item) for item, entry in ammo.items()
                              if entry["regular"] == item and item in expected)
            indices = [int(expected[item][2:]) for _, item in regulars]
            self.assertEqual(indices, sorted(indices), slug)
            for variant, regular in self.data["ammoVariants"].items():
                if variant not in expected:
                    continue
                if regular in expected:
                    self.assertGreater(int(expected[variant][2:]), int(expected[regular][2:]))
                sibling = variant[:-2] + ("hp" if variant.endswith("ap") else "ap")
                if sibling in expected and ammo[variant]["cost"] == ammo[sibling]["cost"]:
                    self.assertEqual(expected[variant], expected[sibling])
        self.assertEqual(ammo["145x114"]["cost"], 2 * ammo["145x114ap"]["cost"])
        self.assertEqual(ammo["45acp41"]["regular"], "45acp41")
        self.assertLess(int(routes["brass"]["9x19"][2:]), int(routes["brass"]["145x114"][2:]))

    def test_ammunition_stage_dependencies_prevent_branch_bypass(self):
        compiled = self.data["compiled"]
        for slug, steps in self.data["ammoOrder"].items():
            for lower, higher in zip(steps, steps[1:]):
                self.assertIn(rewards.progression_id(slug, lower),
                              compiled[rewards.progression_id(slug, higher)]["prerequisites"])
        for slug, contact in self.data["contacts"].items():
            catalogue = contact["catalogue"]
            for variant, regular in self.data["ammoVariants"].items():
                if variant in catalogue and regular in catalogue:
                    self.assertIn(rewards.progression_id(slug, catalogue[regular]["step"]),
                                  compiled[rewards.progression_id(slug, catalogue[variant]["step"])]["prerequisites"])

    def test_starting_water_and_earned_bread(self):
        for slug, contact in self.data["contacts"].items():
            self.assertIn("drink_bottlewater", contact["supplies"], slug)
            self.assertIn("drink_bottlewaterdirty", contact["supplies"], slug)
            self.assertNotIn("food_bread", contact["supplies"], slug)
            self.assertNotIn("drink_bottlewater", contact["catalogue"], slug)
            self.assertNotIn("drink_bottlewaterdirty", contact["catalogue"], slug)
            if "food_bread" in contact["catalogue"]:
                self.assertGreater(int(contact["catalogue"]["food_bread"]["step"][2:]), 1)
            for step in contact["progression"]:
                self.assertNotEqual(step.get("stock", {}).get("item"), "food_bread")

    def test_commented_out_suggestions_remain_disabled(self):
        total = 0
        for slug, contact in self.data["contacts"].items():
            disabled = rewards.disabled_suggestions(slug)
            total += len(disabled)
            self.assertEqual(disabled, set(contact.get("disabledItems", {})), slug)
            self.assertFalse(disabled & set(contact["catalogue"]), slug)
            self.assertFalse(disabled & set(contact["supplies"]), slug)
            for step in contact["progression"]:
                self.assertNotIn(step.get("stock", {}).get("item"), disabled, (slug, step["id"]))
        self.assertGreater(total, 0)

    def test_redundant_stock_is_detected(self):
        changed = copy.deepcopy(self.data)
        contact = changed["contacts"]["atlas"]
        earlier = next(s for s in contact["progression"] if s["id"] == "AT06")
        later = next(s for s in contact["progression"] if s["id"] == "AT20")
        later["stock"] = copy.deepcopy(earlier["stock"])
        self.assertTrue(any("AT20: redundant stock" in e for e in rewards.validate(changed)))

    def test_unimplemented_item_typos_are_detected(self):
        changed = copy.deepcopy(self.data)
        step = next(s for s in changed["contacts"]["haggler"]["progression"] if s.get("plannedUnlocks"))
        step["plannedUnlocks"][0]["inputs"][0]["item"] = "does_not_exist"
        self.assertTrue(any("invalid planned item terms" in e for e in rewards.validate(changed)))

    def test_barter_requires_distinct_inputs(self):
        changed = copy.deepcopy(self.data)
        step = next(s for s in changed["contacts"]["latch"]["progression"] if s.get("plannedUnlocks"))
        terms = step["plannedUnlocks"][0]["inputs"]
        terms[1]["item"] = terms[0]["item"]
        self.assertTrue(any("barter needs distinct" in e for e in rewards.validate(changed)))

    def test_cycles_are_rejected(self):
        changed = copy.deepcopy(self.data)
        changed["compiled"]["cotz/town/atlas/AT01"]["prerequisites"] = ["cotz/town/atlas/AT17"]
        with self.assertRaisesRegex(ValueError, "Progression cycle"):
            rewards.validate(changed)

    def test_storage_proposals_remain_bounded(self):
        changed = copy.deepcopy(self.data)
        step = next(s for s in changed["contacts"]["cleaner"]["progression"]
                    if s.get("plannedUnlocks") and s["plannedUnlocks"][0]["kind"] == "storage")
        step["plannedUnlocks"][0]["target"] = 100
        self.assertTrue(any("storage proposal exceeds" in e for e in rewards.validate(changed)))


if __name__ == "__main__":
    unittest.main(verbosity=2)
