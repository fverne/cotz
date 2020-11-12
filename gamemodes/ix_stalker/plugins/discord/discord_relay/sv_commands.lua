
DiscordRelay.CmdPrefix = "^[%$%.!/]"
DiscordRelay.AdminRoles = { -- TODO: Use permission system instead
	["282267464941699072"] = true, -- Boss of this Gym
	["293169922069102592"] = true, -- Colonel
	["284101946158219264"] = true, -- Janitor
	["290498397910073355"] = true, -- Lua
}
function DiscordRelay.IsMemberAdmin(member)
	for roleId, _ in next, DiscordRelay.AdminRoles do
		if DiscordRelay.MemberHasRoleID(member, roleId) then
			return true
		end
	end
	return false
end

local function doEval(func)
	local msg = {}
	local __G = {}
	for i, v in pairs(_G) do __G[i] = v end

	local env = setmetatable(__G, getmetatable(easylua.EnvMeta))
	setfenv(func, env)

	local ret = { pcall(func) }
	local ok = ret[1]
	table.remove(ret, 1)
	if not ok then
		msg = {
			{
				title = "Lua Error:",
				description = tostring(ret[1]),
				color = DiscordRelay.HexColors.Red
			}
		}
		DiscordRelay.SendToDiscordRaw(nil, nil, msg)
		return
	end
	if ret[1] then
		for k, v in next, ret do
			-- TODO: pretty print tables
			ret[k] = tostring(v):gsub("`", "\\`")
		end
		local res = "```lua\n" .. table.concat(ret, "\t") .. "```"
		if #res >= 2000 then
			res = res:sub(1, 1970) .. "```[...]\noutput truncated"
		end
		msg = {
			{
				title = "Result:",
				description = res,
				color = DiscordRelay.HexColors.Purple
			}
		}
	else
		msg = ":white_check_mark:"
	end
	DiscordRelay.SendToDiscordRaw(nil, nil, msg)
