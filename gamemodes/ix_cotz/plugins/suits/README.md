# Suits, headgear and gasmask filters

The plugin owns equipment resistance calculations, headgear damage, and replaceable gasmask filters.
Shared mechanics load through `sh_plugin.lua`, including `sh_resistances.lua` before headgear wear.
Filter items use the immediate `items/gasmaskfilters/` folder and its `base_gasmaskfilters` base.
No bundled Helix changes are required.

## Filter compatibility

Concrete equipment declares `ITEM.filterType`. Compatibility is exact; a scientific cartridge cannot
replace a civilian or military cartridge. Equipment declared with `false` has no filter socket.

| Filter | Item ID | Compatible equipment | Moderate exposure lifetime | Price |
| --- | --- | --- | --- | --- |
| Civilian | `gasmask_filter_civilian` | Halfmask, Respirator, GP5, CS-1, CS-2 | 10 minutes | 850 |
| Military | `gasmask_filter_military` | EO-20, PMK-3, XM-40, CS-4, PRACS, PSZ-12 | 15 minutes | 1,700 |
| Scientific | `gasmask_filter_scientific` | M40, M50, Exohelm with Respirator, Spartan, Screen | 20 minutes | 2,550 |

SSP-99, SSP-99M and all SEVA and NBC variants use air tanks that provide full tank-dependent radiation protection until empty.
Three tank sizes share the `air_tank` socket; scientific cartridges and gas tanks cannot substitute for one another.

| Tank | Item ID | Wear divisor | Reference lifetime | Price | Full refill | Size | Weight |
| --- | --- | --- | --- | --- | --- | --- | --- |
| Small | `gasmask_filter_air_tank_small` | 400 | 33 minutes | 3,500 | 2,300 | 1×2 | 3.5 kg |
| Medium | `gasmask_filter_air_tank` | 700 | 58 minutes | 6,000 | 4,000 | 2×2 | 6 kg |
| Large | `gasmask_filter_air_tank_large` | 1,000 | 83 minutes | 8,500 | 5,700 | 2×3 | 9 kg |

Reference lifetimes use 20 raw radiation damage per second. The medium tank keeps the original item ID,
so existing loose tanks became medium tanks. Suits record a swapped-in size in the `filterUniqueID` item
data; suits without it, including all existing and new suits, hold a medium tank and use their concrete
wear divisor of 700. Suit weights include a medium tank; another installed size adds or removes the difference.
Drag a tank onto a backpack suit or its equipped card, or use **Swap Gas Tank**. Swapping uses the
same six-second cancellable action and ownership/placement checks as filters. A same-size outgoing tank
returns in the incoming tank's backpack space with its actual air remaining at completion, including
0%, so those swaps work with a full backpack. A different-size outgoing tank is created asynchronously
and placed in the incoming tank's space or any main-backpack space freed by it; the swap is refused up
front when it would not fit, and kept intact if room disappears before creation completes. Both items stay
locked until then, with a 15-second timeout. Tanks cannot be removed without replacing them.
Suit durability deteriorates normally from combat and anomalies regardless of remaining air.
Tank depletion does not taper radiation protection: any air above 0%, including fractional percentages,
provides the full tank protection scale; at 0% the tank-dependent protection is lost.
Unlimited durability retains its existing behavior.
Technut refills filters and tanks separately from durability repairs, including loose cartridges and
tanks, mask filters and suit tanks, even when equipment durability is full. Each concrete filter declares
`refillCost`, the price of refilling it from empty: 550, 1,100 and 1,700 RU for civilian, military and
scientific cartridges, and the tank costs in the table above. The quote scales with the missing percentage
before earned discounts and repair credit. Empty sockets and filters locked by an installation cannot be
refilled, and Boss offers no refills. Ordinary repairs do not refill filters or tanks. Existing and new suits start with full tanks;
partial and exhausted tanks persist in `filterCondition`. Tank mass is included in existing suit weight.
Suit percentage and flat radiation protection still scale with suit durability;
independent upgrades and attachments retain their existing behavior.

