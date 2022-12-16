ix.discordrelay = ix.discordrelay or {}

function ix.discordrelay.RelayChatToDiscord(name, text)
    local name = name or "Unknown"
    local text = text or "Unintelligible"
	local avatar_url = "https://cdn2.steamgriddb.com/file/sgdb-cdn/icon/22b1cd168ec628442b3d4dc00fca434b/32/256x256.png"

	HTTP({
		url = ix.config.Get("webUrl"),
		method = "POST",
		body = util.TableToJSON({
			content = text,
			username = name,
			avatar_url = avatar_url
		}),
		headers = {
			['Content-Type'] = 'application/json',
			['accept'] = '*/*'
		},
		type = "application/json; charset=utf-8",
		success = function (code, body, headers) end,
		failed = function( err ) end
	})
end