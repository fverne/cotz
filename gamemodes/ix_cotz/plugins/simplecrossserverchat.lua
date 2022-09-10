
local PLUGIN = PLUGIN

PLUGIN.name = "Simple Cross Server Chat"
PLUGIN.author = "gumlefar"
PLUGIN.description = "A simple system for sharing chat messages over multiple servers."



PLUGIN.lastSeenId = PLUGIN.lastSeenId or 0
PLUGIN.checktime = PLUGIN.checktime or 0
PLUGIN.postTime = PLUGIN.postTime or 0

ix = ix or {}
ix.crossserverchat = ix.crossserverchat or {}
ix.crossserverchat.queue = ix.crossserverchat.queue or {}

ix.chat.Register("gpdainternal", {
	CanSay = function(self, speaker, text)

		return true
	end,
	OnChatAdd = function(self, speaker, text, bAnonymous, data)
		chat.AddText(Color(180,61,61), "[GPDA-"..data.name.."] ", Color(0,241,255), Material(data.icon), ": "..data.message)
	end,
	prefix = {},
	CanHear = function(self, speaker, listener)
		listener:EmitSound( "stalkersound/pda/pda_news.wav", 55, 100, 0.2, CHAN_AUTO )

		return true
	end,
})

if (SERVER) then
	function PLUGIN:Think()
		if self.checktime < CurTime() then 
			self.checktime = CurTime() + 5

			self:CheckForNewData()
		end

		if self.postTime < CurTime() then 
			self.postTime = CurTime() + 1

			self:ProcessTopOfQueue()
		end
	end

	-- Ensures tables exist
	function PLUGIN:LoadTables()
		query = mysql:Create("ix_xserverchat")
		query:Create("id", "INT(11) UNSIGNED NOT NULL AUTO_INCREMENT")
		query:Create("name", "VARCHAR(60)")
		query:Create("icon", "VARCHAR(60)")
		query:Create("text", "TEXT")
		query:Create("sourcemap", "VARCHAR(60)")

		query:PrimaryKey("id")
		query:Execute()
	end

	function PLUGIN:CheckForNewData()
		local query = mysql:Select("ix_xserverchat")
		query:Select("id")
		query:Select("name")
		query:Select("icon")
		query:Select("text")
		query:WhereGT("id", self.lastSeenId)
		query:WhereNotEqual("sourcemap", game.GetMap())

		query:Callback(function(result)
			if (istable(result) and #result > 0) then
				for _, v in pairs(result) do
					if (istable(v)) then
						local id = tonumber(v.id)
						local name = v.name or "Unknown"
						local text = v.text or "<corrupted message>"
						local icon = v.icon or "vgui/icons/news.png"

						if (id > ix.plugin.list["simplecrossserverchat"].lastSeenId) then
							ix.plugin.list["simplecrossserverchat"].lastSeenId = id
						end

						table.insert(ix.crossserverchat.queue, {name, text, icon})
					end
				end
			end
		end)
		query:Execute()
	end


	function PLUGIN:ProcessTopOfQueue()
		if(#ix.crossserverchat.queue > 0)then
			local msg = ix.crossserverchat.queue[1]
			table.remove(ix.crossserverchat.queue, 1)

			ix.chat.Send(nil, "gpdainternal", "", nil, nil, {
				name = msg[1],
				message = msg[2],
				icon = msg[3]
			})
		end
	end

	function PLUGIN:PostMessage(name, text, icon)

		local datatoinsert = {}
		if(not istable(data))then
			data = {data}
		end
		datatoinsert = data

		-- Insert query
		local query = mysql:InsertIgnore("ix_xserverchat")
			query:Insert("name", name)
			query:Insert("text", text)
			query:Insert("icon", icon)
			query:Insert("sourcemap", game.GetMap())
		query:Execute()
		
	end

	ix.crossserverchat.PostMessage = PLUGIN.PostMessage

	function PLUGIN:SaveData()
		self:SetData({["lastseen"] = self.lastSeenId})
	end

	function PLUGIN:LoadData()
		local data = self:GetData()

		self.lastSeenId = data["lastseen"] or 0
		if(SERVER)then
			self:LoadTables()
		end
	end
end