Cloth Mask, Riot Helmet and Altyn remain exempt. Screen requires a scientific filter despite
its closed-respiratory description.

Filters are available through normal admin item spawning/giving and seller-specific progression.
Latch unlocks civilian filters before Halfmask, military before EO-20, and scientific before M40.
Boss sells civilian filters by default, unlocking military filters before CS-4 and scientific before Screen. Each unlock is a separate
delivery immediately before that seller's first mask of its type. Filters have four starting/maximum
stock with a refill amount of one every 6 hours. Filter and mask purchase
permissions remain personal to the character and seller. No loot or reward pools are added.
Each cartridge occupies 1×1 cells and weighs 0.2 kg, whether loose or installed. Equipment's existing
weight describes the equipment without its cartridge. See the [town progression guide](../townnpcs/README.md#gasmask-filter-purchases).

## Protection and use

Suit anomaly protection has three independent percentage/flat pairs. Impact is a combat stat with its own pair:

| Protection | Percentage field | Flat field | Damage types |
| --- | --- | --- | --- |
| Thermal | `thermalRes` | `flatThermalRes` | Burn, slow burn |
| Electrical | `electricalRes` | `flatElectricalRes` | Shock |
| Chemical | `chemicalRes` | `flatChemicalRes` | Acid, drowning, poison, nerve gas |

Every concrete suit declares all eight fields, initially copying its previous `ar`/`far` values.
These are definition values, so existing instances use them without changing saved item data.
`getAR(field)` returns the remaining-damage multiplier; `getFAR(field)` returns flat absorption.
Damage is `max((incoming - flat) * multiplier, 0)`. Base protection retains its ordinary durability
taper below 80%. Suit tooltips list every effective percentage reduction in their cosmetic units,
including zero ratings, without flat absorption or a protection subheader.
The equipment footer shows each family's combined percentage reduction and flat absorption tooltip.

Legacy `ar`/`far` remain as fallback values and for existing untyped callers and environmental
headgear wear outside these families. Broad upgrades, attachments and the flat anomaly wish still
apply to every family with their existing formulas. A type-specific field overrides its broad fallback,
including explicit zero; flat attachments retain their existing behavior and do not add suit absorption.
Equipped headgear may also supply these fields, otherwise its existing `ar`/`far` apply to every family, including impact.
The existing resistance refresh paths update each family's cached network values.
Mixed anomaly flags use the weakest applicable anomaly family once, without stacking reductions.
Impact is a combat stat, resolved between bullet and rupture. Explosions, gravitational anomalies, falls and
blunt hits (human and mutant melee, controller melee, pseudogiant and Vareshka ground slams, player punches and
blunt melee weapons) use its percentage first, then its flat absorption. Falls reduce damage but never wear
suits or headgear. Other impact damage wears suits at the bullet rate and headgear at the combat rate.
Tooltips and the equipment footer list Impact directly after Rupture.

A filter has 0–100% condition. Effectiveness is `clamp(condition / 20, 0, 1)`: full at 20–100%, then
linear below 20%. The headgear's percentage and flat radiation protection multiply its ordinary
durability scale by this filter scale. Other resistances, independent attachments, artifacts and
buffs keep their existing behavior. Missing and exhausted filters give no filter-dependent protection.
The ordinary durability scale remains `clamp(durability / 80, 0, 1)`. A mask at 50% durability with
a filter at 10% condition supplies 31.25% of its rated percentage and flat radiation protection.

Only positive incoming `DMG_RADIATION` exposure drains an equipped filter, including fully blocked
exposure. Condition loss is raw damage divided by the concrete cartridge's `filterWearDivisor`:
120 civilian, 180 military, 240 scientific. The reference moderate field delivers 4 damage every
0.2 seconds. Stronger radiation drains faster; clean areas and other damage do not drain filters.
Protection uses the condition at the start of the hit, before filter wear and the radiation health override.
Safe-zone damage blocking, corpse protection and `unlimitedDurability` preserve filter condition.
Town NPC radiation protection (`buff_townradprotect`) also pauses filter wear, including its existing
grace period after leaving the protected area. Wear resumes when the buff expires.
Radiation no longer wears ordinary durability on filter-dependent headgear. Other headgear wear remains.

Drag a matching cartridge from the main backpack onto a mask in the backpack or onto its equipped
card or icon, including any linked helmet/backpack card for integrated equipment. The mask can stay
equipped. Its **Install Filter** context-menu action appears only when a matching backpack cartridge is available.
Installing or replacing a filter takes six seconds through the existing black-screen action bar;
press **F** to cancel. Both cartridges stay unchanged until completion, apart from normal exposure
wear on the installed one. The old filter continues providing its current protection during the delay.

Replacing an installed cartridge returns it in the incoming cartridge's backpack cell, retaining
its actual remaining condition at completion. This works with a full backpack. Installing into an
empty socket consumes the loose cartridge only when the action completes successfully.
**Remove Filter** appears when a cartridge is installed and a backpack cell is free. It also works while equipped and returns a matching
cartridge at its remaining condition, including 0%. A fresh cartridge restores 100% filter condition
without repairing the headgear. Removed filters can be reinstalled; durability repairs cannot recharge them, but Technut refills can.

Tank tooltips and condition bars show remaining air. Other tooltips show the required filter and its percentage or **No filter**. Backpack icons use the durability texture and condition colors for the filter/tank bar above ordinary durability.
Equipment cards show the teal filter/tank bar above ordinary durability. Tooltips list filter/tank condition before durability.
Protection tooltips and the equipment footer use effective radiation resistance.

## Suit families and variants

Each concrete suit declares its own protection, price, repair cost, weight, carry bonus and slots. The
[variant plan](../../../../docs/suit-variant-plan.md) records the rules behind the values and full tables.

- Every family offers Authority, Mercenary, Ecologist, Fanatic, Anarchist, Scavenger and Looted variants.
  SSP-99 offers Ruby, Sapphire, Emerald, Amethyst and Diamond instead. SSP-99M has none.
- Variants keep the base suit's flat protection, repair cost and slots; Anarchist adds one misc slot.
- Base impact is the average of bullet and rupture. SEVA's rupture and impact are lower by hand.
- Sky-3, Sky-4 and Expedition have definitions but no shop entry or progression yet, so players cannot get
  them. Looted variants are not offered by Suture's conversion service.

**Protection cap.** Worn totals in every family except radiation stop at 90% (`ix.suits.MAX_PROTECTION`).
The damage multiplier cannot go below 0.1 however suits, headgear, attachments and upgrades stack. Protection
tooltips show the same cap.

**Repair cost.** `ITEM.fullRepairCost` is what a full repair costs before discounts, independent of price.
`GetRepairCost` returns 1/200 of it because the repair service charges per missing point and doubles it.

**Misc slots.** A suit saves its slot limits in `maxMiscSlots` when created and refreshes them only through the
Equip action. An owned Anarchist suit gains its new slot after being taken off and put on again. Tooltips show
the saved limit.

**Looted melee.** A definition's `meleeDamageBonus` (the average of the base suit's bullet, rupture, impact
and three anomaly values) raises damage from `tfa_nmrimelee_base` weapons against players and NPCs, and returns
the stamina of a swing that hits. Wear and attachments do not change it. Misses cost stamina, the 20 stamina
minimum to swing still applies, and fists are excluded. It does not apply where this plugin skips damage
handling (PVP disabled or arena fights between players).

