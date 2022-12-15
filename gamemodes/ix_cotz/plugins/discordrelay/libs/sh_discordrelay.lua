ix.util = ix.util or {}

-- local function EncodePdaAvatar(path)
--     local avatarFile = file.Read(path)
--     local base64avatar = util.Base64Encode(avatarfile)

--     return base64avatar
-- end

function ix.util.DoHttpPost(name, text)
    local name = name or "Unknown"
    local text = text or "Unintelligible"

	HTTP({
		url = ix.config.Get("webUrl"),
		method = "POST",
		body = {
			content = text,
			charname = name
		},
		type = "application/json",
		success = function (code, body, headers) end,
		failed = function (reason) Msg(reason) end
	})
end