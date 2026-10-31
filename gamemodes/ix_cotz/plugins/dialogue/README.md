# NPC dialogue

Conversation definitions live in dialogue/sh_<dialogueID>.lua. The existing loader discovers
these shared files and registers their topics on both realms. Vendor templates bind to them
through dialogueid.

## Main menu and questions

The root contains trade, barter, services, repeatable work, progression, reward claims,
**Can I ask you something?**, and Goodbye, where those actions exist.

The shared loader groups the offered BackgroundTopic, InterestTopic, TutorialTopic,
SpecialtyTopic, AdviceTopic, and ContactsTopic entries into QuestionsTopic after task-reward
integration. Keep text, callbacks, and ShouldAdd conditions in the NPC definition; there is no
need to duplicate the grouping logic in every conversation file.

Only topics actually offered by GREETING or BackTopic are collected. Commented-out or otherwise
unoffered topics are not enabled. NPCs with no offered flavour topics get no empty submenu.
When all collected topics are conditionally unavailable, the submenu entry is hidden.

BackgroundTopic*, Interest*, and TutorialTopic* follow-up branches return through
QuestionsBackTopic instead of the main BackTopic. The six entry topics above follow the same
rule. Services, jobs, and progression continue to use BackTopic for the main menu. Questions
include both a main-menu return and Goodbye. Actionable Introduction topics stay at root.

New flavour topic families should be added deliberately to the shared classifier and regression
checks. Do not classify topics by their player-facing text: a question can also be a service action.
Keep a BackTopic main menu and GOODBYE in each complete conversation.

The generated questions entries have empty responses so grouping does not add new spoken lines
to silent characters. Personality and conversation text remain with the individual NPC.

## Checks

From the repository root:

    luatex --luaonly tests/dialogue_order_spec.lua
    luatex --luaonly tests/task_rewards_spec.lua
    luatex --luaonly tests/progression_spec.lua

The standalone checks cover root actions, question navigation and conditions, reward integration,
and existing UI behaviour with mocks. In multiplayer, verify main menu → questions → a nested
reply → question list → main menu, Goodbye/Escape, and normal trade/service/job flows for old and
new NPCs. Also check an NPC whose questions are locked and one with no flavour topics.
