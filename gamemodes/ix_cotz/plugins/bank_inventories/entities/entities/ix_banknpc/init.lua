AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
    self:SetModel("models/z-o-m-b-i-e/st/shkaf/st_seif_02.mdl")
    self:SetHullType(HULL_MEDIUM)
    self:SetHullSizeNormal()
    self:SetSolid(SOLID_BBOX)
    self:SetUseType(SIMPLE_USE)

    local physObj = self:GetPhysicsObject()

    if (IsValid(physObj)) then
        physObj:EnableMotion(true)
        physObj:Wake()
    end
end

function ENT:Use(activator)
    if not activator:IsPlayer() then return end

    local character = activator:GetCharacter()
    if not character then return end

    local ID = character:GetData("bankID")
    local bank

    if ID then
        bank = ix.item.inventories[ID]

        if not bank then
            ix.inventory.Restore(ID, 3, 2, function(inventory)
                inventory:SetOwner(character:GetID())
                bank = inventory
            end)
        end
    else
        bank = ix.inventory.Create(3, 2, os.time())
        bank:SetOwner(character:GetID())
        bank:Sync(activator)

        character:SetData("bankID", bank:GetID())
    end

    ix.storage.Open(activator, bank, {
        entity = self,
        name = "Bank Account",
        searchText = "Accessing bank account...",
        searchTime = ix.config.Get("containerOpenTime", 1)
    })
    return
end