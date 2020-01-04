ITEM.name = "Armor"
ITEM.description = "An Armor Base."
ITEM.category = "Armor"
ITEM.model = "models/Gibs/HGIBS.mdl"
ITEM.width = 1
ITEM.resiAmount = 1
ITEM.height = 1
ITEM.outfitCategory = "model"
ITEM.longdesc = "No Longer Description Available"
ITEM.resistance = true
ITEM.isBodyArmor = true
ITEM.pacData = {}
ITEM.skincustom = {}
ITEM.bgcustom = {}
ITEM.ballisticlevels = {"1", "1", "1", "1", "1", "1", "1"}
ITEM.ballisticareas = {"  Head:", "  Torso:", "  Abdomen:", "  Arms:", "  Legs:", "  Anomaly:", "  Radiation:"}
ITEM.ballisticrpgtypes = {"Ballistic (Body)", "Ballistic (Limb)"}
ITEM.anomalousrpgtypes = {"Impact","Burning","Radiation","Chemical","Electrical"}

ITEM.br = 0
ITEM.fbr = 0
ITEM.ar = 0
ITEM.far = 0
ITEM.radProt = 0
ITEM.equipIcon = Material("materials/vgui/ui/stalker/misc/equip.png")


--[[
-- This will change a player's skin after changing the model. Keep in mind it starts at 0.
ITEM.newSkin = 1
-- This will change a certain part of the model.
ITEM.replacements = {"group01", "group02"}
-- This will change the player's model completely.
ITEM.replacements = "models/manhack.mdl"
-- This will have multiple replacements.
ITEM.replacements = {
	{"male", "female"},
	{"group01", "group02"}
}

-- This will apply body groups.
ITEM.bodyGroups = {
	["blade"] = 1,
	["bladeblur"] = 1
}
]]--

