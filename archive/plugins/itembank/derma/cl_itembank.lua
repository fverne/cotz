local PLUGIN = PLUGIN

local function openItemBank(invID)
    local itemBankInventory = ix.item.inventories[invID]
    itemBank = vgui.Create("ixInventory", inventoryframe)
    ownPanel = vgui.Create("ixInventory", inventoryframe)
    ownPanel:SetInventory(LocalPlayer():GetCharacter():GetInventory())
    ownPanel:CenterHorizontal(0.8)
    ownPanel:CenterVertical()
    ownPanel:ShowCloseButton(false)
    ownPanel:MakePopup()

    function ownPanel:Think()
        if (not IsValid(StartingFrame)) then
            ownPanel:MoveToFront()
        end
    end

    itemBank:SetInventory(itemBankInventory)
    itemBank:SetTitle("Item Bank")
    itemBank:ShowCloseButton(true)
    itemBank:CenterHorizontal(0.25)
    itemBank:ShowCloseButton(false)
    itemBank:CenterVertical()
    itemBank:MakePopup()

    function itemBank:Think()
        if (not IsValid(StartingFrame)) then
            itemBank:MoveToFront()
        end
    end

    function itemBank:OnRemove()
        ownPanel:Remove()
    end

    timer.Simple(2, function()
        function ownPanel:OnKeyCodePressed(key)
            if (key == KEY_TAB) then
                inventoryframe:Remove()
            end
        end
    end)
end

netstream.Hook("OpenItemBank", openItemBank)