end
DiscordRelay.Commands = {
	status = function(msg)
		local time = CurTime()
		local uptime = string.format(":arrows_clockwise: **Uptime**: %.2d:%.2d:%.2d",
			math.floor(CurTime() / 60 / 60), -- hours
			math.floor(CurTime() / 60 % 60), -- minutes
			math.floor(CurTime() % 60) -- seconds
		)
		local players = {}
		for _, ply in next, player.GetAll() do
			players[#players + 1] = ply:Nick()
		end
		players = table.concat(players, ", ")
		DiscordRelay.SendToDiscordRaw(nil, nil, {
			{
				author = {
					name = GetHostName(),
					url = "https://re-dream.org/join",
					icon_url = "https://re-dream.org/media/redream-logo.png"
				},
				description = uptime .. " - :map: **Map**: `" .. game.GetMap() .. "`",
				fields = {
					{
						name = "Players: " .. player.GetCount() .. " / " .. game.MaxPlayers(),
						value = players:Trim() ~= "" and [[```]] .. players .. [[```]] or "It's lonely in here."
					}
				},
				color = DiscordRelay.HexColors.LightBlue
			}
		})
	end,
	l = function(msg, line)
		local admin = DiscordRelay.IsMemberAdmin(msg.author)
		if not admin then
			DiscordRelay.SendToDiscordRaw(nil, nil, {
				{
					title = "No access!",
					color = DiscordRelay.HexColors.Red
				}
			})
			return
		end

		local nick = DiscordRelay.GetMemberNick(msg.author)

		MsgC(COLOR_DISCORD, "[Discord Lua] ", COLOR_MESSAGE, "from ", COLOR_USERNAME, nick .. ": ", COLOR_MESSAGE, line, "\n")
		local print = _G.print
		_G.print = function(...)
			local args = {...}
			if args[1] then
				local str = "```lua\n%s```"
				for k, v in next, args do
					args[k] = tostring(v):gsub("`", "\\`")
				end
				str = str:format(table.concat(args, "\t"))
				if #str >= 2000 then
					str = str:sub(1, 1970) .. "```[...]\noutput truncated"
				end
				DiscordRelay.SendToDiscordRaw(nil, nil, str)
			end
		end
		local func = CompileString("return " .. line, "discord_lua", false)
		if isfunction(func) then
			doEval(func)
		else
			func = CompileString(line, "discord_lua", false)
			if isfunction(func) then
				doEval(func)
			else
				local msg = {
					{
						title = "Lua Error:",
						description = func,
						color = DiscordRelay.HexColors.Red
					}
				}
				DiscordRelay.SendToDiscordRaw(nil, nil, msg)
			end
		end
		_G.print = print
	end,
	ban = function(msg, line)
		if not banni then return end

		local admin = DiscordRelay.IsMemberAdmin(msg.author)
		if not admin then
			DiscordRelay.SendToDiscordRaw(nil, nil, {
				{
					title = "No access!",
					color = DiscordRelay.HexColors.Red
				}
			})
			return
		end

		local args = mingeban.utils.parseArgs(line)
		if not args[1] then
			DiscordRelay.SendToDiscordRaw(nil, nil, "Missing arguments?")
			return
		end

		if not args[2] then
			args[2] = "1d"
		end

		if not args[3] then
			args[3] = "No reason specified"
		end

		RunConsoleCommand("mingeban", "banni", args[1], args[2], args[3])
	end,
	rocket = function(msg, line)
		local admin = DiscordRelay.IsMemberAdmin(msg.author)
		if not admin then
			DiscordRelay.SendToDiscordRaw(nil, nil, {
				{
					title = "No access!",
					color = DiscordRelay.HexColors.Red
				}
			})
			return
		end

		DiscordRelay.SendToDiscordRaw(nil, nil, 'Running rocket command "' .. line .. '"...')

		local t_post = {
			cmd = line
		}
		local t_struct = {
			failed = function(err)
				MsgC(Color(255, 64, 64), "HTTP error: " .. err .. "\n")
			end,
			success = function(code, body, headers)
				local msg
				if code == 500 then
					msg = {
						{
							title = "Internal Error",
							color = DiscordRelay.HexColors.Red
						}
					}
				else
					local desc = "```" .. tostring(body) .. "```"
					if #desc >= 1995 then
						desc = desc:sub(0, 1000) .. "\n[...]\n" .. desc:sub(-995)
					end
					msg = {
						{
							title = 'Rocket command "' .. line .. '" run, result:',
							description = desc,
							color = DiscordRelay.HexColors.Purple
						}
					}
				end
				DiscordRelay.SendToDiscordRaw(nil, nil, msg)
			end,
			method = "POST",
			url = "https://re-dream.org/rcon/bot/index.php",
			parameters = t_post,
			headers = {
				Authorization = "Bot " .. DiscordRelay.BotToken
			}
		}

		HTTP(t_struct)
	end,
	help = function()
		local helpText = {}
		for cmd, _ in next, DiscordRelay.Commands do
			helpText[#helpText + 1] = cmd
		end
		helpText = table.concat(helpText, ", ")
		DiscordRelay.SendToDiscordRaw(nil, nil, {
			{
				title = "Available commands:",
				description = "```" .. helpText .. "```",
				color = DiscordRelay.HexColors.Purple
			}
		})
	end,
	rcon = function(msg, line)
		local admin = DiscordRelay.IsMemberAdmin(msg.author)
		if not admin then
			DiscordRelay.SendToDiscordRaw(nil, nil, {
				{
					title = "No access!",
					color = DiscordRelay.HexColors.Red
				}
			})
			return
		end

		cmd(line)
		DiscordRelay.SendToDiscordRaw(nil, nil, ":white_check_mark:")
	end,
	seen = function(msg, line)
		local ply = mingeban and mingeban.utils.findPlayer(line) or Entity(-1) -- uhh, maybe will change in future???
		ply = type(ply) == 'table' and ply[1] or Entity(-1)
		if IsValid(ply) and type(ply) == 'Player' then
			DiscordRelay.SendToDiscordRaw(nil, nil, {
				{
					title = "Results",
					description = ('```%s is currently online.```'):format(ply:Name()),
					color = DiscordRelay.HexColors.LightBlue
				}
			})
			return
		end

		DiscordRelay.SendToDiscordRaw(nil, nil, {
			{
				title = "Results",
				description = ('```%s```'):format(seen and seen.Compute(line):gsub('``', '`​​`') or 'Something bad happened.'),
				color = DiscordRelay.HexColors.Purple
			}
		})
	end
}

hook.Add("MingebanInitialized", "DiscordRelay_rocketcommand", function()
	local oldRocket = mingeban.GetCommand("rocket").callback

	local rocket = mingeban.CreateCommand({"rocket", "liftoff"}, function(caller, line)
		if IsValid(caller) then
			if line:Trim() == "" then
				oldRocket(caller)
				return
			end

			caller:ChatAddText(Color(155, 255, 64), 'rocket - Running command "' .. line .. '"...')
		end

		Msg"[rocket] "print('Running command "' .. line .. '"...')

		local t_post = {
			cmd = line
		}
		local t_struct = {
			failed = function(err)
				MsgC(Color(255, 64, 64), "HTTP error: " .. err .. "\n")
			end,
			success = function(code, body, headers)
				local msg
				if code == 500 then
					if IsValid(caller) then
						caller:ChatAddText(Color(255, 64, 64), "rocket - 500 Internal Error")
					end

					Msg"[rocket] "MsgC(Color(255, 64, 64), "500 Internal Error\n")
				else
					body = body:gsub("\n", "", 1) -- remove starting newline
					body = "rocket: " .. body

					if IsValid(caller) then
						caller:ChatAddText(Color(155, 255, 64), 'rocket - Command "' .. line .. '" run, result in console')

						for _, line in next, body:Split("\n") do
							caller:PrintMessage(HUD_PRINTCONSOLE, line)
						end
					end

					Msg"[rocket] "print('Command "' .. line .. '" run, result in console')
					MsgC(Color(192, 192, 192), body)
				end
			end,
			method = "POST",
			url = "https://re-dream.org/rcon/bot/index.php",
			parameters = t_post,
			headers = {
				Authorization = "Bot " .. DiscordRelay.BotToken
			}
		}

		HTTP(t_struct)
	end)
end)
if istable(GAMEMODE) and mingeban then
	hook.GetTable().MingebanInitialized["DiscordRelay_rocketcommand"]()
end
