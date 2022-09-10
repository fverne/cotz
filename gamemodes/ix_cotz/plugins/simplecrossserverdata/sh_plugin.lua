
local PLUGIN = PLUGIN

PLUGIN.name = "Simple Cross Server Data"
PLUGIN.author = "gumlefar"
PLUGIN.description = "A simple system for sharing data over multiple servers."



PLUGIN.lastSeenData = PLUGIN.lastSeenData or 0
PLUGIN.checktime = PLUGIN.checktime or 0

ix.util.Include("sh_callbacks.lua")

if (SERVER) then
	function PLUGIN:Think()
		if self.checktime > CurTime() then return end
		self.checktime = CurTime() + 15

		self:CheckForNewData()

	end

	-- Ensures tables exist
	function PLUGIN:LoadTables()
		query = mysql:Create("ix_xserverdata")
		query:Create("key", "VARCHAR(60) NOT NULL")
		query:Create("json_data", "TEXT DEFAULT NULL")
		query:Create("timestamp", "BIGINT")

		query:PrimaryKey("key")
		query:Execute()
	end

	function PLUGIN:CheckForNewData()
		local query = mysql:Select("ix_xserverdata")
		query:Select("key")
		query:Select("json_data")
		query:Select("timestamp")
		query:WhereGT("timestamp", self.lastSeenData)

		query:Callback(function(result)
			if (istable(result) and #result > 0) then
				for _, v in pairs(result) do
					if (istable(v)) then
						local key = v.key
						local data = util.JSONToTable(v.json_data or "[]")
						local timestamp = tonumber(v.timestamp)

						if (timestamp > ix.plugin.list["simplecrossserverdata"].lastSeenData) then
							ix.plugin.list["simplecrossserverdata"].lastSeenData = timestamp
						end

						ix.crossserverdata.callback(key, data)
					end
				end
			end
		end)
		query:Execute()
	end


	function PLUGIN:SetXServerData(key, data)

		local datatoinsert = {}
		if(not istable(data))then
			data = {data}
		end
		datatoinsert = data

		local selectquery = mysql:Select("ix_xserverdata")
			selectquery:Select("key")
			selectquery:Callback(function(result) 
				if(istable(result) and #result > 0)then
					-- Update query
					local query = mysql:Update("ix_xserverdata")
					query:Update("json_data", util.TableToJSON(datatoinsert))
					query:Update("timestamp", os.time())
					query:Where("key", key)
					query:Execute()
				else
					-- Insert query
					local query = mysql:InsertIgnore("ix_xserverdata")
					query:Insert("key", key)
					query:Insert("json_data", util.TableToJSON(datatoinsert))
					query:Insert("timestamp", os.time())
					query:Execute()
				end
			end)
		selectquery:Execute()
		
	end

	function PLUGIN:GetXServerData(key, callback)
		local selectquery = mysql:Select("ix_xserverdata")
			selectquery:Select("json_data")
			selectquery:WhereLike("key", key)
			selectquery:Callback(callback)
		local selectresult = selectquery:Execute()
	end

	function PLUGIN:SaveData()
		self:SetData({["lastseen"] = self.lastSeenData})
	end

	function PLUGIN:LoadData()
		local data = self:GetData()

		self.lastSeenData = data["lastseen"] or 0
		if(SERVER)then
			self:LoadTables()
		end
	end
end