ITEM.name = "PAC Outfit"
ITEM.description = "A PAC Outfit Base."
ITEM.longdesc = "No Longer Description Available"
ITEM.category = "Outfit"
ITEM.model = "models/Gibs/HGIBS.mdl"
ITEM.width = 2
ITEM.height = 2
ITEM.pacData = {}
ITEM.br = 0
ITEM.fbr = 0
ITEM.ar = 0
ITEM.far = 0
ITEM.radProt = 0
ITEM.resistance = true
ITEM.isHelmet = nil
ITEM.isGasmask = nil
ITEM.equipIcon = Material("materials/vgui/ui/stalker/misc/equip.png")
ITEM.ballisticlevels = {"0"}
ITEM.ballisticareas = {"  Head:"}
ITEM.ballisticrpgtypes = {"Ballistic (Head)"}
ITEM.anomalousrpgtypes = {"Impact","Burning","Radiation","Chemical","Electrical"}

function ITEM:GetDescription()
	local quant = self:GetData("quantity", 1)
	local str = self.description
	if self.longdesc then
		str = str.."\n"..(self.longdesc or "")
	end

	local customData = self:GetData("custom", {})
	if(customData.desc) then
		str = customData.desc
	end

	if (self.entity) then
		return (self.description .. "\n \nDurability: " .. math.floor(self:GetData("durability", 100)) .. "%")
	else
        return (str)
	end
end

function ITEM:GetName()
	local name = self.name
	
	local customData = self:GetData("custom", {})
	if(customData.name) then
		name = customData.name
	end
	
	return name
end

ITEM.functions.Custom = {
	name = "Customize",
	tip = "Customize this item",
	icon = "icon16/wrench.png",
	OnRun = function(item)		
		ix.plugin.list["customization"]:startCustom(item.player, item)
		
		return false
	end,
	
	OnCanRun = function(item)
		local client = item.player
		return client:GetCharacter():HasFlags("N") and !IsValid(item.entity)
	end
}

ITEM.functions.Inspect = {
	name = "Inspect",
	tip = "Inspect this item",
	icon = "icon16/picture.png",
	OnClick = function(item, test)
		local customData = item:GetData("custom", {})

		local frame = vgui.Create("DFrame")
		frame:SetSize(540, 680)
		frame:SetTitle(item.name)
		frame:MakePopup()
		frame:Center()

		frame.html = frame:Add("DHTML")
		frame.html:Dock(FILL)
		
		local imageCode = [[<img src = "]]..customData.img..[["/>]]
		
		frame.html:SetHTML([[<html><body style="background-color: #000000; color: #282B2D; font-family: 'Book Antiqua', Palatino, 'Palatino Linotype', 'Palatino LT STD', Georgia, serif; font-size 16px; text-align: justify;">]]..imageCode..[[</body></html>]])
	end,
	OnRun = function(item)
		return false
	end,
	OnCanRun = function(item)
		local customData = item:GetData("custom", {})
	
		if(!customData.img) then
			return false
		end
		
		if(item.entity) then
			return false
		end
		
		return true
	end
}

ITEM.functions.Clone = {
	name = "Clone",
	tip = "Clone this item",
	icon = "icon16/wrench.png",
	OnRun = function(item)
		local client = item.player	
	
		client:requestQuery("Are you sure you want to clone this item?", "Clone", function(text)
			if text then
				local inventory = client:GetCharacter():GetInventory()
				
				if(!inventory:Add(item.uniqueID, 1, item.data)) then
					client:Notify("Inventory is full")
				end
			end
		end)
		return false
	end,
	OnCanRun = function(item)
		local client = item.player
		return client:GetCharacter():HasFlags("N") and !IsValid(item.entity)
	end
}

function ITEM:RadProtTranslator(value)
	if value == 0 then
		return "None"
	elseif value <= 0.1 then
		return "Negligible"
	elseif value <= 0.2 then
		return "Bad"
	elseif value <= 0.3 then
		return "Decent"
	elseif value <= 0.4 then
		return "Good"
	elseif value < 0.8 then
		return "Very Good"
	elseif value >= 0.8 then
		return "Excellent"
	end
end

function ITEM:AnomProtTranslator(value)
	if value == 0 then
		return "None"
	elseif value <= 0.02 then
		return "Negligible"
	elseif value <= 0.04 then
		return "Bad"
	elseif value <= 0.06 then
		return "Decent"
	elseif value <= 0.08 then
		return "Good"
	elseif value <= 0.10 then
		return "Very Good"
	elseif value > 0.10 then
		return "Excellent"
	end
