local PLUGIN = PLUGIN
ix.lang.AddTable("english", {maps = "Maps"})

local HTML_PREFIX = [=[<!doctype html><html><head><meta charset="utf-8">
<meta http-equiv="Content-Security-Policy"
content="default-src 'none'; img-src asset:; style-src 'unsafe-inline'; script-src 'unsafe-inline'">
<style>
html, body { margin: 0; width: 100%; height: 100%; overflow: hidden; background: #131214; }
img { position: absolute; top: 0; left: 0; width: 100%; height: 100%; object-fit: contain; }
p { color: #d8d7c9; font: 18px sans-serif; padding: 16px; }
</style></head><body><p id="status">Loading map...</p><img src="]=]
local HTML_SUFFIX = [=[" alt="Map image unavailable"
onload="document.getElementById('status').style.display='none'"
onerror="this.style.display='none';document.getElementById('status').textContent='Map image unavailable.'">
</body></html>]=]

local mapImages = {}
local mapViewer
local selectedMapID

function PLUGIN:LoadMapImage(id, url, callback)
	if type(url) ~= "string" or not url:match("^https?://%S+$") then
		callback(nil)

		return
	end

	local entry = mapImages[id]
	if entry and entry.url == url then
		if entry.html then
			callback(entry.html)
		else
			entry.callbacks[#entry.callbacks + 1] = callback
		end

		return
	end

	local directory = "helix/" .. Schema.folder .. "/pda/maps/"
	local cacheKey = directory .. util.SHA256(url)
	local path = cacheKey .. ".png"
	local html = HTML_PREFIX .. "asset://garrysmod/data/" .. path .. HTML_SUFFIX

	-- Convert the previous embedded-image cache without downloading the map again.
	if not file.Exists(path, "DATA") then
		local source = file.Read(cacheKey .. ".txt", "DATA")
		local encoded = source and source:match("^data:image/[%w.+-]+;base64,(.+)$")
		local body = encoded and util.Base64Decode(encoded)
		if body and body ~= "" then
			file.Write(path, body)
		end
	end

	if file.Exists(path, "DATA") then
		mapImages[id] = {url = url, html = html}
		callback(html)

		return
	end

	entry = {url = url, callbacks = {callback}}
	mapImages[id] = entry
	local function finish(html)
		if mapImages[id] == entry then
			if html then
				entry.html = html
			else
				mapImages[id] = nil
			end
		end

		local callbacks = entry.callbacks
		entry.callbacks = nil
		for _, pending in ipairs(callbacks) do pending(html) end
	end

	http.Fetch(url, function(body, _, headers, code)
		if code ~= 200 or body == "" then
			finish(nil)

			return
		end

		local mime = "image/png"
		for key, value in pairs(headers) do
			if key:lower() == "content-type" then
				mime = value:match("^(image/[%w.+-]+)")
				break
			end
		end
		if not mime then
			finish(nil)

			return
		end

		-- Let the browser decode the file, including WebP, without embedding it in SetHTML.
		file.CreateDir(directory)
		file.Write(path, body)
		finish(html)
	end, function()
		finish(nil)
	end)
end

function PLUGIN:PopulateMapMenu(container)
	local maps = self:GetInstalledMaps(LocalPlayer())
	if #maps == 0 then
		ix.cotzUI.Label(container, "Use a map USB to add a map to this menu.")

		return
	end
	local selector = ix.cotzUI.StyleCombo(container:Add("DComboBox"))
	selector:Dock(TOP)
	ix.cotzUI.SetHeight(selector, 34)
	local status = ix.cotzUI.Label(container, "")
	local image = mapViewer
	if not IsValid(image) then
		image = container:Add("DHTML")
		image:SetAllowLua(false)
		image:SetAutoDelete(false)
		mapViewer = image
	else
		image:SetParent(container)
	end
	image:Dock(FILL)
	-- Keep the browser document alive when Helix destroys the menu and its tab containers.
	local originalOnRemove = container.OnRemove
	container.OnRemove = function(panel)
		if IsValid(image) and image:GetParent() == panel then
			image:SetVisible(false)
			image:SetParent(nil)
		end
		if originalOnRemove then originalOnRemove(panel) end
	end
	local selection = 0
	selector.OnSelect = function(_, _, _, id)
		selection = selection + 1
		local request = selection
		local definition = self.maps[id]
		selectedMapID = id
		local url = ix.config.Get(definition.urlConfig, "")
		if image.cotzMapURL == url then
			status:SetVisible(false)
			image:SetVisible(true)

			return
		end
		status:SetText("Loading map...")
		status:SetVisible(true)
		image:SetVisible(false)
		self:LoadMapImage(id, url, function(html)
			if not IsValid(image) or image:GetParent() ~= container or request ~= selection then return end

			status:SetText(html and "" or "No map image is available.")
			status:SetVisible(html == nil)
			image:SetVisible(html ~= nil)
			if html then
				image:SetHTML(html)
				image.cotzMapURL = url
			else
				image.cotzMapURL = nil
			end
		end)
	end
	local selectedIndex = 1
	for index, map in ipairs(maps) do
		selector:AddChoice(map.name, map.id)
		if map.id == selectedMapID then selectedIndex = index end
	end
	selector:ChooseOptionID(selectedIndex)
end

function PLUGIN:CreateMenuButtons(tabs)
	if #self:GetInstalledMaps(LocalPlayer()) == 0 then return end
	tabs["maps"] = function(container)
		self:PopulateMapMenu(container)
	end
end
