# Gear customization

Technut offers **Can you change the finish on my gear or suit?** at his main menu.
The same window lists equipped supported gear and suits in the main inventory, including equipment
cells. The combined service requires Technut's painting progression unlock for both gear and suits.
Each confirmed appearance change costs 100 rubles. All choices preview before confirmation, and
unchanged selections cannot be purchased. The old separate suit-painting dialogue and preview are removed.

Suit finishes come from the existing sparse `skincustom` allowlist, including approved model overrides.
They retain `setSkin` and `setSkinOverrideModel` persistence and ordinary suit equip behavior; they do
not use PAC gear descriptors or a new saved appearance field. Confirmation rechecks the item, allowlist,
painting permission for both gear and suits, saved skin/model, equipped state, money and proximity.
Existing saves need no migration.
Suture's suit conversions remain his separate service under the gear customization dialogue submenu.

The window previews the selected gear on a copy of the player's current character
model. The rotation control turns the preview. Changes remain local until confirmed;
Reset Preview and Cancel never alter the item or charge money. The preview deliberately
shows the selected gear rather than copying all other worn PAC equipment. Suit finishes preview on
the character model. Escape cancels a confirmation before closing this window; holding it for one second
closes the conversation and its related windows.
PAC parenting and bone modifiers update before the preview character is drawn, so
bonemerged outfits follow its skeleton even outside PAC's world draw distance.

## Current assets

Eighteen concrete wearable definitions declare skin allowlists: the Altyn, CS1/CS2/CS4,
PRACS, PSZ12 and radiation headgear; the five Screen variants; Sphere-08/Sphere-12;
EO-20, half mask and XM40 masks; and the exoskeleton frame. Faction finishes are allowed.
Choices are based on the materials actually used by each model's meshes. Duplicate
or ineffective skin families are excluded, including the unused skin families on
the ACH, Russian operator helmets, riot helmet, GP5 and Arab helmet.
Twelve EO-20 Sunset finishes lack material definitions in the installed content and
are also excluded. Check mounted materials before expanding any allowlist.

The installed wearable models have no cosmetic bodygroup alternatives. Backpack
`root` groups switch between dropped, arms and worn geometry; those remain fixed.
Bodygroup controls appear only after a concrete item declares approved alternatives.
Unsupported backpacks and other single-appearance wearables do not appear in the menu.

Ground-model skins are mapped explicitly. Where the ground model has the same
material surface but lacks skin families, configured submaterial replacements carry
the finish over, for example the Altyn. Screen outfits and some CS4 finishes have no
matching ground-model surface; those keep the ground model's factory appearance.
Their menu displays that limitation. The worn PAC preview remains authoritative for
these finishes. No models, materials, protection values or faction identities change.

## Concrete item configuration

Declare `ITEM.appearanceCustomization` in the concrete item before its presentation
settings. Its values are shared definition data, never mutable instance state:

```lua
ITEM.appearanceCustomization = {
	targets = {{1, 1}},
	defaultSkin = "green",
	worldMaterialSlots = {},
	skins = {
		{id = "green", name = "Green", skin = 0, worldSkin = 0},
		{id = "black", name = "Black", skin = 1, worldSkin = 1},
	},
	bodygroups = {
		{
			id = "cover", name = "Cover", group = "cover", default = "open",
			options = {
				{id = "open", name = "Open", value = 0, worldValue = 0},
				{id = "closed", name = "Closed", value = 1, worldValue = 1},
			},
		},
	},
}
```

This illustrates an item with real cosmetic bodygroups; it does not add them to the
current assets. Only approve visible cosmetic variants, retaining protective components.
Keep each option ID stable after deployment. IDs contain letters, digits, underscores
or hyphens and are at most 64 characters. At most 16 bodygroup controls are supported.
The default skin and bodygroup values must match the item's existing PAC definition.

