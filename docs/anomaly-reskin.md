# Anomaly model reskins

COTZ weapons with a counterpart in the Anomaly CW2.0 conversion (in `cotz_general` and
`cotz_wepmats`) use its view model, world model, sounds and item icon while keeping their COTZ class,
item IDs, balance, ammunition and attachment slots. Saved weapons and loot tables are unaffected.
The conversion content must be installed.

## Weapon reskin

`docs/anomaly/reskin_weapons.py` holds the class map and converts each mapped weapon:

- It removes fields tied to the old viewmodel: models, ironsights, sight aim positions and alignment tables,
  bodygroup tables and calls, shell and muzzle tuning, bolt bones, attachment models, hand bone offsets
  and the old firing-animation functions.
- It appends the presentation from `cw_anomaly_<id>`: models, field of view, ironsights, sprint pose,
  animations and their sounds, fire sounds, reload speed and timings, muzzle and shell settings, world
  model offsets and selection icon. It then adds the `_vmrecoil` variant's settings: Lua viewmodel recoil, bolt or slide
  bone offsets and, where the variant has one, an empty `fireAnimFunc`. Manually operated actions keep
  their firing animation.
- The world model pitch is raised from the pack's -5 to -10 (-7 for pistol hold types) in `SWEP.WMAng`.
  At -5 the third-person gun aimed below the player's aim, so it clipped the support hand and the stock the face.
- Reloads play at the Anomaly speed (`ReloadSpeed = 1`), so the reload sounds stay in sync with the
  animation. Reload durations therefore follow the Anomaly animations rather than the old COTZ values.
- Items with that class take the Anomaly world model, including in the back-slot PAC part. Regeneration
  reuses an existing `iconCam` tuned for that world model.
- The M16A4, P90, LR-300, HK416, and Remington 870 use the pack's separate stock sight
  model. CW draws it on the viewmodel whenever the weapon uses its iron-sight aim pose,
  and installing an optic hides it until the weapon returns to irons.

### Integrated scopes

The AUG, F2000, M98B, SV-98, and TRG-42 reskins copy their reticle and magnification from their source
SWEP. Those reskins and native Anomaly guns that have a `lense_rt` viewmodel material use CW's square
render target. A client-side override on the lens replaces the TFA material proxy. Complex mode draws
the magnified scene and reticle in the lens. The simple telescopics option keeps the full-screen scope
overlay. Weapons with their own CW scope renderer, such as the VSSK, keep that renderer.

```sh
python3 docs/anomaly/reskin_weapons.py --dry-run
python3 docs/anomaly/reskin_weapons.py --base HEAD   # regenerate from committed sources
```

61 weapons are mapped. Not converted:

- The 9A-91 and VSSK already used Anomaly models; the 9A-91 item took the debug iconCam.
- The L85 and L115 use render-target integrated scopes on the old models, the Mosin has a scope render
  target and muzzle override, and the TOZ-194 draws its world model itself. These need manual work.
- Guns without an Anomaly counterpart keep their models, for example the G2 Contender.

## Attachments

Every Anomaly viewmodel has the same `wpn_body` bone orientation. `docs/anomaly/attachment_spec.py` writes
a spec (and exports the pre-reskin weapons from git as donors) for the offline placement runner, which
places one anchor sight per gun and lets the placement tool add the others from hand-placed donors,
fitting every aim offline:

```sh
python3 docs/anomaly/attachment_spec.py outputs/anomaly-attachments
luatex --luaonly docs/attachments/offline_placement.lua anomaly outputs/anomaly-attachments/exports outputs/anomaly-attachments/anomaly_spec.lua
luatex --luaonly docs/attachments/offline_placement.lua suppressors outputs/anomaly-attachments/sup outputs/anomaly-attachments/anomaly_spec.lua
python3 docs/attachments/apply_placements.py outputs/anomaly-attachments/exports/*.json outputs/anomaly-attachments/sup/*.json
```

- **Rail guns** (pack sights include an EOTech) get an EOTech seated where the pack hand-placed its own
  EOTech model: the two meshes share a center and the COTZ sight is sized to the pack model's extents.
  The resulting sight lines match the pack's tuned EOTech aims to within about 0.05 units sideways and
  0.1–0.3 vertically. Kobras are left off rail guns.
