PLUGIN.name = "Safebox"
PLUGIN.author = "STEAM_0:1:29606990"
PLUGIN.description = "Personal storage of items for players."

ix.config.Add("safeInvWidth", 5, "How many slots in a row there is in a safebox inventory.", nil, {
	data = {min = 0, max = 20},
	category = PLUGIN.name
})

ix.config.Add("safeInvHeight", 5, "How many slots in a column there is in a safebox inventory.", nil, {
	data = {min = 0, max = 20},
	category = PLUGIN.name
})

ix.config.Add("safeboxOpenTime", 0.5, "How long it takes to open a safebox.", nil, {
	data = {min = 0, max = 50, decimals = 1},
	category = PLUGIN.name
})

ix.config.Add("safeEnableMoney", true, "Allow money transfer.", nil, {
	category = PLUGIN.name
})

ix.safebox = ix.safebox or {}
ix.util.Include("sv_plugin.lua")

function PLUGIN:InitializedPlugins()
	ix.inventory.Register("safebox", ix.config.Get("safeInvWidth"), ix.config.Get("safeInvHeight"))
end

if (CLIENT) then
	net.Receive("ixSafeboxOpen", function()
		if (IsValid(ix.gui.menu)) then
			return
		end

		local client = LocalPlayer()
		local character = client:GetCharacter()

		if (!character) then
			return
		end

		local index = character:GetData("safeboxID")
		local inventory = ix.inventory.Get(index)

		if (inventory and inventory.slots) then
			local localInventory = character:GetInventory()
			local panel = vgui.Create("ixStorageView")

			local allowMoney = ix.config.Get("safeEnableMoney")

			if (localInventory) then
				panel:SetLocalInventory(localInventory)

				if (allowMoney) then
					panel:SetLocalMoney(character:GetMoney())
				end
			end

			panel:SetStorageID(index)
			panel:SetStorageInventory(inventory)

			if (allowMoney) then
				panel:SetStorageMoney(character:GetData("safeboxMoney", 0))

				panel.storageMoney.OnTransfer = function(_, amount)
					net.Start("ixSafeboxMoneyTake")
						net.WriteUInt(amount, 32)
					net.SendToServer()
				end

				panel.localMoney.OnTransfer = function(_, amount)
					net.Start("ixStorageMoneyGive")
						net.WriteUInt(amount, 32)
					net.SendToServer()
				end

				panel.Think = function(this)
					local money = character:GetMoney()

					if (this.localMoney:GetMoney() ~= money) then
						this.localMoney:SetMoney(money)
					end

					money = character:GetData("safeboxMoney", 0)

					if (this.storageMoney:GetMoney() ~= money) then
						this.storageMoney:SetMoney(money)
					end
				end
			end
		end
	end)
end