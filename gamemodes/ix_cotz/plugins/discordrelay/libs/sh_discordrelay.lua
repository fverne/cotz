ix.util = ix.util or {}



function ix.util.DoHttpPost(name, text)
    local name = name or "Unknown"
    local text = text or "Unintelligible"

	HTTP({
		url = ix.config.Get("webUrl"),
		method = "POST",
		body = util.TableToJSON({
			content = text,
			username = name
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