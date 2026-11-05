# Personal and squad hideouts

See [runtime, setup, migration and verification guide](README.md).

The base lifecycle remains UNLOADED → LOADING → ACTIVE → SAVING → UNLOADED. Instances reserve
remote map space, share occupancy across visitors, and retain failed saves for recovery.

- Personal entrances are fixed administrator-placed door keypads. Squad entrances are officer-placed,
  shared invisible interaction entities; squad members always enter and outsiders follow access mode.
- Player actions live in entrance, exit, individual container and vendor menus. The squad tab
  provides initial entrance placement. Chat commands are administrator-only; server-side menu sessions
  bind actions to the character, role and appropriate physical interaction.
- Personal storage uses independently identified, upgraded inventories. Every spot defaults private;
  its owner may share it with invited characters. Global personal banks stay separate.
- Squad building capabilities are contextual and limited to furnishings plus the movable vendor.
  Template geometry and fixed utilities are protected. Vendor reset never touches stock or money.
- Stock items retain their authoritative Helix rows. Listings are instance data; only buyer-funded
  purchases credit a shared squad treasury. Native transactions coordinate economic changes, with
  deferred character saves and durable upgrade entitlement replay beneath existing APIs.
- Ordinary state uses plugin/item/character APIs. The operation journal and treasury are the only
  new SQL stores. No bundled Helix files change; SQL construction remains in the installed builder.
- Artifact destinations use stable hideout identity/local coordinates. Cross-map arrival uses the
  existing session handoff and an expiring character intent; access is checked again at admission.
- Existing IDs, banks and floor-item row authority are preserved. Retirement retains new inventory
  references for explicit recovery. No saves are reset and no first-time world setup is invoked.

SQLite regression coverage does not establish live MySQL contention, networking, tool behaviour,
map geometry or AdvDupe correctness. Follow the multiplayer checklist in the runtime guide.
