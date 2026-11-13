# Weapon workshop

Technut and Boss offer **Weapon workshop** alongside existing repairs and weapon cleaning.
The workshop has fixed component exchanges, full durability rebuilds, dismantling and stored item
collection. Existing NPC, faction, progression and proximity access rules still apply. No additional
progression unlock is required. Restart the server and reconnect clients to load the new plugin/items.

## Player loop

- Carry a firearm to reveal its barrel and receiver recipes. Two identical firearms share one recipe
  pair. Each recipe detail lists ingredients required/carried and the commission. Missing ingredients
  leave the recipe readable but remove its confirmation action.
- Buy the two components in any order. Each costs 20% of the firearm's nominal definition price,
  rounded up, plus its fixed recipe. Repair discounts and provider-bound credits reduce the money
  commission; they do not replace ingredients. Components remain transferable between players.
- Choose the exact firearm instance and hand in one matching barrel and receiver. Both are consumed;
  durability becomes 100%, while cleanliness, ammunition and attachments remain unchanged. Equipped
  weapon durability is updated too. Fitting has no additional commission.
- Dismantling permanently removes an unequipped, unloaded firearm with no installed attachments and
  awards parts of its salvage family. The confirmation shows exact probabilities and current condition.
  It costs no money. A failed item removal awards nothing.
- Outputs awaiting inventory space remain saved. Collect them through either technician or let the
  character-load retry deliver them. Collect outstanding workshop items before starting another action.

There are 130 supported firearms, 260 exact-model components and four salvage items. Components
use the existing loose-mechanism model with explicit names and compatibility. Component item values
range from 20–200 RU, separately from technician exchange costs. Town vendors buy components through
buy-only catalogue rows; the workshop prevents vendors selling components to players. Salvage keeps
its vendor restriction. Player transfers remain available. The existing valuable
`value_weaponparts` and all current weapon IDs and saves retain their existing meanings.

## Tiers and salvage families

The reviewed catalogue in `sh_catalogue.lua` uses each weapon's highest-weight occurrence in the
active `task_rewards_weapons` tables, merging low/high variants. Melee tier 00 and commented tier 08
are excluded. Counts for tiers 1–7 are 11, 12, 14, 19, 57, 8 and 9. F2000 resolves to tier 5.
Runtime audits warn about changed or conflicting loot tiers; they do not silently retune the catalogue.

Families follow cartridge and mechanism class, not primary/secondary equipment slots:

| Salvage item | Nominal value per part | Assignment |
| --- | --- | --- |
| `weapon_parts_pistol_smg` | 40 RU | Handguns, SMGs, pistol-cartridge carbines and .22LR rifles |
| `weapon_parts_shotgun` | 60 RU | Shotgun mechanisms, including .410 |
| `weapon_parts_intermediate` | 100 RU | Intermediate-cartridge rifles, including 9x39 and 5.56 Sako |
| `weapon_parts_long_rifle` | 150 RU | Full-power/heavy rifles, including Obrez and FN FAL |

All four families stack to ten, with quantity and per-part weight declared on each concrete item.
Drag matching owned inventory stacks together to combine them; excess stays in the source stack.
Different families cannot mix, and unacknowledged workshop deliveries cannot combine or be sold.
New dismantling rewards arrive as one quantity-bearing stack. Existing quantity-less saved parts
still count as one, and previously queued single-part rewards remain claimable without conversion.

Full-condition base expected yields for tiers 1–7 are 0.5, 1, 1.5, 2, 2.5, 3 and 4 parts.
Multiply by durability/100 and cleanliness/100, clamped to 0–100. The integer portion is guaranteed;
one fractional roll determines an extra part. The integer tiers do not perform a random roll.
For example, a tier-5 gun at 80% durability and 80% cleanliness yields one guaranteed part and a
60% chance of a second. Tier 7 at 100% on both readings gives exactly four. Saved `wear` means
cleanliness, so zero cleanliness gives zero salvage; clean a gun before dismantling if worthwhile.

## Recipes and editing

Each concrete `items/weaponcomponents/sh_weapon_<kind>_<weaponID>.lua` explicitly declares identity,
descriptions, model, dimensions, weight, nominal value, weapon ID, component kind, commission rate
and recipe. Shared item bases provide category and valuable mechanics. Both item folders are at the
Helix loader's immediate discovery depth. `sh_plugin.lua` explicitly includes shared/server modules.
Dialogue installation runs at `InitializedPlugins`, after both technician conversations exist.

Recipes were authored against current unit prices. Complete rebuilds total roughly 61–73% of weapon nominal
price before earned discounts/credits, with 40% as commission. Low-value firearms omit expensive oil
or reduce fasteners/parts. Nuts and bolts consume individual saved quantity units across stacks;
oils and tool sets consume whole items. Tools in recipes are barter inputs and are consumed.
Barrels use civilian gun oil, spray lubricant, military cleaner and firearm lubricant, with supporting
cleaning stock, fasteners and workshop supplies varying by model and tier. Higher tiers add precision
tools and advanced/specialty tool boxes where affordable. Tools are consumed barter goods.
The F2000 receiver requires five intermediate parts, eleven bolts, two precision screwdriver sets,
one civilian oil and 5,700 RU commission before benefits. The barrel has a separate recipe.

