# Dialogue writing references

[Writing guide](../writing-guide.md) · [Reference index](README.md) · [Item collection](items.md)

These four examples use editorial paraphrases. They illustrate different conversational purposes,
not replacement voices for COTZ contacts. File context suggests the subtitle situations below; no audio
or in-game trigger was checked. Apply the index's [translation caveat](README.md#translation-and-attribution)
to all three Anomaly examples. Presence in the English XML does not verify the Russian meaning.

## DA-DIALOGUE-01 — Sidorovich redirects ambition into work

- Source: [verified source file](https://github.com/Appuruu/dead-air-english-translation/blob/d61323cc7b1a77fb53bd51e2dc06166f3dfb9004/gamedata/configs/text/eng/st_dialog_manager.xml).
- File: `gamedata/configs/text/eng/st_dialog_manager.xml`.
- String ID: `drx_sl_esc_m_trader_game_start_dialog_1_1`.
- Revision: `d61323cc7b1a77fb53bd51e2dc06166f3dfb9004` (repository commit; checked 2026-11-05).

**Context:** Sidorovich's opening answer to a player seeking the Wish Granter, in Appuruu's Dead Air
English translation. The surrounding comment credits **DoctorX Questlines 1.6**, dated October 6, 2016;
the file header identifies CoC 1.4.21 / DoctorX Questlines 1.20, revised December 21, 2016. Those are
upstream component notes, distinct from the repository revision above.

**Paraphrase:** The trader first mocks the ease of reaching the Wish Granter, dismisses the legend,
then channels the newcomer's wish for wealth toward contacts and paid work.

**What COTZ can learn:** A practical referral can also reveal self-interest and a way of handling people.
The answer changes direction rather than stacking ominous remarks. Keep only techniques appropriate to
the target contact; do not transfer Sidorovich's mockery to everyone, treat his dismissal as verified lore,
or copy the source's stock warnings and length. In COTZ, referrals and PDA updates must actually exist
before the speaker promises them.

## AS-01 — A musician's small hesitation

- Source: [verified source file](https://github.com/antglobes/Anomaly-Subtitles/blob/8f33614e95a12b5a5ba886546ae6a9ad05c380d6/gamedata/configs/text/eng/st_as_sub_bandit_1_talk.xml).
- File: `gamedata/configs/text/eng/st_as_sub_bandit_1_talk.xml`.
- String ID: `as_sub_characters_voice_human_bandit_1_talk_intros_intro_music_4`.
- Revision: `8f33614e95a12b5a5ba886546ae6a9ad05c380d6` (repository commit; checked 2026-11-05).

**Context:** Bandit voice set 1, music introduction. The nearby translator comment explicitly discusses
uncertainty over the word transcribed as `Labush` and proposes a contextual reading about playing.

**Paraphrase:** The speaker wonders whether their hands still remember how to play.

**What COTZ can learn:** A brief, ordinary concern can give someone human texture without a biography
or grand statement about survival. Tentativeness before a small social act offers a different register
from a threat or job briefing. Use such a moment only where the contact and scene support it; it does
not establish that a COTZ NPC plays music.

**Translation status:** Especially tentative: the file includes a local interpretation note as well
as the project's general machine-translation warning. This paraphrase describes the English rendering,
not a verified Russian idiom or performance.

## AS-02 — Gratitude after help

- Source: [verified source file](https://github.com/antglobes/Anomaly-Subtitles/blob/8f33614e95a12b5a5ba886546ae6a9ad05c380d6/gamedata/configs/text/eng/st_as_sub_human_ecolog_1.xml).
- File: `gamedata/configs/text/eng/st_as_sub_human_ecolog_1.xml`.
- String ID: `as_sub_characters_voice_human_ecolog_1_alife_defence_actor_help_1_pda`.
- Revision: `8f33614e95a12b5a5ba886546ae6a9ad05c380d6` (repository commit; checked 2026-11-05).

**Context:** Ecologist voice set 1, `alife_defence/actor_help` PDA variant. The path suggests an
acknowledgement after help during defence; exact trigger conditions and reward behavior were not checked.

**Paraphrase:** The speaker thanks the helper and invites them to the base, indicating that appreciation
will follow there.

**What COTZ can learn:** Gratitude can be direct, warm, and forward-looking. The social invitation
distinguishes it from both the musician's hesitation and the guard's boundary below. A COTZ contact can
acknowledge help in their own register without adding a veteran's maxim. Do not turn unspecified thanks
into an item gift, payment, service, or new base interaction without runtime support.

**Translation status:** English text verified; Russian/audio meaning unverified. Neighbouring entries
contain visibly garbled translations, so a readable line is not evidence that this voice set was
uniformly human-checked. The non-PDA identifier has conflicting duplicates; this entry uses the unique
PDA identifier above. Treat the promise's exact force cautiously.

## AS-03 — A guard makes conversation conditional

- Source: [verified source file](https://github.com/antglobes/Anomaly-Subtitles/blob/8f33614e95a12b5a5ba886546ae6a9ad05c380d6/gamedata/configs/text/eng/st_as_sub_scenario_bar_bar_guard.xml).
- File: `gamedata/configs/text/eng/st_as_sub_scenario_bar_bar_guard.xml`.
- String ID: `as_sub_characters_voice_scenario_bar_bar_guard_bar_guard_hello`.
- Revision: `8f33614e95a12b5a5ba886546ae6a9ad05c380d6` (repository commit; checked 2026-11-05).

**Context:** Scenario bar guard greeting, separate from that file's entry permission and warning strings.
The greeting asks the listener to put away their weapon before talking.

**Paraphrase:** The guard offers conversation while requiring the weapon to be hidden.

**What COTZ can learn:** One short turn can combine approachability and a firm boundary. Its brevity
has a concrete purpose; a hostile monologue would obscure it. A COTZ speaker's boundary should reflect
their role and the actual scene. Preserve existing weapon and access checks; prose alone must not imply
a new restriction or permission system.

**Translation status:** English XML verified; no entry-specific human verification was established.
The project-wide machine-translation caveat still applies despite the straightforward English.

## Verified local grounding

For a continuity check or unavailable external source, use an actual COTZ contact rather than inventing
source dialogue. [Mute's existing profile](../npc-overhaul/contacts/mute.md) records implemented near-silence,
gestures, guarded working space, and understated humour. Follow its links to the
[bound conversation](../../gamemodes/ix_cotz/plugins/dialogue/dialogue/sh_stalkernetadmin.lua) and
[work/progression definition](../../gamemodes/ix_cotz/plugins/townnpcs/definitions/sh_mute.lua).
These were inspected during setup; read current consumers and conditions for each request. The external
examples cannot justify making Mute chatty, importing another speaker's personality, or revealing a
later branch early. Long-term voice notes remain in the existing profile.
