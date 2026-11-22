# CW attachment placement

The placement tool transfers hand-placed first-person attachment setups between CW weapons. Place one
attachment on the target, and the tool derives the others from donors that share that attachment,
fits their aim offsets, and saves the result as JSON. An offline script then writes that JSON into the
weapon and item definitions.

| File | Role |
| --- | --- |
| `lua/autorun/client/cotz_attachment_placement.lua` | In-game editor and batch command (client, listen host or singleplayer). |
| `lua/cotz/attachment_policy.lua` | Which sights each weapon family may receive, mounts, and the ranked donor list. |
| `docs/attachments/apply_placements.py` | Applies the saved exports to `lua/weapons/<class>/shared.lua` and the item files. |

## Rollout policy

The policy file decides which sights the tool may add. Weapons default to a family by
`ITEM.weaponCategory` (primary: rifle, secondary: pistol), with per-class overrides.

- **Rifles** take every sight.
- **Pistols** take rail red dots only: Micro T-1, EoTech, Aimpoint, C-More, Reflex, and RMR.
- **Revolvers** take the pistol red dots and the Schmidt ShortDot.
- **Shotguns** take sights only when `mounts` lists a rail or dovetail on the viewmodel itself.
  Rail adapter models do not count. The TOZ-34 and its sawn-off use the hand-placed barrel mounts.
- **WW2 and period weapons** take suppressors only.
- New PSO-1 entries need a dovetail: `mounts[class] = "dovetail"` or `SWEP.HasDovetailMount = true`.
  Keep the existing PSO-1 setups on the Mosin, SVT-40, and Obrez Malfunction.

The tool never removes existing entries. It adds only sights, so suppressors stay limited to the
calibre-specific ones each weapon already lists; other attachments are only repositioned.

## Batch generation

Run `cotz_attachment_batch all`, or name classes such as `cotz_attachment_batch cw_9a91 cw_gepardpdw`.
No weapon needs to be equipped. For each weapon, the batch picks the first placed sight that a policy
donor also places in its sight slot, keeps every existing placement, and adds the allowed sights from the
ranked donors. It saves `garrysmod/data/cotz_attachment_placement/<class>.json` and prints one line per
weapon. Weapons without a shared placed sight need seed mode in the editor.

## Editor

Equip the target and run `cotz_attachment_placement [donor ...]`. Without arguments it uses the
policy donors; pass the weapon's own class to move only its existing models as a group.

1. Choose an anchor. Existing placements move the target's models as a group. A **Seed** entry starts
   a new anchor from a donor's placement for weapons with no usable sight. Pick the seed's bone and
   scale; a seed creates the sight slot when the weapon has none.
2. Adjust the anchor position and angle. The X, Y, and Z values are forward, right, and up relative to
   the anchor bone. Each new model keeps its donor's pose relative to the anchor, scaled with it.
   Existing models keep their own offsets unless **Re-seat existing models from donors** is checked.
3. Cycle the preview list to check each model's fit.
4. Click **Save placements** and apply the export.

## Aim offsets

Saving fits the aim offset of every new or moved sight against the target's idle animation and keeps
the authored aim angle. The Schmidt ShortDot, ACOG, and Nightforce NXS use their measured rear lens
centers. Every other sight recovers its line of sight from the donor's hand-tuned aim, so new red
dots and PSO-1s align the same way they do on the donor. Without an authored aim, the eye relief follows
the donor's aim relative to its ironsights. New scopes also receive zeroed alignment tables
(`PSO1AxisAlign` and similar) when the weapon lacks them.

New sights that cannot be fitted are left out of the export and reported as skipped: aiming without an
offset would break. This happens when a sight faces away from the sightline, or the donor has no aim for
it. Mirrored viewmodels and third-person models need manual setup.

The scope render camera follows the player's pitch and yaw. Keep model and mount orientation in the
attachment placement, and use the scope camera alignment fields for sight calibration and lens roll.

## Applying exports

From the repository root:

```sh
python3 docs/attachments/apply_placements.py --dry-run
python3 docs/attachments/apply_placements.py
```

Without paths it applies every export in `garrysmod/data/cotz_attachment_placement/`. The script updates
existing model positions and angles, adds new `SWEP.AttachmentModelsVM` entries in the file's style,
sets aim and alignment fields (new ones go after `SWEP.IronsightAng`), and adds the IDs to the sight slot,
creating it when needed. In each item with that class, it adds the IDs to `ITEM.validAttachments` and
turns `ITEM.canAttach` on. Applying an export again changes nothing. Review the diff, then check the fit
and sight picture of each new sight in game.

Rail optics on a dovetail weapon without a rail receive an `md_rail` entry using
`models/wystan/attachments/akrailmount.mdl` and `SWEP.SightWithRail = true`. Use the model's existing
rail or rail bodygroup where present.

Run `tests/run.sh attachment_placement attachment_apply` after changing the tool or the script.
