# Item properties

Numerical gameplay readings belong in **PROPERTIES**, with protection readings listed directly
without a protection subheader. Missing or zero protection is omitted; adverse protection remains visible.
Converted readings appear immediately below PROPERTIES, followed by legacy item rows and weight. Quantity rows are omitted because quantities have different meanings
across item families. Ammunition descriptions retain their original box text, live round count and
ammo-specific background. Descriptions identify an object and provide background; they do not append
condition, quantity, ammunition capacity or restoration tables. Calibres, model names, ingredients and historical numbers
may remain in prose. Saved custom descriptions and task/location instructions remain intact.

## Ownership and API

The automatically loaded schema libraries `sh_itemproperties.lua` and `cl_itemproperties.lua` own
`ix.itemProperties`. Schema's `PopulateItemTooltip` hook supplies the common path used by inventory,
vendors, equipment and world entities. Weight and legacy protection/filter helpers delegate to it;
semantic row IDs prevent duplicates regardless of plugin dispatch order. Existing quantity/condition
bars, the imperial weight preference and equipment summary controls remain available. Weight retains
the legacy gram/kilogram and ounce/pound formatter and bottom-row position. Carry capacity retains
its legacy label and formatter and remains hidden on world items. Distances and jump velocity retain
their raw Source-unit values, without conversion to metres.

- `Convert(kind, value)` returns the numeric display value and unit. It rejects unknown kinds and
  nonfinite values. Negative values remain negative; conversions do not clamp gameplay values.
- `Format(kind, value, signed)` rounds percentages except medicinal healing to whole numbers, formats other readings with at
  most two decimals, groups thousands and optionally prefixes positive values with `+`. A nonzero
  reading small enough to round to zero displays zero. Cleanliness appears before durability.
- `GetRows(item)`, `GetProtection(item)`, `GetFilterRows(item)` and `GetEffects(item)` return ordered
  `{id, text}` rows without constructing panels or invoking gameplay callbacks.
- `AddRow(tooltip, id, text, iconKey, variant)`, `PopulateProtection(tooltip, item)` and
  `Populate(tooltip, item)` render converted rows. Readings with an entry in the client `ICONS` table
  (keyed by row ID, or by a row's optional `icon` key) use a tinted greyscale icon from
  `vgui/ui/stalker/*_grey` through `PropertyDesc2`; other readings keep the `PropertyDesc` bullet.
  Their optional fourth argument supplies a semantic row ID; repeated rows update the existing row and children.
  Effect rows carry an `icon` key for their buff. The cyclic-rate row carries a `variant` from
  `GetFireModeGroup(weapon)`, the fastest CW 2.0 fire mode group (auto, burst, semi, pump, break, bolt),
  which selects the firerate icon's tint.
  Property labels use explicit Helix word wrapping and size each row from the measured lines,
  including resetting its height when text becomes shorter. Full population runs once per tooltip. World-item tooltips keep legacy weight and existing item
  modifiers, without evaluating or adding converted nutrition, hydration, effects or protection rows.
- Concrete items can implement `GetPropertyEffects()` for implemented timed effects, returning
  `{buff, duration, amount}` or `{buff, duration, multiplier}` entries. These expressions reference
  item tuning, not copied computed totals. Include an entry only for an effect that actually exists.
- Unique effects use `GetIndividualProperties()`, returning `{id, text}` rows. Conditional providers
  must read current instance state: for example, clean flask water must not advertise dirty-water
  effects. Neither provider should mutate item/player state.

Family readers use saved quantities and rolled meat weight, effective suit/headgear protection,
filter/tank state and installed attachment getters. Equipped firearms use their current SWEP when
available; other previews use registered SWEP definitions. Magazine size and cyclic rate come from
that weapon rather than historical figures in prose. Firearms list all compatible ammunition by item name, including variants offered by their SWEP
ammo attachments. Ammo items omit the cartridge row and expand special variant labels such as
HP to Hollow Point. Long ammunition lists wrap within the tooltip width. Firearms on `base_newweapons` then list installed
attachments (when any) and compatible attachments by `ix.weapontables` name, before cleanliness. Melee weapons have no cartridge, magazine capacity or cyclic-rate rows. Unsupported or missing SWEP definitions
do not produce invented capacities.

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
| Medicinal health restoration | HP per tick / viewer maximum HP × 100 | % of maximum health per tick |
| Completion healing | unchanged | HP |
| Instant radiation removal/exposure | radiation points / 100 × 30000 | mSv |
| Medicinal radiation removal/exposure | radiation points per second / 100 × 30000 | mSv/s |
| Bandage clotting | severity points per second / 100 × 150000 | mL/min |
| Stamina restoration | stamina points per second / 100 × 100000 | µg/s |
| Psychic recovery/damage | psychic points per second | %/s |
| World distance / jump velocity | unchanged | Source units / units per second |
| Weight, carry capacity | legacy weight formatter | g/kg or oz/lbs |
| Duration | unchanged | s |

Hydration equivalents are a COTZ extension and do not describe bottle volume. Medicinal healing
percentages use the viewing player's current maximum health, retaining up to two decimal places.
Without a valid client viewer, readings use 100 maximum HP. Healing rows show restoration per actual
tick (0.5 seconds for rapid healing or one second for slow healing), followed by the overall duration.
For example, a 2 HP tick at 200 maximum HP reads `+1% per 1 second over 300 seconds`. Other buff
readers account for their actual callback interval. Durations describe the effect after application, separately from application time.

Protection readings show each effective resistance fraction as a whole-number percentage, without
cosmetic unit conversion, followed by flat absorption rounded to one decimal (for example
`Ballistics: 40% + 8`). Radiation has no flat absorption reading. The value is coloured on the legacy
scale from red (0%) to blue (100%), with full saturation outside that range. Psychic shielding from
`buff_psyblock` is flat absorption and shows its raw amount. Attachment rows show flat absorption only
when the attachment defines it. Zero protection rows are omitted; adverse protection remains visible.

Examples: Bread restores 9 hunger and reads **+90 kcal** per portion. Old antirad removes a nominal
50 radiation points in 120 seconds and reads **−125 mSv/s for 120 s**. Gauze supplies 20 additional
severity reduction over six seconds and reads **5,000 mL/min**, plus **6 HP** on application completion.

## Verification

Run `luatex --luaonly tests/item_properties_spec.lua` from the repository root. It covers conversions,
actual item definitions, source/provider agreement, quantity omission, legacy weight/distance displays,
meat weight, weapon state, rounded condition ordering, melee cartridge omission, condition-sensitive
protection, semantic bullet-row deduplication and exclusion of converted rows from world tooltips.
Also run the bleeding, buffs persistence, anomaly resistance, gasmask filter, item description,
headgear durability, suit attachment, mobile action and equipment view specs.

Standalone mocks do not prove Garry's Mod rendering or multiplayer timing. Check inventory, vendors,
equipment and world items at narrow, 1080p, ultrawide and 4K resolutions. Verify partial/empty filters,
low-condition armour, attachment changes, saved quantities, two-client treatment and cancellation,
reconnects, character changes, death and actual cross-server transfer. No world initialization or
persistent data reset is required.
