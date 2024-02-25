ix.discordrelay = ix.discordrelay or {}

function ix.discordrelay.RelayChatToDiscord(name, text)
    local name = name or "Unknown"
    local text = text or "Unintelligible"
	local avatar_url = "https://i.imgur.com/gYv1qmH.png"

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
		failed = function( err ) print("Failed to post to Discord, reason: ", err) end
	})

end