local PLUGIN = PLUGIN

function PLUGIN:OnCharacterCreated(client, character)
    local bank = ix.inventory.Create(3, 2, os.time())
    bank:SetOwner(character:GetID())
    bank:Sync(client)

    character:SetData("bankID", bank:GetID())
end

function PLUGIN:PlayerLoadedCharacter(client, character, currentCharacter)
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
        bank:Sync(character)

        character:SetData("bankID", bank:GetID())
    end
end