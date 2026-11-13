# Technician weapon rebuilding and dismantling

Status: design recommendations accepted and implemented, 13 November 2026.
See the [weapon workshop guide](../gamemodes/ix_cotz/plugins/weaponservice/README.md) for current recipes,
implementation details and verification limits. The design rationale and original cost examples follow.
The original idea establishes the two-component repair loop, technician-only exchanges, four salvage
families, condition-sensitive yields and reward-pool tiers. The user authorized the recommended defaults.

## Repair loop

1. Bring a firearm to a technician and select that weapon instance.
2. Its barrel and receiver recipes become visible. Recipes are fixed and show all requirements,
   the commission and the quantities currently carried. Missing ingredients disable the exchange;
   they do not hide the recipe.
3. Exchange ingredients and money for each component, together or on separate visits.
4. Present one matching barrel and one matching receiver. The technician consumes both and restores
   the selected firearm's durability to 100%.

Proposed default: components match the exact weapon item ID. An F2000 receiver repairs an F2000;
a tier-5 receiver is not interchangeable across every tier-5 weapon. The phrase “random pistol” in
the example is treated as an illustrative pistol, rather than a random component reward.
This interpretation was adopted for implementation.

Components are ordinary transferable inventory items, without character or weapon-instance binding.
Another instance of the same model can use them. Possession of a component alone does not reveal its
recipe; possession of the firearm does. Carrying two identical guns shows one recipe pair and allows
the player to choose which damaged instance receives the rebuild.

Rebuilding is a single hand-in of both components. There is no partial installation, separate barrel
condition, separate receiver condition or new weapon degradation simulation. The existing weapon
instance retains its identity and saved configuration. Only durability becomes 100%; cleanliness
stays at its current value. Installation has no additional fee beyond the component commissions.
Do not offer installation on an already fully durable weapon.

The proposed menu has three actions: obtain components, rebuild a weapon and dismantle a weapon.
Current technician services remain alongside these actions. No new progression gate is proposed;
existing access checks still apply. Initially use the existing repair providers, Technut and Boss,
rather than automatically treating traders or ammunition specialists as technicians.

## Components, salvage and recipes

Keep the two kinds of parts distinct in the UI:

| Kind | Purpose | Compatibility |
| --- | --- | --- |
| Barrel / receiver | Two finished components used in a full rebuild | Exact weapon model |
| Weapon parts | Dismantling output and component recipe input | One of four salvage families |

The four salvage families are pistol/SMG, shotgun, intermediate rifle and long rifle.
Each firearm has one explicit family. Use its actual weapon role and cartridge, rather than its
primary/secondary equipment slot. For example, F2000 uses intermediate rifle parts, FN FAL uses long
rifle parts, and the Obrez remains a long rifle source despite its shortened form. Rimfire rifles,
9x39 weapons and other edge cases need explicit classification in the implementation catalogue.

The existing `value_weaponparts` item is “Loose Weapon Mechanisms”, a general valuable. Preserve its
ID and existing uses. The four new families should have their own IDs and clearly distinct names;
do not silently convert existing saved mechanisms into a new salvage currency.

There are 130 concrete firearms today. Exact-model components therefore mean 260 component
definitions plus four salvage definitions. Use shared mechanics, with each concrete item's identity,
model, price, dimensions, weight and compatibility declared explicitly. Asset reuse is acceptable;
duplicate generic names that hide compatibility are not.

Each component recipe records its fixed ingredients, family part quantity and commission rate.
Author recipes by tier and family as a starting point, with explicit per-weapon overrides where
prices make a common recipe unsuitable. Do not roll new ingredients on reconnect or each visit.

### Commission and price examples

The literal reading of the proposal charges 20% of the weapon's nominal `ITEM.price` **per component**.
Round each commission up to a whole RU. This totals 40% of the gun price for a complete rebuild,
before ingredients. Do not use the gun's condition-adjusted resale price to calculate commission.

| Example | One component | Full pair |
| --- | --- | --- |
| Makarov, nominal price 900 RU | 180 RU commission | 360 RU commission |
| F2000, nominal price 28,500 RU | 5,700 RU commission | 11,400 RU commission |

