local PLUGIN = PLUGIN

PLUGIN.name = "Bank Inventories"
PLUGIN.author = "armdupe"
PLUGIN.description = "Creates an NPC that gives additional storage to players."

ix.util.Include("sv_invtypes.lua")
ix.util.Include("derma/cl_itembank.lua")
ix.util.Include("derma/cl_bankmenu.lua")

--ix.inventory.Register("itemBankInventory", 2, 2)
--ix.inventory.Register("itemBankInventoryUpgrade1", 10, 10)

ixBankUpgrade = ixBankUpgrade or {}

ixBankUpgrade.Upgrades = {
    {
        identifier = "itemBankInventory",
        invW = 2,
        invH = 2,
        upgrade = 1,
        price = 500,
    },

    {
        identifier = "itemBankInventoryUpgrade1",
        invW = 5,
        invH = 3,
        upgrade = 2,
        price = 500,
    },
}

for i, v in pairs(ixBankUpgrade.Upgrades) do
ix.inventory.Register(v.identifier, v.invW, v.invH)
end
