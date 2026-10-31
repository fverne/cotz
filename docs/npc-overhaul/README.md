# Town NPC overhaul design

Planning reference, 31 October 2026. **The full overhaul is not implemented.**
The 11 new contacts now have manually placeable appearance and basic dialogue scaffolds;
their progression, jobs, and economy remain design-only. See the
[scaffold setup guide](../../gamemodes/ix_cotz/plugins/vendor_adv/README.md).
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
| [Implementation handoff](implementation.md) | Source locations, definition-file design, missing mechanics, migration, and verification. |

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
- The latest authorised runtime phase is new-contact appearance and basic dialogue only.
  Progression and the old-NPC overhaul remain deferred.

## Working design, subject to review

| Home | Existing contacts | New contacts | Total | Proposed finite steps |
| --- | ---: | ---: | ---: | ---: |
| Marsh | 7 | 3 | 10 | 248 |
| Garbage | 4 | 5 | 9 | 212 |
| Waystation | 5 | 3 | 8 | 186 |
| Pripyat | 0 | 0 | 0 | 0 |
| **Total** | **16** | **11** | **27** | **646** |

The 646 steps are a planning budget, not implemented content or a promised duration.
The previously discussed per-contact ranges now total **544–704**, after removing the
community NPC and Hoarder. Earlier 29-contact totals are obsolete.

Map identities: Marsh establishes survival and community; Garbage centres on salvage,
hunting, and contested trade; Waystation organises specialist preparation and expeditions.
Pripyat provides demanding objectives and discoveries without town services.
An NPC's home does not restrict all their objectives to that map.

Job categories here are player-facing specialties. Medical deliveries and ammunition
deliveries use similar mechanics but distinct item lists. Equipment recovery remains
one category regardless of the case's contents. Do not disguise duplicate categories
through different names. Exact runtime category IDs still need to be mapped.

## Decisions still open

1. Final item-by-item allocation of the complete current vendor-unlock catalogue.
2. Garbage's actual map identifier, landmarks, travel links, loot tiers, and placements.
3. Exact step objectives, item quantities, cumulative job thresholds, prices, and reward amounts.
4. Final main-story travel gates, arrival rules, and cross-NPC prerequisites.
5. Migration of existing completions, assignments, stock, and pending rewards.
6. New field-story mechanics and any visible town changes or functional ferry crossings.
7. Models and final dialogue for new NPCs.
8. Boundary between preserved secret Hoarder content and redistribution of his current unlocks.

Do not treat a chapter title, sample line, step budget, or suggested reward as a finished definition.
Runtime guides describe what works today; these documents describe the proposed replacement.
The individual contact drafts now fill the full 646-step outline, but unresolved item slots,
quantities, sites, upgrade comparisons, and save migrations still require authoring and validation.

## Related references

- [Map content design](../map-content-design.md)
- [Map setup](../map-setup.md)
- [Repository layout](../repository-layout.md)
- [Current dialogue source guide](../balance/progression/dialogue-guide.md)
- [Current progression runtime](../../gamemodes/ix_cotz/plugins/progression/README.md)
- [Current jobsystem runtime](../../gamemodes/ix_cotz/plugins/jobsystem/README.md)
