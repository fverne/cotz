"""Keep the editable NPC menu declarations consistent, including the template."""
from pathlib import Path
import sys
import unittest

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
import balance
import progression


class DialogueOrderTests(unittest.TestCase):
    def test_goodbye_is_last_and_common_main_menu_options_have_consistent_order(self):
        folder = Path(__file__).resolve().parents[3] / 'gamemodes/ix_cotz/plugins/dialogue/dialogue'
        priorities = {
            'TradeTopic': 10, 'StartBarter': 20, 'HealTopic': 30, 'RepairItems': 35,
            'StorageTopic': 40, 'PaintSuit': 45, 'ChangeSuitVariant': 46, 'PDAAvatarTopic': 47,
            'NicknameTopic': 48, 'WishTopic': 49, 'JoinArena': 50, 'AboutWorkTopic': 60,
            'GetTask': 65, 'GetTaskByDifficulty': 65, 'AboutProgression': 70,
            'UpgradeTaskReward': 75, 'TutorialTopic': 80, 'Introduction': 90,
            'BackgroundTopic': 90, 'InterestTopic': 95, 'BackTopic': 900, 'GOODBYE': 1000,
        }
        checked = 0
        for path in folder.glob('sh_*.lua'):
            tokens = balance.tokenize(path.read_text())
            for index in range(len(tokens) - 7):
                if [t.value for t in tokens[index:index + 4]] != ['DIALOGUE', '.', 'addTopic', '(']:
                    continue
                if tokens[index + 4].kind != 'string' or tokens[index + 6].value != '{':
                    continue
                topic = balance.lua_string(tokens[index + 4].value)
                end = progression.table_end(tokens, index + 6)
                entries = progression.entries(tokens[index + 6:end])
                options = next((entry[2:] for entry in entries if len(entry) > 2
                                and entry[0].value == 'options' and entry[1].value == '='), None)
                if options is None:
                    continue
                values = progression.array(options, balance.lua_string)
                with self.subTest(file=path.name, topic=topic):
                    if 'GOODBYE' in values:
                        self.assertEqual(values[-1], 'GOODBYE')
                    if topic in {'GREETING', 'BackTopic'}:
                        ranks = [priorities.get(value, 200) for value in values]
                        self.assertEqual(ranks, sorted(ranks))
                checked += 1
        self.assertGreater(checked, 100)
