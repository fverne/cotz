ix.util = ix.util or {}



function ix.util.DoHttpPost(name, text)
    local name = name or "Unknown"
    local text = text or "Unintelligible"

	HTTP({
		url = ix.config.Get("webUrl"),
		method = "POST",
		body = util.TableToJSON({
			content = text,
			charname = name
		}),
		headers = {
			['Content-Type'] = 'application/json',
			['accept'] = '*/*'
		},
		type = "application/json; charset=utf-8",
		success = function (code, body, headers)
			print("IT WORKED " .. body)
		 end,
		failed = function( err ) 
            print("IT DIDNT WORK " .. err)
        end
	})
end