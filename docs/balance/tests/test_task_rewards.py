"""Audit real task-kit graphs and contact catalogues without executing game Lua."""
from pathlib import Path
import sys
import unittest

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
import balance
import progression

ROOT = Path(__file__).resolve().parents[3]


def literal(tokens):
    if not tokens or tokens[0].value != '{':
        return progression.scalar(tokens, balance.lua_string)
    named, array = {}, []
    for part in progression.entries(tokens):
        if len(part) > 2 and part[0].kind == 'identifier' and part[1].value == '=':
            named[part[0].value] = literal(part[2:])
        elif len(part) > 4 and part[0].value == '[' and part[2].value == ']' and part[3].value == '=':
            named[literal(part[1:2])] = literal(part[4:])
        else:
            array.append(literal(part))
    return named or array


def assigned_table(tokens, start):
    return literal(tokens[start:progression.table_end(tokens, start)])


class TaskRewardAuditTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        folder = ROOT / 'gamemodes/ix_cotz'
        cls.items, cls.pools, cls.jobs = {}, {}, []
        paths = list((folder / 'schema/items').rglob('sh_*.lua'))
        paths += list((folder / 'plugins').glob('*/items/**/sh_*.lua'))
        for path in paths:
            if 'old' in path.parts:
                continue
            data, tokens = {}, balance.tokenize(path.read_text())
            for i in range(len(tokens) - 4):
                if tokens[i].value != 'ITEM' or tokens[i + 1].value != '.' or tokens[i + 3].value != '=':
                    continue
                if tokens[i + 2].value in {'items', 'itemsForcedDrop'} and tokens[i + 4].value == '{':
                    data[tokens[i + 2].value] = assigned_table(tokens, i + 4)
            cls.items[path.stem[3:]] = data
        for path in (folder / 'plugins/randomitem/libs').glob('*.lua'):
            tokens = balance.tokenize(path.read_text())
            for i in range(len(tokens) - 9):
                if [t.value for t in tokens[i:i + 6]] != ['ix', '.', 'randomitems', '.', 'tables', '[']:
                    continue
                if tokens[i + 6].kind != 'string' or tokens[i + 8].value != '=' or tokens[i + 9].value != '{':
                    continue
                try:
                    cls.pools[balance.lua_string(tokens[i + 6].value)] = assigned_table(tokens, i + 9)
                except ValueError:
                    # Unrelated computed pools cannot be task-kit dependencies below.
                    pass
        for path in (folder / 'plugins/jobsystem').glob('sh_*.lua'):
            tokens = balance.tokenize(path.read_text())
            for i in range(len(tokens) - 4):
                if [t.value for t in tokens[i:i + 4]] == ['tempJob', '.', 'reward', '=']:
                    value = (assigned_table(tokens, i + 4) if tokens[i + 4].value == '{'
                             else literal(tokens[i + 4:i + 5]))
                    cls.jobs.append(value)
        tokens = balance.tokenize((folder / 'plugins/jobsystem/libs/sh_taskrewards.lua').read_text())
        cls.constants = {}
        for i in range(len(tokens) - 3):
            if tokens[i].value == 'local' and tokens[i + 2].value == '=' and tokens[i + 3].value == '{':
                cls.constants[tokens[i + 1].value] = assigned_table(tokens, i + 3)

    def test_all_task_reward_graphs_resolve_to_real_items_without_cycles(self):
        visited = set()

        def visit(item_id, chain=()):
            self.assertIn(item_id, self.items, f'missing item reached via {chain}')
            self.assertNotIn(item_id, chain, 'cyclic reward graph')
            if item_id in visited:
                return
            visited.add(item_id)
            item = self.items[item_id]
            for slot in item.get('items', []):
                self.assertGreater(sum(entry[0] for entry in slot), 0)
                for _, pool_id in slot:
                    self.assertIn(pool_id, self.pools, f'missing pool in {item_id}')
                    pool = self.pools[pool_id]
                    self.assertGreater(sum(entry[0] for entry in pool), 0)
                    for _, reward in pool:
                        visit(reward[0], (*chain, item_id))
            for reward in item.get('itemsForcedDrop', []):
                visit(reward[0], (*chain, item_id))

        for item_id in self.items:
            if item_id.startswith('kit_reward_'):
                visit(item_id)
        for rewards in self.jobs:
            for entry in rewards if isinstance(rewards, list) else [rewards]:
                item_id = entry[0] if isinstance(entry, list) else entry
                if isinstance(item_id, str):
                    visit(item_id)
        self.assertGreater(len(visited), 350)
        self.assertGreater(len(self.jobs), 100)

    def test_every_contact_profile_uses_existing_items(self):
        profiles = self.constants['PROFILES']
        self.assertEqual(len(profiles), 19)
        for contact, items in profiles.items():
            self.assertEqual(len(items), len(set(items)), contact)
            for item in items:
                self.assertIn(item, self.items, contact)

    def test_paid_upgrade_topics_are_removed(self):
        folder = ROOT / 'gamemodes/ix_cotz/plugins/dialogue'
        for path in folder.rglob('*.lua'):
            self.assertNotIn('UpgradeTaskReward', path.read_text(), path)
