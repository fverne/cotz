local PLUGIN = PLUGIN

PLUGIN.name = "Check Inventory"
PLUGIN.author = "some faggot"
PLUGIN.desc = "Simple command to check inventory of target player"

ix.command.Add("charcheckinv", {
	adminOnly = true,
	arguments = {
		ix.type.character,
	},
	OnRun = function(self, client, character)
		if character then
			local target = character
			local inventory = target:GetInventory()
		
			if (target and target != client) then
				inventory:Sync(client)
				inventory:AddReceiver(client)
				
				netstream.Start(client, "invCheck", inventory:GetID())
	        elseif target == client then
	        	client:Notify("Can't check yourself")
	        else
	            client:Notify("Player not found")
	        end
	    end
	end
})

ix.command.Add("charcheckmoney", {
	adminOnly = true,
	arguments = {
		ix.type.character,
	},	
	OnRun = function(self, client, character)
		if character then
			local target = character
		
			if (target and target != client) then
				client:Notify("Target has "..ix.currency.Get(target:GetMoney()))
	        elseif target == client then
	        	client:Notify("Can't check yourself")
	        else
	            client:Notify("Player not found")
	        end
	    end
	end
})

if CLIENT then
	netstream.Hook("invCheck", function(index)
		local inventory = ix.item.inventories[index]

		if (inventory and inventory.slots) then
			
			ix.gui.inv1 = vgui.Create("ixInventory")
			ix.gui.inv1:ShowCloseButton(true)
			ix.gui.inv1:SetPos(ScrW()*0.5, ScrH()*0.2)

			local inventory2 = LocalPlayer():GetCharacter():GetInventory()

			if (inventory2) then
				ix.gui.inv1:SetInventory(inventory2)
			end

			local panel = vgui.Create("ixInventory")
			panel:ShowCloseButton(true)
			panel:SetTitle("Checked inventory")
			panel:SetInventory(inventory)
			panel:Center()
			panel:MoveLeftOf(ix.gui.inv1, 4)
			panel:MakePopup()
			panel.OnClose = function(this)
				if (IsValid(ix.gui.inv1) and !IsValid(ix.gui.menu)) then
					ix.gui.inv1:Remove()
				end

				netstream.Start("invCheckExit")
			end

			local oldClose = ix.gui.inv1.OnClose
			ix.gui.inv1.OnClose = function()
				if (IsValid(panel) and !IsValid(ix.gui.menu)) then
					panel:Remove()
				end

				netstream.Start("invCheckExit")
				-- IDK Why. Just make it sure to not glitch out with other stuffs.
				if ix.gui.inv1 then
					ix.gui.inv1.OnClose = oldClose
				end
			end

			ix.gui["inv"..index] = panel
		end
	end)
else
	netstream.Hook("invCheckExit", function(client)
		local entity = client.ixBagEntity

		if (IsValid(entity)) then
			entity.receivers[client] = nil
		end

		client.ixBagEntity = nil
	end)
end