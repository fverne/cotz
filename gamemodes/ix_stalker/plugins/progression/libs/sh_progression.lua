ix.progression = ix.progression or {}
ix.progression.status = ix.progression.status or {}


function ix.progression.SetProgressionValue(progid, amount, playername)
	if (ix.progression.definitions[progid]) then
		ix.progression.status[progid] = ix.progression.status[progid] or {}

		local preval = ix.progression.status[progid].value or 0

		ix.progression.status[progid].value = amount

		ix.progression.status[progid].contributors = ix.progression.status[progid].contributors or {}
		ix.progression.status[progid].contributors[playername] = ix.progression.status[progid].contributors[playername] or 0
		ix.progression.status[progid].contributors[playername] = ix.progression.status[progid].contributors[playername] + amount

		for level, threshold in pairs(ix.progression.definitions[progid].progressthresholds) do
			if( preval < threshold && ix.progression.status[progid].value >= threshold) then
				ix.progression.InvokeProgressionLevel(progid, level) -- If we pass a threshold, run the function
			end
		end
	end
end

function ix.progression.GetProgressionValue(progid)
	if (ix.progression.definitions[progid]) then
		ix.progression.status[progid] = ix.progression.status[progid] or {}
		ix.progression.status[progid].value = ix.progression.status[progid].value or 0
		return ix.progression.status[progid].value
	end
end

function ix.progression.AddProgessionValue(progid, amount, playername)
	ix.progression.SetProgressionValue(progid, ix.progression.GetProgressionValue(progid) + amount, playername)
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
		if(k >= levelreached) then return end
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