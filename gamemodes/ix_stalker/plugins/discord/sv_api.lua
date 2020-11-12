
function DiscordRelay.GetGuild()
	if not DiscordRelay.BotToken or DiscordRelay.BotToken == "" then
		Error("Invalid Bot Token!")
	end

	if not DiscordRelay.DiscordGuildID or DiscordRelay.DiscordGuildID == "" then
		Error("Invalid Guild ID.")
	end

	local t_struct = {
		failed = function(err)
			MsgC(Color(255, 0, 0), "HTTP error: " .. err .. "\n")
		end,
		success = function(code, body, headers)
			DiscordRelay.Guild = util.JSONToTable(body)
		end,
		url = "http://discordapp.com/api/guilds/" .. DiscordRelay.DiscordGuildID,
		method = "GET",
		headers = {
			Authorization = "Bot " .. DiscordRelay.BotToken
		}
	}

	HTTP(t_struct)
end
function DiscordRelay.GetMembers()
	if not DiscordRelay.BotToken or DiscordRelay.BotToken == "" then
		Error("Invalid Bot Token!")
	end

	if not DiscordRelay.DiscordGuildID or DiscordRelay.DiscordGuildID == "" then
		Error("Invalid Guild ID.")
	end

	local t_struct = {
		failed = function(err)
			MsgC(Color(255, 0, 0), "HTTP error: " .. err .. "\n")
		end,
		success = function(code, body, headers)
			DiscordRelay.Members = util.JSONToTable(body)
		end,
		url = "http://discordapp.com/api/guilds/" .. DiscordRelay.DiscordGuildID .. "/members?limit=1000",
		method = "GET",
		headers = {
			Authorization = "Bot " .. DiscordRelay.BotToken
		}
	}

	HTTP(t_struct)
end
local function membersAction(callback)
	if not DiscordRelay.Members then
		DiscordRelay.GetMembers()
		return
	end

	return callback()
end
local function guildAction(callback)
	if not DiscordRelay.Guild then
		DiscordRelay.GetGuild()
		return
	end

	return callback()
end
-- TODO: Separate into other files
function DiscordRelay.GetMemberByID(id)
	return membersAction(function()
		for k, user in next, DiscordRelay.Members do
			if user.user.id == id then
				return user
			end
		end
	end)
end
function DiscordRelay.MemberHasRoleID(member, roleId)
	return membersAction(function()
		for k, user in next, DiscordRelay.Members do
			if user.user.id == member.id then
				for k, role in next, user.roles do
					if role:match(roleId) then
						return true
					end
				end
			end
		end
		return false
	end)
end
function DiscordRelay.GetMemberNick(member)
	local username = member.username
	membersAction(function()
		for _, user in next, DiscordRelay.Members do
			if user.user.username == username and user.nick then
				username = user.nick
			end
		end
	end)
	return username
end