function ITEM:GetDescription()
	local quant = self:GetData("quantity", 1)
	local str = self.description.."\n"..self.longdesc

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
	elseif value <= 0.05 then
		return "Negligible"
	elseif value <= 0.15 then
		return "Bad"
	elseif value <= 0.25 then
		return "Decent"
	elseif value <= 0.35 then
		return "Good"
	elseif value <= 0.45 then
		return "Very Good"
	elseif value > 0.45 then
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
			rrighttext:SetFont("ixSmallFont")

			local rpgdesc = tooltip:AddRowAfter("radtitle", "rpgdesc")
			rpgdesc:SetText("\nRPG VALUES:")
			rpgdesc:SizeToContents()	

			local rpgballisticdesc = tooltip:AddRowAfter("rpgdesc", "rpgballisticdesc")
			rpgballisticdesc:SetText("  "..self.ballisticrpgtypes[1]..":")
			rpgballisticdesc:SizeToContents()

			local rpgballistictext = rpgballisticdesc:Add("DLabel")
			rpgballistictext:MoveRightOf(rpgballisticdesc)
			rpgballistictext:SetText(" "..self.ballisticrpglevels["body"])
			rpgballistictext:SetContentAlignment(1)
			rpgballistictext:SetFont("ixSmallFont")
			if self:RPGSuitTranslator(self.ballisticrpglevels["body"] or 0) == "None" then
				rpgballistictext:SetTextColor(Color(255, 0, 0))
			elseif self:RPGSuitTranslator(self.ballisticrpglevels["body"] or 0) == "Negligible" then
				rpgballistictext:SetTextColor(Color(255, 80, 0))
			elseif self:RPGSuitTranslator(self.ballisticrpglevels["body"] or 0) == "Bad" then
				rpgballistictext:SetTextColor(Color(255, 160, 0))
			elseif self:RPGSuitTranslator(self.ballisticrpglevels["body"] or 0) == "Decent" then
				rpgballistictext:SetTextColor(Color(255, 255, 0))
			elseif self:RPGSuitTranslator(self.ballisticrpglevels["body"] or 0) == "Good" then
				rpgballistictext:SetTextColor(Color(130, 255, 0))
			elseif self:RPGSuitTranslator(self.ballisticrpglevels["body"] or 0) == "Very Good" then
				rpgballistictext:SetTextColor(Color(0, 255, 0))
			elseif self:RPGSuitTranslator(self.ballisticrpglevels["body"] or 0) == "Excellent" then
				rpgballistictext:SetTextColor(Color(0, 135, 255))
			end

			local rpgballisticdesc2 = tooltip:AddRowAfter("rpgballisticdesc", "rpgballisticdesc2")
			rpgballisticdesc2:SetText("  "..self.ballisticrpgtypes[2]..":")
			rpgballisticdesc2:SizeToContents()

			local rpgballistictext2 = rpgballisticdesc2:Add("DLabel")
			rpgballistictext2:MoveRightOf(rpgballisticdesc2)
			rpgballistictext2:SetText(" "..self.ballisticrpglevels["limb"])
			rpgballistictext2:SetContentAlignment(1)
			rpgballistictext2:SetFont("ixSmallFont")
			if self:RPGSuitTranslator(self.ballisticrpglevels["limb"] or 0) == "None" then
				rpgballistictext2:SetTextColor(Color(255, 0, 0))
			elseif self:RPGSuitTranslator(self.ballisticrpglevels["limb"] or 0) == "Negligible" then
				rpgballistictext2:SetTextColor(Color(255, 80, 0))
			elseif self:RPGSuitTranslator(self.ballisticrpglevels["limb"] or 0) == "Bad" then
				rpgballistictext2:SetTextColor(Color(255, 160, 0))
			elseif self:RPGSuitTranslator(self.ballisticrpglevels["limb"] or 0) == "Decent" then
				rpgballistictext2:SetTextColor(Color(255, 255, 0))
			elseif self:RPGSuitTranslator(self.ballisticrpglevels["limb"] or 0) == "Good" then
				rpgballistictext2:SetTextColor(Color(130, 255, 0))
			elseif self:RPGSuitTranslator(self.ballisticrpglevels["limb"] or 0) == "Very Good" then
				rpgballistictext2:SetTextColor(Color(0, 255, 0))
			elseif self:RPGSuitTranslator(self.ballisticrpglevels["limb"] or 0) == "Excellent" then
				rpgballistictext2:SetTextColor(Color(0, 135, 255))
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
				if self:RPGSuitTranslator(self.anomalousrpglevels[i] or 0) == "None" then
					rpganomaloustext:SetTextColor(Color(255, 0, 0))
				elseif self:RPGSuitTranslator(self.anomalousrpglevels[i] or 0) == "Negligible" then
					rpganomaloustext:SetTextColor(Color(255, 80, 0))
				elseif self:RPGSuitTranslator(self.anomalousrpglevels[i] or 0) == "Bad" then
					rpganomaloustext:SetTextColor(Color(255, 160, 0))
				elseif self:RPGSuitTranslator(self.anomalousrpglevels[i] or 0) == "Decent" then
					rpganomaloustext:SetTextColor(Color(255, 255, 0))
				elseif self:RPGSuitTranslator(self.anomalousrpglevels[i] or 0) == "Good" then
					rpganomaloustext:SetTextColor(Color(130, 255, 0))
				elseif self:RPGSuitTranslator(self.anomalousrpglevels[i] or 0) == "Very Good" then
					rpganomaloustext:SetTextColor(Color(0, 255, 0))
				elseif self:RPGSuitTranslator(self.anomalousrpglevels[i] or 0) == "Excellent" then
					rpganomaloustext:SetTextColor(Color(0, 135, 255))
				end
			end

			if self.maxAgi then
				local maxagititle = tooltip:AddRow("maxagititle")
				maxagititle:SetText("\nMaximum Agility when worn: "..self.maxAgi)
				maxagititle:SizeToContents()
			end
			
			local skintitle = tooltip:AddRowAfter("maxagititle", "skintitle")
			skintitle:SetText("\nCurrent skin: "..self:GetData("setSkin", self.newSkin))
			skintitle:SizeToContents()

			local duratitle = tooltip:AddRowAfter("skintitle", "duratitle")
			duratitle:SetText("Durability: " .. math.floor(self:GetData("durability", 100)) .. "%")
			duratitle:SizeToContents()
		end
	end
end