end

function ITEM:RPGHelmTranslator(value)
	if tonumber(value) == 0 then
		return "None"
	elseif tonumber(value) <= 4 then
		return "Negligible"
	elseif tonumber(value) <= 8 then
		return "Bad"
	elseif tonumber(value) <= 12 then
		return "Decent"
	elseif tonumber(value) <= 16 then
		return "Good"
	elseif tonumber(value) <= 20 then
		return "Very Good"
	elseif tonumber(value) > 20 then
		return "Excellent"
	end
end

-- Inventory drawing
if (CLIENT) then
	function ITEM:PaintOver(item, w, h)
		if (item:GetData("equip")) then
			surface.SetDrawColor(110, 255, 110, 255)
		else
			surface.SetDrawColor(255, 110, 110, 255)
		end

		surface.SetMaterial(item.equipIcon)
		surface.DrawTexturedRect(w-23,h-23,19,19)

		if (item:GetData("durability")) then
			surface.SetDrawColor( Color( 255, 255, 255, 255 ) )
			surface.DrawOutlinedRect( 7, h - 15, 41, 9 )
			if (item:GetData("durability") > 0) then
				surface.SetDrawColor(110, 255, 110, 100)
				surface.DrawRect(8, h - 14, (item:GetData("durability")/100) * 40, 8)
			else
				surface.SetDrawColor(255, 110, 110, 100)
				surface.DrawRect(8, h - 14, 40, 8)
			end
		end
	end

	function ITEM:PopulateTooltip(tooltip)
		if !self.entity then
			local ballistictitle = tooltip:AddRowAfter("description", "ballistictitle")
			ballistictitle:SetText("\nBALLISTIC PROTECTION LEVELS:")
			ballistictitle:SizeToContents()

			for i = 1, #self.ballisticlevels do				
				local ballisticdesc = tooltip:AddRowAfter("ballistictitle", "ballisticdesc")
				ballisticdesc:SetText(self.ballisticareas[i])
				ballisticdesc:SizeToContents()

				local brighttext = ballisticdesc:Add("DLabel")
				brighttext:MoveRightOf(ballisticdesc)
				brighttext:SetText(self.ballisticlevels[i])
				brighttext:SetContentAlignment(1)
				if self.ballisticlevels[i] == "0" then
					brighttext:SetTextColor(Color(255, 0, 0))
				elseif self.ballisticlevels[i] == "l" then
					brighttext:SetTextColor(Color(255, 80, 0))
				elseif self.ballisticlevels[i] == "ll-a" then
					brighttext:SetTextColor(Color(255, 160, 0))
				elseif self.ballisticlevels[i] == "ll" then
					brighttext:SetTextColor(Color(255, 255, 0))
				elseif self.ballisticlevels[i] == "lll-a" then
					brighttext:SetTextColor(Color(130, 255, 0))
				elseif self.ballisticlevels[i] == "lll" then
					brighttext:SetTextColor(Color(0, 255, 0))
				elseif self.ballisticlevels[i] == "lll+" then
					brighttext:SetTextColor(Color(0, 255, 130))
				elseif self.ballisticlevels[i] == "lV" then
					brighttext:SetTextColor(Color(0, 255, 255))
				elseif self.ballisticlevels[i] == "V" then
					brighttext:SetTextColor(Color(0, 135, 255))
				end
				brighttext:SetFont("ixSmallFont")
			end

			local envirotitle = tooltip:AddRowAfter("ballisticdesc", "envirotitle")
			envirotitle:SetText("\nENVIRONMENTAL PROTECTION LEVELS:")
			envirotitle:SizeToContents()

			local anomalytitle = tooltip:AddRowAfter("envirotitle", "anomalytitle")
			anomalytitle:SetText("  Anomaly:")
			anomalytitle:SizeToContents()

			local arighttext = anomalytitle:Add("DLabel")
			arighttext:MoveRightOf(anomalytitle)
			arighttext:SetText(self:AnomProtTranslator(self.ar or 0))
			arighttext:SetContentAlignment(4)
			arighttext:SetSize(anomalytitle:GetWide(), anomalytitle:GetTall())
			if self:AnomProtTranslator(self.ar or 0) == "None" then
				arighttext:SetTextColor(Color(255, 0, 0))
			elseif self:AnomProtTranslator(self.ar or 0) == "Negligible" then
				arighttext:SetTextColor(Color(255, 80, 0))
			elseif self:AnomProtTranslator(self.ar or 0) == "Bad" then
				arighttext:SetTextColor(Color(255, 160, 0))
			elseif self:AnomProtTranslator(self.ar or 0) == "Decent" then
				arighttext:SetTextColor(Color(255, 255, 0))
			elseif self:AnomProtTranslator(self.ar or 0) == "Good" then
				arighttext:SetTextColor(Color(130, 255, 0))
			elseif self:AnomProtTranslator(self.ar or 0) == "Very Good" then
				arighttext:SetTextColor(Color(0, 255, 0))
			elseif self:AnomProtTranslator(self.ar or 0) == "Excellent" then
				arighttext:SetTextColor(Color(0, 135, 255))
			end
			arighttext:SetFont("ixSmallFont")

			local radtitle = tooltip:AddRowAfter("anomalytitle", "radtitle")
			radtitle:SetText("  Radiation:")
			radtitle:SizeToContents()

			local rrighttext = radtitle:Add("DLabel")
			rrighttext:MoveRightOf(radtitle)
			rrighttext:SetText(self:RadProtTranslator(self.radProt or 0))
			rrighttext:SetContentAlignment(4)
			rrighttext:SetSize(radtitle:GetWide(), radtitle:GetTall())
			rrighttext:SetFont("ixSmallFont")
			if self:RadProtTranslator(self.radProt or 0) == "None" then
				rrighttext:SetTextColor(Color(255, 0, 0))
			elseif self:RadProtTranslator(self.radProt or 0) == "Negligible" then
				rrighttext:SetTextColor(Color(255, 80, 0))
			elseif self:RadProtTranslator(self.radProt or 0) == "Bad" then
				rrighttext:SetTextColor(Color(255, 160, 0))
			elseif self:RadProtTranslator(self.radProt or 0) == "Decent" then
				rrighttext:SetTextColor(Color(255, 255, 0))
			elseif self:RadProtTranslator(self.radProt or 0) == "Good" then
				rrighttext:SetTextColor(Color(130, 255, 0))
			elseif self:RadProtTranslator(self.radProt or 0) == "Very Good" then
				rrighttext:SetTextColor(Color(0, 255, 0))
			elseif self:RadProtTranslator(self.radProt or 0) == "Excellent" then
				rrighttext:SetTextColor(Color(0, 135, 255))
			end

			local rpgdesc = tooltip:AddRowAfter("radtitle", "rpgdesc")
			rpgdesc:SetText("\nRPG VALUES:")
			rpgdesc:SizeToContents()	

			for i = 1, #self.ballisticrpgtypes do
				local rpgballisticdesc = tooltip:AddRowAfter("rpgdesc", "rpgballisticdesc")
				rpgballisticdesc:SetText("  "..self.ballisticrpgtypes[i]..":")
				rpgballisticdesc:SizeToContents()

				local rpgballistictext = rpgballisticdesc:Add("DLabel")
				rpgballistictext:MoveRightOf(rpgballisticdesc)
				rpgballistictext:SetText(" "..self.ballisticrpglevels["head"])
				rpgballistictext:SetContentAlignment(1)
				rpgballistictext:SetFont("ixSmallFont")
				if self:RPGHelmTranslator(self.ballisticrpglevels["head"] or 0) == "None" then
					rpgballistictext:SetTextColor(Color(255, 0, 0))
				elseif self:RPGHelmTranslator(self.ballisticrpglevels["head"] or 0) == "Negligible" then
					rpgballistictext:SetTextColor(Color(255, 80, 0))
				elseif self:RPGHelmTranslator(self.ballisticrpglevels["head"] or 0) == "Bad" then
					rpgballistictext:SetTextColor(Color(255, 160, 0))
				elseif self:RPGHelmTranslator(self.ballisticrpglevels["head"] or 0) == "Decent" then
					rpgballistictext:SetTextColor(Color(255, 255, 0))
				elseif self:RPGHelmTranslator(self.ballisticrpglevels["head"] or 0) == "Good" then
					rpgballistictext:SetTextColor(Color(130, 255, 0))
				elseif self:RPGHelmTranslator(self.ballisticrpglevels["head"] or 0) == "Very Good" then
					rpgballistictext:SetTextColor(Color(0, 255, 0))
				elseif self:RPGHelmTranslator(self.ballisticrpglevels["head"] or 0) == "Excellent" then
					rpgballistictext:SetTextColor(Color(0, 135, 255))
				end
			end

			for i = 1, #self.anomalousrpglevels do
				local rpganomalousdesc = tooltip:AddRowAfter("rpgballisticdesc", "rpganomalousdesc")
				rpganomalousdesc:SetText("  "..self.anomalousrpgtypes[i]..":")
				rpganomalousdesc:SizeToContents()

				local rpganomaloustext = rpganomalousdesc:Add("DLabel")
				rpganomaloustext:MoveRightOf(rpganomalousdesc)
				rpganomaloustext:SetText(" "..self.anomalousrpglevels[i])
				rpganomaloustext:SetContentAlignment(1)
				rpganomaloustext:SetFont("ixSmallFont")
				if self:RPGHelmTranslator(self.anomalousrpglevels[i] or 0) == "None" then
					rpganomaloustext:SetTextColor(Color(255, 0, 0))
				elseif self:RPGHelmTranslator(self.anomalousrpglevels[i] or 0) == "Negligible" then
					rpganomaloustext:SetTextColor(Color(255, 80, 0))
				elseif self:RPGHelmTranslator(self.anomalousrpglevels[i] or 0) == "Bad" then
					rpganomaloustext:SetTextColor(Color(255, 160, 0))
				elseif self:RPGHelmTranslator(self.anomalousrpglevels[i] or 0) == "Decent" then
					rpganomaloustext:SetTextColor(Color(255, 255, 0))
				elseif self:RPGHelmTranslator(self.anomalousrpglevels[i] or 0) == "Good" then
					rpganomaloustext:SetTextColor(Color(130, 255, 0))
				elseif self:RPGHelmTranslator(self.anomalousrpglevels[i] or 0) == "Very Good" then
					rpganomaloustext:SetTextColor(Color(0, 255, 0))
				elseif self:RPGHelmTranslator(self.anomalousrpglevels[i] or 0) == "Excellent" then
					rpganomaloustext:SetTextColor(Color(0, 135, 255))
				end
			end

			local duratitle = tooltip:AddRow("duratitle")
			duratitle:SetText("\nDurability: " .. math.floor(self:GetData("durability", 100)) .. "%")
			duratitle:SizeToContents()
		end
	end