**Saved-item conversion.** On every database connection, `sv_migration.lua` converts rows in `ix_items`:

- The four colour trenchcoats become `suit_trenchcoat` and keep their colour in `legacyCoatSkin` until repainted.
- Old Sky-3 (`suit_cs3`, `suit_cs3_ecologist`) becomes Sky-5. New Sky-3 items reuse those IDs and carry
  `skyLineVersion`, so the conversion skips them. Keep `ITEM.skyLineVersion` on those two definitions.

Each statement is one `UPDATE` that no longer matches what it changed, so repeat boots and several map servers
are safe. Deploy all map servers together: a server still on the old definitions cannot load converted items.
Back up the database before the first deployment. Characters keep their purchase and conversion unlocks,
because Sky-5 and the Trenchcoat reuse the old progression step IDs.

## Saved state and inventory safety

Installed condition lives in the equipment's `filterCondition` item data. Numbers from 0–100 mean an
installed cartridge; `false` means an empty socket. Missing legacy data initializes to 100 on restore
or first access, using the equipment's declared type. Existing ordinary durability is preserved.
New equipment includes a full matching cartridge. Loose cartridges save their own `filterCondition`;
creation preserves supplied partial or zero condition. Empty and depleted states survive reconnects,
server restarts and transfers. There is no database reset or bulk migration.

