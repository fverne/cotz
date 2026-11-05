
-- luacheck: globals pac pace

-- This Library is just for PAC3 Integration.
-- You must install PAC3 to make this library work.

PLUGIN.name = "PAC3 Integration"
PLUGIN.author = "Black Tea"
PLUGIN.description = "PAC3 integration for item parts."

if (!pace) then return end

ix.pac = ix.pac or {}
ix.pac.list = ix.pac.list or {}

CAMI.RegisterPrivilege({
	Name = "Helix - Manage PAC",
	MinAccess = "superadmin"
})

-- this stores pac3 part information to plugin's table'
function ix.pac.RegisterPart(id, outfit)
	ix.pac.list[id] = outfit
end

-- Fixing the PAC3's default stuffs to fit on Helix.
if (CLIENT) then
	-- Disable the "in editor" HUD element.
	hook.Add("InitializedPlugins", "PAC3Fixer", function()
		hook.Remove("HUDPaint", "pac_in_editor")
	end)

	-- Remove PAC3 LoadParts
	function pace.LoadParts(name, clear, override_part) end

	-- Prohibits players from deleting their own PAC3 outfit.
	concommand.Add("pac_clear_parts", function()
		RunConsoleCommand("pac_restart")
	end)

	-- you need the proper permission to open the editor
	function PLUGIN:PrePACEditorOpen()
		if (!CAMI.PlayerHasAccess(LocalPlayer(), "Helix - Manage PAC", nil)) then
			return false
		end
	end
end

function PLUGIN:pac_CanWearParts(client)
	if (!CAMI.PlayerHasAccess(client, "Helix - Manage PAC", nil)) then
		return false
	end
end

local meta = FindMetaTable("Player")

-- Get Player's PAC3 Parts.
function meta:GetParts()
	if (!pac) then return end

	return self:GetNetVar("parts", {})
end

if (SERVER) then
	util.AddNetworkString("ixPartWear")
	util.AddNetworkString("ixPartRemove")
	util.AddNetworkString("ixPartReset")
	util.AddNetworkString("cotz/gear-appearance/pac-ready")

	function meta:AddPart(uniqueID, item)
		if (!pac) then return end

		local curParts = self:GetParts()

		local descriptor = true
		if item and ix.gearAppearance and ix.gearAppearance.IsSupported(item) then
			descriptor = {itemID = item:GetID(), appearance = ix.gearAppearance.Normalize(item)}
		end
		curParts[uniqueID] = descriptor
		self:SetNetVar("parts", curParts)

		net.Start("ixPartWear")
			net.WriteEntity(self)
			net.WriteString(uniqueID)
			if ix.gearAppearance then
				ix.gearAppearance.WriteDescriptor(descriptor)
			else
				net.WriteBool(false)
			end
		net.Broadcast()
	end

	function meta:RemovePart(uniqueID)
		if (!pac) then return end

		local curParts = self:GetParts()

		-- remove the parts.
		net.Start("ixPartRemove")
			net.WriteEntity(self)
			net.WriteString(uniqueID)
		net.Broadcast()

		curParts[uniqueID] = nil

		self:SetNetVar("parts", curParts)
	end

	function meta:ResetParts()
		if (!pac) then return end

		net.Start("ixPartReset")
			net.WriteEntity(self)
			net.WriteTable(self:GetParts())
		net.Broadcast()

		self:SetNetVar("parts", {})
	end

	-- A client can finish loading after the original wear broadcasts were sent.
	net.Receive("cotz/gear-appearance/pac-ready", function(_, client)
		if CurTime() < (client.cotzPACNextSync or 0) then return end
		client.cotzPACNextSync = CurTime() + 5
		for _, wearer in player.Iterator() do
			for uniqueID, descriptor in pairs(wearer:GetParts() or {}) do
				net.Start("ixPartWear")
				net.WriteEntity(wearer)
				net.WriteString(uniqueID)
				if ix.gearAppearance then
					ix.gearAppearance.WriteDescriptor(descriptor)
				else
					net.WriteBool(false)
				end
				net.Send(client)
			end
		end
	end)

	function PLUGIN:PlayerLoadedCharacter(client, curChar, prevChar)
		-- Reset the characters parts.
		local curParts = client:GetParts()

		if (curParts) then
			client:ResetParts()
		end

		-- After resetting all PAC3 outfits, wear all equipped PAC3 outfits.
		if (curChar) then
			local inv = curChar:GetInventory()

			for _, v in pairs(inv:GetItems()) do
				if (v:GetData("equip") == true and v.pacData) then
					client:AddPart(v.uniqueID, v)
				end
			end
		end
	end

	function PLUGIN:PlayerSwitchWeapon(client, oldWeapon, newWeapon)
		local oldItem = IsValid(oldWeapon) and oldWeapon.ixItem
		local newItem = IsValid(newWeapon) and newWeapon.ixItem

		if (oldItem and oldItem.isWeapon and oldItem:GetData("equip") and oldItem.pacData) then
			oldItem:WearPAC(client)
		end

		if (newItem and newItem.isWeapon and newItem.pacData) then
			newItem:RemovePAC(client)
		end
	end

	-- Hides PAC parts when a player enters observer.
	function PLUGIN:OnPlayerObserve(client, state)
		local curParts = client:GetParts()

		-- Remove all the parts
		if (curParts) then
			client:ResetParts()
		end

		-- If exiting of observer, re-add all parts.
		if (!state) then
			local character = client:GetCharacter()
			local inventory = character:GetInventory()

			for _, v in pairs(inventory:GetItems()) do
				if (v:GetData("equip") == true and v.pacData) then
					client:AddPart(v.uniqueID, v)
				end
			end
		end
	end