end

function ITEM:OnInstanced()
	self:SetData("durability", 100)
end

function ITEM:RemovePart(client)
	local char = client:GetCharacter()

	self:SetData("equip", false)
	client:RemovePart(self.uniqueID)

	if (self.attribBoosts) then
		for k, _ in pairs(self.attribBoosts) do
			char:RemoveBoost(self.uniqueID, k)
		end
	end

	self:OnUnequipped()
end

-- On item is dropped, Remove a weapon from the player and keep the ammo in the item.
ITEM:Hook("drop", function(item)
	if (item:GetData("equip")) then
		item.player:RecalculateResistances()
		item.player:ReevaluateOverlay()
		item:RemovePart(item.player)
	end
end)

-- On player uneqipped the item, Removes a weapon from the player and keep the ammo in the item.
ITEM.functions.EquipUn = { -- sorry, for name order.
	name = "Unequip",
	tip = "equipTip",
	icon = "icon16/stalker/unequip.png",
	OnRun = function(item)
		item:RemovePart(item.player)

		item.player:RecalculateResistances()
		item.player:ReevaluateOverlay()

		return false
	end,
	OnCanRun = function(item)
		local client = item.player

		return !IsValid(item.entity) and IsValid(client) and item:GetData("equip") == true and
			hook.Run("CanPlayerUnequipItem", client, item) != false and item.invID == client:GetCharacter():GetInventory():GetID()
	end
}

