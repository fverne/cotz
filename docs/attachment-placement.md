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
| `docs/attachments/offline_placement.lua` | Runs the tool's transfer and aim fits without the game (run with `luatex --luaonly`). |
| `docs/attachments/mdl_pose.py` | Samples bone and attachment matrices from `.mdl` animations for the offline runner. |

## Rollout policy

Regular Helix CW firearms use the sight rules below and have at most one detachable suppressor
per class. `lua/cotz/weapon_attachment_profiles.lua` applies the rules to inventory and SWEP slots
and records existing sight exceptions. CW keeps authored mounts and sight aims and fills the remaining placements from
`lua/cotz/weapon_attachment_poses.lua`. Those fallback positions sample each viewmodel's idle pose
and use the receiver surface and the sight's optical axis as placement references. Check the
fallback entries after changing viewmodels.

`python3 docs/attachments/weapon_fit.py fallback all` audits those entries against the idle pose of each
viewmodel, using the bodygroups the weapon sets in `IndividualInitialize` or `IndividualThink`. The original
table placed every sight on a gun at one shared distance from the eye, so on short viewmodels (pistols, revolvers
and compact SMGs) the sights hung behind the frame. The audit moves a sight with less than half of its mount over
the gun forward or back along its line of sight to the nearest flat stretch of the gun's top, seats it, and
lowers or raises its aim by the same height. Aim depth is unchanged, since the fallback aims keep the gun's
ironsight-relative ADS position. It also moves suppressors that stand in front of the visible barrel back onto it.
Some models put their muzzle attachment past the barrel, and the M29 and Obrez show a shorter barrel than
that point. Add `--write` to update the table. Arm and hand bones are excluded by name. Side-mounted optics and
long scopes that only overhang the end of a receiver are left alone.

Weapons default to a family by
`ITEM.weaponCategory` (primary: rifle, secondary: pistol), with per-class overrides.

- **Rifles** take every sight.
- **Pistols** take rail red dots only: Micro T-1, EoTech, Aimpoint, C-More, Reflex, and RMR.
- **Revolvers** take the pistol red dots and the Schmidt ShortDot.
- **Shotguns** take sights only when `mounts` lists a rail or dovetail on the viewmodel itself.
  Rail adapter models do not count. The Anomaly Remington 870 and Saiga-12 qualify; the TOZ-34 and its
  sawn-off keep sights over the barrel.
- **WW2 and period weapons** take suppressors only.
- New PSO-1 entries need a dovetail: `mounts[class] = "dovetail"` or `SWEP.HasDovetailMount = true`.
  Keep the existing PSO-1 setups on the Mosin, SVT-40, and Obrez Malfunction.

In the regular CotZ catalogue, the 1P29 fits listed dovetail mounts and the PU fits the Mosin,
SVT-40 and SKS. The staged Anomaly weapons use shared CW hardware. Fixed optics stay with their guns.

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
the authored aim angle. If the idle sequence the SWEP names is missing from its model, sampling uses the
first sequence, as the engine does. The Micro T-1 uses the measured center of its rear aperture.
The Schmidt ShortDot, ACOG, and Nightforce NXS use measured lens axes. Other sights recover their line
of sight from the donor's hand-tuned aim. Without an authored aim, the eye relief follows
the donor's aim relative to its ironsights. New scopes also receive zeroed alignment tables
(`PSO1AxisAlign` and similar) when the weapon lacks them.

New sights that cannot be fitted are left out of the export and reported as skipped: aiming without an
offset would break. This happens when a sight faces away from the sightline, or the donor has no aim for
it. The placement editor cannot fit mirrored viewmodels.

Red dots in standard ADS draw along the render camera's center ray. As ADS settles, CW also shifts the
whole viewmodel sideways and vertically so the mounted optic's aperture sits on that ray. The
correction uses the live mount, including static pistol slide mounts, and keeps the current eye relief.
Free Aim and backup sights retain their own aim behavior. The CW scope cameras start from the scene view, and their dot or chevron is centered
in the square render target and the simple scope overlay. Reticle texture offsets account for artwork
whose aiming point is a few texels away from the texture center. Keep model and mount orientation in
the placement and use the scope camera alignment fields for calibration and lens roll.
Mounted CW optics bind their render target to the attachment model's lens, so a weapon's built-in
lens material can use its own binding. Magnification comes from each optic's CW definition.

## Third-person display

CW copies installed attachment models and their offsets from the first-person idle pose, using the
muzzle points to align them with the worldmodel. Where both models have a `wpn_body` bone, the distance
from that bone to the muzzle estimates the difference in scale. Rail adapters follow the installed
sight. The server replicates the installed attachment list so other players can see changes and
clients entering visibility can draw the current setup. Placement is approximate, especially on
legacy model pairs with differently oriented muzzle points.

