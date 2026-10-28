ix.npcbarter = ix.npcbarter or {}
ix.npcbarter.barterdict = ix.npcbarter.barterdict or {}
ix.npcbarter.activebarters = ix.npcbarter.activebarters or {}

function ix.npcbarter.GetActiveBartersForNPC(character, npcName)
	local ret = {}
	if not ix.progression.CanUseNPC(character, npcName) then
		return ret
	end

	for barterid, _ in pairs(ix.npcbarter.barterdict[npcName] or {}) do
		local barter = ix.npcbarter.barterdict[npcName][barterid]
		if ix.npcbarter.activebarters[barterid]
			and not (ix.taskRewards and ix.taskRewards.IsLegacyKit(barter.barterItem[1])) then
			table.insert(ret, barterid)
		end
	end

	return ret
end

if SERVER then
	function ix.npcbarter.ConsumeItems(ply, item, cnt)
		local available = 0
		for _, entry in pairs(ply:GetCharacter():GetInventory():GetItems()) do
			if entry.uniqueID == item then
				available = available + entry:GetData("quantity", entry.quantity or 1)
			end
		end
		if available < cnt then return false end
		local itemstoremove = {}
		local itemsfound = 0

		for _, v in pairs(ply:GetCharacter():GetInventory():GetItems()) do
			if v.uniqueID == item then
				local itemquant = v:GetData("quantity", v.quantity or 1)
				local itemquantdif = itemquant - (cnt - itemsfound)
				if itemquantdif > 0 then -- item has enough quant to satisfy condition, break
					v:SetData("quantity", itemquant - (cnt - itemsfound))
					itemsfound = itemsfound + (cnt - itemsfound)
					break
				else
					itemsfound = itemsfound + itemquant
					table.insert(itemstoremove, v)
				end
			end
		end

		if itemsfound == cnt then
			for _, v in pairs(itemstoremove) do
				v:Remove()
			end

			return true
		else
			-- No items consumed

			return false
		end
	end

	function ix.npcbarter.SetActive(barterid, active)
		if ix.npcbarter.barterdict[barterid] then
			ix.npcbarter.activebarters[barterid] = tobool(active)
		end
	end
else
	function ix.npcbarter.TryExecuteBarter(npcName, barterid, item)
		net.Start("npcbarter_execute")
		net.WriteString(npcName)
		net.WriteString(barterid)
		net.WriteString(item)
		net.SendToServer()
	end
end

-- Network functions
-- For syncing active barters
if CLIENT then
	net.Receive("npcbarter_sync_receive", function(len)
		local tbl = net.ReadTable()

		ix.npcbarter.activebarters = tbl
	end)

	net.Receive("npcbarter_execute_confirmation", function(len)
		local str = net.ReadString()

		if str then
			LocalPlayer():Notify(str)
		end
	end)
else
	util.AddNetworkString("npcbarter_sync")
	util.AddNetworkString("npcbarter_sync_receive")
	util.AddNetworkString("npcbarter_execute")
	util.AddNetworkString("npcbarter_execute_confirmation")

	net.Receive("npcbarter_sync", function(len, pl)
		net.Start("npcbarter_sync_receive")
		net.WriteTable(ix.npcbarter.activebarters)
		net.Send(pl)
	end)

	net.Receive("npcbarter_execute", function(len, pl)
		local npcName = net.ReadString()
		local barterid = net.ReadString()
		local item = net.ReadString()

		local character = pl:GetCharacter()
		if not character or not ix.progression.CanUseNPC(character, npcName) then
			return
		end
		local nearby = false
		for _, vendor in ipairs(ents.FindByClass("ix_vendor_adv")) do
			if
				vendor:GetDisplayName() == npcName
				and vendor:CanAccess(pl)
				and pl:GetPos():DistToSqr(vendor:GetPos()) <= 192 * 192
			then
				nearby = true
				break
			end
		end
		if not nearby then
			return
		end
		local isbarteractive = ix.npcbarter.activebarters[barterid]

		local out = "No such barter exists."

		if
			isbarteractive
			and ix.npcbarter.barterdict[npcName]
			and ix.npcbarter.barterdict[npcName][barterid]
		then
			local barterdict = ix.npcbarter.barterdict[npcName][barterid]
			local cnt = 0
			local rewardItem = barterdict.barterItem
			if ix.taskRewards and ix.taskRewards.IsLegacyKit(rewardItem[1]) then return end

			if barterdict.reqItem[1] == item then
				cnt = barterdict.reqItem[2] or 1
			end

			if cnt > 0 then
				if ix.npcbarter.ConsumeItems(pl, item, cnt) then
					for _ = 1, cnt do
						ix.dialogue.notifyItemLost(pl, ix.item.list[barterdict.reqItem[1]].name)
					end
					rewardCnt = rewardItem[2] or 1
					for _ = 1, rewardCnt do
						if
							pl:GetCharacter()
							and not pl:GetCharacter()
								:GetInventory()
								:Add(rewardItem[1], 1, rewardItem[3] or {})
						then
							ix.item.Spawn(
								rewardItem[1],
								pl:GetItemDropPos(),
								nil,
								AngleRand(),
								rewardItem[3] or {}
							)
							pl:Notify("No space in your inventory! Items have been dropped.")
						end
						ix.dialogue.notifyItemGet(pl, ix.item.list[rewardItem[1]].name)
					end
					-- pl:GetCharacter():GetInventory():Add(rewardItem[1], rewardCnt, rewardItem[3] or {})
					-- - old one (items disappear when the inventory is full)

					out = "Successfully bartered "
						.. cnt
						.. "x "
						.. ix.item.list[item].name
						.. " to "
						.. rewardCnt
						.. "x "
						.. ix.item.list[rewardItem[1]].name
						.. "."
				else
					out = "Not enough " .. ix.item.list[item].name .. " in inventory."
				end
			end
		end

		net.Start("npcbarter_execute_confirmation")
		net.WriteString(out)
		net.Send(pl)
	end)
end
