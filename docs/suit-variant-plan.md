# Suit variant plan

**Implemented.** Item definitions hold the live values; the
[suits plugin guide](../gamemodes/ix_cotz/plugins/suits/README.md#suit-families-and-variants) describes
runtime behaviour. Where this document and the definitions differ, the definitions win.

How the implementation differs from the plan below:

- Sky-3, Sky-4 and Expedition have item files but **no shop entry, purchase step or conversion unlock**.
- Existing new variants joined Suture's matching conversion steps. Trenchcoat and SSP-99 variants have new
  one-step branches. Looted variants are not convertible.
- Progression step IDs were kept: Sky-5 uses the former Sky-3 steps, so no saved progress is rewritten.
- The saved-item conversion is safe to repeat. It does not rely on running exactly once.
- Amethyst uses a maroon finish, because the SSP-99 model has no purple one.

References below to *(new)* mean the variant had no item file when the plan was written.

## Suit ladder

Anorak is the lower bound and Radsuit the upper bound. Their bullet, rupture and anomaly values do not change.

### Base impact

Every base suit's impact is the average of its planned bullet and rupture values, rounded to 0.1%. This
includes science suits, Exoskeleton, Nosorog and new suits. Flat impact does not change. Variants apply their
boost or penalty to the new value.

Impact also covers gravity anomaly damage, so this lowers science suits' protection against it:

| Suit | Bullet | Rupture | Impact now | Planned impact |
|---|---|---|---|---|
| NBC Suit | 9.0 | 17.0 | 20.0 | 13.0 |
| SEVA Suit | 22.0 | 30.0 | 55.0 | 23.5 |
| SSP-99 | 1.0 | 1.0 | 70.0 | 1.0 |
| SSP-99M | 10.0 | 20.0 | 70.0 | 15.0 |
| Exoskeleton | 45.0 | 81.0 | 25.0 | 63.0 |
| Nosorog | 48.0 | 86.0 | 26.0 | 67.0 |

SEVA is an exception: its rupture is then lowered from 35% to 30%, and its impact from 28.5% to 23.5%.

### How the ladder was spaced

Bullet, rupture and anomaly come from the spacing below, which ran **before** the base impact rule, when impact
equalled anomaly. They are not respaced afterward, so the final averages no longer keep those exact
percentage steps. The table is listed in price score order, which includes the new impact. The spacing average
below is the earlier one, so a few rows are not in its order.

- A suit's place on the ladder is its average of bullet, rupture, impact, thermal, electrical and chemical.
- A new suit first gets values between its two named neighbors. Expedition is halfway between IO7a and
  Berill. Sky-3 and Sky-4 are one third and two thirds of the way from Sky-2 to Sky-5.
- Spacing is measured as the percentage step from one suit to the next. Each new suit adds one average step
  to the gap it lands in, and that gap is split evenly. All steps then shrink by the same share (13/16), so
  the ladder still ends at Radsuit. Steps without a new suit keep the same size relative to each other.
- Each suit's bullet, rupture and anomaly values are scaled by the same factor, so its own mix is unchanged.
  Flat values, psychic, radiation, weight and slots do not change.
- Not on the protection ladder: the science suits (NBC, SEVA, SSP-99, SSP-99M), Exoskeleton and Nosorog.
  Only their impact changes. SEVA is also on the price list below.
- All variant tables below are calculated from the new base values.

### Prices

- Price score = (bullet + rupture + impact + anomaly) / 4, where anomaly is the average of thermal,
  electrical and chemical. Flat values, psychic and radiation are not counted.
- Every suit on the price list is priced in score order. Anorak, Mail Jacket, Trenchcoat, Sunrise and IO7a
  keep their current prices, which already follow it.
- Fixed points: IO7a 48,700, Berill-5M 400,000, Skat-9 5,000,000 and Radsuit 10,000,000. SEVA is set to
  1,500,000 and does not follow the curve.
- Between two fixed points, each score point adds the same percentage:

| Section | Price | Added per score point |
|---|---|---|
| IO7a to Berill-5M | 48,700 to 400,000 | +19.4% |
| Berill-5M to Skat-9 | 400,000 to 5,000,000 | +17.9% |
| Skat-9 to Radsuit | 5,000,000 to 10,000,000 | +16.7% |

- `price = lower fixed price x (price at upper point / lower fixed price) ^ ((score - lower score) /
  (upper score - lower score))`, using unrounded scores. Prices are rounded to the nearest 100 below 100,000,
  1,000 below 1,000,000, and 10,000 above that.
- SSP-99 is 143,000 and SSP-99M 868,000, the values this curve gives. Gem variants cost 1.1 x 143,000. Both
  suits keep the repair bill from their earlier price.
- NBC, Exoskeleton and Nosorog keep their current prices.
- Variants cost 1.1 x the new base price. The Technut conversion fee stays 10% of the variant's price.

| Suit | Price score | Current game price | New price | Times the suit below | Full repair now | Planned full repair |
|---|---|---|---|---|---|---|
| Anorak | 5.75 | 6,690 | 6,690 | - | 3,770 | 3,770 |
| Mail Jacket | 8.53 | 17,530 | 17,530 | x2.62 | 5,200 | 5,200 |
| Trenchcoat | 8.58 | 23,320 | 23,320 | x1.33 | 5,710 | 5,710 |
| Sunrise STALKER Suit | 11.77 | 47,920 | 47,920 | x2.05 | 7,260 | 7,260 |
| IO7a Suit | 12.15 | 48,700 | 48,700 | x1.02 | 7,300 | 7,300 |
| Sky-1 Suit | 14.45 | 49,250 | 73,200 | x1.50 | 7,330 | 7,330 |
| Pathfinder Suit | 16.65 | 99,500 | 108,000 | x1.48 | 9,270 | 9,270 |
| Universal Protection Suit | 17.08 | 108,280 | 116,000 | x1.07 | 9,530 | 9,530 |
| Expedition Suit *(new)* | 17.62 | - | 128,000 | x1.10 | - | 9,670 |
| Sky-2 Suit | 20.00 | 135,280 | 195,000 | x1.52 | 10,270 | 10,270 |
| Sky-3 Suit *(new)* | 22.60 | - | 309,000 | x1.58 | - | 11,730 |
| Berill-5M | 24.05 | 252,100 | 400,000 | x1.29 | 12,630 | 12,630 |
| Sky-4 Suit *(new)* | 25.60 | - | 516,000 | x1.29 | - | 12,740 |
| Sky-5 Suit | 30.18 | 278,200 | 1,100,000 | x2.13 | 13,060 | 13,060 |
| SEVA Suit | 32.63 | 535,000 | 1,500,000 | x1.36 | 16,240 | 16,240 |
| Skat-10 Armored Suit | 35.30 | 606,200 | 2,550,000 | x1.70 | 16,930 | 16,930 |
| Skat-9 Armored Suit | 39.38 | 1,090,000 | 5,000,000 | x1.96 | 20,580 | 20,580 |
| Radsuit | 43.88 | 3,000,920 | 10,000,000 | x2.00 | 28,850 | 28,850 |

### Repair cost

A full repair currently costs 200 x the cube root of price, before discounts (`GetRepairCost` in the suit base,
doubled in `progression/libs/sh_services.lua`). The `ITEM.repairCost` field in the suit files is not what this
uses. Raising prices alone would raise repair bills.

- Give each suit definition `ITEM.fullRepairCost`, the planned value in the table above.
- `GetRepairCost` returns `self.fullRepairCost / 200`, so the current services charge exactly that value for a
  full repair and discounts work as before. Headgear is not changed.
- Variants use their base suit's value.
- Every existing suit on the price list keeps today's bill, which already rises with price score. New suits
  are filled in between their neighbors.
- Suits not on the price list keep their current bills.

### Left as they are

Resale (15% of price at any condition), the higher sale value of suits already owned, the 10% conversion fee,
the disabled random suit offer and unlock deliveries are not changed.

| Rank | Suit | Spacing average | Bullet | Rupture | Impact | Anomaly | Price score |
|---|---|---|---|---|---|---|---|
| 1 | Anorak | 5.3 | 1.0 | 11.0 | 5 → 6.0 | 5.0 | 5.75 |
| 2 | Mail Jacket | 6.9 | 6 → 5.7 | 14 → 13.2 | 6 → 9.5 | 6 → 5.7 | 8.53 |
| 3 | Trenchcoat | 7.4 | 4 → 3.7 | 16 → 14.8 | 7 → 9.3 | 7 → 6.5 | 8.58 |
| 4 | Sunrise STALKER Suit | 10.9 | 10 → 8.5 | 19 → 16.1 | 12 → 12.3 | 12 → 10.2 | 11.77 |
| 5 | IO7a Suit | 8.4 | 13 → 11.7 | 19 → 17.1 | 6 → 14.4 | 6 → 5.4 | 12.15 |
| 6 | Sky-1 Suit | 13.7 | 13 → 12.1 | 19 → 17.7 | 14 → 14.9 | 14 → 13.1 | 14.45 |
| 7 | Pathfinder Suit | 15.9 | 14 → 12.6 | 24 → 21.6 | 17 → 17.1 | 17 → 15.3 | 16.65 |
| 8 | Universal Protection Suit | 15.2 | 17 → 15.5 | 23 → 20.9 | 15 → 18.2 | 15 → 13.7 | 17.08 |
| 9 | Expedition Suit *(new)* | 12.2 | 15.7 | 26.1 | 20.9 | 7.8 | 17.62 |
| 10 | Sky-2 Suit | 18.5 | 23 → 20.0 | 25 → 21.7 | 20 → 20.9 | 20 → 17.4 | 20.00 |
| 11 | Sky-3 Suit *(new)* | 21.1 | 22.4 | 24.5 | 23.5 | 20.0 | 22.60 |
| 12 | Berill-5M | 16.6 | 23 → 20.5 | 41 → 36.5 | 12 → 28.5 | 12 → 10.7 | 24.05 |
| 13 | Sky-4 Suit *(new)* | 24.1 | 25.2 | 27.7 | 26.5 | 23.0 | 25.60 |
| 14 | Sky-5 Suit | 28.7 | 28 → 29.5 | 31 → 32.7 | 26 → 31.1 | 26 → 27.4 | 30.18 |
| 15 | Skat-10 Armored Suit | 27.5 | 30 → 32.0 | 45 → 47.9 | 20 → 40.0 | 20 → 21.3 | 35.30 |
| 16 | Skat-9 Armored Suit | 30.2 | 35 → 36.5 | 51 → 53.2 | 22 → 44.9 | 22 → 22.9 | 39.38 |
| 17 | Radsuit | 36.2 | 39.0 | 58.0 | 30 → 48.5 | 30.0 | 43.88 |

Protection and averages are in percent.

## New and renamed suits

| Suit | Item ID | Model (`models/cotz/sectorfour/`) | Skins |
|---|---|---|---|
| Sky-1 | `suit_cs1` | `male_cs1b` (changed) | 0-4 |
| Sky-2 | `suit_cs2` | `male_cs2` (unchanged) | 0-6 |
| Sky-3 *(new)* | `suit_cs3` | `male_cs1a` | 0-5 |
| Sky-4 *(new)* | `suit_cs4` | `male_cs1` | 0-11 |
| Sky-5 (was Sky-3) | `suit_cs5` | `male_cs4` (unchanged) | 0-4 |
| Expedition *(new)* | `suit_expedition` | `male_outfit_expedition` | 0-10 |

- Variants use their base suit's model. Sky-1 Scavenger moves from `male_cs1a` and Sky-1 Ecologist stays on
  `male_cs1b`. Skins saved on another model fall back to the factory skin.
- Old Sky-3a becomes Sky-5a. Other variant names are not decided.
- Starting values for new suits, to be tuned:

| Suit | Flat bullet / rupture / impact and anomaly | Weight | Carry | Slots (exterior / interior / misc) |
|---|---|---|---|---|
| Sky-3 | 1 / 2 / 1 | 12 | 9.6 | 2 / 2 / 1 |
| Sky-4 | 2 / 2 / 2 | 14 | 11.2 | 2 / 2 / 2 |
| Expedition | 2 / 1 / 1 | 10.5 | 8.4 | 2 / 1 / 0 |

- Weight is interpolated like protection, and carry is 0.8 x weight. Prices come from the price list. New suits have
  no helmet, gas mask or backpack flag. Sky-1 keeps its helmet flag.
- Each new suit still needs a description, inventory icon, ground model, factory skin, Technut purchase
  step and Suture variant step. Technut's tier list in `sh_equipment.lua` needs the new IDs, and the model
  table in `tests/suit_appearance_spec.lua` needs Expedition.

## Variant types

| Type | Boosts | Other protections | Special | Weight | Carry | Price |
|---|---|---|---|---|---|---|
| Authority | Rupture +15% | -6% | - | x1.02 | x1.02 | x1.1 |
| Mercenary | Bullet and impact +15%, thermal +10% | -3% | - | x1.02 | x1.01 | x1.1 |
| Ecologist | All anomaly +10%, impact +5% | -6% | - | x0.60 | x0.90 | x1.1 |
| Fanatic | All anomaly +5% | -3% | Psychic bonus | x1.00 | x0.99 | x1.1 |
| Anarchist | Chemical +10% | -3% | +1 misc slot | x1.01 | x0.98 | x1.1 |
| Scavenger | Electrical +10% | -3% | Suit carry bonus x2 | x0.99 | x2.00 | x1.1 |
| Looted | Bullet +10% | -3% | Melee perk | x1.01 | x0.99 | x1.1 |

Every suit gets all seven types, except SSP-99 and SSP-99M (see SSP-99 gem variants). *(new)* in the tables
marks a variant that had no item file when planned.

Exoskeleton and Nosorog variants keep the base price and carry bonus, except that Scavenger doubles carry.
Existing Exoskeleton variants keep their current weights. New Exoskeleton variants and all Nosorog variants
use the base weight.

## Protection rules

- Changes are relative to the base suit: 40% protection with a +15% boost becomes 46%.
- Stats: bullet, rupture, impact, thermal, electrical, chemical, psychic, radiation.
- "Other protections" means every stat the type does not boost. A stat the base suit lacks stays at 0.
- Radiation of 90% or higher (NBC, SEVA) is not penalised. Lower radiation takes the type's penalty.
- Thermal, electrical and chemical are not spread apart. Each takes exactly the type's boost or penalty.
- Variants have no flat protection changes. All flat values and `flatRadProt` are the same as the base
  suit's, so the tables leave them out.
- Values are fixed in each item file. Nothing is rolled at runtime.

## 90% cap

- Every protection except radiation is capped at 90%.
- The cap applies to suit definitions and to the worn total of suit, headgear, attachments and upgrades.
  In the worn-total functions in `plugins/suits/sh_plugin.lua`, the damage multiplier cannot go below 0.1.
- Suit tooltips should show the capped value.

## Special perks

For both averages, "all resistances" means the percentage values of bullet, rupture, impact, thermal,
electrical and chemical. Psychic, radiation and flat values are left out.

### Fanatic: psychic bonus

- Psychic = base psychic + the average of the Fanatic variant's own six values, added as percentage points.
- It is a fixed value in the item file, so attachments and wear do not change the average.
- Psychic takes no penalty. The 90% cap applies.

### Anarchist: +1 misc slot

- `extraSlots` = base `extraSlots` + 1.
- Suits save their slot limits in `maxMiscSlots` when created. Do not update owned suits on load or spawn.
  Refresh the saved value from the item definition when the suit is equipped (the Equip action, not
  `OnLoadout`). A suit that is already worn gets the slot after being taken off and put on again.
- The tooltip draws slots from the definition. Make it use the saved limit, so it does not show a slot
  that cannot be used yet.
- All current misc attachments add carry capacity, and nothing prevents installing the same one twice.

### Looted: melee

- Applies while the Looted suit is worn, to weapons based on `tfa_nmrimelee_base`. Fists are not included.
- Damage is multiplied by 1 + the average of the **base suit's** six definition values.
- The bonus is a fixed value in the Looted item file. Wear, attachments, upgrades, headgear and the Looted
  suit's own boosts and penalties do not change it.
- A swing that hits a player or NPC gets its stamina back. Misses cost stamina as normal, and the existing
  minimum of 20 stamina to swing still applies.
- Needs changes to the melee base's swing functions. Both of their hit paths (bullet and hull trace) need covering.

## SSP-99 gem variants

SSP-99 gets five gem variants instead of the seven types. SSP-99M is the bullet and rupture option. It keeps
its current stats, apart from base impact, and has no variants of its own.

| Gem | Boost |
|---|---|
| Ruby | Thermal +20% |
| Sapphire | Electrical +20% |
| Emerald | Chemical +20% |
| Amethyst | Psychic +20% |
| Diamond | Impact set to 30% |

- Every protection the gem does not boost gets -2%, including bullet and rupture. Radiation stays at 99%.
- Weight, carry, slots and flat values match SSP-99. Price is x1.1, like other variants.
- Variants declare `baseSuit = "suit_ssp99"` and `suitVariant` as the gem name. SSP-99 conversion offers and
  unlocks must include these five names.
- Each gem needs a skin in its color (Sapphire is blue). Which of the model's skins 0-14 fit is not checked.

## One trenchcoat with seven variants

The four color items become one suit, `suit_trenchcoat`, named "Trenchcoat". Color is only a skin.

- It declares `baseSuit = "suit_trenchcoat"`, which the color items lack, and keeps factory skin 1 (black).
- Technut may apply every skin, 0-8. All four items already allow this range.
- Technut sells one trenchcoat in place of four. Keep the saved progression step
  `v3/suits/suit_trenchcoat_black`, and reword its completion line, which lists four colors.
- Update the entries in `townnpcs` (`sh_technut.lua`, `sh_equipment.lua`, `sv_runtime.lua`), the docs and
  the tests that name the color IDs.

## Fixes to existing mistakes

The base suit is treated as correct, so most fixes follow from recalculating the variants.

| Mistake | Fix |
|---|---|
| Anorak and Sunrise variants lack radiation protection | Derive it from the base 0.05, then apply the penalty |
| Mail Jacket variants use a different elemental value | Derive from the base 0.06 |
| Sunrise variant prices use 47,290 | Derive from the new base price |
| Authority Anorak costs 7,539 | 7,359 |
| Sky-5 (old Sky-3) Ecologist has no anomaly percentage boost | Apply the Ecologist recipe |
| Sky-2 and Mail Jacket Ecologist carry bonuses | Base carry x0.90: 7.2 and 4.36 |
| PS5-M Authority carry bonus | Base carry x1.02: 8.98 |
| Wind Fanatic weighs 5.6 | 5.0 |
| Exoskeleton Fanatic has no variant tag | Set `suitVariant = "fanatic"` |

## Tooltips

- Protection tooltips show one decimal, so small penalties stay visible.

## Open points

- Base Radsuit has no radiation protection. It is left at 0.
- NBC's price is not rescaled.
- Exoskeleton and Nosorog still use the placeholder 9,999,999,999.
- Fists are left out of the Looted melee perk.
- Doubled carry on Exoskeleton and Nosorog Scavenger gives 128 kg.
- Sky-3, Sky-4 and Expedition still need progression before players can get them.
- Looted variants cannot be obtained through any current menu.

## Numbers

Protection is in percent.

### Anorak (`suit_anorak`)

| Suit | Bullet | Rupture | Impact | Thermal | Electrical | Chemical | Psychic | Radiation | Misc slots | Melee bonus | Weight | Carry | Price |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| Base | 1.0 | 11.0 | 6.0 | 5.0 | 5.0 | 5.0 | 0.0 | 5.0 | 0 | - | 3.86 | 3.09 | 6690 |
| Authority | 0.9 | 12.7 | 5.6 | 4.7 | 4.7 | 4.7 | 0.0 | 4.7 | 0 | - | 3.937 | 3.15 | 7359 |
| Mercenary | 1.2 | 10.7 | 6.9 | 5.5 | 4.9 | 4.9 | 0.0 | 4.9 | 0 | - | 3.937 | 3.12 | 7359 |
| Ecologist | 0.9 | 10.3 | 6.3 | 5.5 | 5.5 | 5.5 | 0.0 | 4.7 | 0 | - | 2.316 | 2.78 | 7359 |
| Fanatic *(new)* | 1.0 | 10.7 | 5.8 | 5.3 | 5.3 | 5.3 | 5.5 | 4.9 | 0 | - | 3.86 | 3.06 | 7359 |
| Anarchist | 1.0 | 10.7 | 5.8 | 4.9 | 4.9 | 5.5 | 0.0 | 4.9 | 1 | - | 3.899 | 3.03 | 7359 |
| Scavenger | 1.0 | 10.7 | 5.8 | 4.9 | 5.5 | 4.9 | 0.0 | 4.9 | 0 | - | 3.821 | 6.18 | 7359 |
| Looted *(new)* | 1.1 | 10.7 | 5.8 | 4.9 | 4.9 | 4.9 | 0.0 | 4.9 | 0 | +5.5% | 3.899 | 3.06 | 7359 |

### Mail Jacket (`suit_mailjacket`)

| Suit | Bullet | Rupture | Impact | Thermal | Electrical | Chemical | Psychic | Radiation | Misc slots | Melee bonus | Weight | Carry | Price |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| Base | 5.7 | 13.2 | 9.5 | 5.7 | 5.7 | 5.7 | 0.0 | 0.0 | 0 | - | 6.92 | 4.84 | 17530 |
| Authority | 5.4 | 15.2 | 8.9 | 5.4 | 5.4 | 5.4 | 0.0 | 0.0 | 0 | - | 7.058 | 4.94 | 19283 |
| Mercenary | 6.6 | 12.8 | 10.9 | 6.3 | 5.5 | 5.5 | 0.0 | 0.0 | 0 | - | 7.058 | 4.89 | 19283 |
| Ecologist | 5.4 | 12.4 | 10.0 | 6.3 | 6.3 | 6.3 | 0.0 | 0.0 | 0 | - | 4.152 | 4.36 | 19283 |
| Fanatic *(new)* | 5.5 | 12.8 | 9.2 | 6.0 | 6.0 | 6.0 | 7.6 | 0.0 | 0 | - | 6.92 | 4.79 | 19283 |
| Anarchist | 5.5 | 12.8 | 9.2 | 5.5 | 5.5 | 6.3 | 0.0 | 0.0 | 1 | - | 6.989 | 4.74 | 19283 |
| Scavenger | 5.5 | 12.8 | 9.2 | 5.5 | 6.3 | 5.5 | 0.0 | 0.0 | 0 | - | 6.851 | 9.68 | 19283 |
| Looted *(new)* | 6.3 | 12.8 | 9.2 | 5.5 | 5.5 | 5.5 | 0.0 | 0.0 | 0 | +7.6% | 6.989 | 4.79 | 19283 |

### Trenchcoat (`suit_trenchcoat`)

| Suit | Bullet | Rupture | Impact | Thermal | Electrical | Chemical | Psychic | Radiation | Misc slots | Melee bonus | Weight | Carry | Price |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| Base | 3.7 | 14.8 | 9.3 | 6.5 | 6.5 | 6.5 | 0.0 | 0.0 | 0 | - | 5.22 | 4.18 | 23320 |
| Authority *(new)* | 3.5 | 17.0 | 8.7 | 6.1 | 6.1 | 6.1 | 0.0 | 0.0 | 0 | - | 5.324 | 4.26 | 25652 |
| Mercenary *(new)* | 4.3 | 14.4 | 10.7 | 7.2 | 6.3 | 6.3 | 0.0 | 0.0 | 0 | - | 5.324 | 4.22 | 25652 |
| Ecologist *(new)* | 3.5 | 13.9 | 9.8 | 7.2 | 7.2 | 7.2 | 0.0 | 0.0 | 0 | - | 3.132 | 3.76 | 25652 |
| Fanatic *(new)* | 3.6 | 14.4 | 9.0 | 6.8 | 6.8 | 6.8 | 7.9 | 0.0 | 0 | - | 5.22 | 4.14 | 25652 |
| Anarchist *(new)* | 3.6 | 14.4 | 9.0 | 6.3 | 6.3 | 7.2 | 0.0 | 0.0 | 1 | - | 5.272 | 4.1 | 25652 |
| Scavenger *(new)* | 3.6 | 14.4 | 9.0 | 6.3 | 7.2 | 6.3 | 0.0 | 0.0 | 0 | - | 5.168 | 8.36 | 25652 |
| Looted *(new)* | 4.1 | 14.4 | 9.0 | 6.3 | 6.3 | 6.3 | 0.0 | 0.0 | 0 | +7.9% | 5.272 | 4.14 | 25652 |

### IO7a Suit (`suit_io7a`)

| Suit | Bullet | Rupture | Impact | Thermal | Electrical | Chemical | Psychic | Radiation | Misc slots | Melee bonus | Weight | Carry | Price |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| Base | 11.7 | 17.1 | 14.4 | 5.4 | 5.4 | 5.4 | 0.0 | 0.0 | 0 | - | 9 | 7.2 | 48700 |
| Authority | 11.0 | 19.7 | 13.5 | 5.1 | 5.1 | 5.1 | 0.0 | 0.0 | 0 | - | 9.18 | 7.34 | 53570 |
| Mercenary | 13.5 | 16.6 | 16.6 | 5.9 | 5.2 | 5.2 | 0.0 | 0.0 | 0 | - | 9.18 | 7.27 | 53570 |
| Ecologist | 11.0 | 16.1 | 15.1 | 5.9 | 5.9 | 5.9 | 0.0 | 0.0 | 0 | - | 5.4 | 6.48 | 53570 |
| Fanatic | 11.3 | 16.6 | 14.0 | 5.7 | 5.7 | 5.7 | 9.8 | 0.0 | 0 | - | 9 | 7.13 | 53570 |
| Anarchist | 11.3 | 16.6 | 14.0 | 5.2 | 5.2 | 5.9 | 0.0 | 0.0 | 1 | - | 9.09 | 7.06 | 53570 |
| Scavenger | 11.3 | 16.6 | 14.0 | 5.2 | 5.9 | 5.2 | 0.0 | 0.0 | 0 | - | 8.91 | 14.4 | 53570 |
| Looted | 12.9 | 16.6 | 14.0 | 5.2 | 5.2 | 5.2 | 0.0 | 0.0 | 0 | +9.9% | 9.09 | 7.13 | 53570 |

### Sunrise STALKER Suit (`suit_sunrise`)

| Suit | Bullet | Rupture | Impact | Thermal | Electrical | Chemical | Psychic | Radiation | Misc slots | Melee bonus | Weight | Carry | Price |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| Base | 8.5 | 16.1 | 12.3 | 10.2 | 10.2 | 10.2 | 0.0 | 5.0 | 0 | - | 6.2 | 4.96 | 47920 |
| Authority | 8.0 | 18.5 | 11.6 | 9.6 | 9.6 | 9.6 | 0.0 | 4.7 | 0 | - | 6.324 | 5.06 | 52712 |
| Mercenary | 9.8 | 15.6 | 14.1 | 11.2 | 9.9 | 9.9 | 0.0 | 4.9 | 0 | - | 6.324 | 5.01 | 52712 |
| Ecologist *(new)* | 8.0 | 15.1 | 12.9 | 11.2 | 11.2 | 11.2 | 0.0 | 4.7 | 0 | - | 3.72 | 4.46 | 52712 |
| Fanatic | 8.2 | 15.6 | 11.9 | 10.7 | 10.7 | 10.7 | 11.3 | 4.9 | 0 | - | 6.2 | 4.91 | 52712 |
| Anarchist | 8.2 | 15.6 | 11.9 | 9.9 | 9.9 | 11.2 | 0.0 | 4.9 | 1 | - | 6.262 | 4.86 | 52712 |
| Scavenger | 8.2 | 15.6 | 11.9 | 9.9 | 11.2 | 9.9 | 0.0 | 4.9 | 0 | - | 6.138 | 9.92 | 52712 |
| Looted | 9.4 | 15.6 | 11.9 | 9.9 | 9.9 | 9.9 | 0.0 | 4.9 | 0 | +11.2% | 6.262 | 4.91 | 52712 |

### Expedition Suit (`suit_expedition`)

| Suit | Bullet | Rupture | Impact | Thermal | Electrical | Chemical | Psychic | Radiation | Misc slots | Melee bonus | Weight | Carry | Price |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| Base | 15.7 | 26.1 | 20.9 | 7.8 | 7.8 | 7.8 | 0.0 | 0.0 | 0 | - | 10.5 | 8.4 | 128000 |
| Authority *(new)* | 14.8 | 30.0 | 19.6 | 7.3 | 7.3 | 7.3 | 0.0 | 0.0 | 0 | - | 10.71 | 8.57 | 140800 |
| Mercenary *(new)* | 18.1 | 25.3 | 24.0 | 8.6 | 7.6 | 7.6 | 0.0 | 0.0 | 0 | - | 10.71 | 8.48 | 140800 |
| Ecologist *(new)* | 14.8 | 24.5 | 21.9 | 8.6 | 8.6 | 8.6 | 0.0 | 0.0 | 0 | - | 6.3 | 7.56 | 140800 |
| Fanatic *(new)* | 15.2 | 25.3 | 20.3 | 8.2 | 8.2 | 8.2 | 14.2 | 0.0 | 0 | - | 10.5 | 8.32 | 140800 |
| Anarchist *(new)* | 15.2 | 25.3 | 20.3 | 7.6 | 7.6 | 8.6 | 0.0 | 0.0 | 1 | - | 10.605 | 8.23 | 140800 |
| Scavenger *(new)* | 15.2 | 25.3 | 20.3 | 7.6 | 8.6 | 7.6 | 0.0 | 0.0 | 0 | - | 10.395 | 16.8 | 140800 |
| Looted *(new)* | 17.3 | 25.3 | 20.3 | 7.6 | 7.6 | 7.6 | 0.0 | 0.0 | 0 | +14.3% | 10.605 | 8.32 | 140800 |

### Sky-1 Suit (`suit_cs1`)

| Suit | Bullet | Rupture | Impact | Thermal | Electrical | Chemical | Psychic | Radiation | Misc slots | Melee bonus | Weight | Carry | Price |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| Base | 12.1 | 17.7 | 14.9 | 13.1 | 13.1 | 13.1 | 0.0 | 0.0 | 1 | - | 7 | 5.6 | 73200 |
| Authority *(new)* | 11.4 | 20.4 | 14.0 | 12.3 | 12.3 | 12.3 | 0.0 | 0.0 | 1 | - | 7.14 | 5.71 | 80520 |
| Mercenary *(new)* | 13.9 | 17.2 | 17.1 | 14.4 | 12.7 | 12.7 | 0.0 | 0.0 | 1 | - | 7.14 | 5.66 | 80520 |
| Ecologist | 11.4 | 16.6 | 15.6 | 14.4 | 14.4 | 14.4 | 0.0 | 0.0 | 1 | - | 4.2 | 5.04 | 80520 |
| Fanatic *(new)* | 11.7 | 17.2 | 14.5 | 13.8 | 13.8 | 13.8 | 14.1 | 0.0 | 1 | - | 7 | 5.54 | 80520 |
| Anarchist *(new)* | 11.7 | 17.2 | 14.5 | 12.7 | 12.7 | 14.4 | 0.0 | 0.0 | 2 | - | 7.07 | 5.49 | 80520 |
| Scavenger | 11.7 | 17.2 | 14.5 | 12.7 | 14.4 | 12.7 | 0.0 | 0.0 | 1 | - | 6.93 | 11.2 | 80520 |
| Looted *(new)* | 13.3 | 17.2 | 14.5 | 12.7 | 12.7 | 12.7 | 0.0 | 0.0 | 1 | +14.0% | 7.07 | 5.54 | 80520 |

### Universal Protection Suit (`suit_ps5m`)

| Suit | Bullet | Rupture | Impact | Thermal | Electrical | Chemical | Psychic | Radiation | Misc slots | Melee bonus | Weight | Carry | Price |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| Base | 15.5 | 20.9 | 18.2 | 13.7 | 13.7 | 13.7 | 0.0 | 0.0 | 1 | - | 11 | 8.8 | 116000 |
| Authority | 14.6 | 24.0 | 17.1 | 12.9 | 12.9 | 12.9 | 0.0 | 0.0 | 1 | - | 11.22 | 8.98 | 127600 |
| Mercenary | 17.8 | 20.3 | 20.9 | 15.1 | 13.3 | 13.3 | 0.0 | 0.0 | 1 | - | 11.22 | 8.89 | 127600 |
| Ecologist | 14.6 | 19.6 | 19.1 | 15.1 | 15.1 | 15.1 | 0.0 | 0.0 | 1 | - | 6.6 | 7.92 | 127600 |
| Fanatic | 15.0 | 20.3 | 17.7 | 14.4 | 14.4 | 14.4 | 16.0 | 0.0 | 1 | - | 11 | 8.71 | 127600 |
| Anarchist | 15.0 | 20.3 | 17.7 | 13.3 | 13.3 | 15.1 | 0.0 | 0.0 | 2 | - | 11.11 | 8.62 | 127600 |
| Scavenger *(new)* | 15.0 | 20.3 | 17.7 | 13.3 | 15.1 | 13.3 | 0.0 | 0.0 | 1 | - | 10.89 | 17.6 | 127600 |
| Looted *(new)* | 17.1 | 20.3 | 17.7 | 13.3 | 13.3 | 13.3 | 0.0 | 0.0 | 1 | +16.0% | 11.11 | 8.71 | 127600 |

### Pathfinder Suit (`suit_wind`)

| Suit | Bullet | Rupture | Impact | Thermal | Electrical | Chemical | Psychic | Radiation | Misc slots | Melee bonus | Weight | Carry | Price |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| Base | 12.6 | 21.6 | 17.1 | 15.3 | 15.3 | 15.3 | 0.0 | 0.0 | 2 | - | 5 | 5 | 108000 |
| Authority | 11.8 | 24.8 | 16.1 | 14.4 | 14.4 | 14.4 | 0.0 | 0.0 | 2 | - | 5.1 | 5.1 | 118800 |
| Mercenary *(new)* | 14.5 | 21.0 | 19.7 | 16.8 | 14.8 | 14.8 | 0.0 | 0.0 | 2 | - | 5.1 | 5.05 | 118800 |
| Ecologist *(new)* | 11.8 | 20.3 | 18.0 | 16.8 | 16.8 | 16.8 | 0.0 | 0.0 | 2 | - | 3 | 4.5 | 118800 |
| Fanatic | 12.2 | 21.0 | 16.6 | 16.1 | 16.1 | 16.1 | 16.3 | 0.0 | 2 | - | 5 | 4.95 | 118800 |
| Anarchist | 12.2 | 21.0 | 16.6 | 14.8 | 14.8 | 16.8 | 0.0 | 0.0 | 3 | - | 5.05 | 4.9 | 118800 |
| Scavenger *(new)* | 12.2 | 21.0 | 16.6 | 14.8 | 16.8 | 14.8 | 0.0 | 0.0 | 2 | - | 4.95 | 10 | 118800 |
| Looted | 13.9 | 21.0 | 16.6 | 14.8 | 14.8 | 14.8 | 0.0 | 0.0 | 2 | +16.2% | 5.05 | 4.95 | 118800 |

### Berill-5M (`suit_berill`)

| Suit | Bullet | Rupture | Impact | Thermal | Electrical | Chemical | Psychic | Radiation | Misc slots | Melee bonus | Weight | Carry | Price |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| Base | 20.5 | 36.5 | 28.5 | 10.7 | 10.7 | 10.7 | 0.0 | 0.0 | 1 | - | 12 | 9.6 | 400000 |
| Authority | 19.3 | 42.0 | 26.8 | 10.1 | 10.1 | 10.1 | 0.0 | 0.0 | 1 | - | 12.24 | 9.79 | 440000 |
| Mercenary | 23.6 | 35.4 | 32.8 | 11.8 | 10.4 | 10.4 | 0.0 | 0.0 | 1 | - | 12.24 | 9.7 | 440000 |
| Ecologist | 19.3 | 34.3 | 29.9 | 11.8 | 11.8 | 11.8 | 0.0 | 0.0 | 1 | - | 7.2 | 8.64 | 440000 |
| Fanatic *(new)* | 19.9 | 35.4 | 27.6 | 11.2 | 11.2 | 11.2 | 19.4 | 0.0 | 1 | - | 12 | 9.5 | 440000 |
| Anarchist | 19.9 | 35.4 | 27.6 | 10.4 | 10.4 | 11.8 | 0.0 | 0.0 | 2 | - | 12.12 | 9.41 | 440000 |
| Scavenger | 19.9 | 35.4 | 27.6 | 10.4 | 11.8 | 10.4 | 0.0 | 0.0 | 1 | - | 11.88 | 19.2 | 440000 |
| Looted | 22.6 | 35.4 | 27.6 | 10.4 | 10.4 | 10.4 | 0.0 | 0.0 | 1 | +19.6% | 12.12 | 9.5 | 440000 |

### Sky-2 Suit (`suit_cs2`)

| Suit | Bullet | Rupture | Impact | Thermal | Electrical | Chemical | Psychic | Radiation | Misc slots | Melee bonus | Weight | Carry | Price |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| Base | 20.0 | 21.7 | 20.9 | 17.4 | 17.4 | 17.4 | 0.0 | 0.0 | 1 | - | 10 | 8 | 195000 |
| Authority *(new)* | 18.8 | 25.0 | 19.6 | 16.4 | 16.4 | 16.4 | 0.0 | 0.0 | 1 | - | 10.2 | 8.16 | 214500 |
| Mercenary *(new)* | 23.0 | 21.0 | 24.0 | 19.1 | 16.9 | 16.9 | 0.0 | 0.0 | 1 | - | 10.2 | 8.08 | 214500 |
| Ecologist | 18.8 | 20.4 | 21.9 | 19.1 | 19.1 | 19.1 | 0.0 | 0.0 | 1 | - | 6 | 7.2 | 214500 |
| Fanatic *(new)* | 19.4 | 21.0 | 20.3 | 18.3 | 18.3 | 18.3 | 19.3 | 0.0 | 1 | - | 10 | 7.92 | 214500 |
| Anarchist *(new)* | 19.4 | 21.0 | 20.3 | 16.9 | 16.9 | 19.1 | 0.0 | 0.0 | 2 | - | 10.1 | 7.84 | 214500 |
| Scavenger | 19.4 | 21.0 | 20.3 | 16.9 | 19.1 | 16.9 | 0.0 | 0.0 | 1 | - | 9.9 | 16 | 214500 |
| Looted *(new)* | 22.0 | 21.0 | 20.3 | 16.9 | 16.9 | 16.9 | 0.0 | 0.0 | 1 | +19.1% | 10.1 | 7.92 | 214500 |

### Sky-3 Suit (`suit_cs3`)

| Suit | Bullet | Rupture | Impact | Thermal | Electrical | Chemical | Psychic | Radiation | Misc slots | Melee bonus | Weight | Carry | Price |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| Base | 22.4 | 24.5 | 23.5 | 20.0 | 20.0 | 20.0 | 0.0 | 0.0 | 1 | - | 12 | 9.6 | 309000 |
| Authority *(new)* | 21.1 | 28.2 | 22.1 | 18.8 | 18.8 | 18.8 | 0.0 | 0.0 | 1 | - | 12.24 | 9.79 | 339900 |
| Mercenary *(new)* | 25.8 | 23.8 | 27.0 | 22.0 | 19.4 | 19.4 | 0.0 | 0.0 | 1 | - | 12.24 | 9.7 | 339900 |
| Ecologist *(new)* | 21.1 | 23.0 | 24.7 | 22.0 | 22.0 | 22.0 | 0.0 | 0.0 | 1 | - | 7.2 | 8.64 | 339900 |
| Fanatic *(new)* | 21.7 | 23.8 | 22.8 | 21.0 | 21.0 | 21.0 | 21.9 | 0.0 | 1 | - | 12 | 9.5 | 339900 |
| Anarchist *(new)* | 21.7 | 23.8 | 22.8 | 19.4 | 19.4 | 22.0 | 0.0 | 0.0 | 2 | - | 12.12 | 9.41 | 339900 |
| Scavenger *(new)* | 21.7 | 23.8 | 22.8 | 19.4 | 22.0 | 19.4 | 0.0 | 0.0 | 1 | - | 11.88 | 19.2 | 339900 |
| Looted *(new)* | 24.6 | 23.8 | 22.8 | 19.4 | 19.4 | 19.4 | 0.0 | 0.0 | 1 | +21.7% | 12.12 | 9.5 | 339900 |

### Sky-4 Suit (`suit_cs4`)

| Suit | Bullet | Rupture | Impact | Thermal | Electrical | Chemical | Psychic | Radiation | Misc slots | Melee bonus | Weight | Carry | Price |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| Base | 25.2 | 27.7 | 26.5 | 23.0 | 23.0 | 23.0 | 0.0 | 0.0 | 2 | - | 14 | 11.2 | 516000 |
| Authority *(new)* | 23.7 | 31.9 | 24.9 | 21.6 | 21.6 | 21.6 | 0.0 | 0.0 | 2 | - | 14.28 | 11.42 | 567600 |
| Mercenary *(new)* | 29.0 | 26.9 | 30.5 | 25.3 | 22.3 | 22.3 | 0.0 | 0.0 | 2 | - | 14.28 | 11.31 | 567600 |
| Ecologist *(new)* | 23.7 | 26.0 | 27.8 | 25.3 | 25.3 | 25.3 | 0.0 | 0.0 | 2 | - | 8.4 | 10.08 | 567600 |
| Fanatic *(new)* | 24.4 | 26.9 | 25.7 | 24.2 | 24.2 | 24.2 | 24.9 | 0.0 | 2 | - | 14 | 11.09 | 567600 |
| Anarchist *(new)* | 24.4 | 26.9 | 25.7 | 22.3 | 22.3 | 25.3 | 0.0 | 0.0 | 3 | - | 14.14 | 10.98 | 567600 |
| Scavenger *(new)* | 24.4 | 26.9 | 25.7 | 22.3 | 25.3 | 22.3 | 0.0 | 0.0 | 2 | - | 13.86 | 22.4 | 567600 |
| Looted *(new)* | 27.7 | 26.9 | 25.7 | 22.3 | 22.3 | 22.3 | 0.0 | 0.0 | 2 | +24.7% | 14.14 | 11.09 | 567600 |

### Skat-10 Armored Suit (`suit_skat10`)

| Suit | Bullet | Rupture | Impact | Thermal | Electrical | Chemical | Psychic | Radiation | Misc slots | Melee bonus | Weight | Carry | Price |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| Base | 32.0 | 47.9 | 40.0 | 21.3 | 21.3 | 21.3 | 0.0 | 0.0 | 1 | - | 16.5 | 11.55 | 2550000 |
| Authority | 30.1 | 55.1 | 37.6 | 20.0 | 20.0 | 20.0 | 0.0 | 0.0 | 1 | - | 16.83 | 11.78 | 2805000 |
| Mercenary | 36.8 | 46.5 | 46.0 | 23.4 | 20.7 | 20.7 | 0.0 | 0.0 | 1 | - | 16.83 | 11.67 | 2805000 |
| Ecologist | 30.1 | 45.0 | 42.0 | 23.4 | 23.4 | 23.4 | 0.0 | 0.0 | 1 | - | 9.9 | 10.4 | 2805000 |
| Fanatic *(new)* | 31.0 | 46.5 | 38.8 | 22.4 | 22.4 | 22.4 | 30.6 | 0.0 | 1 | - | 16.5 | 11.43 | 2805000 |
| Anarchist | 31.0 | 46.5 | 38.8 | 20.7 | 20.7 | 23.4 | 0.0 | 0.0 | 2 | - | 16.665 | 11.32 | 2805000 |
| Scavenger *(new)* | 31.0 | 46.5 | 38.8 | 20.7 | 23.4 | 20.7 | 0.0 | 0.0 | 1 | - | 16.335 | 23.1 | 2805000 |
| Looted | 35.2 | 46.5 | 38.8 | 20.7 | 20.7 | 20.7 | 0.0 | 0.0 | 1 | +30.6% | 16.665 | 11.43 | 2805000 |

### Sky-5 Suit (`suit_cs5`)

| Suit | Bullet | Rupture | Impact | Thermal | Electrical | Chemical | Psychic | Radiation | Misc slots | Melee bonus | Weight | Carry | Price |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| Base | 29.5 | 32.7 | 31.1 | 27.4 | 27.4 | 27.4 | 0.0 | 0.0 | 2 | - | 16 | 12.8 | 1100000 |
| Authority *(new)* | 27.7 | 37.6 | 29.2 | 25.8 | 25.8 | 25.8 | 0.0 | 0.0 | 2 | - | 16.32 | 13.06 | 1210000 |
| Mercenary *(new)* | 33.9 | 31.7 | 35.8 | 30.1 | 26.6 | 26.6 | 0.0 | 0.0 | 2 | - | 16.32 | 12.93 | 1210000 |
| Ecologist | 27.7 | 30.7 | 32.7 | 30.1 | 30.1 | 30.1 | 0.0 | 0.0 | 2 | - | 9.6 | 11.52 | 1210000 |
| Fanatic *(new)* | 28.6 | 31.7 | 30.2 | 28.8 | 28.8 | 28.8 | 29.5 | 0.0 | 2 | - | 16 | 12.67 | 1210000 |
| Anarchist *(new)* | 28.6 | 31.7 | 30.2 | 26.6 | 26.6 | 30.1 | 0.0 | 0.0 | 3 | - | 16.16 | 12.54 | 1210000 |
| Scavenger *(new)* | 28.6 | 31.7 | 30.2 | 26.6 | 30.1 | 26.6 | 0.0 | 0.0 | 2 | - | 15.84 | 25.6 | 1210000 |
| Looted *(new)* | 32.5 | 31.7 | 30.2 | 26.6 | 26.6 | 26.6 | 0.0 | 0.0 | 2 | +29.3% | 16.16 | 12.67 | 1210000 |

### Skat-9 Armored Suit (`suit_skat9`)

| Suit | Bullet | Rupture | Impact | Thermal | Electrical | Chemical | Psychic | Radiation | Misc slots | Melee bonus | Weight | Carry | Price |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| Base | 36.5 | 53.2 | 44.9 | 22.9 | 22.9 | 22.9 | 0.0 | 0.0 | 1 | - | 21 | 16.8 | 5000000 |
| Authority | 34.3 | 61.2 | 42.2 | 21.5 | 21.5 | 21.5 | 0.0 | 0.0 | 1 | - | 21.42 | 17.14 | 5500000 |
| Mercenary *(new)* | 42.0 | 51.6 | 51.6 | 25.2 | 22.2 | 22.2 | 0.0 | 0.0 | 1 | - | 21.42 | 16.97 | 5500000 |
| Ecologist | 34.3 | 50.0 | 47.1 | 25.2 | 25.2 | 25.2 | 0.0 | 0.0 | 1 | - | 12.6 | 15.12 | 5500000 |
| Fanatic | 35.4 | 51.6 | 43.6 | 24.0 | 24.0 | 24.0 | 33.8 | 0.0 | 1 | - | 21 | 16.63 | 5500000 |
| Anarchist | 35.4 | 51.6 | 43.6 | 22.2 | 22.2 | 25.2 | 0.0 | 0.0 | 2 | - | 21.21 | 16.46 | 5500000 |
| Scavenger | 35.4 | 51.6 | 43.6 | 22.2 | 25.2 | 22.2 | 0.0 | 0.0 | 1 | - | 20.79 | 33.6 | 5500000 |
| Looted | 40.2 | 51.6 | 43.6 | 22.2 | 22.2 | 22.2 | 0.0 | 0.0 | 1 | +33.9% | 21.21 | 16.63 | 5500000 |

### Radsuit (`suit_radsuit`)

| Suit | Bullet | Rupture | Impact | Thermal | Electrical | Chemical | Psychic | Radiation | Misc slots | Melee bonus | Weight | Carry | Price |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| Base | 39.0 | 58.0 | 48.5 | 30.0 | 30.0 | 30.0 | 0.0 | 0.0 | 2 | - | 22.5 | 17.64 | 10000000 |
| Authority | 36.7 | 66.7 | 45.6 | 28.2 | 28.2 | 28.2 | 0.0 | 0.0 | 2 | - | 22.95 | 17.99 | 11000000 |
| Mercenary | 44.8 | 56.3 | 55.8 | 33.0 | 29.1 | 29.1 | 0.0 | 0.0 | 2 | - | 22.95 | 17.82 | 11000000 |
| Ecologist | 36.7 | 54.5 | 50.9 | 33.0 | 33.0 | 33.0 | 0.0 | 0.0 | 2 | - | 13.5 | 15.88 | 11000000 |
| Fanatic | 37.8 | 56.3 | 47.0 | 31.5 | 31.5 | 31.5 | 39.3 | 0.0 | 2 | - | 22.5 | 17.46 | 11000000 |
| Anarchist | 37.8 | 56.3 | 47.0 | 29.1 | 29.1 | 33.0 | 0.0 | 0.0 | 3 | - | 22.725 | 17.29 | 11000000 |
| Scavenger *(new)* | 37.8 | 56.3 | 47.0 | 29.1 | 33.0 | 29.1 | 0.0 | 0.0 | 2 | - | 22.275 | 35.28 | 11000000 |
| Looted *(new)* | 42.9 | 56.3 | 47.0 | 29.1 | 29.1 | 29.1 | 0.0 | 0.0 | 2 | +39.2% | 22.725 | 17.46 | 11000000 |

### NBC Suit (`suit_nbc`)

| Suit | Bullet | Rupture | Impact | Thermal | Electrical | Chemical | Psychic | Radiation | Misc slots | Melee bonus | Weight | Carry | Price |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| Base | 9.0 | 17.0 | 13.0 | 20.0 | 20.0 | 20.0 | 10.0 | 90.0 | 0 | - | 7.9 | 6.32 | 165000 |
| Authority | 8.5 | 19.6 | 12.2 | 18.8 | 18.8 | 18.8 | 9.4 | 90.0 | 0 | - | 8.058 | 6.45 | 181500 |
| Mercenary *(new)* | 10.4 | 16.5 | 15.0 | 22.0 | 19.4 | 19.4 | 9.7 | 90.0 | 0 | - | 8.058 | 6.38 | 181500 |
| Ecologist *(new)* | 8.5 | 16.0 | 13.7 | 22.0 | 22.0 | 22.0 | 9.4 | 90.0 | 0 | - | 4.74 | 5.69 | 181500 |
| Fanatic | 8.7 | 16.5 | 12.6 | 21.0 | 21.0 | 21.0 | 26.8 | 90.0 | 0 | - | 7.9 | 6.26 | 181500 |
| Anarchist | 8.7 | 16.5 | 12.6 | 19.4 | 19.4 | 22.0 | 9.7 | 90.0 | 1 | - | 7.979 | 6.19 | 181500 |
| Scavenger *(new)* | 8.7 | 16.5 | 12.6 | 19.4 | 22.0 | 19.4 | 9.7 | 90.0 | 0 | - | 7.821 | 12.64 | 181500 |
| Looted *(new)* | 9.9 | 16.5 | 12.6 | 19.4 | 19.4 | 19.4 | 9.7 | 90.0 | 0 | +16.5% | 7.979 | 6.26 | 181500 |

### SEVA Suit (`suit_seva`)

| Suit | Bullet | Rupture | Impact | Thermal | Electrical | Chemical | Psychic | Radiation | Misc slots | Melee bonus | Weight | Carry | Price |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| Base | 22.0 | 30.0 | 23.5 | 55.0 | 55.0 | 55.0 | 45.0 | 98.0 | 2 | - | 10.4 | 22.88 | 1500000 |
| Authority | 20.7 | 34.5 | 22.1 | 51.7 | 51.7 | 51.7 | 42.3 | 98.0 | 2 | - | 10.608 | 23.34 | 1650000 |
| Mercenary | 25.3 | 29.1 | 27.0 | 60.5 | 53.4 | 53.4 | 43.7 | 98.0 | 2 | - | 10.608 | 23.11 | 1650000 |
| Ecologist | 20.7 | 28.2 | 24.7 | 60.5 | 60.5 | 60.5 | 42.3 | 98.0 | 2 | - | 6.24 | 20.59 | 1650000 |
| Fanatic (stays `UNAVAILABLE`) | 21.3 | 29.1 | 22.8 | 57.8 | 57.8 | 57.8 | 86.1 | 98.0 | 2 | - | 10.4 | 22.65 | 1650000 |
| Anarchist | 21.3 | 29.1 | 22.8 | 53.4 | 53.4 | 60.5 | 43.7 | 98.0 | 3 | - | 10.504 | 22.42 | 1650000 |
| Scavenger *(new)* | 21.3 | 29.1 | 22.8 | 53.4 | 60.5 | 53.4 | 43.7 | 98.0 | 2 | - | 10.296 | 45.76 | 1650000 |
| Looted *(new)* | 24.2 | 29.1 | 22.8 | 53.4 | 53.4 | 53.4 | 43.7 | 98.0 | 2 | +40.1% | 10.504 | 22.65 | 1650000 |

### Exoskeleton (`suit_exoskeleton`)

| Suit | Bullet | Rupture | Impact | Thermal | Electrical | Chemical | Psychic | Radiation | Misc slots | Melee bonus | Weight | Carry | Price |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| Base | 45.0 | 81.0 | 63.0 | 25.0 | 25.0 | 25.0 | 0.0 | 0.0 | 2 | - | 32 | 64 | 9999999999 |
| Authority | 42.3 | 90.0 | 59.2 | 23.5 | 23.5 | 23.5 | 0.0 | 0.0 | 2 | - | 33.5 | 64 | 9999999999 |
| Mercenary | 51.8 | 78.6 | 72.4 | 27.5 | 24.3 | 24.3 | 0.0 | 0.0 | 2 | - | 34.5 | 64 | 9999999999 |
| Ecologist | 42.3 | 76.1 | 66.2 | 27.5 | 27.5 | 27.5 | 0.0 | 0.0 | 2 | - | 32.6 | 64 | 9999999999 |
| Fanatic | 43.7 | 78.6 | 61.1 | 26.3 | 26.3 | 26.3 | 43.7 | 0.0 | 2 | - | 33 | 64 | 9999999999 |
| Anarchist | 43.7 | 78.6 | 61.1 | 24.3 | 24.3 | 27.5 | 0.0 | 0.0 | 3 | - | 32.5 | 64 | 9999999999 |
| Scavenger *(new)* | 43.7 | 78.6 | 61.1 | 24.3 | 27.5 | 24.3 | 0.0 | 0.0 | 2 | - | 31.68 | 128 | 9999999999 |
| Looted *(new)* | 49.5 | 78.6 | 61.1 | 24.3 | 24.3 | 24.3 | 0.0 | 0.0 | 2 | +44.0% | 32.32 | 64 | 9999999999 |

### Nosorog (`suit_nosorog`)

| Suit | Bullet | Rupture | Impact | Thermal | Electrical | Chemical | Psychic | Radiation | Misc slots | Melee bonus | Weight | Carry | Price |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| Base | 48.0 | 86.0 | 67.0 | 26.0 | 26.0 | 26.0 | 0.0 | 0.0 | 2 | - | 35 | 64 | 9999999999 |
| Authority *(new)* | 45.1 | 90.0 | 63.0 | 24.4 | 24.4 | 24.4 | 0.0 | 0.0 | 2 | - | 35.7 | 64 | 9999999999 |
| Mercenary *(new)* | 55.2 | 83.4 | 77.1 | 28.6 | 25.2 | 25.2 | 0.0 | 0.0 | 2 | - | 35.7 | 64 | 9999999999 |
| Ecologist *(new)* | 45.1 | 80.8 | 70.4 | 28.6 | 28.6 | 28.6 | 0.0 | 0.0 | 2 | - | 21 | 64 | 9999999999 |
| Fanatic *(new)* | 46.6 | 83.4 | 65.0 | 27.3 | 27.3 | 27.3 | 46.1 | 0.0 | 2 | - | 35 | 64 | 9999999999 |
| Anarchist *(new)* | 46.6 | 83.4 | 65.0 | 25.2 | 25.2 | 28.6 | 0.0 | 0.0 | 3 | - | 35.35 | 64 | 9999999999 |
| Scavenger *(new)* | 46.6 | 83.4 | 65.0 | 25.2 | 28.6 | 25.2 | 0.0 | 0.0 | 2 | - | 34.65 | 128 | 9999999999 |
| Looted *(new)* | 52.8 | 83.4 | 65.0 | 25.2 | 25.2 | 25.2 | 0.0 | 0.0 | 2 | +46.5% | 35.35 | 64 | 9999999999 |

### SSP-99 gem variants (`suit_ssp99`)

| Suit | Bullet | Rupture | Impact | Thermal | Electrical | Chemical | Psychic | Radiation | Misc slots | Weight | Carry | Price |
|---|---|---|---|---|---|---|---|---|---|---|---|---|
| Base | 1.0 | 1.0 | 1.0 | 70.0 | 70.0 | 70.0 | 50.0 | 99.0 | 1 | 2.9 | 2.61 | 143000 |
| Ruby *(new)* | 1.0 | 1.0 | 1.0 | 84.0 | 68.6 | 68.6 | 49.0 | 99.0 | 1 | 2.9 | 2.61 | 157300 |
| Sapphire *(new)* | 1.0 | 1.0 | 1.0 | 68.6 | 84.0 | 68.6 | 49.0 | 99.0 | 1 | 2.9 | 2.61 | 157300 |
| Emerald *(new)* | 1.0 | 1.0 | 1.0 | 68.6 | 68.6 | 84.0 | 49.0 | 99.0 | 1 | 2.9 | 2.61 | 157300 |
| Amethyst *(new)* | 1.0 | 1.0 | 1.0 | 68.6 | 68.6 | 68.6 | 60.0 | 99.0 | 1 | 2.9 | 2.61 | 157300 |
| Diamond *(new)* | 1.0 | 1.0 | 30.0 | 68.6 | 68.6 | 68.6 | 49.0 | 99.0 | 1 | 2.9 | 2.61 | 157300 |
| SSP-99M (bullet and rupture; only impact changes) | 10.0 | 20.0 | 15.0 | 70.0 | 70.0 | 70.0 | 50.0 | 99.0 | 1 | 3.9 | 11.7 | 868000 |