- **Dovetail guns** (pack sights include a Kobra) take the 9A-91's hand-placed Kobra, moved by the
  difference between the pack's Kobra sight lines and the guns' `wpn_scope` mounts. They get
  `SWEP.HasDovetailMount` and the AK rail adapter for rail optics.
- **Pistols, the PKM, RPK, Skorpion and the TOZ-34s** keep the old gun's hand-tuned red dot height above
  the ironsights. The sight's mesh center sits a tenth of the way from `wpn_body` to the muzzle (the RPK
  uses the 9A-91's offset from `wpn_scope`). Eye distances are not reused: they do not carry over between
  viewmodel fields of view, which left sights floating behind the guns.
- Guns whose pack offers no sights get none: integrated optics (AUG, F2000, G36K, TRG-42, SV-98, M98B)
  and models without a mount. Period weapons and unmounted shotguns follow the
  [placement policy](attachment-placement.md#rollout-policy).
- Suppressors move to the Anomaly muzzle attachment, using the median mount point of each suppressor model
  over the old hand placements. Foregrips were removed: nothing on the new models fixes their position.

Each new sight stands upright and faces the view. Mounts come next:

- The G3A3 and MP5 get the pack's own claw mounts (`wpn_g3_mount.mdl`, `wpn_mp5_mount_hud.mdl`) as
  `md_rail`, placed exactly where the pack bonemerges them (the inverse of the skinned bone's pose in the
  mount model). The pack's tuned sight lines on those guns assume the mount.
- Pistols get `models/cw2/attachments/pistolrail.mdl` (size 0.17) centred under the sights. Its lower clamp
  hangs under the frame, so only its top rail (above model height 10) counts when it is seated on the slide.
- Dovetail guns keep the AK rail adapter from the 9A-91.

Every sight is then seated by contact (`mdl_pose.py --contact`): rays under the sight find its own lowest
surface and the highest surface of the gun and any placed mount at the same points, and the sight moves
down or up until the two touch. Rays stay within 0.2 units of the sight's centre line, where a clamp's
channel meets the rail top, because clamp jaws hook under a rail's lips at the sides. The contact point is
the 15th percentile of the per-ray gaps, so a recoil lug in a rail slot or an iron sight post under a long
scope does not hold a sight up. The 9A-91's hand-placed side-mount Kobra and PSO-1 are not moved on
dovetail guns, and the Kobra is left off guns without a dovetail.

Each sight line must then pass at least 0.4 units over the gun between the sight and the muzzle. Where it
does not (the M16A4, SG552, UMP45 and both TOZ-34s), a spacer goes under the sights: the Picatinny segment
`models/wystan/attachments/rail.mdl`, fitted to the missing height and up to six units of the sights'
combined footprint, seated on the gun as `md_rail`. No dedicated riser model exists locally or in the subscribed workshop
items; swap `SPACER_MODEL` in `offline_placement.lua` to use one. Aims are refitted after every move.
Pistol sights and rails finally move onto the slide bone that the vm-recoil variant animates.

Mesh data comes from `mdl_pose.py`, posed by each model's first sequence: some attachment models (the
ShortDot, RMR and the pack's EOTech) rotate their root bone there. `offline_placement.lua seats CLASS...`
prints each sight's clearance and `posts CLASS...` each sight line's clearance over the gun, for the files
as they stand.

The applier replaces the sight
list with the placed sights and removes dropped sights and foregrips from the weapon slots and
`ITEM.validAttachments`. `offline_placement.lua inspect SPEC CLASS...` prints each model's mesh center
next to the gun's `wpn_body`, `wpn_scope` and muzzle for a quick check.

The c_hands conversions in `cotz_general` (formerly the `cotz_weapon_chands` addon) replace listed
viewmodels with c_hands conversions of the old models; it skips guns whose viewmodel is under
`models/flaymi/anomaly/` so the reskins keep their Anomaly models.

## Verification

Standalone checks: `tests/run.sh anomaly_reskin attachment_apply attachment_placement`. Offline aim fits
reproduce the hand-tuned ACOG aims on the old guns to within about 0.005 units. In game, check each
reskinned gun's sight pictures, how attachments sit on the model, reload speed, the back-slot PAC
position and the inventory icon.
