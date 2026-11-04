# Relationships and editable dialogue

[Design index](README.md) · [Roster](roster.md)

These relationships are proposed flavour, not a licence to change existing personalities.
Review each old contact's current conversation and template before writing final lines.
Use two or three prominent relationships per contact, with secondary references during relevant chapters.
No ordinary gossip, directions, or referrals should disclose secret Hoarder's identity or appearance rules.

## Social circles

| Contact | Proposed relationships and conversational direction |
| --- | --- |
| Old Timer | Trusts Spicy Lemon and Technut; tolerates Haggler; respects Wake's persistence. Questions the reliability of The Original's stories. |
| Spicy Lemon | Argues with Spoor about usable meat versus specimens and with Jitters about healthy food. Quietly makes sure Old Timer eats. |
| Haggler | Calls Brass inflexible and Ledger obsessed with paperwork. Respects Cleaner's discretion; complains about competitors' prices. |
| Jitters | Depends on Spicy Lemon's food and Gasket's clean water. Dislikes Arena Master's attitude to injury; values Wake's recovery information. |
| Technut | Enthusiastic about Latch's machinery. Argues with Mute over modifications and wants to improve Gasket's improvised repairs. |
| Mute | Rare pointed remarks about Technut; terse, reliable dealings with Spool; guarded professional suspicion of Smartass. Silence and short responses remain important. |
| The Original | Corrects Old Timer's accounts; claims memories Carbon cannot verify. Respects Spoor's field knowledge more than modern instruments. |
| Atlas | Trusts Ballast's local knowledge and Ledger's records. Cross-checks The Original's stories; works with Wake on missing routes. |
| Gasket | Complains about Technut borrowing parts and Haggler's fuel prices. Gives the clinic's water needs priority. |
| Ballast | Mocks Atlas for mapping changing ground. Respects Ledger's packing; distrusts Haggler's shipment weights. |
| Cleaner | Judges Ledger by results and Haggler by discretion. Calls Wake sentimental, yet occasionally supplies a useful recovery lead. |
| Arena Master | Praises Brass' supply and Suture's workmanship. Deflects Jitters' criticism; considers Boss overly serious. |
| Beanstalk | Worries about Vesper's risk-taking; debates Egghead's priorities; checks Intern's preparations. |
| Smartass | Trades technical jabs with Spool, questions Mute's secrecy, needles Quartermaster, becomes careful when discussing Boss. |
| Latch | Likes Technut's enthusiasm but complains about specifications. Supplies Gasket; exchanges useful material finds with Suture. |
| Spoor | Respects Old Timer, disputes The Original's mutant accounts, argues with Spicy Lemon over carcasses. |
| Brass | Trusts Quartermaster's discipline, dislikes Haggler's bargaining, demands accurate ammunition accounts from Arena Master. |
| Wake | Works with Atlas and Spool; challenges Boss when secrecy obstructs recovery; recognises concern beneath Old Timer's sternness. |
| Vesper | Respects Egghead's knowledge, challenges laboratory assumptions, finds Beanstalk overcautious, checks Intern's field equipment. |
| Quartermaster | Values Brass, Ledger, and Suture as suppliers. Has little patience for Smartass; reports professionally to Boss. |
| Boss | Depends on Quartermaster; finds Smartass useful but irritating. Respects Ledger; regards Wake's justified questions as inconvenient. |
| Egghead | Debates Beanstalk, relies on Intern, exchanges records with Carbon, values Vesper's field observations. |
| Intern | Seeks Egghead's approval, appreciates Beanstalk's concern, trusts Vesper's advice; occasionally reveals an unfair workload. |
| Suture | Respects Quartermaster's specifications, complains about arena equipment damage, exchanges materials with Latch. |
| Ledger | Depends on Ballast, Cleaner, and Spool; documents disputes with Haggler; appreciates intact cargo. |
| Spool | Helps Wake recognise missing callers, respects Mute's ability, argues technically with Smartass. |
| Carbon | Cross-checks The Original, exchanges records with Egghead, clashes with Boss over restricted documents. |

## Dialogue layers

| Layer | When available | Purpose and example |
| --- | --- | --- |
| Stable gossip | Ordinary conversation, subject to known contacts. | Gasket: “Technut borrowed a regulator. Said he'd improve it. I'd settle for getting it back.” |
| Useful referral | When the destination and service are available or the lock can be explained. | Old Timer: “Need ammunition in quantity? Brass, over in Garbage. Count your rounds before you start arguing prices.” |
| Personal reaction | Relevant milestone completed by this player character. | Spool: “Wake said you found their recorder. I kept that frequency open for weeks.” |
| Relationship change | A shared story's required personal milestones completed. | Technut and Latch acknowledge completing a restoration; Beanstalk and Vesper revise an earlier disagreement. |
| New greeting | Meaningful relationship milestone or story completion. | Old Timer: “Still in one piece? Good. Pull up a chair.” |

Avoid implying that one player's personal milestone happened for every character. Gossip can describe
shared world changes only when that state is genuinely global. Do not require NPCs to magically know
undisclosed discoveries; explain the report, recording, or referral that carries information.

Proposed joint stories: Technut/Latch restoration; Beanstalk/Vesper conflicting field observations;
Wake/Boss restricted expedition records. They should change dialogue without forcing whole-roster
completion or creating circular prerequisites.

## Authoring requirements

The user must be able to change text without searching reward, networking, or persistence code.
Keep each contact's editable material easy to locate:

- Greetings, backgrounds, personality lines, ordinary gossip, directions, and exits.
- Repeatable-work explanation naming the single job specialty, difficulty locks, and reward explanation.
- Progression briefing, requirement explanation, partial hand-in response, checkpoint text, completion,
  return directions, and pending-reward explanation.
- Relationship topics with explicit unlock conditions, before/after lines, and priority.
- Service descriptions, purchase unlock announcements, and precise provider/location referrals.

Proposed topic record fields: stable topic key, player prompt, NPC response, availability condition,
priority, and return/exit destination. These are authoring requirements, not an implemented new API.
Use existing dialogue registration where it fits; choose the smallest data-driven extension needed.
Keep simple authored conditions declarative where supported; reserve code callbacks for actual logic.

Root menu ordering: trade/barter, services, work, progression, **Can I ask you something?**, then GOODBYE.
Background, gossip, advice, specialty explanations, tutorials, and contact information belong in
that questions submenu. The shared dialogue loader groups the currently offered flavour topics;
NPC definition files retain their editable text and conditions. Flavour replies return to the
questions list, with a separate way back to the main menu. Actionable access introductions stay at root.
Every branch needs a way back or out. Do not display a future unlock as already purchasable.
Show the actual saved requirements and reward details alongside flavour text.
