PLUGIN.name = "Save Items"
PLUGIN.author = "Chessnut"
PLUGIN.description = "Saves items that were dropped."

function PLUGIN:LoadData()
	local items = self:GetData()

	if items then
		local idRange = {}
		local info = {}

		for _, v in ipairs(items) do
			idRange[#idRange + 1] = v[1]
			info[v[1]] = { v[2], v[3], v[4] }
		end

		if #idRange > 0 then
			if hook.Run("ShouldDeleteSavedItems") == true then
				-- don't spawn saved item and just delete them.
				local query = mysql:Delete("ix_items")
				query:WhereIn("item_id", idRange)
				query:Execute()

				print("Server Deleted Server Items (does not includes Logical Items)")
			else
				local query = mysql:Select("ix_items")
				query:Select("item_id")
				query:Select("unique_id")
				query:Select("data")
				query:WhereIn("item_id", idRange)
				query:Callback(function(result)
					if istable(result) then
						local loadedItems = {}
						local bagInventories = {}

						for _, v in ipairs(result) do
							local itemID = tonumber(v.item_id)
							local data = util.JSONToTable(v.data or "[]")
							if hook.Run("ShouldRestoreWorldItem", data) == false then
								continue
							end
							local uniqueID = v.unique_id
							local itemTable = ix.item.list[uniqueID]

							if itemTable and itemID then
								local item = ix.item.New(uniqueID, itemID)
								item.data = data or {}

								local itemInfo = info[itemID]
								local position, angles, movable = itemInfo[1], itemInfo[2], true

								if isbool(itemInfo[3]) then
									movable = itemInfo[3]
								end

								local itemEntity = item:Spawn(position, angles)
								itemEntity.ixItemID = itemID

								local physicsObject = itemEntity:GetPhysicsObject()

								if IsValid(physicsObject) then
									physicsObject:EnableMotion(movable)
								end

								item.invID = 0
								loadedItems[#loadedItems + 1] = item

								if item.isBag then
									local invType = ix.item.inventoryTypes[uniqueID]
									bagInventories[item:GetData("id")] = { invType.w, invType.h }
								end
							end
						end

						-- World bags have no current owner, so character loading cannot restore their inventories.
						if not table.IsEmpty(bagInventories) then
							ix.inventory.Restore(bagInventories)
						end

						hook.Run("OnSavedItemLoaded", loadedItems)
					end
				end)
				query:Execute()
			end
		end
	end
end

function PLUGIN:SaveData()
	local items = {}

	for _, v in ipairs(ents.FindByClass("ix_item")) do
		if v.ixItemID and not v.bTemporary and hook.Run("ShouldSaveWorldItem", v) ~= false then
			local physicsObject = v:GetPhysicsObject()
			local movable = nil

			if IsValid(physicsObject) then
				movable = physicsObject:IsMoveable()
			end

			items[#items + 1] = {
				v.ixItemID,
				v:GetPos(),
				v:GetAngles(),
				movable,
			}
		end
	end

	self:SetData(items)
end
