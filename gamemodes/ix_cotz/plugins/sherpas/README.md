# Sherpa quartermasters

Reusable vendors for individual characters and squad hideouts. Requires `vendor_adv`, `dialogue`,
`hideouts`, and the hideout structured database/transaction support. The personal bank dialogue
option uses `personalstorage` when enabled. No bundled Helix files are modified.

The plugin retains the `sherpas` ID and the saved `SherpaVendors` character variable, including legacy
name grants. It is now a directory rather than the old standalone Lua file. Restart/changelevel to
apply this loading change; do not hot-reload over active economic operations.

## Individual player vendors

1. Spawn **Entities → Helix → Vendor - Sherpa** as an administrator.
2. Use its **Edit Vendor** property to set model, name, description, sound/animation group and explicit
   idle sequence. A blank sequence uses automatic idle selection. Skin/bodygroup properties use the
   existing tools. The default Half-Life 2 model is a replaceable placeholder.
3. Look directly at the nearby vendor and run `/CharAddCurrentSherpaVendor "Character Name"`.
   This grants stock management to that character using the vendor's stable ID. Repeat for additional
   authorized characters. `/CharRemoveCurrentSherpaVendor` revokes both the current ID and legacy name.
   Existing `/CharAddSherpaVendor`, `/CharRemoveSherpaVendor` and `/CharResetSherpaVendors` remain.
4. The character uses the vendor's dialogue and selects stock/donations. The advanced trading window
   shows vendor instances on the left and their own items on the right. Select an item and click Donate.
   Right-click a stock row to set its whole-instance price (0 means unlisted), or recover it for free.
   Regular visitors can purchase listed stock. Authorized managers recover items without payment.
5. Options exposes pagination, refresh and authorized earnings withdrawals. `/TakeVendorMoney` now
   opens this window so the withdrawal follows the same validated transaction path.

The storage dialogue opens the visitor's existing personal bank, bound to that character and the
nearby vendor. Donations, bank storage and hideout container storage are distinct. No bank contents
are automatically transferred into stock.

A donation preserves the original item row and its instance data. Purchases transfer that same row;
full inventories leave it and the buyer's money untouched. Equipped, bound, cargo and inventory-bearing
items follow hideout stock exclusions. Sales apply `hideoutSaleCommission` and credit the vendor's
own earnings account. No NPC restock, progression or ordinary vendor trade reward callbacks run.
Commands and network actions recheck location and authorization on the server; stock windows bind to
the current character/session. Ordinary inventory transfers and item actions cannot bypass stock sales.

## Squad integration

`ix_hideout_vendor` inherits `ix_sherpa_vendor`, which inherits `ix_vendor_adv`. Squad membership/rank,
instance lifecycle, treasury and journal operations remain with hideouts. All members can donate;
officers/leaders can price or recover stock, and only the leader withdraws squad earnings. The same
trading window and dialogue are used. Personal storage rooms instantiate no vendor.

Parent initialization resolves the registered entity definition through `scripted_ents.GetStored`.
Helix plugin registration can occur after GMod populates its separate baseclass cache, so initialization
must not depend on that cache containing these plugin entities.

Squad vendor appearance is saved separately from its local movement transform. It survives unloading,
reallocation and position reset. An administrator can use **Edit Vendor** without joining the squad;
this does not grant furnishing/tool privileges or player access to its containers.

## Saves and recovery

Standalone placements/appearance use the existing `vendor_adv` map save. Stable ID → stock inventory
assignments also live in the `sherpas` plugin map data, so removing a placed vendor does not discard
its stock reference. Items stay in Helix inventories; earnings stay in the transaction adapter's
`ix_hideout_treasuries` row under a stable `sherpa:<ID>` key. Back up these together with the operation
journal and normal Helix item/character tables.

To replace a deleted vendor, run `/SherpaStockList` to find its stable ID, spawn a fresh Sherpa, aim
at it, and use `/SherpaAttachStock ID` **before opening its stock window**. The command rejects an
already initialized destination or stock attached to another live vendor. Existing ID grants continue
to work. Grant character access to the new ID when replacing legacy name-based access.

Existing squad stock inventories and listing data require no item conversion. Old `ix_vendor_adv`
entities with the Sherpa flag use the new dialogue/instance endpoint while retaining their placement,
appearance, legacy catalogue, money field and character stock-history data. **Old counted Sherpa stock
is not automatically converted into new items or earnings.** Those counts were personal NPC catalogue
state, sometimes restocked, and never retained the donated instances' data; treating each viewer's
count as shared physical stock would duplicate goods. Keep these saved values for a reviewed manual
migration; do not reset them or infer missing condition/quantity data. New donations use real instances.

## Verification

From the repository root:

    python3 gamemodes/ix_cotz/plugins/hideouts/tests/run.py
    luatex --luaonly tests/hideout_vendor_spec.lua
    luatex --luaonly tests/vendor_dialogue_spec.lua
    luatex --luaonly tests/vendor_stock_spec.lua
    luatex --luaonly tests/helix_vendor_trade_spec.lua
    luatex --luaonly tests/dialogue_order_spec.lua
    luatex --luaonly tests/cotz_ui_spec.lua

The hideout suite syntax-checks the Sherpa modules and uses the installed query builder and real SQLite
transactions for custody/payment/rollback tests. It also covers storage ranks, demotion during an upgrade,
personal room limits and cross-map squad ownership claims. Mocks do not establish GMod correctness.

Multiplayer verification still needed: derived entity loading on both realms; dialogue/back/goodbye;
model/skin/bodygroups and idle/group animation editing; two-column trading, pagination and confirmations;
individual access grants/revocation; simultaneous purchases and full inventories; bank callback character
changes; vendor deletion/reattachment; restart and hideout unload/reload appearance/stock retention;
and real MySQL failures/contention across two maps. Test UI at narrow, 1080p, ultrawide and 4K sizes.
