ix.util = ix.util or {}

local function EncodePdaAvatar(path)
    local avatarFile = file.Read(path)
    local base64avatar = util.Base64Encode(avatarfile)

    return base64avatar
end

function ix.util.DoHttpPost(name, text, avatarPath)
    local name = name or "Unknown"
    local text = text or "Unintelligible"
    local avatarPath = avatarPath or "vgui/icons/news.png"

	HTTP({
		url = ix.config.Get("webUrl"),
		method = "POST",
		body = {
			content = text,
			charname = name
			//avatar_url = EncodePdaAvatar(avatarPath)
		},
		success = function (code, body, headers) end,
		failed = function (reason) Msg(reason) end
	})
end