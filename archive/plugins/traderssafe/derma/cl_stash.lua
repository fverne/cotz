local PANEL = {}
	function PANEL:Init()
		if (IsValid(ix.gui.stash)) then
			ix.gui.stash:Remove()
		end

		ix.gui.stash = self

		self:SetSize(ScrW() * 0.5, 680)
		self:MakePopup()
		self:Center()

		self.stash = self:Add("nutStashItemList")
		self.stash:Dock(LEFT)
		self.stash:SetWide(self:GetWide() * 0.5 - 7)
		self.stash:SetDrawBackground(true)
		self.stash:DockMargin(0, 0, 5, 0)
		self.stash.action:SetText(L"Withdraw")
		
		local upgrade = self.stash:Add("DButton")
		upgrade:Dock(TOP)
		upgrade:SetText(L"Upgrade stash.")
		upgrade.DoClick = function()
		Derma_Query(Format("Increase storage capacity by 2. It will cost you %s.", ix.currency.Get(LocalPlayer():GetCharacter():getUpgradeCost())), L"Upgrade", L"yes", function()
				netstream.Start("stashUpgrade")
			end, L"no")
		end
		

		self.inv = self:Add("nutStashItemList")
		self.inv:Dock(RIGHT)
		self.inv:SetWide(self:GetWide() * 0.5 - 7)
		self.inv:SetDrawBackground(true)
		self.inv.title:SetText(LocalPlayer():Name())
		self.inv.action:SetText(L"Deposit")

		self.stash.action.DoClick = function()
			local selectedItem = ix.gui.stash.activeItem

			if (IsValid(selectedItem)) then
				-- transfer items.
				netstream.Start("stashOut", selectedItem.indexID)
			end
		end

		self.inv.action.DoClick = function()
			local selectedItem = ix.gui.stash.activeItem

			if (IsValid(selectedItem)) then
				if LocalPlayer():GetCharacter():getNumStash() < LocalPlayer():GetCharacter():getMaxStash() then
					netstream.Start("stashIn", selectedItem.indexID, true)
				else
					ix.util.Notify("Your stash is full!")
				end
			end
		end
	end

	function PANEL:setStash()		
		self.stash.title.Think = function()
			self.stash.title:SetText(L("Trader's Stash", 0, 50).." ("..LocalPlayer():GetCharacter():getNumStash().."/"..LocalPlayer():GetCharacter():getMaxStash()..")")
		end
		self.stash.items:Clear()
		self.inv.items:Clear()

		self:SetTitle(L("stashMenu"))

		for k, v in pairs(LocalPlayer():GetCharacter():GetInventory():GetItems()) do
			if (v.base == "base_bags") or (v.uniqueID == "sattelitephone") then
				continue
			end
			if v.invID == LocalPlayer():GetCharacter():GetInventory():GetID() then
				self.inv:addItem(v.uniqueID, v)
			end
		end

		for k, _ in pairs(LocalPlayer():GetCharacter():getStash()) do
			local item = ix.item.instances[k]
			PrintTable(ix.item.instances)
			PrintTable(LocalPlayer():GetCharacter():getStash())
			
			self.stash:addItem(item.uniqueID, item)
		end
	end

	function PANEL:OnRemove()
		--netstream.Start("vendorExit")
	end
vgui.Register("nutStash", PANEL, "DFrame")

PANEL = {}
	function PANEL:Init()
		self.title = self:Add("DLabel")
		self.title:SetTextColor(color_white)
		self.title:SetExpensiveShadow(1, Color(0, 0, 0, 150))
		self.title:Dock(TOP)
		self.title:SetFont("ixSmallFont")
		self.title:SizeToContentsY()
		self.title:SetContentAlignment(7)
		self.title:SetTextInset(10, 5)
		self.title.Paint = function(this, w, h)
			surface.SetDrawColor(0, 0, 0, 150)
			surface.DrawRect(0, 0, w, h)
		end
		self.title:SetTall(self.title:GetTall() + 10)

		self.items = self:Add("DScrollPanel")
		self.items:Dock(FILL)
		self.items:SetDrawBackground(true)
		self.items:DockMargin(5, 5, 5, 5)

		self.action = self:Add("DButton")
		self.action:Dock(BOTTOM)
		self.action:SetTall(32)
		self.action:SetFont("ixMediumFont")
		self.action:SetExpensiveShadow(1, Color(0, 0, 0, 150))

		self.itemPanels = {}
	end

	function PANEL:addItem(uniqueID, itemObject)
		local itemTable = ix.item.list[uniqueID]

		if (!itemTable) then
			return
		end

		local oldPanel = self.itemPanels[uniqueID]

		local color_dark = Color(0, 0, 0, 80)

		local panel = self.items:Add("DPanel")
		panel:SetTall(36)
		panel:Dock(TOP)
		panel:DockMargin(5, 5, 5, 0)
		panel.Paint = function(this, w, h)
			surface.SetDrawColor(ix.gui.stash.activeItem == this and ix.config.Get("color") or color_dark)
			surface.DrawRect(0, 0, w, h)
		end
		panel.indexID = itemObject:GetID()
		panel.count = count

		panel.icon = panel:Add("SpawnIcon")
		panel.icon:SetPos(2, 2)
		panel.icon:SetSize(32, 32)
		panel.icon:SetModel(itemTable.model, itemTable.skin)

		panel.name = panel:Add("DLabel")
		panel.name:DockMargin(40, 2, 2, 2)
		panel.name:Dock(FILL)
		panel.name:SetFont("ixChatFont")
		panel.name:SetTextColor(color_white)
		panel.name:SetText(itemTable:GetName()..(count and " ("..count..")" or ""))
		panel.name:SetExpensiveShadow(1, Color(0, 0, 0, 150))

		panel.overlay = panel:Add("DButton")
		panel.overlay:SetPos(0, 0)
		panel.overlay:SetSize(ScrW() * 0.25, 36)
		panel.overlay:SetText("")
		panel.overlay.Paint = function() end
		panel.overlay.DoClick = function(this)
			ix.gui.stash.activeItem = panel
		end

		//panel.overlay:SetToolTip(L("itemPriceInfo", nut.currency.get(price), nut.currency.get(price2)))
		self.itemPanels[uniqueID] = panel

		return panel
	end
vgui.Register("nutStashItemList", PANEL, "DPanel") 

netstream.Hook("stashUpdate", function()
	if (ix.gui.stash and ix.gui.stash:IsVisible()) then
		print("UPDATE REQUEST")
	end
end)