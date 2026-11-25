# Suit playermodels

Characters and worn suits use the Sector Four playermodels under `models/cotz/sectorfour/`, shipped in
the `cotz_playermodels` content addon (Workshop item `2290872628`). Each model is a single compiled
outfit with the shared ShtokerBox head and balaclava. The legacy `stalkerisaac` and `nasca` paths stay
registered in `schema/sh_schema.lua` for NPCs, props and characters that have not loaded since the change.

## Suit families

Each concrete suit declares its model (`ITEM.newModel`), factory finish (`ITEM.newSkin`), the finishes
Technut may apply (`ITEM.skincustom`) and any fixed bodygroups (`ITEM.bodyGroups`, by name).
Every suit offers every skin of its model, except where two families share a model.

| Suits | Model | Finishes | Fixed bodygroups |
|---|---|---|---|
| Anorak, Mail Jacket | `male_anorak` | 0–60 | Hood action (`Neck` 0/1) |
| Trenchcoats | `male_trenchcoat` | 0–8 | Hood action (`Neck` 0/1) |
| Berill | `male_berill5m` | 0–12 | |
| Sky-1, Sky-1a, Sky-1b | `male_cs1`, `male_cs1a`, `male_cs1b` | all skins of each | |
| Sky-2 | `male_cs2` | 0–6 | |
| Sky-3 | `male_cs4` | 0–4 | |
| IO7a | `male_hawk` | 0–39 | |
| PS5-M | `male_psz9` | 0–64 | |
| Skat-9 | `male_stingray9` | `SKAT9_SKINS` | |
| Skat-10 | `male_stingray9` | `SKAT10_SKINS` | |
| Sunrise | `male_sunrise` | `SUNRISE_SKINS` | |
| Pathfinder | `male_sunrise` | `PATHFINDER_SKINS` | |
| Exoskeleton, Nosorog | `male_exoskeleton` | 0–36 | `Exoskeleton` 0 (frame shown) |
| Radsuit | `male_exoskeleton` | 0–36 | `Exoskeleton` 1 (frame hidden) |
| NBC | `male_nbc_lone` | 0–50 | `Head` 1, `Hood` 0, `Gasmask` 1 |
| SEVA | `male_seva` | 0–64 | `Head` 0 (sealed helmet) |
| SSP-99, SSP-99M | `male_ssp99` | 0–14 | `Head` 1, `Neck` 1 (sealed visor) |

The shared lists live in `schema/libs/sh_suitappearance.lua`. They split each shared model by the vest
painted into the skin texture, compared in the vest region of every texture through the mesh UV map:

- **Sector Four Sunrise:** Pathfinder suits get skin 41's plain-flap pouch vest (30–33, 37, 39, 41, 42,
  46–48). Sunrise suits get the remaining skins: the Sunrise vest (0–29), the ribbed-flap pouch vests
  (36, 38, 43–45) and the strap plate carriers (34, 35, 40).
- **Stingray-9:** Skat-9 gets skin 17's three-pouch vest (1–6, 10, 12, 14–17, 22, 28–30); Skat-10 gets
  skin 18's two-pouch vest (0, 7–9, 11, 13, 18–21, 23–27).

Factory finishes follow the faction named in each skin texture (`anorak_duty1`, `exo_monolith1`, ...).
Models without a matching faction finish use loner, military or renegade finishes. The ground models
(`ITEM.model`) and inventory icons are unchanged.

The exoskeleton frame toggle needs the rebuilt `male_exoskeleton.mdl` with its `Exoskeleton` bodygroup
(0 frame, 1 hidden). With an older build, the bodygroup is missing and Radsuits show the frame.
Exoskeleton suits no longer attach the PAC overlay; the frame is part of the model. The separate
`gear_exoskeletonframe` still uses its PAC overlay over other suits.

## Worn appearance