If 20% was intended for the entire rebuild, use 10% on each component instead. That is a design
choice, not an implementation detail.

The example tier-2 pistol barrel requires seven **individual nuts**, two civilian oil containers,
two pistol/SMG parts and its commission. Nuts use saved stack quantity; seven nuts does not mean
seven inventory stacks. Civilian oil currently has no quantity field, so two means two complete items.

At current nominal prices, seven nuts cost 140 RU and two civilian oils cost 1,200 RU. Applied to a
Makarov, that barrel alone costs 1,520 RU plus two salvage parts. A receiver with the same recipe
would bring a rebuild to 3,040 RU plus four parts, against a new gun's 900 RU price.
These are nominal comparisons; actual purchase access and stock also affect replacement cost.

Recommendation: retain that example as a higher-value pistol recipe reference, and make cheap
firearms explicit recipe exceptions. A provisional review target is 60–80% of new nominal value
for a full rebuild, including commissions and ingredient opportunity cost. This target is a proposed
balance policy, not a result the example currently meets. It also requires assigning useful values
to the new salvage families before recipes can be called balanced.

For the tier-5 F2000 receiver, preserve the suggested five intermediate rifle parts and 5,700 RU
commission as the draft anchor. Select its specialist ingredients from existing obtainable items
after checking their regional availability. The barrel needs a separate authored recipe; it must
not silently inherit the receiver's ingredients. No new random ingredient pool is needed.

Recommended service-credit policy: technician discounts and provider-bound repair credits apply
to the money commission through the existing quote system. Ingredients are always required in full.
The quote shows base commission, discount, credit used and cash due. This preserves the purpose of
Technut's existing job rewards; Boss does not spend Technut-bound credits.

## Dismantling

The technician destroys one selected firearm and awards zero to four parts of its salvage family.
Dismantling does not directly award a finished barrel or receiver. No dismantling fee is proposed.
Require the weapon to be unequipped, unloaded and stripped of removable attachments before
confirmation, so the destructive operation has no hidden ammunition or attachment losses.
Show the model, current condition, reward family and exact reward probabilities before confirmation.

Proposed clean, fully durable yields:

| Tier | Base yield expressed as a percentage | Result at 100% durability and cleanliness |
| --- | --- | --- |
| 1 | 50% | 50% chance of one part; otherwise none |
| 2 | 100% | One part |
| 3 | 150% | One part, plus a 50% chance of a second |
| 4 | 200% | Two parts |
| 5 | 250% | Two parts, plus a 50% chance of a third |
| 6 | 300% | Three parts |
| 7 | 400% | Four parts |

Seven active firearm tiers do not fit eight successive 50-percentage-point steps from 50% through
400%. This proposed table keeps simple steps through tier 6 and gives tier 7 the final jump.
This curve was adopted; the reward tiers themselves remain unchanged.

Proposed initial condition rule:

```text
expectedParts = baseYield[tier] × (durability / 100) × (cleanliness / 100)
guaranteedParts = floor(expectedParts)
extraPartChance = expectedParts - guaranteedParts
```

Here `baseYield` is 0.5 through 4, not 50 through 400. Clamp both condition readings to 0–100.
Award the guaranteed count and make one roll for the fractional extra part. This gives adjacent
possible counts rather than several independent rolls with a wider range of results.

Examples:

- Tier 1 at 50% durability and 80% cleanliness: 20% chance of one part.
- Tier 5 at 80% durability and 80% cleanliness: one part plus a 60% chance of another.
- Tier 7 at 100% durability and 80% cleanliness: three parts plus a 20% chance of another.
- Tier 7 at 100% on both readings: exactly four parts.

In current COTZ, saved `wear` means cleanliness: higher is better. It is not accumulated damage.
The proposed multiplication makes zero on either reading give zero parts and deliberately makes
cleaning before dismantling useful. If that is too punishing, reduce cleanliness's influence during
balancing rather than accidentally reversing its meaning. Display the benefit of cleaning before
the player spends money on it. Existing reward guns start at 80% cleanliness even in “high” pools,
so their advertised maximum salvage is not automatically four parts.

