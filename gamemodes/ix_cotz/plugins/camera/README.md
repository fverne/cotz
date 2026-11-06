# Camera

`ix_camera` is a standalone job-tool SWEP. Give it with `give ix_camera` in a development session,
or spawn **COTZ → Camera** from the weapons menu as an admin. It can be used by any character
who has been given it. Left-click takes one picture; the server enforces a one-second cooldown
across camera instances. There is no job registration, inventory item, battery mechanic or reward logic.

Merge the `models/`, `materials/` and `sound/` directories from
`/home/fverne/Desktop/cotz_content_work/packs/infra_camera/addon_ready/cotz_camera_assets`
into the existing content addon, preserving their internal paths. Asset distribution is managed by
that content addon; the camera plugin does not register client downloads. The original Workshop addon
is not required. Restart after installing the assets and plugin.

The camera currently uses a 90-degree horizontal field of view at 16:9, a range of 2,000 Source units,
and 1366×768 JPEG output. These values are configured in `sh_plugin.lua`. Only the latest image and JSON
subject list are kept in the photographing client's `garrysmod/data/cotz/camera/latest.jpg` and
`latest.json`. The count appears in chat and the full subject list appears in that client's console,
including an explicit message when the 128-subject limit is reached. Empty photos replace old results.
Escape-menu capture failures are reported rather than saving an empty image.

The first-person model has a live screen using the original camera's control-panel attachments.
The preview uses the photo's field of view and aspect ratio, letterboxed to fit the model's screen.
It refreshes a cached 512×512 render target only while the camera is active in first person, without
the HUD, hands or camera being rendered into that preview. The screen placement is adapted from
akua's original SWEP; it does not require the original addon's screen materials, fonts or response system.
The photographing client plays `items/camera/snap.wav` once when the server accepts a shot.
Viewmodel FOV and Helix lowering angles remain configured on the SWEP itself.

The server builds the list from its own shoot position and eye angles, with rectangular framing and
`MASK_VISIBLE` line-of-sight checks. Entity candidates are `ix_*`, `npc_mutant_*`, `npc_human_*`,
`anom_*`, `sanom_*`, `rad_*`, `teleport` and entities marked `IsSTALKERNPC`. The owner, camera and `GetNoDraw()` entities
are excluded. The entity center and eight bounding-box corners are sampled, so partially visible
entities can count. This is a geometric visibility test, not pixel recognition; custom invisible draws,
translucency, client draw-distance rules and very narrow visible slivers can differ from the list.

Configured spawnpoints use the existing **spawnpointesp** plugin's server-side collector and category
registry. Keep that plugin enabled for spawnpoint capture; its admin-only overlay and request access
rules are unchanged. All its categories are included, including unoccupied locations. Points are
tested eight units above their stored position so floor placement does not block the photograph.
This records a visible location, not proof that a spawned entity is present. Entity-backed spawnpoints
retain their entity for line-of-sight checks. No preset deployment or save mutations occur.

`ix.plugin.Get("camera"):TakePhoto(client, weapon)` returns the authoritative result and also replaces
`weapon.lastPhoto`. It includes character ID, map, origin, angles, subjects and a truncation flag.
Each subject has `kind`, `id`, `class`, `label` and `position`. Entity IDs are session-only entity indices;
spawnpoint IDs combine category and the existing record key, which can change when points are edited.
These are not persistent assignment identities. A future job integration must validate the result's
character and define its own stable target identity. Client JPEG/JSON files are not authoritative.

The client renders the server's shutter viewpoint on receipt. Moving actors may have moved slightly
by then; the server's subject list is the shutter-time result. Use first-person framing for aiming.

Assets: [INFRA Camera SWEP by akua](https://steamcommunity.com/sharedfiles/filedetails/?id=3410154200),
original camera content from **INFRA / Loiste Interactive**. Imported assets retain their original
ownership; the repository's MIT license does not relicense them. Only the two camera models and
companions, camera material/three textures, and shutter/deploy/holster sounds are used. Original Lua,
responses, voices, batteries, targets, particles, icons and fonts are excluded. The content pack records
the source archive hash, selected files, Linux casing corrections and removal of the INFRA-only
`UseHighlight` material proxy.

Run `luatex --luaonly tests/camera_spec.lua` from the repository root. Mocks cover framing, occlusion,
partial visibility, spawnpoint identity, ownership, cooldowns, bounded results, realm loading, local
shutter playback and reusable preview rendering without recursion or leaked render state.
Multiplayer verification still needs to confirm the models/materials/hands and sounds, a clean JPEG
and an aligned live screen on 4:3 and widescreen clients, empty/occluded/multiple targets, reconnects,
two photographers, weapon swaps, and spawnpoint capture without observer access. Disable the
original Workshop addon while testing so it cannot hide missing dependencies.
