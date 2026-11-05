# COTZ writing guide

Use this guide before authoring or revising item descriptions, NPC dialogue, or related player-facing
prose. Start with the relevant examples in the [reference index](writing-references/README.md).
This setup establishes writing guidance; it does not rewrite existing runtime text or change mechanics.
Ordinary code-only work does not require the writing references.

## Sources and continuity

GAMMA, Dead Air, and Anomaly subtitles are the initial stylistic references. Choose by relevance to
the object, speaker, and scene; there is no fixed ranking and no requirement to use all three in every
piece. The collections explain particular techniques and their limits, rather than prescribe a single
voice. Write original prose informed by those techniques. Do not splice source lines together or
closely imitate their wording.

Established COTZ characterization and implemented mechanics remain authoritative. External lore,
factions, history, scientific explanations, locations, and gameplay rules do not automatically become
COTZ canon. A reference to batteries, salvage, a military supply route, or a promised reward cannot
establish a corresponding COTZ feature. Distinguish accepted facts, attributed beliefs, rumours, and
new proposals. Mark proposed characterization or world claims outside the draft; do not silently
promote them into maintained profiles or runtime text.

Read the curated local entries first. Follow external sources when deeper context or exact wording
matters, and verify the file, string ID, language, and revision. GAMMA is a collection of contributors:
credit the supplying component where identifiable and distinguish that from proven original authorship.
The Anomaly subtitle project's [translation notes](writing-references/README.md#translation-and-attribution)
apply to every subtitle example. A string's presence verifies the English file, not the accuracy of
its translation or its actual in-game trigger.

If an external source is unavailable, use verified entries already in these collections and relevant
local COTZ definitions/conversations. Record material access or attribution gaps in the handoff. Do not
invent quotations, identifiers, translations, or an unavailable source's contents. Recheck local text
against the current checkout; existing prose is evidence of continuity, not automatically an editorial ideal.

## Item descriptions

Before drafting, inspect the concrete definition, several established family members, the complete base
chain, and description/effect consumers. Establish the effective configuration and what the player sees.
Keep the field names and presentation already used by that family; this guide introduces no item fields.

The regular description identifies the object and its immediate practical role. The long description
must add information beyond that identification. It should reward inspection with relevant detail,
rather than repeat the short text with synonyms. Keep the object explicit: naming the awl, fan,
fabric or flight log is useful when explaining it, and is not the same as repeating its identification.
A single useful addition may be enough; there is no required length or list of subjects for every object.

