ix.progression = ix.progression or {}
ix.progression.status = ix.progression.status or {}


function ix.progression.SetProgressionValue(progid, amount, playername)
	if (ix.progression.definitions[progid]) then
		ix.progression.status[progid] = ix.progression.status[progid] or {}

		local preval = ix.progression.status[progid].value or 0

		ix.progression.status[progid].value = amount

		for level, threshold in pairs(ix.progression.definitions[progid].progressthresholds) do
			if( preval < threshold && ix.progression.status[progid].value >= threshold) then
				ix.progression.InvokeProgressionLevel(progid, level) -- If we pass a threshold, run the function
			end
		end
	end
end

function ix.progression.SetActive(progid, active)
	if (ix.progression.definitions[progid]) then
		ix.progression.status[progid] = ix.progression.status[progid] or {}

		ix.progression.status[progid].active = tobool(active)
	end
end

function ix.progression.IsActive(progid)
	if (ix.progression.definitions[progid]) then
		ix.progression.status[progid] = ix.progression.status[progid] or {}
		if(ix.progression.status[progid].active == nil) then
			if(ix.progression.definitions[progid].defaultActive)then
				ix.progression.status[progid].active = true
			else
				ix.progression.status[progid].active = false
			end
		end

		return ix.progression.status[progid].active
	else
		return false
	end
end

-- Marks progression as completed and inactive.
function ix.progression.SetCompleted(progid)
	if (ix.progression.definitions[progid]) then
		ix.progression.status[progid] = ix.progression.status[progid] or {}
		
		ix.progression.status[progid].active = false
		ix.progression.status[progid].completed = true
	end
end

-- Returns if progression is completed, otherwise false.
function ix.progression.IsCompleted(progid)
	if (ix.progression.definitions[progid]) then
		ix.progression.status[progid] = ix.progression.status[progid] or {}

		return ix.progression.status[progid].completed
	else
		return false
	end
end

function ix.progression.GetProgressionValue(progid)
	if (ix.progression.definitions[progid]) then
		ix.progression.status[progid] = ix.progression.status[progid] or {}
		ix.progression.status[progid].value = ix.progression.status[progid].value or 0
		return ix.progression.status[progid].value
	end
end

function ix.progression.GetActiveProgressions(npcidentifier)
	local ret = {}

	for progid,progstruct in pairs(ix.progression.definitions) do
		if(progstruct.keyNpc == npcidentifier and ix.progression.IsActive(progid)) then
			table.insert(ret, progid)
		end
	end

	return ret
end

function ix.progression.AddProgessionValue(progid, amount, playername)
	if (ix.progression.definitions[progid]) then
		ix.progression.SetProgressionValue(progid, ix.progression.GetProgressionValue(progid) + amount, playername)

		ix.progression.status[progid] = ix.progression.status[progid] or {}

		ix.progression.status[progid].contributors = ix.progression.status[progid].contributors or {}
		ix.progression.status[progid].contributors[playername] = ix.progression.status[progid].contributors[playername] or 0
		ix.progression.status[progid].contributors[playername] = ix.progression.status[progid].contributors[playername] + amount
	end
end

function ix.progression.GetComplexProgressionValue(progid)
	if (ix.progression.definitions[progid]) and ix.progression.definitions[progid].fnGetComplexProgression then
		return ix.progression.definitions[progid].fnGetComplexProgression()
	end
end

function ix.progression.GetComplexProgressionReqs(progid)
	if (ix.progression.definitions[progid]) and ix.progression.definitions[progid].GetItemIds then
		return ix.progression.definitions[progid].GetItemIds()
	end
end

function ix.progression.AddComplexProgressionValue(progid, dat, playername)
	if (ix.progression.definitions[progid]) and ix.progression.definitions[progid].fnAddComplexProgression and ix.progression.definitions[progid].fnCheckComplexProgression then
		 -- In complex progressions, the progression definition is responsible for taking care of everything
		ix.progression.definitions[progid].fnAddComplexProgression(dat, playername)
		ix.progression.definitions[progid].fnCheckComplexProgression()
	end
end

function ix.progression.RemoveProgressionValue(progid, amount, playername)
  ix.progression.AddProgressionValue(progid, -amount, playername)
end

function ix.progression.InvokeProgression(progid)
	local totalprogression = ix.progression.GetProgressionValue(progid)
	local levelreached = 0

	for level, threshold in pairs(ix.progression.definitions[progid].progressthresholds) do
		if(totalprogression >= threshold) then 
			levelreached = level 
		else 
			break
		end
	end

	ix.progression.status[progid].hasfuncrun = ix.progression.status[progid].hasfuncrun or {}

	-- Call all unlocked functions
	for k, func in pairs(ix.progression.definitions[progid].progressfunctions) do
		if(k > levelreached) then return end
		if( func.RunOnce && !(ix.progression.status[progid].hasfuncrun[k] or false)) then
			func:OnRun()
			ix.progression.status[progid].hasfuncrun[k] = true
		elseif (!func.RunOnce) then
			func:OnRun()
			ix.progression.status[progid].hasfuncrun[k] = true
		end
	end
end

function ix.progression.InvokeProgressionLevel(progid, level)

	ix.progression.status[progid].hasfuncrun = ix.progression.status[progid].hasfuncrun or {}

	local func = ix.progression.definitions[progid].progressfunctions[level]
	func:OnRun()
	ix.progression.status[progid] = ix.progression.status[progid] or {}
	ix.progression.status[progid].hasfuncrun = ix.progression.status[progid].hasfuncrun or {}
	ix.progression.status[progid].hasfuncrun[level] = true
	
end

function ix.progression.GetContributors(progid)
	return ix.progression.status[progid].contributors or {}
end

function ix.progression.GetNPCFromName(npcname)
	for _, entity in ipairs(ents.FindByClass("ix_vendor_adv")) do
		if( entity:GetDisplayName() == npcname) then
			return entity
		end
	end

	return nil
end

if CLIENT then
	net.Receive("progression_sync_receive", function(len)
		local tbl = net.ReadTable()

		ix.progression.status = tbl
	end)

else
	util.AddNetworkString( "progression_sync" )
	util.AddNetworkString( "progression_sync_receive" )

	net.Receive("progression_sync", function(len, pl)
		net.Start("progression_sync_receive")
			net.WriteTable(ix.progression.status)
		net.Broadcast()
	end)
end