Each target path starts with an index in `pacData`, then follows successive `children`
indices. List every intended clipped copy explicitly, leaving unrelated outfit parts
out. Bodygroup entries can override `targets` and `worldGroup`; otherwise they use the
item's targets and their `group` name. Both PAC `model` and `model2` are supported through
child bodygroup parts. Existing transforms, clipping and unrelated fixed groups survive.

Skin options may declare `worldMaterials = {[index] = "material/path"}`; list every
overridden index in `worldMaterialSlots` so returning to another finish clears previous
overrides. Use `worldNotice` to explain an intentional ground-model limitation. Omit
`worldValue` for bodygroup variants with no ground counterpart. Bodygroup-only items
declare `skins = {}` and omit `defaultSkin`.

## APIs and persistence

The shared `ix.gearAppearance` API resolves/validates selections (`Normalize`,
`ValidateDefinition`, `IsSupported`, `GetConfiguration`, `CanCustomize`), builds isolated PAC trees (`BuildPAC`), applies
ground mappings (`ApplyWorld`), and supplies descriptions, fingerprints and typed
state/descriptor serialization. Client-only `OpenMenu` and `GetIcon` own the window
and rendered icons. Shared initialization validates authored definitions.

One `gearAppearance` item-data value stores `{skin = optionID, bodygroups = {[id] = optionID}}`.
No new inventories, database tables or character progression fields are introduced.
Absent data uses definition defaults. Removed options fall back visually to defaults
without rewriting the saved selection. Dropping, transferring and reconnecting retain
the instance's data. Default item IDs, categories, gameplay state and equip callbacks
are unchanged.

The schema PAC integration stores an item ID and appearance descriptor for supported
worn gear instead of a boolean. Other PAC items retain boolean entries. Wear messages
include a typed optional descriptor; all clients must update with the server. Clients
clone definitions, namespace part identities by wearer and item instance, remap internal
references, and retain the exact attached tree for removal. Late clients request a
rate-limited snapshot once PAC is ready, with up to three delayed retries if entities
are not yet available. Delayed attachment checks that the item has not been removed.

Rendered icons use appearance-specific keys in the existing icon cache and preserve
explicit image overrides. The schema's scoped icon-renderer detour restores renderer
skin, submaterials and bodygroups after capture. No bundled Helix or PAC3 files change.

## Transactions and deployment

The server validates Technut's identity/dialogue binding, access, life state, proximity
within 192 units, current character, inventory membership, equipped state, allowed
choices, funds and pending equipment transitions. Requests are limited to one per
0.25 seconds. Each player has one 60-second, single-use confirmation bound to the
character, vendor, exact item, definition and previous appearance. Confirmation repeats
validation before saving and charging. A visual refresh never replays equip callbacks.

Deploy the same code to all map servers and restart. Do not hot-disable the plugin or
mix old/new clients during the PAC protocol update. No migration or save reset is
required; do not rerun first-time setup.

## Verification

From the repository root:

```sh
luatex --luaonly tests/gear_customization_spec.lua
luatex --luaonly tests/gear_rendering_spec.lua
luatex --luaonly tests/gear_menu_spec.lua
luatex --luaonly tests/dialogue_order_spec.lua
luatex --luaonly tests/equipment_slots_spec.lua
luatex --luaonly tests/equipment_views_spec.lua
luatex --luaonly tests/equipment_interactions_spec.lua
luatex --luaonly tests/cotz_ui_spec.lua
luatex --luaonly tests/progression_spec.lua
```

These tests use mocks; they do not establish engine rendering or multiplayer correctness.
In a multiplayer development session, verify two players wearing different copies,
all configured finishes (especially clipped masks and compound Screen equipment),
ground mappings, inventory/equipment icons, late joins, reconnects, observer mode,
character changes and saved world items after restart. Try full backpacks, repeated
confirmations, moving away, dying, losing funds and unequipping during confirmation.
Check that protection, capacity, condition and upgrades remain unchanged. Inspect
preview cancellation and cleanup, keyboard/modal focus, long lists and narrow,
1080p, ultrawide and 4K layouts, including resolution changes while open.