-- On player eqipped the item, Gives a weapon to player and load the ammo data from the item.
ITEM.functions.Equip = {
	name = "Equip",
	tip = "equipTip",
	icon = "icon16/stalker/equip.png",
	OnRun = function(item)
		local char = item.player:GetCharacter()
		local items = char:GetInventory():GetItems()

		for _, v in pairs(items) do
			if (v.id != item.id) then
				local itemTable = ix.item.instances[v.id]

				if (v.isHelmet == true and item.isHelmet == true and itemTable:GetData("equip")) then
					item.player:Notify("You are already equipping a helmet!")

					return false
				end

				if (v.isGasmask == true and item.isGasmask == true and itemTable:GetData("equip")) then
					item.player:Notify("You are already equipping a gasmask!")

					return false
				end
			end
		end

		item:SetData("equip", true)
		item.player:AddPart(item.uniqueID, item)

		if (item.attribBoosts) then
			for k, v in pairs(item.attribBoosts) do
				char:AddBoost(item.uniqueID, k, v)
			end
		end

		item.player:RecalculateResistances()
		item.player:ReevaluateOverlay()

		item:OnEquipped()
		return false
	end,
	OnCanRun = function(item)
		local client = item.player

		return !IsValid(item.entity) and IsValid(client) and item:GetData("equip") != true
	end
}

