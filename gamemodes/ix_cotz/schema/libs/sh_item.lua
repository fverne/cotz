-- adds support for "throw away" option
function ix.item.Register(uniqueID, baseID, isBaseItem, path, luaGenerated)
	local meta = ix.meta.item

	if uniqueID then
		ITEM = (isBaseItem and ix.item.base or ix.item.list)[uniqueID] or setmetatable({}, meta)
		ITEM.uniqueID = uniqueID
		ITEM.base = baseID or ITEM.base
		ITEM.isBase = isBaseItem
		ITEM.hooks = ITEM.hooks or {}
		ITEM.postHooks = ITEM.postHooks or {}
		ITEM.functions = ITEM.functions or {}
		ITEM.functions.throwaway = ITEM.functions.throwaway
			or {
				tip = "throwawayTip",
				icon = "icon16/world.png",
				OnRun = function(item)
					local success, error = item:Transfer(nil, nil, nil, item.player)

					if not success and isstring(error) then
						item.player:NotifyLocalized(error)
					else
						item.player:EmitSound(
							"npc/zombie/foot_slide" .. math.random(1, 3) .. ".wav",
							75,
							math.random(90, 120),
							1
						)

						item:GetEntity().bTemporary = true
						item:SetData("bTemporary", true)
					end

					return false
				end,
				OnCanRun = function(item)
					return not IsValid(item.entity) and not item.noDrop
				end,
			}
		ITEM.functions.drop = ITEM.functions.drop
			or {
				tip = "dropTip",
				icon = "icon16/world.png",
				OnRun = function(item)
					local success, error = item:Transfer(nil, nil, nil, item.player)

					if not success and isstring(error) then
						item.player:NotifyLocalized(error)
					else
						item.player:EmitSound(
							"npc/zombie/foot_slide" .. math.random(1, 3) .. ".wav",
							75,
							math.random(90, 120),
							1
						)
					end

					return false
				end,
				OnCanRun = function(item)
					return not IsValid(item.entity) and not item.noDrop
				end,
			}
		ITEM.functions.take = ITEM.functions.take
			or {
				tip = "takeTip",
				icon = "icon16/box.png",
				OnRun = function(item)
					local client = item.player
					local success, error =
						item:Transfer(client:GetCharacter():GetInventory():GetID(), nil, nil, client)

					if not success then
						client:NotifyLocalized(error or "unknownError")

						return false
					else
						client:EmitSound(
							"npc/zombie/foot_slide" .. math.random(1, 3) .. ".wav",
							75,
							math.random(90, 120),
							1
						)

						if item.data then -- I don't like it but, meh...
							for k, v in pairs(item.data) do
								item:SetData(k, v)
							end
						end
					end

					return true
				end,
				OnCanRun = function(item)
					return IsValid(item.entity)
				end,
			}

		local oldBase = ITEM.base

		if ITEM.base then
			local baseTable = ix.item.base[ITEM.base]

			if baseTable then
				for k, v in pairs(baseTable) do
					if ITEM[k] == nil then
						ITEM[k] = v
					end

					ITEM.baseTable = baseTable
				end

				local mergeTable = table.Copy(baseTable)
				ITEM = table.Merge(mergeTable, ITEM)
			else
				ErrorNoHalt(
					"[Helix] Item '" .. ITEM.uniqueID .. "' has a non-existent base! (" .. ITEM.base .. ")\n"
				)
			end
		end

		if PLUGIN then
			ITEM.plugin = PLUGIN.uniqueID
		end

		if not luaGenerated and path then
			ix.util.Include(path)
		end

		if ITEM.base and oldBase ~= ITEM.base then
			local baseTable = ix.item.base[ITEM.base]

			if baseTable then
				for k, v in pairs(baseTable) do
					if ITEM[k] == nil then
						ITEM[k] = v
					end

					ITEM.baseTable = baseTable
				end

				local mergeTable = table.Copy(baseTable)
				ITEM = table.Merge(mergeTable, ITEM)
			else
				ErrorNoHalt(
					"[Helix] Item '" .. ITEM.uniqueID .. "' has a non-existent base! (" .. ITEM.base .. ")\n"
				)
			end
		end

		ITEM.description = ITEM.description or "noDesc"
		ITEM.width = ITEM.width or 1
		ITEM.height = ITEM.height or 1
		ITEM.category = ITEM.category or "misc"

		if ITEM.OnRegistered then
			ITEM:OnRegistered()
		end

		(isBaseItem and ix.item.base or ix.item.list)[ITEM.uniqueID] = ITEM

		if IX_RELOADED then
			-- we don't know which item was actually edited, so we'll refresh all of them
			for _, v in pairs(ix.item.instances) do
				if v.uniqueID == uniqueID then
					ix.util.MetatableSafeTableMerge(v, ITEM)
				end
			end
		end
		if luaGenerated then
			return ITEM
		else
			ITEM = nil
		end
	else
		ErrorNoHalt("[Helix] You tried to register an item without uniqueID!\n")
	end
end

-- Schema override of the Helix method: keep hideout persistence hooks
-- here so the upstream framework remains unchanged.
if SERVER then
	function ix.item.PerformInventoryAction(client, action, item, invID, data)
		local character = client:GetCharacter()

		if not character then
			return
		end

		local inventory = ix.item.inventories[invID or 0]

		if hook.Run("CanPlayerInteractItem", client, action, item, data) == false then
			return
		end

		if not inventory:OnCheckAccess(client) then
			return
		end

		if isentity(item) then
			if IsValid(item) then
				local entity = item
				local itemID = item.ixItemID
				item = ix.item.instances[itemID]

				if not item then
					return
				end

				item.entity = entity
				item.player = client
			else
				return
			end
		elseif isnumber(item) then
			item = ix.item.instances[item]

			if not item then
				return
			end

			item.player = client
		end

		if item.entity then
			if item.entity:GetPos():Distance(client:GetPos()) > 96 then
				return
			end
		elseif not inventory:GetItemByID(item.id) then
			return
		end

		if not item.bAllowMultiCharacterInteraction and IsValid(client) and client:GetCharacter() then
			local itemPlayerID = item:GetPlayerID()
			local itemCharacterID = item:GetCharacterID()
			local playerID = client:SteamID64()
			local characterID = client:GetCharacter():GetID()

			if
				itemPlayerID
				and itemCharacterID
				and itemPlayerID == playerID
				and itemCharacterID ~= characterID
			then
				client:NotifyLocalized("itemOwned")

				item.player = nil
				item.entity = nil

				return
			end
		end

		local callback = item.functions[action]

		if callback then
			if callback.OnCanRun and callback.OnCanRun(item, data) == false then
				item.entity = nil
				item.player = nil

				return
			end

			hook.Run("PlayerInteractItem", client, action, item)

			local entity = item.entity
			local result

			if item.hooks[action] then
				result = item.hooks[action](item, data)
			end

			if result == nil then
				result = callback.OnRun(item, data)
			end

			if item.postHooks[action] then
				-- Posthooks shouldn't override the result from OnRun
				item.postHooks[action](item, result, data)
			end

			if result ~= false then
				hook.Run("OnItemActionCompleted", client, action, item, entity)
				if IsValid(entity) then
					entity.ixIsSafe = true
					entity:Remove()
				else
					item:Remove()
				end
			end

			item.entity = nil
			item.player = nil

			return result ~= false
		end
	end
end