The `wpn_body` estimate is only as good as that bone's position in both models. Where the viewmodel's
`wpn_body` is not at the same place of the gun (the AEK-971, AK-12 and AKS-74U estimated about 0.55 against a
true 0.84 to 0.90), a weapon can name its own fit:

- `SWEP.WorldAttachmentScale` replaces the estimate.
- `SWEP.WorldAttachmentShift` (Vector, in the worldmodel muzzle frame, after scaling) moves the fitted
  viewmodel along the worldmodel's axes, for muzzle attachments that sit away from the barrel tip.
- `SWEP.WorldAttachmentAngle` turns the viewmodel muzzle frame onto the worldmodel's when the two face opposite
  ways (the CZ-52 and AN-94 pairs, whose sights otherwise landed beyond the muzzle).

`python3 docs/attachments/weapon_fit.py world CLASS... [--write]` measures them. The Anomaly pairs are one mesh
at a uniform scale, so it compares the gun-only vertices of both models in their muzzle frames and accepts a
fit only when the length and width ratios agree (the AN-94 pair is accepted on its turn alone, because its
worldmodel carries extra width). It writes the fields after `SWEP.MuzzleAttachmentName` only where the fit moves a
sight by at least a unit.

`python3 docs/attachments/weapon_fit.py legacy-world all` audits legacy pairs. It measures visible
gun geometry with the active c_hands viewmodel and authored startup bodygroups where applicable.
It checks the scale against a second dimension or compares compatible muzzle tips when the models
have different stock or handguard lengths. For legacy muzzle attachments with a rotated frame,
it aligns the barrel and the top of the gun before computing the shift and angle. For models with
no muzzle attachment and a distinguishable barrel tip, it uses the configured `WorldAttachmentBone`
to follow the worldmodel. Add `--write` to update the accepted fields. Skipped models use the
shared estimate and may need manual measurements. Check the resulting positions and size in multiplayer.

## Attachment bones

Attachment models follow the bone they name, so the bone must travel with the receiver. Some Anomaly
viewmodels animate `body` while `wpn_body` stays at the origin; sights on such a `wpn_body` hang in place
during recoil, reloads and draws. `python3 docs/attachments/weapon_fit.py bones CLASS... | all` reports each
attachment bone's drift from the receiver. `weapon_fit.py rebone CLASS --to BONE --from BONE [--write]` moves the
models onto another bone and recomputes `pos` and `angle`, so each keeps its exact idle pose and the aim fits stay
valid. The AEK-971, AK-12, AKS-74U and AK-74 sit on `body`; the TOZ-34 sights follow the `bend_reload` barrels.
The LAX, MP-18 and TOZ-106 still name bones that their current models lack, so their attachment models never draw.

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

Exports can also replace a slot's list (`slot.replace`) and remove IDs from every slot and from the
items (`removeAttachments`); the Anomaly reskin uses both.

## Offline runner

`docs/attachments/offline_placement.lua` loads weapon files with stubs, translating GMod-only syntax, and
samples viewmodel animations through `mdl_pose.py`, which reads models from the sibling addons. It runs
the same placement and fitting code as the editor:

```sh
luatex --luaonly docs/attachments/offline_placement.lua validate cw_ak74 cw_dragunov
luatex --luaonly docs/attachments/offline_placement.lua axes md_schmidt_shortdot cw_ak74 cw_sks
luatex --luaonly docs/attachments/offline_placement.lua anomaly OUT_DIR SPEC.lua
luatex --luaonly docs/attachments/offline_placement.lua suppressors OUT_DIR SPEC.lua
luatex --luaonly docs/attachments/offline_placement.lua sizes /tmp/attachment-sizes.jsonl
```

`validate` compares fits with authored aims, `axes` prints each gun's line of sight in a sight's model
space, and `anomaly` and `suppressors` produce exports for the [Anomaly reskins](anomaly-reskin.md).

`sizes` audits the generated reskin placements and the profile fallback table against installed model
meshes. Its report includes each before-and-after extent, receiver width where measurable, proposed
model transforms and aim, contact clearance, and aperture deviation across sampled idle frames. Pistol rails use the
slide's measured width, riser length is limited to the mounting footprint, and each optic and
suppressor family has a reference size in game units. A resize preserves the seating height or
muzzle pivot. The runner reseats nearby rail sights by mesh contact and refits ADS against the aperture. Unmeasured apertures still use the reference aim
line. The audit uses the stored unreflected frame on mirrored viewmodels. Idle motion and client
rendering still affect how the in-game lens appears.

Run `tests/run.sh attachment_placement attachment_apply weapon_reticle scope_camera weapon_world_attachments weapon_fit`
after changing the placement, reticle, world attachment or fitting code.