function ITEM:RemoveOutfit(client)
	local character = client:GetCharacter()
	local bgroups = {}

	self:SetData("equip", false)
	if (character:GetData("oldModel" .. self.outfitCategory)) then
		character:SetModel(character:GetData("oldModel" .. self.outfitCategory))
		character:SetData("oldModel" .. self.outfitCategory, nil)
	end

	if (self.newSkin) then
		if (character:GetData("oldSkin" .. self.outfitCategory)) then
			client:SetSkin(character:GetData("oldSkin" .. self.outfitCategory))
			character:SetData("oldSkin" .. self.outfitCategory, nil)
		else
			client:SetSkin(0)
		end
	end

	for k, _ in pairs(self.bodyGroups or {}) do
		local index = client:FindBodygroupByName(k)

		if (index > -1) then
			client:SetBodygroup(index, 0)

			local groups = character:GetData("groups" .. self.outfitCategory, {})

			if (groups[index]) then
				groups[index] = nil
				character:SetData("groups" .. self.outfitCategory, groups)
			end
		end
	end

	for k, v in pairs( self:GetData("origgroups")) do
		self.player:SetBodygroup( k, v )
		bgroups[k] = v
	end

	self.player:GetCharacter():SetData("groups", bgroups)

	if (self.attribBoosts) then
		for k, _ in pairs(self.attribBoosts) do
			character:RemoveBoost(self.uniqueID, k)
		end
	end

	for k, _ in pairs(self:GetData("outfitAttachments", {})) do
		self:RemoveAttachment(k, client)
	end
	self.player:SetNetVar("ArtiSlots",0)
	self:OnUnequipped()
end

-- makes another outfit depend on this outfit in terms of requiring this item to be equipped in order to equip the attachment
-- also unequips the attachment if this item is dropped
function ITEM:AddAttachment(id)
	local attachments = self:GetData("outfitAttachments", {})
	attachments[id] = true

	self:SetData("outfitAttachments", attachments)
end

function ITEM:RemoveAttachment(id, client)
	local item = ix.item.instances[id]
	local attachments = self:GetData("outfitAttachments", {})

	if (item and attachments[id]) then
		item:OnDetached(client)
	end

	attachments[id] = nil
	self:SetData("outfitAttachments", attachments)
end

function ITEM:OnInstanced()
	self:SetData("durability", 100)
end

local function skinset(item, data)
	if data then
		item.player:SetSkin(data[1])
		item:SetData("setSkin", data[1])
		if data[2] then
			--item.player:GetCharacter():SetModel(data[2])
			item:SetData("setSkinOverrideModel", data[2])
		else
			--item.player:GetCharacter():SetModel(item.replacements)
			item:SetData("setSkinOverrideModel", nil)
		end
	end
	return false
end

