ix.busflag = ix.busflag or {}
ix.busflag.list = ix.busflag.list or {}

-- This flag system is primarily for a more advanced and complex business interaction.
-- The idea is to allow multi-character flags, eg "MIL1"
-- This system has no callback support

function ix.busflag.add(flag, name, desc, flagtype, cost, req)
	--flagtype = trader or tech, 1||2
	ix.busflag.list[flag] = {name = name, desc = desc, flagtype = flagtype, cost = cost, req = req }
end

function ix.busflag.getAllWithFlag(flag)
	local returntable = {}

	if !ix.busflag.list[flag] then return end

	for _,v in pairs(ix.item.list) do
		if v.busflag then
			if type(v.busflag) == "table" then
				for _,j in pairs(v.busflag) do
					if j == flag then
						table.insert(returntable, v)
					end
				end
			else
				if v.busflag == flag then
					table.insert(returntable, v)
				end
			end
		end
	end

	return returntable
end

do

	local character = ix.meta.character

	if (SERVER) then

		function character:resetBusFlags()
			self:SetData("busflags", {})
		end

		function character:setBusFlags(flags)
			self:SetData("busflags", flags)
		end


		function character:giveBusFlag(flag)
			local flags = self:getBusFlags()

			local info = ix.busflag.list[flag]

			if (info) then
				if (!character:hasBusFlags(flag)) then
					flags[flag] = true
				end
			end

			self:setBusFlags(flags)
		end


		function character:takeBusFlag(flag)
			local flags = self:getBusFlags()

			if flags[flag] then
				flags[flag] = nil
			end

			self:setBusFlags(flags)
		end
	end


	function character:getBusFlags()
		return self:GetData("busflags", {})
	end


	function character:hasBusFlags(flags)
		local charFlags = self:getBusFlags()

		if type(flags) == "table" then
			for k,v in pairs(flags) do
				if charFlags[v] then
					return true
				end
			end
		else
			if charFlags[flags] then
				return true
			end
		end

		return false
	end
end