function ITEM:CanTransfer(oldInventory, newInventory)
	if (newInventory and self:GetData("equip")) then
		return false
	end

	return true
end

function ITEM:OnRemoved()
	local inventory = ix.item.inventories[self.invID]
	local owner = inventory.GetOwner and inventory:GetOwner()

	if (IsValid(owner) and owner:IsPlayer()) then
		if (self:GetData("equip")) then
			self:RemovePart(owner)
		end
	end
end

function ITEM:OnEquipped()
	if self.isGasmask == true then
		self.player:EmitSound("stalkersound/gasmask_on.ogg")
		return
	end
	self:GetOwner():GetCharacter():setRPGValues()
end

function ITEM:OnUnequipped()
	if self.isGasmask == true then
		self.player:EmitSound("stalkersound/gasmask_off.ogg")
		return
	end
	self:GetOwner():GetCharacter():setRPGValues()
end


function ITEM:getBR() 
	local res = self.br
	local upgrades = self:GetData("upgrades", {})
	
	for k,v in pairs(upgrades) do
		if upgrades[v].br ~= nil then
			res = res + upgrades[v].br
		end
	end
	
	return res
end

function ITEM:getFBR() 
	local res = self.fbr
	local upgrades = self:GetData("upgrades", {})
	
	for k,v in pairs(upgrades) do
		if upgrades[v].fbr ~= nil then
			res = res + upgrades[v].fbr
		end
	end
	
	return res
end

function ITEM:getAR()
	local res = self.ar
	local upgrades = self:GetData("upgrades", {})
	
	for k,v in pairs(upgrades) do
		if v.ar ~= nil then
			res = res + upgrades[v].ar
		end
	end

	return res
end

function ITEM:getFAR() 
	local res = self.far
	local upgrades = self:GetData("upgrades", {})
	
	for k,v in pairs(upgrades) do
		if upgrades[v].far ~= nil then
			res = res + upgrades[v].far
		end
	end
	
	return res
end

function ITEM:pacAdjust(pacdata, client)
	
	if (client:GetModel() == "models/nasca/stalker/male_berill1.mdl") then
		print(client:GetModel())
		client:Notify("berill1")
    	return self.pacDataBerill1
	elseif (client:GetModel() == "models/nasca/stalker/male_expedition.mdl") then
    	print(client:GetModel())
	  	client:Notify("expedition")
	   	return self.pacDataExpedition
	elseif (client:GetModel() == "models/nasca/stalker/male_nbc_lone.mdl" or client:GetModel() == "models/nasca/stalker/male_nbc_mono.mdl" or client:GetModel() == "models/nasca/stalker/male_nbc_free.mdl" or client:GetModel() == "models/nasca/stalker/male_nbc_duty.mdl") then
    	print(client:GetModel())
	  	client:Notify("nbc")
	   	return self.pacDataNBC
    /*elseif (client:GetModel() == "models/nasca/stalker/male_eagle_lone.mdl" or client:GetModel() == "models/nasca/stalker/male_eagle_bandit.mdl" or client:GetModel() == "models/nasca/stalker/male_eagle_duty.mdl" or client:GetModel() == "models/nasca/stalker/male_eagle_free.mdl" or client:GetModel() == "models/nasca/stalker/male_eagle_merc.mdl") then
    	print(client:GetModel())
    	client:Notify("eagle")
    	return self.pacDataEagle*/
    else
    	print(client:GetModel())
    	client:Notify("generic")
    	return self.pacData
	end
end