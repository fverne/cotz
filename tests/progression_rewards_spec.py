"""Regression checks for authored branches and report-only ammunition tooling."""
import copy
import importlib.util
from pathlib import Path
import tempfile
import unittest
from unittest.mock import patch

ROOT = Path(__file__).resolve().parents[1]


def module(name):
    spec = importlib.util.spec_from_file_location(name, ROOT / f"docs/npc-overhaul/tools/{name}.py")
    result = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(result)
    return result


rewards = module("progression_rewards")
ammo = module("ammo_progression")


class ProgressionRewardsSpec(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.data = rewards.snapshot()
        cls.ammo = ammo.ammunition()

    def test_ledger_matches_valid_definitions(self):
        self.assertEqual(rewards.validate(self.data), [])
        self.assertEqual(rewards.LEDGER.read_text(), rewards.render(self.data))
        for slug, contact in self.data["contacts"].items():
            for step in contact["progression"]:
                unlocks = rewards.rewards(self.data, slug, step)[0]
                self.assertTrue(unlocks, (slug, step["id"]))
                self.assertNotIn("completionCash", step)

    def test_directory_maintenance_removed_without_a_roster_gate(self):
        steps = {step["id"]: step for step in self.data["contacts"]["mute"]["progression"]}
        self.assertNotIn("v3/stalkernet/networkRemote", steps)
        self.assertNotIn("v3/stalkernet/networkDossier", steps)
        self.assertNotIn("v3/stalkernet/networkLocation", steps)
        self.assertNotIn("v3/stalkernet/networkActivity", steps)
        self.assertEqual(steps["v3/stalkernet/eventBroadcasts"]["requires"],
                         ["v3/stalkernet/emissionWarnings"])

    def test_fresh_ids_and_hand_in_objectives(self):
        for contact in self.data["contacts"].values():
            for step in contact["progression"]:
                self.assertTrue(step["id"].startswith("v3/"))
                self.assertEqual(step["kind"], "delivery")
                self.assertFalse(step.get("benefits"))
                self.assertFalse(step.get("discounts"))

    def test_gun_changes_never_reorder_authored_ammo(self):
        changed = copy.deepcopy(self.data)
        chain = next(c for c in changed["chains"] if "p90" in c)
        chain.remove("p90")
        chain.insert(0, "p90")
        order, uses = ammo.regular_order(changed, self.ammo)
        self.assertEqual(order, self.data["regularAmmoChain"])
        self.assertEqual(uses["57x28"][0], 1)

    def test_missing_and_duplicate_calibres_fail_validation(self):
        for invalid in (self.data["regularAmmoChain"][:-1], self.data["regularAmmoChain"] + ["22lr"]):
            changed = copy.deepcopy(self.data)
            changed["regularAmmoChain"] = invalid
            with self.assertRaises(ValueError):
                ammo.regular_order(changed, self.ammo)

    def test_ammo_generation_only_writes_a_report(self):
        files = list(rewards.DEFINITIONS.glob("sh_*.lua"))
        before = {p: p.read_bytes() for p in files}
        with tempfile.TemporaryDirectory() as folder:
            report = Path(folder) / "ammo.md"
            with patch.object(ammo, "REPORT", report), patch("sys.argv", ["ammo", "--write"]):
                ammo.main()
            self.assertIn("barter 2:1", report.read_text())
            self.assertIn("barter 3:1", report.read_text())
        self.assertEqual(before, {p: p.read_bytes() for p in files})

    def test_no_cash_routes_for_meat_meals_or_variant_ammo(self):
        for contact in self.data["contacts"].values():
            for item in list(contact["catalogue"]) + list(contact["supplies"]):
                self.assertFalse(item.startswith(("meal_", "meat_")))
                self.assertFalse(item in self.ammo and item.endswith(("hp", "ap")))

    def test_ammo_cross_trader_dependencies(self):
        for slug, contact in self.data["contacts"].items():
            for step in contact["progression"]:
                exchange = step.get("ammoExchange")
                if not exchange:
                    continue
                regular = exchange["input"]
                hp = exchange["output"].endswith("hp")
                branch = "regular-ammo/" + regular if hp else "hp-ammo/" + regular + "hp"
                self.assertEqual(slug, "brass" if hp else "carbon")
                self.assertEqual(exchange["boxes"], 2 if hp else 3)
                self.assertIn("cotz/town/brass/v3/" + branch,
                              self.data["compiled"][rewards.progression_id(slug, step["id"])]["prerequisites"])

    def test_only_wake_awards_capacity(self):
        totals = {"weight": 0, "rows": 0}
        for slug, contact in self.data["contacts"].items():
            for step in contact["progression"]:
                if step.get("capacity"):
                    self.assertEqual(slug, "wake")
                    totals[step["capacity"]["kind"]] += step["capacity"]["amount"]
        self.assertEqual(totals, {"weight": 5, "rows": 2})

    def test_trenchcoat_colours_share_one_step(self):
        catalogue = self.data["contacts"]["technut"]["catalogue"]
        self.assertEqual(len({catalogue["suit_trenchcoat_" + c]["step"]
                              for c in ("black", "brown", "green", "tan")}), 1)

    def test_suture_variants_exclude_looted_finishes(self):
        for item, allocation in self.data["variants"].items():
            self.assertEqual(allocation["contact"], "suture")
            self.assertFalse(item.endswith("_looted"))

    def test_buyers_and_canned_job_rewards(self):
        for slug in ("ballast", "cleaner", "ledger"):
            self.assertTrue(self.data["contacts"][slug]["buyAll"])
            self.assertEqual(self.data["contacts"][slug]["buyScale"], 0.3)
        packages = self.data["contacts"]["spicy-lemon"]["rewards"]["packages"]
        self.assertEqual(len({i for p in packages for i in p["items"] if i.startswith("food_can_")}), 8)

    def test_deferred_or_job_awarded_items_have_no_sale_route(self):
        deferred = {"ij600", "lax410", "ruger1022", "walkman", "cassette_standart",
                    "sharpening_stone", "sharpening_stone_fine", "hidestasher_cutlery"}
        for contact in self.data["contacts"].values():
            self.assertFalse(deferred.intersection(contact["catalogue"]))
            self.assertFalse(deferred.intersection(contact["supplies"]))

    def test_disabled_items_remain_disabled(self):
        for slug, contact in self.data["contacts"].items():
            disabled = rewards.disabled_suggestions(slug)
            self.assertEqual(disabled, set(contact.get("disabledItems", {})))
            self.assertFalse(disabled.intersection(contact["catalogue"]))
            self.assertFalse(disabled.intersection(contact["supplies"]))

    def test_cycles_are_rejected(self):
        changed = copy.deepcopy(self.data)
        identifier = next(iter(changed["compiled"]))
        changed["compiled"][identifier]["prerequisites"] = [identifier]
        with self.assertRaisesRegex(ValueError, "Progression cycle"):
            rewards.validate(changed)

    def test_reports_expose_validation_failures(self):
        report = rewards.render(self.data, ["Example unresolved dependency"])
        self.assertIn("- Example unresolved dependency", report)
        self.assertNotIn("Validation passed", report)


if __name__ == "__main__":
    unittest.main(verbosity=2)
