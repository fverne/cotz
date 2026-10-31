# Town NPC overhaul design

Runtime and design reference, 31 October 2026. **Town NPC implementation is now present.**
There are 27 town contacts (15 existing, 12 new) with 646 new finite nodes.
Carbon is included in the new-contact definitions. Arena Master is based in Marsh.
See the [runtime/editing guide](../../gamemodes/ix_cotz/plugins/townnpcs/README.md)
and [unlock ledger](unlock-ledger.md). Physical placement, field-site authoring, economy/pacing,
and multiplayer verification remain deployment work.
This folder records the conversation's current direction, replacing earlier roster drafts.
It is intended for both human review and future implementation work.

## Reading order

| Document | Use |
| --- | --- |
| [Roster and progression arcs](roster.md) | All 27 contacts: map, job category, personality, chapters, rewards, and proposed step counts. |
| [Progression and reward rules](progression-and-rewards.md) | Objective mix, long-term pacing, purchase unlock preservation, and reward ownership. |
| [Old Timer worked example](old-timer.md) | A concrete 28-step draft, branch structure, reward redistribution, and sample dialogue. |
| [Individual contact designs](contacts/README.md) | The other 26 NPCs: 618 named objectives, chapter plans, small rewards, dialogue samples, and upgrade gates. |
| [Relationships and dialogue](dialogue-and-relationships.md) | Social connections, referrals, progression reactions, and editable dialogue requirements. |
| [Implementation handoff](implementation.md) | Source locations, definition-file design, missing mechanics and verification. |

## User requirements

- Overhaul old and new town contacts together. Existing NPC names, models, and personalities remain.
- Include Marsh, the upcoming STALKER-inspired Garbage, and Waystation as NPC home maps.
- Pripyat has no NPCs. Contacts elsewhere send players there and receive their hand-ins and claims.
- Each NPC offers one repeatable job category. A category may recur on another home map,
  but two NPCs on the same home map must not offer it.
- Finite progression should take a long time to complete across the roster, with many small unlocks.
- Roughly every second finite objective should be an ordinary item hand-in or job-completion tracker.
- Keep every current progression vendor item unlock obtainable across the NPC roster;
  the item need not remain with its current seller.
- Gate direct equipment upgrades behind the lower-tier item's progression unlock. Prefer the same
  NPC's ordered branch; when sellers differ, require the relevant earlier milestone at the other NPC.
- Use easy-to-edit definitions for NPC dialogue and other authored content.
- Exclude ???, Computer, and the community NPC from this town overhaul.
- Hoarder is also excluded: he remains a secret NPC that appears periodically.
  Do not turn him into a permanent contact or advertise him through ordinary referrals.
- All contacts are now implemented with editable work and sparse progression trees.
- Arena Master remains in Marsh, where the arena dupe is located.
- Keep the trees sparse: two narrow branches rather than one long line or a dense web.

## Working design, subject to review

| Home | Existing contacts | New contacts | Total | Proposed finite steps |
| --- | ---: | ---: | ---: | ---: |
| Marsh | 8 | 3 | 11 | 270 |
| Garbage | 3 | 5 | 8 | 190 |
| Waystation | 4 | 4 | 8 | 186 |
| Pripyat | 0 | 0 | 0 | 0 |
| **Total** | **15** | **12** | **27** | **646** |

The 646 town nodes are registered from contact definitions. Standalone non-town content is separate;
replaced town definitions and migration/legacy compatibility paths are removed.
Their count does not establish a completion-time promise.
The previously discussed per-contact ranges now total **544–704**, after removing the
community NPC and Hoarder. Earlier 29-contact totals are obsolete.

Map identities: Marsh establishes survival and community; Garbage centres on salvage,
hunting, and contested trade; Waystation organises specialist preparation and expeditions.
Pripyat provides demanding objectives and discoveries without town services.
An NPC's home does not restrict all their objectives to that map.

Job categories here are player-facing specialties. Medical deliveries and ammunition
deliveries use similar mechanics but distinct item lists. Equipment recovery remains
one category regardless of the case's contents. Do not disguise duplicate categories
through different names. Runtime category IDs are generated per contact and difficulty from its editable job definition.

## Decisions still open

1. Review the implemented unlock ledger and item-family pacing in live play.
2. Garbage's identifier is mz_garbage; final landmarks, travel links, loot placement and NPC positions still need authoring.
3. Playtest the configured quantities, cumulative job thresholds, prices and reward amounts.
4. Final main-story travel gates, arrival rules, and cross-NPC prerequisites.
5. Verify current character persistence and reward recovery in multiplayer.
6. New field-story mechanics and any visible town changes or functional ferry crossings.
7. Final models and refined flavour dialogue for new NPCs.
8. Boundary between preserved secret Hoarder content and redistribution of his current unlocks.

The loaded definitions are authoritative for quantities, mechanics, rewards, and prerequisites.
Contact documents preserve narrative direction alongside a runtime section. A story about several
landmarks currently uses a single configured field assignment unless its definition says otherwise;
custom multi-site investigations and visible town changes remain future work.

## Related references

- [Map content design](../map-content-design.md)
- [Map setup](../map-setup.md)
- [Repository layout](../repository-layout.md)
- [Current dialogue source guide](../balance/progression/dialogue-guide.md)
- [Current progression runtime](../../gamemodes/ix_cotz/plugins/progression/README.md)
- [Current jobsystem runtime](../../gamemodes/ix_cotz/plugins/jobsystem/README.md)
