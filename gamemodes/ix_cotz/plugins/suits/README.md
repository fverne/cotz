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
Their current concrete wear divisor is 700, preserved by tank swaps. The replacement `gasmask_filter_air_tank`
item costs 6,000 RU, occupies 2×2 cells and weighs 6 kg loose. It only fits these suits; scientific
cartridges and gas tanks cannot substitute for one another.
Drag a tank onto a backpack suit or its equipped card, or use **Swap Gas Tank**. Swapping uses the
same six-second cancellable action and ownership/placement checks as filters. The outgoing tank
returns in the incoming tank's backpack space with its actual air remaining at completion, including
0%, so swaps work with a full backpack. Tanks cannot be removed without replacing them.
Suit durability deteriorates normally from combat and anomalies regardless of remaining air.
Tank depletion does not taper radiation protection: any air above 0%, including fractional percentages,
provides the full tank protection scale; at 0% the tank-dependent protection is lost.
Unlimited durability retains its existing behavior.
Technut offers a separate air tank repair/refill even when suit durability is full, restoring tank
condition without repairing the suit. It costs 40 RU per missing percentage point, up to 4,000 RU for an empty tank on any suit, before earned discounts
and repair credit. Ordinary suit repairs do not refill tanks. Existing and new suits start with full tanks;
partial and exhausted tanks persist in `filterCondition`. Tank mass is included in existing suit weight.
Suit percentage and flat radiation protection still scale with suit durability;
independent upgrades and attachments retain their existing behavior.

Cloth Mask, Riot Helmet and Altyn remain exempt. Screen requires a scientific filter despite
its closed-respiratory description.

Filters are available through normal admin item spawning/giving and seller-specific progression.
Latch unlocks civilian filters before Halfmask, military before EO-20, and scientific before M40.
Boss unlocks military filters before CS-4 and scientific before Screen. Each unlock is a separate
delivery immediately before that seller's first mask of its type. Filters have four starting/maximum
stock with a refill amount of one every 12 hours. Filter and mask purchase
permissions remain personal to the character and seller. No loot or reward pools are added.
Each cartridge occupies 1×1 cells and weighs 0.2 kg, whether loose or installed. Equipment's existing
weight describes the equipment without its cartridge. See the [town progression guide](../townnpcs/README.md#gasmask-filter-purchases).

## Protection and use

Suit anomaly protection has four independent percentage/flat pairs:

| Protection | Percentage field | Flat field | Damage types |
| --- | --- | --- | --- |
| Thermal | `thermalRes` | `flatThermalRes` | Burn, slow burn |
| Electrical | `electricalRes` | `flatElectricalRes` | Shock |
| Chemical | `chemicalRes` | `flatChemicalRes` | Acid, drowning, poison, nerve gas |
| Gravitational | `gravitationalRes` | `flatGravitationalRes` | Crush, blast |

Every concrete suit declares all eight fields, initially copying its previous `ar`/`far` values.
These are definition values, so existing instances use them without changing saved item data.
`getAR(field)` returns the remaining-damage multiplier; `getFAR(field)` returns flat absorption.
Damage is `max((incoming - flat) * multiplier, 0)`. Base protection retains its ordinary durability
taper below 80%. Suit tooltips list all four effective pairs, including zero and flat-only ratings.
The equipment footer shows each family's combined percentage reduction and flat absorption tooltip.

Legacy `ar`/`far` remain as fallback values and for existing untyped callers and environmental
headgear wear outside these families. Broad upgrades, attachments and the flat anomaly wish still
apply to every family with their existing formulas. A type-specific field overrides its broad fallback,
including explicit zero; flat attachments retain their existing behavior and do not add suit absorption.
Equipped headgear may also supply these fields, otherwise its existing `ar`/`far` apply to all four.
The existing resistance refresh paths update each family's cached network values.
Mixed damage flags use the weakest applicable family's protection once, without stacking reductions.
Crush damage still uses environmental headgear wear, including gravitational anomalies and physics impacts.

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
equipped. Its **Install Filter** context-menu action also lists matching backpack cartridges.
Installing or replacing a filter takes six seconds through the existing black-screen action bar;
press **F** to cancel. Both cartridges stay unchanged until completion, apart from normal exposure
wear on the installed one. The old filter continues providing its current protection during the delay.

Replacing an installed cartridge returns it in the incoming cartridge's backpack cell, retaining
its actual remaining condition at completion. This works with a full backpack. Installing into an
empty socket consumes the loose cartridge only when the action completes successfully.
**Remove Filter** also works while equipped, requires a free backpack cell and returns a matching
cartridge at its remaining condition, including 0%. A fresh cartridge restores 100% filter condition
without repairing the headgear. Removed filters can be reinstalled; repairs cannot recharge them.

Tank tooltips and condition bars show remaining air. Other tooltips show the required filter and its percentage or **No filter**. Backpack icons have a teal
filter bar above ordinary durability; equipment cards show ordinary durability above the filter bar.
Protection tooltips and the equipment footer use effective radiation resistance.

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
ordinary combat durability and all exemptions and built-in tanks. Check Technut tank quotes, refill of undamaged suits, and rejection at Boss. Check actions and bars on ordinary masks and linked
helmet slots, including Screen. Reconnect, restart and transfer between identically configured servers
with partial, empty and exhausted filters. Try repeated and foreign requests, full backpacks, a
backpack filled during removal, death or character switching during installation/removal, and normal carry limits.
Check equipped and unequipped drag/drop, full-backpack replacement, the complete six-second delay,
F cancellation just before completion, permission changes, repeated requests and filter wear during the delay.
Inspect tooltips, all eight equipment protection statistics and both condition bars at narrow, 1080p,
ultrawide and 4K resolutions. Temporarily give a test suit different thermal, electrical, chemical and
gravitational ratings; compare each field anomaly's damage and equipment wear with its matching tooltip
and footer value. Restore the definition afterward. Check low durability, upgrades, attachments, the
flat anomaly wish, reconnects and mixed damage flags. Standalone specs do not verify live rendering or networking.