## Resolving weapon tiers

Use the active tables in [task_rewards_weapons.lua](../gamemodes/ix_cotz/plugins/randomitem/pools/task_rewards_weapons.lua).
Ignore tier 00 melee entries, commented-out tier 08 tables and the low/high condition variants when
determining weapon identity. Merge low/high occurrences of the same model within each tier.

Proposed interpretation of “most unique entry”: choose the tier in which that weapon has its highest
entry weight. A common appearance in its own tier takes precedence over a rare appearance in an
earlier tier. Do not choose the first occurrence or count low/high variants as competing identities.
For future equal-weight conflicts, require an explicit reviewed override instead of choosing silently.

This rule resolves all 130 current firearms without ties and covers every concrete `newweapons` item.
The F2000 appears at weight 100 in tier 3, 250 in tier 4 and 500 in tier 5, resolving to tier 5.

| Resolved tier | Weapon count |
| --- | --- |
| 1 | 11 |
| 2 | 12 |
| 3 | 14 |
| 4 | 19 |
| 5 | 57 |
| 6 | 8 |
| 7 | 9 |

Tier 5 includes many weapons whose highest available weight is 250 or 100, not 500. Do not restrict
the rule to weight-500 entries. Review this distribution before treating tiers as evenly sized bands.
Implement a reviewed catalogue derived from this audit; subsequent loot-weight edits should produce
a catalogue review warning rather than silently retune live component compatibility or prices.

## Existing systems and implementation boundary

Current paid weapon service restores cleanliness through `wear`; it does not restore durability.
Keep it as the cleaning service. Rebuilding supplies the missing durability service and leaves suit,
headgear and air-tank services intact. See [progression services](../gamemodes/ix_cotz/plugins/progression/README.md).

The legacy NPC barter implementation handles one selected input item type per exchange. It cannot
directly express money plus nuts plus oil plus family parts as one transaction. Build the new mechanic
in an owning weapon-service module/plugin and connect it to technician dialogue and existing service
quotes. Do not place authoritative transaction logic in individual dialogue definitions or bypass
validation with several independent legacy exchanges.

At implementation time, validate ownership, character, technician access, proximity, conditions,
ingredients and money again on confirmation. Quotes identify the exact weapon instance. Serialize
transactions so repeated clicks cannot consume the same gun or ingredients twice. Read live weapon
condition where necessary, and synchronize the item and equipped SWEP when applying a rebuild.

Dismantling must fix its roll once when the operation commits. Record recoverable character-owned
pending rewards so a full inventory, disconnect or retry cannot lose parts or reroll the result.
Failed input removal must not award output; failed output insertion must not consume inputs again.
An implementation must inspect the actual inventory/database callbacks before choosing a commit and
recovery protocol. A UI confirmation alone does not make several asynchronous changes atomic.
New state must preserve existing weapons, valuables and progression balances without a reset.

Verification should cover duplicate weapons, stale quotes, split nut stacks, failed input removal,
insufficient money, credits, full inventory, reconnect recovery, repeated requests, probability
boundaries and all 130 tier/family entries. Multiplayer checks must cover dialogue visibility,
equipped condition synchronization, persistence and real inventory callbacks.

## Adopted defaults

1. Exact-model barrels and receivers, transferable between players and identical firearm instances.
2. 20% commission per component, 40% across a full rebuild before earned discounts and credits.
3. The seven-tier yield table above, multiplied by both durability and cleanliness.
4. Explicit affordable recipe exceptions, with all 130 complete rebuilds at roughly 61–73% of nominal new value
   before benefits. Provider-bound repair credits and discounts apply to commissions.

No existing weapons, progression balances or generic weapon mechanisms are converted or reset.
Salvage now stacks to ten. Component item values are 20–200 RU and town vendors may buy them;
technician recipe costs are separate. Barrel supplies follow the map difficulty bands documented
in the workshop guide, with common early-region supplies and Pripyat inputs reserved for tier 6–7 barrels.
