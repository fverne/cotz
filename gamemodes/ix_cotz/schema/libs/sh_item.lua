
--adds support for "throw away" option
function ix.item.Register(uniqueID, baseID, isBaseItem, path, luaGenerated)
	local meta = ix.meta.item

	if (uniqueID) then
		ITEM = (isBaseItem and ix.item.base or ix.item.list)[uniqueID] or setmetatable({}, meta)
			ITEM.uniqueID = uniqueID
			ITEM.base = baseID or ITEM.base
			ITEM.isBase = isBaseItem
			ITEM.hooks = ITEM.hooks or {}
			ITEM.postHooks = ITEM.postHooks or {}
			ITEM.functions = ITEM.functions or {}
			ITEM.functions.throwaway = ITEM.functions.throwaway or {
				tip = "throwawayTip",
				icon = "icon16/world.png",
				OnRun = function(item)
					local bSuccess, error = item:Transfer(nil, nil, nil, item.player)

					if (!bSuccess and isstring(error)) then
						item.player:NotifyLocalized(error)
					else
						item.player:EmitSound("npc/zombie/foot_slide" .. math.random(1, 3) .. ".wav", 75, math.random(90, 120), 1)
					end

                    item:GetEntity().bTemporary = true
					item:SetData("bTemporary", true)

					return false
				end,
				OnCanRun = function(item)
					return !IsValid(item.entity) and !item.noDrop
				end
			}
			ITEM.functions.drop = ITEM.functions.drop or {
				tip = "dropTip",
				icon = "icon16/world.png",
				OnRun = function(item)
					local bSuccess, error = item:Transfer(nil, nil, nil, item.player)

					if (!bSuccess and isstring(error)) then
						item.player:NotifyLocalized(error)
					else
						item.player:EmitSound("npc/zombie/foot_slide" .. math.random(1, 3) .. ".wav", 75, math.random(90, 120), 1)
					end

					return false
				end,
				OnCanRun = function(item)
					return !IsValid(item.entity) and !item.noDrop
				end
			}
			ITEM.functions.take = ITEM.functions.take or {
				tip = "takeTip",
				icon = "icon16/box.png",
				OnRun = function(item)
					local client = item.player
					local bSuccess, error = item:Transfer(client:GetCharacter():GetInventory():GetID(), nil, nil, client)

					if (!bSuccess) then
						client:NotifyLocalized(error or "unknownError")
						return false
					else
						client:EmitSound("npc/zombie/foot_slide" .. math.random(1, 3) .. ".wav", 75, math.random(90, 120), 1)

						if (item.data) then -- I don't like it but, meh...
							for k, v in pairs(item.data) do
								item:SetData(k, v)
							end
						end
					end

					return true
				end,
				OnCanRun = function(item)
					return IsValid(item.entity)
				end
			}

			local oldBase = ITEM.base

			if (ITEM.base) then
				local baseTable = ix.item.base[ITEM.base]

				if (baseTable) then
					for k, v in pairs(baseTable) do
						if (ITEM[k] == nil) then
							ITEM[k] = v
						end

						ITEM.baseTable = baseTable
					end

					local mergeTable = table.Copy(baseTable)
					ITEM = table.Merge(mergeTable, ITEM)
				else
					ErrorNoHalt("[Helix] Item '"..ITEM.uniqueID.."' has a non-existent base! ("..ITEM.base..")\n")
				end
			end

			if (PLUGIN) then
				ITEM.plugin = PLUGIN.uniqueID
			end

			if (!luaGenerated and path) then
				ix.util.Include(path)
			end

			if (ITEM.base and oldBase != ITEM.base) then
				local baseTable = ix.item.base[ITEM.base]

				if (baseTable) then
					for k, v in pairs(baseTable) do
						if (ITEM[k] == nil) then
							ITEM[k] = v
						end

						ITEM.baseTable = baseTable
					end

					local mergeTable = table.Copy(baseTable)
					ITEM = table.Merge(mergeTable, ITEM)
				else
					ErrorNoHalt("[Helix] Item '"..ITEM.uniqueID.."' has a non-existent base! ("..ITEM.base..")\n")
				end
			end

			ITEM.description = ITEM.description or "noDesc"
			ITEM.width = ITEM.width or 1
			ITEM.height = ITEM.height or 1
			ITEM.category = ITEM.category or "misc"

			if (ITEM.OnRegistered) then
				ITEM:OnRegistered()
			end

			(isBaseItem and ix.item.base or ix.item.list)[ITEM.uniqueID] = ITEM

			if (IX_RELOADED) then
				-- we don't know which item was actually edited, so we'll refresh all of them
				for _, v in pairs(ix.item.instances) do
					if (v.uniqueID == uniqueID) then
						ix.util.MetatableSafeTableMerge(v, ITEM)
					end
				end
			end
		if (luaGenerated) then
			return ITEM
		else
			ITEM = nil
		end
	else
		ErrorNoHalt("[Helix] You tried to register an item without uniqueID!\n")
	end
end