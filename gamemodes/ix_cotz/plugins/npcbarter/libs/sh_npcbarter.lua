ix.npcbarter = ix.npcbarter or {}
ix.npcbarter.barterdict = ix.npcbarter.barterdict or {}
ix.npcbarter.activebarters = ix.npcbarter.activebarters or {}

function ix.npcbarter.GetActiveBartersForNPC(npcname)
	local ret = {}

	for barterid,_ in pairs(ix.npcbarter.barterdict[npcname]) do
		if(ix.npcbarter.activebarters[barterid]) then
			table.insert(ret, barterid)
		end
	end

	return ret
end

if SERVER then
	function ix.npcbarter.ConsumeItems(ply, item, cnt)
		local itemstoremove = {}
		local itemsfound = 0

		for k,v in pairs(ply:GetCharacter():GetInventory():GetItems()) do
			if (v.uniqueID == item) then
				local itemquant = v:GetData("quantity", v.quantity or 1)
				local itemquantdif = itemquant - (cnt - itemsfound)
				if(itemquantdif > 0) then -- item has enough quant to satisfy condition, break
					v:SetData("quantity", itemquant - (cnt - itemsfound))
					itemsfound = itemsfound + (cnt - itemsfound)
					break
				else
					itemsfound = itemsfound + itemquant
					table.insert(itemstoremove, v)
				end
			end
		end

		if ( itemsfound == cnt ) then
			for k,v in pairs(itemstoremove) do
				v:Remove()
			end
			return true
		else
			-- No items consumed
			return false
		end
	end

	function ix.npcbarter.SetActive(barterid, active)
		if (ix.npcbarter.barterdict[barterid]) then
			ix.npcbarter.activebarters[barterid] = ix.progression.status[progid] or {}

			ix.npcbarter.activebarters[barterid] = tobool(active)
		end
	end

else

	function ix.npcbarter.TryExecuteBarter(npcname, barterid, item)

		net.Start("npcbarter_execute")
			net.WriteString(npcname)
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

		if(str)then
			LocalPlayer():Notify(str)
		end
	end)

else
	util.AddNetworkString( "npcbarter_sync" )
	util.AddNetworkString( "npcbarter_sync_receive" )
	util.AddNetworkString( "npcbarter_execute" )
	util.AddNetworkString( "npcbarter_execute_confirmation" )

	net.Receive("npcbarter_sync", function(len, pl)
		net.Start("npcbarter_sync_receive")
			net.WriteTable(ix.npcbarter.activebarters)
		net.Broadcast()
	end)

	net.Receive("npcbarter_execute", function(len, pl)
		local npcname = net.ReadString()
		local barterid = net.ReadString()
		local item = net.ReadString()

		local isbarteractive = ix.npcbarter.activebarters[barterid]

		local out = "No such barter exists."

		if (isbarteractive and ix.npcbarter.barterdict[npcname] and ix.npcbarter.barterdict[npcname][barterid]) then
			local barterdict = ix.npcbarter.barterdict[npcname][barterid]
			local cnt = 0
			local rewardItem = barterdict.barterItem

			for k,v in pairs(barterdict.reqItem)do
				if v[1] == item then
					cnt = v[2] or 1
				end
			end

			if(cnt > 0)then
				if ix.npcbarter.ConsumeItems(pl, item, cnt) then
					rewardCnt = rewardItem[2] or 1
					for i=1,rewardCnt do
						if (pl:GetCharacter() and !pl:GetCharacter():GetInventory():Add(rewardItem[1], 1, rewardItem[3] or {})) then
            				ix.item.Spawn(rewardItem[1], pl:GetItemDropPos(), nil, AngleRand(), rewardItem[3] or {})
            				pl:Notify("Inventory is full! Item is dropped on the ground!")
            			end
            			ix.dialogue.notifyItemGet(pl, ix.item.list[rewardItem[1]].name)
          			end
					--pl:GetCharacter():GetInventory():Add(rewardItem[1], rewardCnt, rewardItem[3] or {}) - old one (items disappear when the inventory is full)

					out = "Successfully bartered "..cnt.."x "..ix.item.list[item].name.." to "..rewardCnt.."x "..ix.item.list[rewardItem[1]].name.."."
				else
					out = "Not enough "..ix.item.list[item].name.." in inventory."
				end
			end
		end

		net.Start("npcbarter_execute_confirmation")
			net.WriteString(out)
		net.Send(pl)
	end)
end
