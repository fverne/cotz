ITEM.name = "Attachment"
ITEM.description = "An attachment."
ITEM.category = "Attachments"
ITEM.model = "models/props/cs_office/Cardboard_box02.mdl"
ITEM.upgradeIcon = Material("materials/vgui/ui/stalker/weaponupgrades/genericmod.png")
ITEM.width = 1
ITEM.height = 1
ITEM.attachName = "namegoeshere"
ITEM.busflag = "dev"

local attachments = {}
attachments["md_microt1"] = {name = "Aimpoint Micro T1", slot = 1}
attachments["md_nightforce_nxs"] = {name = "Nightforce NXS", slot = 1}
attachments["md_rmr"] = {name = "Trijicon RMR", slot = 1}
attachments["md_schmidt_shortdot"] = {name = "Schmidt Shortdot", slot = 1}
attachments["md_pso1"] = {name = "PSO-1", slot = 1}
attachments["md_aimpoint"] = {name = "Aimpoint CompM4", slot = 1}
attachments["md_cmore"] = {name = "CMore Railway", slot = 1}
attachments["md_eotech"] = {name = "Eotech Holographic Sight", slot = 1}
attachments["md_reflex"] = {name = "King Arms MR", slot = 1}
attachments["md_kobra"] = {name = "Kobra Sight", slot = 1}
attachments["md_acog"] = {name = "Trijicon ACOG Sight", slot = 1}
attachments["md_pbs1"] = {name = "PBS Supressor", slot = 2}
attachments["md_cobram2"] = {name = "Cobra M2 Suppressor", slot = 2}
attachments["md_tundra9mm"] = {name = "Tundra Supressor", slot = 2}
attachments["md_saker"] = {name = "SAKER Supressor", slot = 2}
attachments["md_foregrip"] = {name = "Foregrip", slot = 3}

ITEM.functions.use = {
	name = "Install",
	tip = "useTip",
	icon = "icon16/stalker/attach.png",
	isMulti = true,
	multiOptions = function(item, client)
		local targets = {}
		local char = client:GetCharacter()         
		
		if (char) then
			local inv = char:GetInventory()

			if (inv) then
				local items = inv:GetItems()

				for k, v in pairs(items) do
					if (v.isWeapon and v.canAttach) then
						table.insert(targets, {
							name = L(v.name),
							data = {v:GetID()},
						})
					else
						continue
					end
				end
			end
		end

		return targets
		end,
	OnCanRun = function(item)				
		return (!IsValid(item.entity))
	end,
	OnRun = function(item, data)
		local client = item.player
		local char = client:GetCharacter()
		local inv = char:GetInventory()
		local items = inv:GetItems()
		local target = data[1]
		
		for k, invItem in pairs(items) do
			if (data[1]) then
				if (invItem:GetID() == data[1]) then
					target = invItem

					break
				end
			else
				client:Notify("No weapon selected.")
				return false
			end
		end
		
		targetAttach = target:GetData("attachments") or {}
		if targetAttach then
			for k = 1, #targetAttach do
				if attachments[targetAttach[k]].slot == item.attachSlot then
					client:Notify("Weapon already has an attachment of this type installed.")
					return false
				end
			end
		end

		for k = 1, #target.validAttachments do
			if target.validAttachments[k] == item.attachName then
				table.Add(targetAttach,{item.attachName})
				target:SetData("attachments", targetAttach)
				client:Notify("Installed "..item.name.." on "..target.name)
				
				local wepon = client:GetWeapon(target.class)
                -- If you're holding right weapon, just mod it out.
                if (IsValid(wepon) and wepon:GetClass() == target.class) then
                    wepon:attachSpecificAttachment(item.attachName)
				end
				return true
			end
		end

		client:Notify(target.name.." does not support this attachment.")
		return false
	end,
}

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