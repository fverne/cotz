# Implementation reference

Read the [runtime/editing guide](../../gamemodes/ix_cotz/plugins/townnpcs/README.md) first.

| Responsibility | Owner |
| --- | --- |
| Contact jobs, access, catalogue, progression and task dialogue | townnpcs/definitions/sh_<contact>.lua |
| Shared balance, pools, upgrade chains and field sites | townnpcs/definitions/sh_config.lua, sh_pools.lua, sh_equipment.lua, sh_sites.lua |
| Progression storage, requirements, rewards and services | progression/libs/ |
| Ordinary NPC conversation and declared root actions | dialogue/dialogue/sh_<dialogueid>.lua |
| Shared work/progression callbacks | dialogue/libs/sh_towncontacts.lua |
| Shared vendor trade callback | dialogue/integrations/sh_trade.lua |
| Models, names, idle, base stock and dialogue binding | vendor_adv/definitions/sh_<contact>.lua |
| Vendor template/placed-stock assembly | vendor_adv/libs/sh_towncontacts.lua |
| Repeatable execution and finite field primitives | jobsystem/ |

Town registration runs at InitializedPlugins after the owning registries finish loading. Plugin-owned
methods use PLUGIN: and self. Conversation files use DIALOGUE.addTopic and stable dialogue IDs.
There are no retained copies of superseded town progression definitions, old job/progression topics,
old-ID access bridges, stock migrations or prerequisite converters. No database reset is performed.
Secret and standalone non-town content remains separate from the town roster.

The loaded 646 nodes use existing hand-ins, counters and field commissions. Bespoke multi-site
investigations, physical evidence variants, rescue actors and visible town upgrades remain proposals.
Field-site coordinates, NPC placement, mounted models, navigation and travel require in-game authoring.
Do not run first-time setup as validation. Pripyat has no permanent town contacts.

Run the relevant Lua suites listed in the runtime guide. Test real multiplayer accept/travel/objective/
return/reward flows, map transfer, full inventory, disconnect/retry, placement/save/restart and database
interruption before deployment. Standalone mocks do not prove those runtime paths.
