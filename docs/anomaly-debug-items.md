# Anomaly CW2.0 inventory weapons

The 82 regular `anomaly_<id>` inventory items cover the installed Anomaly pack's firearms and launcher
variants without a regular CotZ counterpart. They equip the pack's VM-recoil SWEPs and use its world
models and inventory cameras. The pack's SWEPs, including their bases, live in `lua/weapons/cw_anomaly_*`.
Install the Anomaly CW2.0 content in `cotz_general` and `cotz_wepmats` alongside CotZ to supply the
models, sounds, materials, attachment and projectile entities, and sound registrations. The items are
available through administrator item spawning and have no business, loot, vendor, reward or progression
entries.

## Balance

Each firearm is balanced against its closest CotZ counterpart by calibre and role, for example the
USAS-12 against the Saiga-12 and the PB against the Makarov:

- Wear follows the counterpart's action type: magazine-fed semi-automatic and automatic guns use
  `WearDamage = 0.05`, `DurabilityDamageChance = 0.005` and `WearEffect = 0.007`; manual actions use
  0.33, 0.01 and 0.005; handguns use 0.14, 0.01 and 0.05. `FireMoveMod`, `SpeedDec` and hold types also
  follow the counterpart.
- Spread, recoil and movement penalties match the counterpart. Damage, magazine size, fire modes and
  automatic fire rates keep the pack's distinctions, such as the USAS-12's 20-round automatic drum.
  Semi-automatic handguns and marksman rifles use their counterpart's fire delay; bolt and pump actions
  keep the delay of their firing animation.
- Prices start from the counterpart's price, with a small premium for a larger magazine, integral
  suppressor or optic, or a custom variant. `bulletweight` equals the per-round weight of the calibre's
  standard ammunition item.
- The Gauss rifle, RPG-7, M79 and RG-6 have no counterpart; only their wear follows the policy above.

Anomaly firearms use the same inventory attachments as other CW 2.0 firearms. The shared attachment
profiles select optics by family and mount and allow at most one compatible detachable suppressor.
Pistols use red dots, and revolvers can also take the Schmidt ShortDot. Fixed optics remain part of
their weapons. Pack-only customization entries are excluded from the regular Anomaly SWEP slots.
Install and detach hardware through the inventory. Saved attachments that are no longer compatible
can be removed with **Detach**.

The Kar98k, G43, RPG-7 and Gauss rifle have no equivalent CotZ pack ammunition. The M79 and RG-6 have
no CotZ inventory ammunition supply.

The 307 debug inventory definitions were removed. Helix skips saved instances whose item definitions
are missing. Existing debug rows in a database can be recovered by restoring their definitions before
loading an affected inventory. The regular `anomaly_<id>` and existing CotZ weapon IDs are still registered.

Run `tests/run.sh anomaly_inventory weapon_world_attachments anomaly_reskin` for the catalogue,
installation and reskin checks.
