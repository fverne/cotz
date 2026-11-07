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

    def test_current_snapshot_matches_definitions_even_with_validation_findings(self):
        self.assertEqual(rewards.LEDGER.read_text(), rewards.render(self.data))

    def test_snapshot_reports_actual_coverage_and_validation_failures(self):
        total = live = planned_only = 0
        for slug, contact in self.data["contacts"].items():
            for step in contact["progression"]:
                functional, planned = rewards.rewards(self.data, slug, step)
                total += 1
                live += bool(functional)
                planned_only += bool(planned and not functional)
        report = rewards.render(self.data, ["Example unresolved dependency"])
        self.assertIn(f"{total} active steps; {live} have functional unlocks", report)
        self.assertIn(f"{total - live - planned_only} have no assigned unlock", report)
        self.assertIn("- Example unresolved dependency", report)
        self.assertIn("`--check` remains strict", report)
        self.assertNotIn("Validation passed", report)

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
        self.assertLess(int(catalogue["flashlight"]["step"][2:]), int(catalogue["headlamp"]["step"][2:]))
        self.assertEqual(self.data["canonical"]["headlamp"], "gasket")

    def test_specialist_categories_are_redistributed(self):
        contacts = self.data["contacts"]
        for slug, items in {
            "technut": ["suit_anorak", "suit_nbc"],
            "suture": ["attachment_kevlar_1", "suit_skat9"],
            "latch": ["attachment_steelplate_1", "mask_cloth"],
            "haggler": ["makarov", "ruger1022"],
            "quartermaster": ["pkm", "svd"],
            "jitters": ["drug_cigarette_1", "medic_medkit_1"],
            "cleaner": ["mp5k", "mp40"],
            "egghead": ["medic_stimpak_3", "detectorveles"],
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
            ("saigasemi545", "quartermaster", "cleaner"),
            ("obrezmalfunction", "quartermaster", "haggler"),
            ("sks", "quartermaster", "haggler"),
            ("kobra", "smartass", "ledger"),
            ("aimpoint", "smartass", "ledger"),
            ("eotech", "smartass", "ledger"),
            ("microt1", "smartass", "ledger"),
            ("accesscard_bunker", "boss", "carbon"),
            ("accesscard_laboratory", "egghead", "intern"),
        ]:
            self.assertNotIn(item, contacts[former]["catalogue"])
            if item in rewards.disabled_suggestions(seller):
                self.assertNotIn(item, contacts[seller]["catalogue"])
            else:
                self.assertIn(item, contacts[seller]["catalogue"])
        for item in ["ak74", "fort12"]:
            self.assertNotIn(item, contacts["quartermaster"]["catalogue"])
        for item in ["mp40", "mp5k"]:
            self.assertIn(item, contacts["cleaner"]["catalogue"])
        self.assertIn("cassette_standart", contacts["spool"]["catalogue"])
        for slug in ["carbon", "jitters", "wake", "beanstalk", "intern", "mute",
                     "spool", "smartass", "suture"]:
            contact = contacts[slug]
            self.assertNotIn("lowtiercookerfuel", contact["supplies"])
            self.assertNotIn("lowtiercookerfuel", contact["catalogue"])
            self.assertFalse(any(s.get("stock", {}).get("item") == "lowtiercookerfuel"
                                 for s in contact["progression"]), slug)

    def test_ammunition_gun_order_and_hp_before_ap(self):
        authoring = runpy.run_path(str(ROOT / "docs/npc-overhaul/tools/ammo_progression.py"))
        ammo = authoring["ammunition"]()
        routes, orders = authoring["allocations"](self.data, ammo)
        self.assertEqual(self.data["ammoOrder"], orders)
        regulars, first_uses = authoring["regular_order"](self.data, ammo)
        self.assertEqual(self.data["regularAmmoChain"], regulars)
        self.assertEqual(len(regulars), len(set(regulars)))
        self.assertEqual(set(regulars), {item for item, entry in ammo.items() if entry["regular"] == item})
        self.assertEqual(regulars[-4:], ["127x55", "145x114", "700nitro", "93x64"])
        self.assertEqual(set(regulars[-4:]), set(regulars) - first_uses.keys())
        self.assertFalse(set(regulars) & set(self.data["ammoVariants"]))
        for slug, expected in routes.items():
            catalogue = self.data["contacts"][slug]["catalogue"]
            for item, step in expected.items():
                self.assertEqual(catalogue[item]["step"], step, (slug, item))
            indices = [int(expected[item][2:]) for item in regulars if item in expected]
            self.assertEqual(indices, sorted(indices), slug)
            for variant, regular in self.data["ammoVariants"].items():
                if variant not in expected:
                    continue
                if regular in expected:
                    self.assertGreater(int(expected[variant][2:]), int(expected[regular][2:]))
                sibling = variant[:-2] + ("hp" if variant.endswith("ap") else "ap")
                if variant.endswith("ap") and sibling in expected:
                    self.assertGreater(int(expected[variant][2:]), int(expected[sibling][2:]))
        self.assertEqual(ammo["145x114"]["cost"], 2 * ammo["145x114ap"]["cost"])
        self.assertEqual(ammo["45acp41"]["regular"], "45acp41")
        self.assertNotIn("145x114", routes["brass"])

    def test_regular_ammunition_order_tracks_changed_gun_chains(self):
        authoring = runpy.run_path(str(ROOT / "docs/npc-overhaul/tools/ammo_progression.py"))
        ammo = authoring["ammunition"]()
        changed = copy.deepcopy(self.data)
        chain = next(chain for chain in changed["chains"] if "p90" in chain)
        chain.remove("p90")
        chain.insert(0, "p90")
        regulars, first_uses = authoring["regular_order"](changed, ammo)
        self.assertEqual(first_uses["57x28"][0], 1)
        self.assertEqual(first_uses["57x28"][3], "p90")
        self.assertLess(regulars.index("57x28"), regulars.index("12gauge"))
        self.assertEqual(first_uses["762x25"][3], "nagantrev")

    def test_ammunition_stage_dependencies_prevent_branch_bypass(self):
        compiled = self.data["compiled"]
        for slug, steps in self.data["ammoOrder"].items():
            for lower, higher in zip(steps, steps[1:]):
                self.assertIn(rewards.progression_id(slug, lower),
                              compiled[rewards.progression_id(slug, higher)]["prerequisites"])
        for slug, contact in self.data["contacts"].items():
            catalogue = contact["catalogue"]
            local_regulars = [item for item in self.data["regularAmmoChain"] if item in catalogue]
            for lower, higher in zip(local_regulars, local_regulars[1:]):
                before = rewards.progression_id(slug, catalogue[lower]["step"])
                after = rewards.progression_id(slug, catalogue[higher]["step"])
                if before != after:
                    self.assertIn(before, compiled[after]["prerequisites"], (slug, lower, higher))
            for variant, regular in self.data["ammoVariants"].items():
                if variant in catalogue and regular in catalogue:
                    self.assertIn(rewards.progression_id(slug, catalogue[regular]["step"]),
                                  compiled[rewards.progression_id(slug, catalogue[variant]["step"])]["prerequisites"])
                if variant.endswith("ap") and variant in catalogue and regular + "hp" in catalogue:
                    self.assertIn(rewards.progression_id(slug, catalogue[regular + "hp"]["step"]),
                                  compiled[rewards.progression_id(slug, catalogue[variant]["step"])]["prerequisites"])

    def test_main_plan_has_no_starting_sale_stock(self):
        for slug, contact in self.data["contacts"].items():
            if contact.get("difficultyMultiplier"):
                self.assertFalse(contact["supplies"], slug)
                self.assertTrue(contact["enforceCatalogue"], slug)
        food = self.data["contacts"]["spicy-lemon"]["catalogue"]
        self.assertIn("drink_bottlewater", food)
        self.assertFalse(any(item.startswith(("meal_", "meat_")) for item in food))

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

    def test_anorak_to_nbc_chain_has_no_cycles(self):
        chain = next(chain for chain in self.data["chains"] if "suit_nbc" in chain)
        self.assertEqual(chain[0], "suit_anorak")
        self.assertEqual(chain[-1], "suit_nbc")
        self.assertEqual(self.data["contacts"]["technut"]["catalogue"]["suit_nbc"]["step"], "TN28")
        self.assertFalse(self.data["compiled"]["cotz/town/technut/TN01"]["prerequisites"])
        # Walk every compiled dependency: an introductory suit must not close a later story loop.
        visiting, done = set(), set()
        def visit(identifier):
            self.assertNotIn(identifier, visiting, identifier)
            if identifier in done:
                return
            visiting.add(identifier)
            for parent in self.data["compiled"][identifier]["prerequisites"]:
                visit(parent)
            visiting.remove(identifier)
            done.add(identifier)
        for identifier in self.data["compiled"]:
            visit(identifier)

    def test_town_progression_has_no_item_gifts(self):
        for slug, contact in self.data["contacts"].items():
            for step in list(contact["progression"]) + list(contact.get("retiredProgression", [])):
                self.assertFalse(step.get("benefits", {}).get("items"), (slug, step["id"]))

    def test_introductions_have_an_implemented_reward(self):
        for slug, contact in self.data["contacts"].items():
            if not contact["progression"]:
                continue
            first = contact["progression"][0]["id"]
            initial = [item for item, route in contact["catalogue"].items() if route["step"] == first]
            functional, _ = rewards.rewards(self.data, slug, contact["progression"][0])
            self.assertTrue(functional, slug)
            if len(contact["catalogue"]) > 2:
                self.assertTrue(any(route["step"] != first for route in contact["catalogue"].values()), slug)

    def test_stock_rewards_follow_their_local_purchase(self):
        for slug, contact in self.data["contacts"].items():
            for step in contact["progression"]:
                item = step.get("stock", {}).get("item")
                route = contact["catalogue"].get(item)
                if route and route["step"] != step["id"]:
                    compiled = self.data["compiled"][rewards.progression_id(slug, step["id"])]
                    self.assertIn(rewards.progression_id(slug, route["step"]), compiled["prerequisites"],
                                  (slug, step["id"], item))

    def test_redundant_stock_is_detected(self):
        changed = copy.deepcopy(self.data)
        contact = changed["contacts"]["atlas"]
        earlier = next(s for s in contact["progression"] if s["id"] == "AT04")
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
