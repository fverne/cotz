# Personal character progression

Progression belongs to a Helix **character**, including other characters on the same
account. All 134 delivery steps now use saved personal requirements. Bulk hand-ins
are reduced; fixed story keys keep their single-item requirements. The five
job-completion progressions use the same increasing effort curve as deliveries. NPC arrivals remain
persistent global unlocks triggered by the first character to complete their milestone.

## Personal delivery assignments

A delivery definition contains `requirementSlots`. Each slot names a curated pool
and a positive integer `quantity`. When the step becomes active and its NPC is
personally unlocked, the server selects one candidate per slot and requests exactly
that slot's quantity.

Delivery and job requirements follow a source-based effort curve. Each successor
requires at least 25% more modeled average acquisition effort than its prerequisites.
Map difficulty, normalized loot odds, spawned yields, poaching odds and mutant combat
danger inform quantities. Plentiful supplies need more units than rare trophies.
Counts are raw quantity units. Story access keys remain single-item requests.
The model is an offline tuning tool; runtime definitions contain literal quantities.
See the [model and assumptions](../../../../docs/balance/progression/README.md#quantity-and-effort-decisions)
and [per-step estimates](../../../../docs/balance/progression/pacing.md).

World loot tables come in map pairs: 1/2 are Marsh ordinary/hard-to-find loot,
3/4 are Waystation, and 5/6 are Pripyat. Definitions declare a `lootMapTier`
ceiling for curation and documentation. Opening low-tier branches and the Marsh
story deliveries use local pools; later branches can introduce later-map hardware.
Regression checks compare every candidate's earliest active worldspawn map against
the ceiling. Non-world rewards, harvesting and vendors need their own availability
review; they do not imply a worldspawn route. See the balance rationale for the
exact branch policy and map table.

The server saves the chosen item IDs, quantities, slot selections, and assignment
version in the character's progression line. Clients read those saved requirements;
they never roll their own. Reopening dialogue, reconnecting, changing characters,
restarting, transferring servers, or changing pool definitions cannot reroll an
existing assignment. Every uncompleted step receives its assignment at most once.

There are 559 slots across the 134 deliveries and 85 pools covering 223 item IDs.
Optional quest lines start at one requirement and grow towards eight as their
successor depth increases. Haggler and Quartermaster share one difficulty range:
Haggler uses one slot at depths 0–1, two at depths 2–3, and three from depth 4
onward; Quartermaster's gear branches continue with four at their roots and add
one per successor depth, reaching eight. Shorter branches can finish below the
maximum. Story deliveries use explicit pacing; access keys remain single-item
requests. Detector3 retains its six anomaly categories and adds two document slots.

Related categories share candidates across
the catalog, while slots used together in one delivery remain disjoint. Pools
with multiple candidates spread demand across characters; they
do not guarantee different rolls for every pair of characters. Deliberate single-item
exceptions include story keys, specialty tools, and items without a comparable
substitute. Each exception and its rationale is visible in the workbook.

Artifact categories describe acquisition sources rather than mandatory travel checks.
Caches and trading remain valid ways to obtain the assigned items. Existing saved
assignments keep their original quantities; newly assigned steps use the new tuning.

Dialogue descriptions, available hand-in options, the progression help menu,
inventory highlights, and server validation all use the same character-aware
requirements query. Another pool member is not accepted unless it was assigned to
that character. Hand-ins consume only the remaining required quantity; excess
stack units stay in the inventory. Completed requirements cannot be submitted again.

Delivery rewards are paid once, when all requirements of the progression task are
fulfilled. Partial hand-ins only save credit; they give no currency, reputation or
items. Currency is 30% of the combined value actually consumed. Reputation is twice
the previous formula: `2 * (5 + (fullStackValue * 0.1)^0.25)` per full stack, scaled
by the fraction consumed. Both totals accumulate before rounding at completion, so
splitting a delivery into multiple requests cannot multiply rewards.

Completion also gives a single item from one randomly chosen assigned requirement
pool that has alternatives, excluding the submitted item. Single-item pools
give an additional 30% of their submitted value in money instead of an item (60%
total for those items). The reward item's quantity is half the chosen group's
assigned requirement quantity, rounded down with a minimum of one. For example,
a selected request for 12 units of `drug_cigarette_3` rewards one `drug_cigarette_4`
item with quantity 6.
The item goes into the character's inventory; if it does not fit, it is dropped
at the player's item drop position. The saved completion marker prevents repeat
payouts, including after reconnecting. Administrative milestone grants do not pay
delivery rewards.

Existing partial-task credit is converted to the new rates on the next hand-in.
Previously paid amounts are deducted from the final payout, with a minimum of zero;
money already paid is never reclaimed. Completed tasks are not paid again.
Completion callbacks and successor activation retain their existing behavior and
run once.

## Progression overview workbook

See the [balancing workbook guide](../../../../docs/balance/README.md#reviewing-current-progression)
for setup, then export from the repository root:

```bash
/tmp/cotz-balance-venv/bin/python docs/balance/balance.py export
```

The result is `docs/balance/output/balance.xlsx`; GitHub's export workflow also
includes it in its downloadable artifact. The read-only progression views show:

- NPC summaries and all 139 steps, including incoming/outgoing chain links.
- Candidate hand-ins grouped by slot. Rows in one slot are alternatives, not a combined shopping list.
- Personal service/vendor unlocks and the four global NPC arrivals.
- Potential item demand, pool candidates, quantity multipliers, and rarity rationale.
- Before/after requirements for every delivery, including all single-item exceptions.
- Acquisition evidence from weighted loot, spawned quantities, poaching, cooking, and anomaly tiers.

The workbook describes possible assignments, not live character assignments.
Acquisition probabilities are conditional on the listed source, not an overall
per-map drop rate. Map spawn-point configuration and mutant encounter frequency
are not available from these definitions and require server playtesting. See the
[balance rationale](../../../../docs/balance/progression/README.md).

## Fresh-start storage and server transfers

This release targets the planned database and server-data wipe. There is **no
migration or legacy completion import**. Character records use
`progression = {version = 3, lines = {...}}`; records from older versions are rejected.
New characters start without contributions or completed milestones. Their initially
active, accessible delivery steps receive and save personal assignments.

Helix replicates progression data only to its owner and saves it with the character.
Assignments, hand-ins, and numeric updates save the character. All participating
servers must share the character database/schema and this addon version. The
cross-server transfer path saves characters before redirecting them. Progression
no longer uses `<map>_progression` records in `ix_xserverdata`.

Plugin data stores `{version = 3, worldUnlocks = {...}}` for global NPC arrivals.
It does not seed a character's personal milestones.

## Personal vendor stock

One character's purchases never deplete another character's supply, including
characters on the same account. `Progression unlocks` labels vendor entries
`Personal access and stock` and shows the initial stock, maximum stock, restock
amount, and interval. Stock counts are base values multiplied by `VendorStockMult`;
the interval is in hours and is not multiplied. These are catalog settings, not
live remaining stock. Vendor money remains shared.

Personal stock is stored server-side under `vendorStock`, keyed by map plus NPC
display name. Respawning the same NPC does not reset it. NPCs with the same name
on the same map use the same stock identity for a character; renaming an NPC creates
a different identity. Purchases and sherpa stock changes save the character and
send stock updates only to that shopper. Changing characters closes the shop.

Elapsed restocks, including time offline, are calculated when opening the shop or
checking stock for a trade and are capped at the configured maximum. Zero interval
or amount disables refilling; unlimited items remain unlimited. Admin stock edits
change catalog defaults, not every character's remaining count. Shoppers see updated
catalog settings when reopening the vendor.

## Global NPC arrivals and administration

The four progression NPC arrivals unlock globally on first completion and are placed
once on their configured map after saved vendors load. Their arrival flags survive
restarts. Characters without the personal milestone receive limited dialogue;
full dialogue, trade, and barter require their own unlock. Faction and class
restrictions still apply.

`/ProgressionGrant <character> <progressionID>` marks a milestone complete, activates
its successors, assigns newly accessible deliveries, and unlocks any associated
NPC arrival. It does not replay turn-in rewards or GPDA completion broadcasts.
Completion broadcasts include the finishing character's name alongside the NPC's message.

## Integration API

Queries and mutations require an explicit character:

```lua
ix.progression.IsActive(character, progressionID)
ix.progression.IsCompleted(character, progressionID)
ix.progression.GetLine(character, progressionID)
ix.progression.GetRequirements(character, progressionID)
ix.progression.GetNeededItems(character)
ix.progression.GetActiveProgressions(character, npcName)
ix.progression.AddProgressionValue(character, progressionID, amount)
ix.progression.TurnIn(client, vendorEntity, progressionID, itemID)
```

`GetRequirements` returns a snapshot of the saved item-to-quantity map. On the server,
it ensures an active step has an assignment before returning it. On clients, it only
reads replicated data. `GetComplexProgressionReqs` aliases this character-aware API.
`GetItemIds` is no longer used. `GetNeededItems` returns outstanding assigned quantities
for inventory highlighting.

Definitions use `requirementSlots`, `OnComplete(character)`, `nextProgressions`, and
`vendorUnlocks`. Pools live in `sh_requirementpools.lua`; each candidate has an `item` ID.
Slots define positive integer `quantity` values. Numeric definitions use scaled ordered thresholds and
`OnRun(self, character)`. `BuildResponse(npcName, status, character)` receives the
selected character so it can describe the actual saved request.

## Validation

From the addon root:

```bash
luatex --luaonly tests/progression_spec.lua
luatex --luaonly tests/vendor_stock_spec.lua
/tmp/cotz-balance-venv/bin/python -m unittest discover -s docs/balance/tests -v
```

Tests cover all definitions, persistent assignments, alternate pool selections,
server rejection of unassigned items, the real dialogue producer/UI/consumer path,
partial stacks, reward splitting, one-time completion, personal stock, source
acquisition evidence, and workbook import isolation.

Before rollout, playtest early, middle, and late branches with multiple clients.
Compare assignment difficulty and availability on each configured map. Check that
reconnects, character switches, restarts, and transfers preserve assignments and stock,
and that global NPC arrivals never grant another character's personal access.
