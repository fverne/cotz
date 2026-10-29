--Player open item bank
netstream.Hook("PlayerItemBankUpgrade", function(ply)
    local char = ply:GetCharacter()
    if not char then return end
    if not char:HasMoney(500) then return ply:Notify("You do not have the sufficient funds to upgrade your item bank!") end
    if char:GetData("itemBankUpgradeStage") >= 3 then return ply:Notify("You have reached the max upgrade stage!") end
    char:TakeMoney(500)
    char:SetData("itemBankUpgradeStage", char:GetData("itemBankUpgradeStage") + 1)
    ply:Notify("You have purchased Upgrade Stage: " .. char:GetData("itemBankUpgradeStage") .. "!")
end)

concommand.Add("resetupgradestage", function()
    for k, v in pairs(player.GetAll()) do
        v:GetCharacter():SetData("itemBankUpgradeStage", 1)
        print(v:GetName() .. ": " .. v:GetCharacter():GetData("itemBankUpgradeStage"))
    end
end)

netstream.Hook("PlayerOpenItemBank", function(ply)
    local char = ply:GetCharacter()
    local ibInvID = char:GetData("itemBankInvID", nil)
    local isUpgraded = false

    if char:GetData("itemBankUpgradeStage") == 2 then
        print("VIP set")
        isUpgraded = true
    end

    --Inventory has not been created yet
    if not ibInvID then
        local invType --Determinating inventory category

        if isUpgraded then
            invType = "itemBankInventoryUpgrade1"
        else
            invType = "itemBankInventory"
        end

        --Creating inventory
        --Creating ivnentory if not exist
        ix.inventory.New(char:GetID(), invType, function(inventory)
            char:SetData("itemBankInvID", inventory:GetID())
            ibInvID = inventory:GetID()
            ply:GetCharacter():SetData("itemBankInvID", ibInvID) --Saving Inventory ID
        end)
    else --Possible problems trying to get solved.
        local inv = ix.item.inventories[ibInvID]
        local w, h = inv:GetSize()
        local regInvType = ix.item.inventoryTypes["itemBankInventory"]

        --VIP has Regular Inventory
        if isUpgraded and w == regInvType.w and h == regInvType.h then
            print(" -> Converting Regular Item bank to Upgrade 1 Item bank (" .. ply:Nick() .. ") <-")

            ix.inventory.New(char:GetID(), "itemBankInventoryUpgrade1", function(inventory)
                --Transfering items to new inventory
		inventory.OnAuthorizeTransfer = function(client, curInv, self)
			return true
		end
                inventory.OnCanTransfer = function(curInv, inventory)
		        return true
		end
                for _, i in pairs(inv:GetItems()) do
                    print("transferring regular to upgrade 1")
                    PrintTable(inv:GetItems())
                    print(inv)
                    i:Transfer(inventory:GetID())
                end

                ibInvID = inventory:GetID()
                char:SetData("itemBankInvID", ibInvID) --Saving Inventory ID
            end)
        elseif not isUpgraded and w ~= regInvType.w and h ~= regInvType.h then
            --Regular has VIP Inventory
            print(" -> Converting Upgrade 1 Item bank to Regular Item bank (" .. ply:Nick() .. ") <-")

            ix.inventory.New(char:GetID(), "itemBankInventory", function(inventory)
                --Transfering items to new inventory
		inventory.OnAuthorizeTransfer = function(client, curInv, self)
			return true
		end
                inventory.OnCanTransfer = function(curInv, inventory)
		        return true
		end
                for _, i in pairs(inv:GetItems()) do
                    print("transferring upgrade 1 to regular")
                    PrintTable(inv:GetItems())
                    print(inv)
                    i:Transfer(inventory:GetID())
                end

                ibInvID = inventory:GetID()
                char:SetData("itemBankInvID", ibInvID) --Saving Inventory ID
            end)
        end
    end

    netstream.Start(ply, "OpenItemBank", ibInvID)
end)