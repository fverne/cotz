# Item properties

Numerical gameplay readings belong in **PROPERTIES**, including the **Protection levels** group.
Descriptions identify an object and provide background; they do not append condition, quantity,
ammunition capacity or restoration tables. Calibres, model names, ingredients and historical numbers
may remain in prose. Saved custom descriptions and task/location instructions remain intact.

## Ownership and API

The automatically loaded schema libraries `sh_itemproperties.lua` and `cl_itemproperties.lua` own
`ix.itemProperties`. Schema's `PopulateItemTooltip` hook supplies the common path used by inventory,
vendors, equipment and world entities. Weight and legacy protection/filter helpers delegate to it;
semantic row IDs prevent duplicates regardless of plugin dispatch order. Existing quantity/condition
bars, the imperial weight preference and equipment summary controls remain available.

- `Convert(kind, value)` returns the numeric display value and unit. It rejects unknown kinds and
  nonfinite values. Negative values remain negative; conversions do not clamp gameplay values.
- `Format(kind, value, signed)` formats at most two decimals, groups thousands and optionally prefixes
  positive values with `+`. A nonzero reading small enough to round to zero displays zero.
- `GetRows(item)`, `GetProtection(item)`, `GetFilterRows(item)` and `GetEffects(item)` return ordered
  `{id, text}` rows without constructing panels or invoking gameplay callbacks.
- `AddRow(tooltip, id, text)`, `PopulateProtection(tooltip, item)` and `Populate(tooltip, item)` render
  the rows. Repeated semantic rows update the existing row; full population runs once per tooltip.
- Concrete items can implement `GetPropertyEffects()` for implemented timed effects, returning
  `{buff, duration, amount}` or `{buff, duration, multiplier}` entries. These expressions reference
  item tuning, not copied computed totals. Include an entry only for an effect that actually exists.
- Unique effects use `GetIndividualProperties()`, returning `{id, text}` rows. Conditional providers
  must read current instance state: for example, clean flask water must not advertise dirty-water
  effects. Neither provider should mutate item/player state.

Family readers use saved quantities and rolled meat weight, effective suit/headgear protection,
filter/tank state and installed attachment getters. Equipped firearms use their current SWEP when
available; other previews use registered SWEP definitions. Magazine size and cyclic rate come from
that weapon rather than historical figures in prose. The common ammunition reader preserves calibre
and loading identifiers. Unsupported or missing SWEP definitions do not produce invented capacities.

## Cosmetic conversions

These are game presentation scales, not physical simulation. **100 COTZ survival, health or radiation
points represent one normalized source unit**. The numeric tables are informed by the Anomaly
[Nitpicker StatsDisplay source](https://github.com/Ishmaeel/NitpickerModpack/blob/main/StatsDisplay/gamedata/scripts/ish_item_stats.script)
by Ishmaeel, last modified in that file on 2021-10-21. Its food, medicinal radiation, clotting and power
magnitudes are 1000, 30000, 150000 and 100000 respectively. Source data/units are adapted here;
no external script is loaded or copied into the game.

| Reading | Conversion from COTZ | Display unit |
| --- | --- | --- |
| Nutrition | hunger / 100 × 1000 | kcal per use |
| Hydration | thirst / 100 × 1000 | mL equivalent per use |
| Medicinal health restoration | HP per second / 100 × 1000 | nominal % strength |
| Completion healing | unchanged | HP |
| Instant radiation removal/exposure | radiation points / 100 × 30000 | mSv |
| Medicinal radiation removal/exposure | radiation points per second / 100 × 30000 | mSv/s |
| Bandage clotting | severity points per second / 100 × 150000 | mL/min |
| Stamina restoration | stamina points per second / 100 × 100000 | µg/s |
| Psychic recovery/damage | psychic points per second | %/s |
| World distance / jump velocity | Source units × 0.0254 | m / m/s |
| Weight, duration, quantities | unchanged | kg, s, counts |

Hydration equivalents are a COTZ extension and do not describe bottle volume. The medicinal health
percentage is the reference-style strength index, not a promise to heal that percentage of a
character's maximum health. Buff readers account for the actual 0.5-second or one-second callback
interval. Durations describe the effect after application, separately from application time.

Protection uses an Anomaly-style cosmetic calibration of each effective resistance fraction:
thermal ×300 kW/m², electrical ×480 V, chemical ×100%, ballistic/rupture/gravitational ×2500 J,
psychic ×300 mT and radiation ×3000 mSv. These are explicit COTZ adaptations; the referenced
StatsDisplay version itself displays outfit protection as percentages. Flat absorption is converted
separately, first normalizing its points by 100. A resistance reading is not combined with absorption
into a single protection percentage or threshold. Zero and adverse protection remain visible.

Examples: Bread restores 9 hunger and reads **+90 kcal** per portion. Old antirad removes a nominal
50 radiation points in 120 seconds and reads **−125 mSv/s for 120 s**. Gauze supplies 20 additional
severity reduction over six seconds and reads **5,000 mL/min**, plus **6 HP** on application completion.

## Verification

Run `luatex --luaonly tests/item_properties_spec.lua` from the repository root. It covers conversions,
actual item definitions, source/provider agreement, saved quantities, meat weight, weapon state,
condition-sensitive protection and semantic-row deduplication in all four tooltip contexts.
Also run the bleeding, buffs persistence, anomaly resistance, gasmask filter, item description,
headgear durability, suit attachment, mobile action and equipment view specs.

Standalone mocks do not prove Garry's Mod rendering or multiplayer timing. Check inventory, vendors,
equipment and world items at narrow, 1080p, ultrawide and 4K resolutions. Verify partial/empty filters,
low-condition armour, attachment changes, saved quantities, two-client treatment and cancellation,
reconnects, character changes, death and actual cross-server transfer. No world initialization or
persistent data reset is required.