Server actions validate current character, ownership, life state, backpack/equipment placement,
equipment transitions, exact filter compatibility and submitted IDs. Changes have a 0.5-second
server cooldown. During installation, the mask and loose cartridge cannot be used or transferred;
moving either within the inventory cancels the operation. A bounded monitor releases locks after
cancellation, death, character changes or invalidated state, and disconnect cleanup interrupts the
shared action before the player entity disappears. Completion rechecks ownership, position, equipped
state and interaction permissions before swapping condition or consuming an incoming cartridge.
Cancelled or rejected installations leave both items intact and can be retried.

Removal creates an unplaced item through `ix.item.Instance`, because this bundled Helix's
`Inventory:Add(string)` returns before its database callback completes. The callback revalidates state
and available space before placing the item and emptying the socket. Until then, the equipment cannot
be used, transferred, equipped or unequipped. Failures retain the installed filter and delete uncommitted output.
A 15-second timeout releases the lock; late callbacks delete their output without emptying the socket.
Placement counts the returning cartridge's existing carried mass only once, including at the carry limit.

## Verification

Run from the repository root:

```sh
luatex --luaonly tests/suit_variants_spec.lua
python3 tests/suit_migration_spec.py
luatex --luaonly tests/anomaly_resistance_spec.lua
luatex --luaonly tests/gasmask_filters_spec.lua
luatex --luaonly tests/headgear_durability_spec.lua
luatex --luaonly tests/equipment_slots_spec.lua
luatex --luaonly tests/equipment_layout_spec.lua
luatex --luaonly tests/equipment_views_spec.lua
luatex --luaonly tests/equipment_interactions_spec.lua
luatex --luaonly tests/equipment_admin_spec.lua
luatex --luaonly tests/item_descriptions_spec.lua
```

These standalone checks use mocks. In multiplayer, verify all three cartridges load and spawn, exact
compatibility, percentage taper, moderate exposure lifetimes, fully blocked radiation, safe zones,
ordinary combat durability and all exemptions and built-in tanks. Check Technut refill quotes for loose and installed filters and all three tank sizes, refill of undamaged suits, rejection at Boss, and small/large tank swaps with full and nearly full backpacks. Check actions and bars on ordinary masks and linked
helmet slots, including Screen. Reconnect, restart and transfer between identically configured servers
with partial, empty and exhausted filters. Try repeated and foreign requests, full backpacks, a
backpack filled during removal, death or character switching during installation/removal, and normal carry limits.
Check equipped and unequipped drag/drop, full-backpack replacement, the complete six-second delay,
F cancellation just before completion, permission changes, repeated requests and filter wear during the delay.
Inspect tooltips, all eight equipment protection statistics and both condition bars at narrow, 1080p,
ultrawide and 4K resolutions. Temporarily give a test suit different thermal, electrical, chemical and
impact ratings; compare each field anomaly's damage and equipment wear with its matching tooltip
and footer value. Restore the definition afterward. Check low durability, upgrades, attachments, the
flat anomaly wish, reconnects and mixed damage flags. Standalone specs do not verify live rendering or networking.
