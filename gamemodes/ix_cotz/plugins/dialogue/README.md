# NPC dialogue

Each town conversation declares DIALOGUE.townContact and its root action IDs. At InitializedPlugins,
[townnpcs](../townnpcs/README.md) binds its contact data through dialogue's
libs/sh_towncontacts.lua. That file owns the shared work/progression handlers. Superseded per-NPC
job and progression topics are deleted, rather than replaced or hidden at runtime.

Dialogue text and choices use the original ixSmallFont; speaker names use stalkerregulartitlefont,
including their original font sizes. The shared [COTZ styling](../../../../docs/ui-style.md) supplies slim
scrollbars. Static and dynamic choices both wrap and preserve inherited label height updates.
The existing dialogue frame artwork and keyboard shortcuts are retained.

Ordinary dialogue, flavour and service responses stay in the conversation file. Shared trading uses
ix.dialogue.AddTradeTopic from integrations/sh_trade.lua; it does not copy another NPC's tree.
Task prompts, briefings and completion text stay beside the contact's jobs/progression definitions.

All 27 town contacts offer a two-part personality exchange through SpecialtyTopic and
InterestTownFollowup in the questions menu. These are ordinary conversations available whenever
the contact is accessible. Mute responds through gestures. Work explanations, finite briefings and completion replies, and completed greetings live in the
contact definitions. The November 2026 roster pass replaces repetitive commission text and expands
personal exchanges, while retaining developed Atlas dialogue and suitable existing introductory text.
Work offers show the contact's explanation before difficulty selection; active work still shows the
saved assignment details. Mute's work explanation and written field orders remain nonverbal.

The subsequent personality expansion adds two subjects per contact through InterestZoneLifeTopic and
InterestTownRelationsTopic, with a contextual InterestPersonalFollowup. These explore everyday Zone
experience and existing relationships, using the same questions menu and access as other personal topics.
The existing contact profiles identify the newly authored characterization separately from established
history. This expansion leaves all work and progression dialogue unchanged.

The remaining ordinary dialogue now follows those expanded profiles: greetings, returns, farewells,
trade and service wording, background questions, advice, contact discussions, and The Original's story
pool. Atlas retains his established survey background and observation exchange. Mute's avatar service
uses the same nonverbal presentation as his personal replies, including payment failures. Existing
topic links, callbacks, fees, eligibility checks, and random-story selection are preserved; no dormant
topic is enabled. Work prompts and progression text remain in their unchanged owning definitions.

Conversation definitions live in dialogue/sh_<dialogueID>.lua. The existing loader discovers
these shared files and registers their topics on both realms. Vendor templates bind to them
through dialogueid.

Technut opens the combined [gear and suit customization window](../gearcustomization/README.md)
from his root menu after the painting progression unlock. Each confirmed gear or suit change costs
100 rubles. The server checks the unlock when opening, quoting and confirming customization.
Suture's conversions and Mute's PDA appearance options sit under gear customization. Suture's progression labels distinguish suit variants from suit purchases. Ammunition exchanges sit under barter.
Quartermaster's two gunpowder-for-ammunition-kit exchanges are removed from the main menu. His six regular
currency-for-ammunition barters remain under barter. These menus retain the owning service's access checks. Barter roots are hidden until an active legacy
barter or an available child service exists; ammunition exchanges require at least one unlocked recipe.
Suture's conversion root also stays hidden until a variant is unlocked, regardless of carried suits.
Free hideout claims and ordinary paid repair/treatment retain their existing starting access.

## Main menu and questions

The root contains trade, barter, services, repeatable work, progression, available reward/exchange actions,
**Can I ask you something?**, and Goodbye, where those actions exist.

The shared loader groups the offered BackgroundTopic, InterestTopic, TutorialTopic,
SpecialtyTopic, AdviceTopic, and ContactsTopic entries into QuestionsTopic after task-reward
integration. Keep text, callbacks, and ShouldAdd conditions in the NPC definition; there is no
need to duplicate the grouping logic in every conversation file.

InterestZoneLifeTopic and InterestTownRelationsTopic are also explicit entries in that grouping list.
Their InterestPersonalFollowup uses the existing Interest-prefix rule to return to the questions menu.

Only topics actually offered by GREETING or BackTopic are collected. Commented-out or otherwise
unoffered topics are not enabled. NPCs with no offered flavour topics get no empty submenu.
When all collected topics are conditionally unavailable, the submenu entry is hidden.

BackgroundTopic*, Interest*, and TutorialTopic* follow-up branches return through
QuestionsBackTopic instead of the main BackTopic. The six entry topics above follow the same
rule. Services, jobs, and progression continue to use BackTopic for the main menu. Questions
include a main-menu return; Goodbye remains at the root. Actionable Introduction topics stay at root.

New flavour topic families should be added deliberately to the shared classifier and regression
checks. Do not classify topics by their player-facing text: a question can also be a service action.
Keep a BackTopic main menu and GOODBYE in each complete conversation.

The generated questions entries have empty responses so grouping does not add new spoken lines
to silent characters. Personality and conversation text remain with the individual NPC.

## Checks

From the repository root:

    luatex --luaonly tests/dialogue_order_spec.lua
    luatex --luaonly tests/town_dialogue_menus_spec.lua
    luatex --luaonly tests/task_rewards_spec.lua
    luatex --luaonly tests/progression_spec.lua

The standalone checks cover root actions, question navigation and conditions, reward integration,
and existing UI behaviour with mocks. In multiplayer, verify main menu → questions → a nested
reply → question list → main menu, Goodbye/Escape, and normal trade/service/job flows for old and
new NPCs. Also check an NPC whose questions are locked and one with no flavour topics.

Assignment details appear only while the character has an assignment from that NPC. There is no
Claim rewards submenu: available exchanges and recoverable stored items appear directly at the main
menu, with the existing server validation and pending reward queues. Names appear above every reply.
Option colors use muted amber for jobs, lavender for progression, red for services and barter,
teal for trading, warm off-white for flavour and other dialogue, and grey for back/goodbye.
Categories use explicit action identities rather than substrings of topic IDs. Dynamic barters sharing
the reward resolver declare their service category. Static and dynamic options brighten slightly on
mouseover while preserving their category tint.

Trading and Technut's customization window open without replacing the current dialogue choices.
Escape cancels the foremost related window or returns through the dialogue's back choice; at the
root it says goodbye. Holding Escape for one second closes the entire interaction. Shared COTZ
frames opened during dialogue participate in this navigation, including confirmation cancellation.
The Escape handler remains at the original Garry's Mod hook stage after Helix plugin dispatch.

Repeatable task acceptance reveals no reward choices. Once the objective is complete, the issuing
contact reveals choices through Complete the assignment; choosing one finishes the hand-in.
Five-task bonuses appear only after they are earned. The root shows ready reward choices and
recoverable earned claims, with the existing access, distance and action-rate checks. See the
[jobsystem reward guide](../jobsystem/README.md#task-rewards-and-existing-kits).