ITEM.functions.zCustomizeSkin = {
	name = "Customize Skin",
	tip = "useTip",
	icon = "icon16/stalker/customize.png",
	isMulti = true,
	multiOptions = function(item, client)
		local targets = {}

		for k, v in pairs(item.skincustom) do
			table.insert(targets, {
				name = v.name,
				data = {v.skingroup, v.modelOverride or nil},
			})
		end

		return targets
	end,
	OnCanRun = function(item)				
		return (!IsValid(item.entity) and #item.skincustom > 0 and item:GetData("equip") == true and item:GetOwner():GetCharacter():GetInventory():HasItem("paint") and item:GetOwner():GetCharacter():GetFlags("T"))
	end,
	OnRun = function(item, data)
		if !data[1] then
			return false
		end

		return skinset(item, data)
	end,
}

ITEM:Hook("drop", function(item)
	local client = item.player
	if (item:GetData("equip")) then
		item.player:RecalculateResistances()
		item.player:ReevaluateOverlay()
		item:RemoveOutfit(item:GetOwner())
		item:RemovePart(item.player)
	end
end)

function ITEM:RemovePart(client)
	local char = client:GetCharacter()

	self:SetData("equip", false)
	client:RemovePart(self.uniqueID)

	if (self.attribBoosts) then
		for k, _ in pairs(self.attribBoosts) do
			char:RemoveBoost(self.uniqueID, k)
		end
	end
end

ITEM.functions.EquipUn = { -- sorry, for name order.
	name = "Unequip",
	tip = "equipTip",
	icon = "icon16/stalker/unequip.png",
	OnRun = function(item)
		local client = item.player
				
		item:RemoveOutfit(item.player)
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

ITEM.functions.Equip = {
	name = "Equip",
	tip = "equipTip",
	icon = "icon16/stalker/equip.png",
	OnRun = function(item)
		local client = item.player
		local char = client:GetCharacter()
		local items = char:GetInventory():GetItems()

		for _, v in pairs(items) do
			if (v.id != item.id) then
				local itemTable = ix.item.instances[v.id]

				if (itemTable.pacData and v.outfitCategory == item.outfitCategory and itemTable:GetData("equip")) then
					item.player:Notify("You're already equipping this kind of outfit")

					return false
				end

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

		local origbgroups = {}
		for k, v in ipairs(client:GetBodyGroups()) do
			origbgroups[v.id] = client:GetBodygroup(v.id)
		end
		item:SetData("origgroups", origbgroups)

		item.player:RecalculateResistances()
		item.player:ReevaluateOverlay()

		if (type(item.OnGetReplacement) == "function") then
			char:SetData("oldModel" .. item.outfitCategory, char:GetData("oldModel" .. item.outfitCategory, item.player:GetModel()))
			char:SetModel(item:OnGetReplacement())
		elseif (item.replacement or item.replacements) then
			char:SetData("oldModel" .. item.outfitCategory, char:GetData("oldModel" .. item.outfitCategory, item.player:GetModel()))

			if (type(item.replacements) == "table") then
				if (#item.replacements == 2 and type(item.replacements[1]) == "string") then
					char:SetModel(item.player:GetModel():gsub(item.replacements[1], item.replacements[2]))
				else
					for _, v in ipairs(item.replacements) do
						char:SetModel(item.player:GetModel():gsub(v[1], v[2]))
					end
				end
			else
				char:SetModel(item.replacement or item.replacements)
			end
		end

		if (item.newSkin) then
			char:SetData("oldSkin" .. item.outfitCategory, item.player:GetSkin())
			item.player:SetSkin(item.newSkin)
		end

		if item:GetData("setSkin", nil) != nil then
			client:SetSkin( item:GetData("setSkin", item.newSkin) )
		end

		if (item.bodyGroups) then
			local groups = {}

			for k, value in pairs(item.bodyGroups) do
				local index = item.player:FindBodygroupByName(k)

				if (index > -1) then
					groups[index] = value
				end
			end

			local newGroups = char:GetData("groups", {})

			for index, value in pairs(groups) do
				newGroups[index] = value
				item.player:SetBodygroup(index, value)
			end

			if (table.Count(newGroups) > 0) then
				char:SetData("groups", newGroups)
			end
		end

		if (item.attribBoosts) then
			for k, v in pairs(item.attribBoosts) do
				char:AddBoost(item.uniqueID, k, v)
			end
		end
		item.player:SetNetVar("ArtiSlots",item.artifactcontainers[1])
		item:OnEquipped()
		return false
	end,
	OnCanRun = function(item)
		local client = item.player

		return !IsValid(item.entity) and IsValid(client) and item:GetData("equip") != true and
			hook.Run("CanPlayerEquipItem", client, item) != false and item.invID == client:GetCharacter():GetInventory():GetID()
	end
}

function ITEM:OnLoadout()
	if (self:GetData("equip")) then
		local client = self.player
		if self.newSkin then
			client:SetSkin( self.newSkin )
		end

		if self:GetData("setSkin", nil) != nil then
			client:SetSkin( self:GetData("setSkin", self.newSkin) )
		end

		if self:GetData("setBG", nil) != nil then
			local data = self:GetData("setBG", nil)
			local bgroup = data[1]
			local bgroupsub = data[2]

			for i=1,#bgroup do
				client:SetBodygroup( bgroup[i], bgroupsub[i] )
			end
		end
	end
	self:checkMaxAGI()
end

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
	self:checkMaxAGI()
	self:GetOwner():GetCharacter():setRPGValues()
	self.player:EmitSound("stalkersound/inv_slot.mp3")
end

function ITEM:OnUnequipped()
	self:checkMaxAGI()
	self:GetOwner():GetCharacter():setRPGValues()
	self.player:EmitSound("stalkersound/inv_slot.mp3")
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

function ITEM:RPGSuitTranslator(value)
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

function ITEM:checkMaxAGI() 
	local character = self:GetOwner():GetCharacter()
	local agi = character:GetAttribute("agility", 0)
	
	character:RemoveBoost("maxagiboost", "agility")

	if self.maxAgi then
		if self:GetData("equip") and agi > self.maxAgi then
			character:AddBoost("maxagiboost", "agility", self.maxAgi-agi)
		end
	end
end