else
	local attached = setmetatable({}, {__mode = "k"})
	local syncRetries, syncQueued = 0, false

	local function requestSync()
		net.Start("cotz/gear-appearance/pac-ready")
		net.SendToServer()
	end

	local function retrySync()
		if syncQueued or syncRetries >= 3 then return end
		syncQueued = true
		syncRetries = syncRetries + 1
		-- Entity creation may lag behind a reliable wear message during a late join.
		timer.Simple(5.1, function()
			syncQueued = false
			if pac and IsValid(pac.LocalPlayer) then requestSync() end
		end)
	end

	local function RemovePart(client, uniqueID)
		local parts = attached[client]
		local entry = parts and parts[uniqueID]
		local tree = entry and entry.tree or ix.pac.list[uniqueID]
		if parts then parts[uniqueID] = nil end
		if tree and isfunction(client.RemovePACPart) then client:RemovePACPart(tree) end
	end

	local function AttachPart(client, uniqueID, descriptor)
		if not IsValid(client) then return end
		local itemTable = ix.item.list[uniqueID]
		local pacData = ix.pac.list[uniqueID]
		if not pacData then return end
		attached[client] = attached[client] or {}
		local previous = attached[client][uniqueID]
		if previous then RemovePart(client, uniqueID) end
		if itemTable and itemTable.pacAdjust then
			pacData = itemTable:pacAdjust(table.Copy(pacData), client)
		end
		if type(descriptor) == "table" and itemTable and ix.gearAppearance then
			local key = client:EntIndex() .. ":" .. descriptor.itemID
			pacData = ix.gearAppearance.BuildPAC(itemTable, descriptor.appearance, key, pacData)
		end
		local entry = {tree = pacData}
		attached[client][uniqueID] = entry
		if isfunction(client.AttachPACPart) then
			client:AttachPACPart(pacData)
		else
			pac.SetupENT(client)
			timer.Simple(0.1, function()
				if IsValid(client) and attached[client] and attached[client][uniqueID] == entry
					and isfunction(client.AttachPACPart) then
					client:AttachPACPart(pacData)
				end
			end)
		end
	end

	hook.Add("Think", "ix_pacupdate", function()
		if (!pac) then
			hook.Remove("Think", "ix_pacupdate")
			return
		end

		if (IsValid(pac.LocalPlayer)) then
			for _, v in player.Iterator() do
				local character = v:GetCharacter()

				if (character) then
					local parts = v:GetParts()

					for k2, descriptor in pairs(parts) do
						AttachPart(v, k2, descriptor)
					end
				end
			end

			requestSync()
			hook.Remove("Think", "ix_pacupdate")
		end
	end)

	net.Receive("ixPartWear", function(length)
		if (!pac) then return end

		local wearer = net.ReadEntity()
		local uid = net.ReadString()
		local descriptor = true
		if ix.gearAppearance then descriptor = ix.gearAppearance.ReadDescriptor() end
		if not descriptor then return end
		if not IsValid(wearer) then retrySync() return end

		if (!wearer.pac_owner) then
			pac.SetupENT(wearer)
		end

		AttachPart(wearer, uid, descriptor)
	end)

	net.Receive("ixPartRemove", function(length)
		if (!pac) then return end

		local wearer = net.ReadEntity()
		local uid = net.ReadString()
		if not IsValid(wearer) then return end

		if (!wearer.pac_owner) then
			pac.SetupENT(wearer)
		end

		RemovePart(wearer, uid)
	end)

	net.Receive("ixPartReset", function(length)
		if (!pac) then return end

		local wearer = net.ReadEntity()
		local uidList = net.ReadTable()
		if not IsValid(wearer) then return end

		if (!wearer.pac_owner) then
			pac.SetupENT(wearer)
		end

		for k, _ in pairs(uidList) do
			RemovePart(wearer, k)
		end
	end)

	function PLUGIN:DrawPlayerRagdoll(entity)
		local ply = entity.objCache

		if (IsValid(ply)) then
			if (!entity.overridePAC3) then
				if ply.pac_parts then
					for _, part in pairs(ply.pac_parts) do
						if part.last_owner and part.last_owner:IsValid() then
							hook.Run("OnPAC3PartTransferred", part)
							part:SetOwner(entity)
							part.last_owner = entity
						end
					end
				end
				ply.pac_playerspawn = pac.RealTime -- used for events

				entity.overridePAC3 = true
			end
		end
	end

	function PLUGIN:OnEntityCreated(entity)
		local class = entity:GetClass()

		-- For safe progress, I skip one frame.
		timer.Simple(0.01, function()
			if (class == "prop_ragdoll") then
				if (entity:GetNetVar("player")) then
					entity.RenderOverride = function()
						entity.objCache = entity:GetNetVar("player")
						entity:DrawModel()

						hook.Run("DrawPlayerRagdoll", entity)
					end
				end
			end

			if (class:find("HL2MPRagdoll")) then
				for _, v in player.Iterator() do
					if (v:GetRagdollEntity() == entity) then
						entity.objCache = v
					end
				end

				entity.RenderOverride = function()
					entity:DrawModel()

					hook.Run("DrawPlayerRagdoll", entity)
				end
			end
		end)
	end

	function PLUGIN:DrawCharacterOverview()
		if (!pac) then
			return
		end

		if (LocalPlayer().pac_outfits) then
			pac.RenderOverride(LocalPlayer(), "opaque")
			pac.RenderOverride(LocalPlayer(), "translucent", true)
		end
	end

	function PLUGIN:DrawHelixModelView(panel, ent)
		if (!pac) then
			return
		end

		if (LocalPlayer():GetCharacter()) then
			pac.RenderOverride(ent, "opaque")
			pac.RenderOverride(ent, "translucent", true)
		end
	end
end

function PLUGIN:InitializedPlugins()
	local items = ix.item.list

	for _, v in pairs(items) do
		if (v.pacData) then
			ix.pac.list[v.uniqueID] = v.pacData
		end
	end
end