Use a grounded, varied voice. Explain what the particular object is made from, how its construction
relates to its ordinary purpose, or what someone familiar with it would notice. The
[approved COTZ drafts](writing-references/items.md#approved-cotz-item-drafts) establish the current
direction: an awl's point and palm-sized handle, a cooler's fan and heatsink, aramid's use in layered
textiles, and the information recorded in a flight log. These are examples of useful specificity,
not a sentence pattern or a checklist every item must follow.

Atmosphere should grow out of those details. Dust between cooling fins has a connection to the
cooler's purpose; interchangeable passages about dust, scuffs, missing paperwork or an unknown
previous owner usually add little. Avoid abstract reflections that could describe many unrelated
objects. A longdesc should still make its subject clear when read without the item name above it.
Humour, warmth and unease can fit, but do not give every object the same cynical narrator.

Choose details that suit the item:

- Provenance: manufacture, circulation, repairs, previous use, or signs of handling supported by the item.
- Practical shortcomings: awkward fit, wear, weight, limited scope, or maintenance, where consistent with
  implemented behavior. Do not imply hidden penalties or capabilities through flavour.
- Trade: who values it, why it changes hands, or how scarcity affects its treatment, when established or
  clearly proposed. Do not promise a buyer, price, barter, or salvage action that does not exist.
- Beliefs: what particular people think about it, with a clear distinction between opinion and fact.
- Anomalous uncertainty: concrete observations, conflicting reports, and limits of explanation. Avoid
  presenting unsupported pseudo-science as settled truth or giving every artifact a generic mystery ending.

Use the [item examples](writing-references/items.md) to see how material detail, limitations, and social
context can add substance. Borrow the relationship between details, not external stats or lore. Keep
required usage instructions, live readings, and saved descriptions intact. Do not retune an item to
match prose, or change rendering merely to accommodate a writing preference.

Modest incidental fictional detail is allowed where it fits the established object and setting.
Flag significant new history, named people or organisations, supply routes and other substantial lore
separately for review. An explanation of an object's ordinary purpose does not establish a COTZ
action: a valuable tool or component must not promise working repair, crafting, power or rescue
mechanics merely because its real-world counterpart has those uses.

### Catalogue preservation and review

The current catalogue rewrite uses **`1aa477d9` (22 October 2026)**, the agreed `origin/master`
snapshot, as its fixed historical cutoff. Do not substitute the older local `master` tip or a later
moving branch tip.

- For items present at the cutoff, preserve their current regular descriptions verbatim.
- Preserve current substantive longdescs that were already present at the cutoff verbatim too.
  Older items with no longdesc, a blank value or an explicit placeholder at that cutoff may receive
  one. Longdescs added afterward may be revised within the requested scope, including additions to
  older items. Treat explicit markers such as `PLACEHOLDER` as unfinished text; brevity or awkward
  writing alone does not make an established longdesc a placeholder.
- Newer items may have both fields rewritten. Track identity through IDs and history, accounting for
  moved or renamed files and generated definitions. If eligibility is uncertain, preserve the text
  until its history is established.
- Preservation means leaving the text found before the rewrite unchanged, not restoring wording from
  the cutoff commit. Record questionable protected claims for review instead of correcting them or
  changing gameplay to match them.

Begin a catalogue rewrite by presenting a few representative description/longdesc pairs for user
approval before applying it. Keep them as drafts until approved; the wider rewrite must follow the
agreed voice and scope.
The four linked COTZ examples were accepted as the writing direction on 5 November 2026 and applied
in the subsequent authorised catalogue pass. They remain references for the agreed style, not
permission to alter protected text. The [catalogue review](item-prose-review.md) records coverage,
preservation checks and remaining presentation checks for that pass.

When integrating an authorised batch, keep a coverage checklist, compare related items for useful
distinctions and repeated phrasing, and verify protected text against a pre-edit snapshot. Preserve
names, IDs, tuning, actions, saved instance text and dynamic instructions. Keep archived and bundled
Helix content outside this catalogue rewrite. Keep each Lua prose string literal on one source line,
even when it exceeds the usual code line limit. Run the existing description check from the repository
root with `luatex --luaonly tests/item_descriptions_spec.lua`; check representative inventory, world
and dynamic descriptions in multiplayer when available, and report any display checks left unverified.

## NPC dialogue

Read the [contact index](npc-overhaul/contacts/README.md), the existing contact profile, its bound
conversation, and applicable runtime definitions and consumers before drafting. Resolve actual template
and dialogue bindings; display names can differ from filenames. Read requirements, rewards, prerequisites,
and state checks for work/progression text. Draft planning tables do not override implemented behavior.
Use the [dialogue examples](writing-references/dialogue.md) for relevant conversational techniques.

Let each NPC's priorities determine what they notice, volunteer, conceal, misunderstand, or refuse.
Preserve individual rhythm, vocabulary, humour, relationships, and emotional range. Keep lasting
NPC-specific voice notes in that contact's existing profile, within the task's authorized scope.
Do not turn every trader, researcher, and near-silent operator into an interchangeable veteran.

Give the exchange a purpose: a practical decision, a disclosure, an evasion, a disagreement, or a change
in rapport. Personal questions can warrant developed answers; repeat transactions, interruptions,
deliberate silence, and gestures can warrant brevity. Vary length and conversational shape with purpose.
Do not impose identical sentence counts, mandatory anecdotes, or decorative follow-ups.

Respect knowledge boundaries and the player's actual state. A rumour is not proof; a speaker cannot
know an uncompleted sibling branch or reveal a later twist without support. Warmth should fit the
relationship actually checked. Keep choices natural without assigning the player unwanted feelings,
allegiance, knowledge, or a fixed personality.

Avoid stock aphorisms, compulsory cynicism, repeated catchphrases, and generic atmospheric filler.
Prefer a particular observation or motive over another declaration about how cruel or mysterious the
Zone is. Humour, ordinary irritations, warmth, and uncertainty belong where the person supports them.
Keep job instructions clear and spoken promises consistent with actual rewards and services.

## Editorial review

Review the prose in its actual presentation, together with adjacent descriptions or conversation options:

1. **Grounding:** Are mechanics, quantities, conditions, rewards, locations, and relationship/state claims
   supported? Separate new proposals from established continuity. Preserve IDs and implementation contracts.
2. **Added value:** Does the long description add information? Does each dialogue turn advance its purpose
   or reveal something particular? Cut repetition and filler while preserving purposeful brevity or development.
3. **Voice and variety:** Could another contact say the same line unchanged? Is a shared routine phrase
   justified, or has the speaker lost their personality? Check neighbouring replies for repeated structure.
4. **Source independence:** Is this original prose? Have external lore or mechanics slipped into COTZ?
   Retain translation and attribution uncertainty when discussing evidence.
5. **Integration:** For implemented text, check the owning consumers, formatting, and applicable repository
   checks. Editorial review does not prove in-game display or runtime correctness. For prose-only work,
   deliver a reviewable draft without changing code or silently accepting proposed canon.