`ix.suitAppearance.ApplyWorn` (server) puts the suit's model, finish and bodygroups on its wearer. Equip,
loadout after every spawn or map transfer, Technut's paint confirmation and the `paint` item action all
use it, so a suit always loads on its current definition. A model change starts from the new model's
default bodygroups. The shared `ApplyBodygroups` also drives Technut's preview, so NBC, SEVA and SSP-99
suits keep their helmets, masks and hidden balaclava heads. Technut offers skins only for suits.
Anoraks and the sweater use bare hands on their player models. Other suits, including the Mail
Jacket, use gloves. The first-person hand selection also uses the worn skin. With
the [Garry's Mod THAP Rework 2.1 port](https://steamcommunity.com/sharedfiles/filedetails/?id=3130162394)
mounted, the tan Loner Anorak uses its bare-handed Novice jacket sleeves. Gloved suits prefer
matching Rework variants when present. The sweater keeps its existing first-person arms.
The schema falls back to [[Anomaly] Hands](https://steamcommunity.com/sharedfiles/filedetails/?id=2943525727)
and then to the bundled CotZ hands. Repainting updates the first-person model when the new finish
uses a different donor.

The baked hand models and their source THAP materials are included in the updated local
`cotz_playermodels` addon. All arm textures there (sleeves, gloves and normal maps) are at most 512
pixels on the longest side. Each baked skin recolours the THAP sleeve texture at up to 2048 pixels, then
shrinks it, so folds, seams, stitching, armour plates, straps, gloves and bare forearm skin follow THAP
Rework. Only fabric inside the sleeve material's UV area changes:

- A plain finish recolours the fabric to the suit's fabric colour. Camouflage in a donor texture is
  removed first, so it does not survive as shading.
- A camouflage finish on a patterned rig keeps that rig's own pattern with the suit's colours. A plain rig
  that shares its layout with a patterned faction rig uses that rig's texture instead.
- A camouflage finish on a plain rig with no patterned sibling gets its own pattern, upscaled with
  crisp edges and randomly arranged so it does not repeat.

The rig's normal map and shader are kept, and Technut's paint switches the skin without recreating the
hands entity while the rig stays the same. NBC suits wear the gloved Sunrise arms of the matching
Sunrise finish (NBC skins 2-50 are the Sunrise skins in Sunrise order); SEVA uses NBC-style hands and
bare-handed Anoraks use the Novice rig. Servers and clients need the updated content build. Older builds
use the available stock hands.

`cotz_content_work/packs/sectorfour_playermodels/tools/bake_suit_hands.py` builds the skins from
`source/cotz_sleeve_plan.json`, which lists the donor rig of every suit finish. `sleeve_bake.py` holds the
image processing, including the reviewed list of patterned donor textures and the clean fabric samples;
`sleeve_geometry.py` decompiles each donor rig to find the sleeve's UV area and texel density. The
full-size THAP originals stay in the pack's `source/thap_full`, because the addon's copies are reduced.
Run it from the pack directory with the content workspace's Python (numpy, Pillow and sourcepp installed),
into an empty staging folder:

```sh
python tools/bake_suit_hands.py <cotz_playermodels> source/cotz_sleeve_plan.json <output> <sv_bakedhands.lua> --sources source/thap_full --texture-size 512
```

The base **Lift Hood** action toggles the bodygroup named in `ITEM.hoodBodygroup`. Its state is not
saved; respawns lower the hood.

## Saved data

- A paid finish saves `setSkin` together with `setSkinModel`, the model whose skin table it indexes.
  `ix.suitAppearance.GetSkin` uses it only while it matches `ITEM.newModel` and the suit's list.
  Finishes saved for the legacy models therefore show the new factory finish. They are not rewritten.
  A repaint at Technut (100 rubles) replaces them.
- `setSkinOverrideModel` (former model overrides) is cleared on the next paint and never read.
  Index-based `setBG` data from the legacy models is no longer applied.
- Suit conversions copy item data. A variant on the same model keeps its finish; any other model
  falls back to the factory finish.

`Schema:PrePlayerLoadedCharacter` calls `ix.suitAppearance.MigrateCharacter` before Helix applies the
saved appearance. Already migrated characters are left unchanged, so it runs safely on every load:

- A character not wearing a suit on the legacy Anorak moves to the new Anorak. The former creator skins
  keep their menu order on Loner finishes 0–23. Saved bodygroups, which index the old model, are cleared.
- For a worn suit, the character model becomes the suit's model with its saved bodygroups cleared.
  A legacy Anorak saved for after the suit comes off (`oldModel`/`oldSkin`) is converted the same way,
  and the suit's `origgroups` from the legacy model are removed.
- Other models, such as administrator-assigned ones, are untouched.

New Loners use the sweater as their base model and spawn wearing an Anorak. The server picks one
of the 35 Loner finishes (0–34) when it grants the item and saves that color on the Anorak.
Taking the Anorak off restores the sweater.

## Deployment and checks

Deploy the code to every map server together, after clients can download the current
`cotz_playermodels` Workshop content. No database reset or first-time setup is involved.

```sh
luatex --luaonly tests/suit_appearance_spec.lua
luatex --luaonly tests/gear_customization_spec.lua
luatex --luaonly tests/gear_menu_spec.lua
```

The spec covers every concrete definition against the compiled models' skin counts and bodygroups,
the vest families, character creation, the suit base actions and migration. It uses mocks.
In a multiplayer session, verify:

- A character created before the change, with and without a worn suit and with a legacy paint, then
  taking the suit off; reconnecting and transferring maps afterwards.
- Technut previews and paid finishes for each family, then re-equipping, respawning and reconnecting.
- NBC, SEVA and SSP-99 helmets and masks, the Radsuit without a frame and the exoskeletons with one.
- Lift Hood on Anoraks, Mail Jackets and Trenchcoats; high skin indices on Anorak, PSZ-9 and SEVA.
- Create a Loner, check their starter color through a reconnect, then remove the Anorak. Compare
  first-person and third-person gloves when swapping between the sweater, Anorak and other suits.
- Weapon holds, ragdolls and helmet/gear clipping with worn PAC headgear and backpacks.