Component `ITEM.price` is the low nominal resale value, not commission plus ingredients. Keep it in
20–200 RU when editing recipes. Commission still uses the firearm's price and `commissionRate`.
Keep each full rebuild's commission plus ingredient value within the intended 60–80% review band.
The catalogue/budget spec detects drift. For a new gun, add an explicit tier/family catalogue entry
and two concrete component files; preserve existing IDs to retain saved compatibility.

Recipe difficulty follows the FTS source maps and actual loot weights, rather than item price alone.
Recipes stay fixed when a player travels; these bands describe where their supplies can be obtained.

| Weapon tier | Ingredient access policy |
| --- | --- |
| 1–2 | Common Swamps `worldspawn_1` items, each with entry weight at least 50; no rare oil or tool requirements |
| 3 | Adds regular Garbage stock, including metal spare parts, nippers, screwdrivers and wrenches |
| 4 | Adds regular Waystation `worldspawn_3`, including spray lubricant and military cleaners |
| 5 | Adds Garbage/Waystation rare stock and affordable precision/advanced workshop tools |
| 6–7 | Adds Pripyat supplies; each barrel requires a Pripyat-sourced programmer, controller or precision gyroscope |

Cheap guns keep affordable recipe exceptions. Low-tier receivers follow the same source limits;
two tier-3 receiver recipes use common civilian oil and detergent instead of military cleaner.
The standalone spec checks every ingredient against these live pool definitions and protects the
early-tier common-loot threshold. The map/pool assignments come from the FTS presets and the
[availability audit](../../../../docs/npc-overhaul/delivery-balance.md); live saved spawns can differ.

## Authority, delivery and persistence

`sh_service.lua` computes offers and descriptions on both realms. `sv_transactions.lua` revalidates
the character, exact weapon, provider, access, distance, quote expiry, current condition, money and
inputs on confirmation. Server action/quote cooldowns are 0.5 seconds. A quote is consumed on its
first confirmation attempt. Missing ingredients and failed removals do not charge commission or grant
output; already removed ingredients are returned through the same acknowledged delivery queue.
Partial stacks are restored immediately on failure. Queues are bounded to 64 entries; transactions
with more ingredient stacks require combining stacks first.
In-flight item inserts are separately bounded to 128 across the server; excess claims remain stored.

Commission charging uses `ix.progression.ChargeService`, shared with ordinary progression services,
so credit spending and discount calculations retain one owner. Workshop state is new character data
under `weaponWorkshop`, containing a serial and pending item/data/token entries. No migration or reset
of existing character, weapon, loot or valuable state is required.

`sv_delivery.lua` saves fixed rewards before attempting insertion. A reserved slot from inventory
`Add` is not treated as a delivered item: `InventoryItemAdded` acknowledges the insert, including
bag inventories without an owner. Each insert carries `weaponWorkshopDelivery` for reconnect
reconciliation. Items stay locked until the acknowledgement is saved. Delayed delivery never inserts
into the player's newly selected character, and retries do not reroll salvage or charge again.
If a database callback never arrives, that in-flight claim stays locked rather than issuing another
copy. Investigate database errors before restarting; reconnect scans already inserted receipts.
If an old insert races a newly restored character object, its token stays in flight until inventory
restoration includes that row; it cannot start a duplicate insertion in the interim.

Helix item deletion, item data and character saving remain separate database operations. This is
not an ACID transaction across a process crash or database outage between input removal and reward
save. Do not claim crash-atomic exchanges; deployment backups and database recovery remain necessary.

## Verification

Run from the repository root:

```sh
luatex --luaonly tests/weapon_workshop_spec.lua
luatex --luaonly tests/progression_services_spec.lua
luatex --luaonly tests/dialogue_order_spec.lua
luatex --luaonly tests/town_dialogue_menus_spec.lua
luatex --luaonly tests/town_vendor_buying_spec.lua
luatex --luaonly tests/vendor_stock_spec.lua
```

The workshop spec covers every catalogue entry and recipe budget, condition probabilities, component
visibility/compatibility, credits, full inventories, failed consumption/refunds, duplicate confirmation,
stale quotes, character changes, asynchronous acknowledgement, reconnect reconciliation, stack limits,
merge ownership/failed removal, quantity-aware weight/value, regional ingredient access and vendor direction.
These are standalone mocks. Multiplayer QA still needs both providers, real includes/item discovery,
model rendering, dialog navigation, two-client transfers, equipped SWEP synchronization, real SQL
callbacks and reconnects with pending items. No first-time setup or save reset is part of validation.
For stacks, also check drag-combining across owned bags, full targets, partial remainders and the
quantity counter. Verify component sales at an existing town vendor and that no component appears
for purchase after selling one.
