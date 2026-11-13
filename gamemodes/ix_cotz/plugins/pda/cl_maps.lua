local PLUGIN = PLUGIN
ix.lang.AddTable("english", {maps = "Maps"})

local HTML_PREFIX = [=[<!doctype html><html><head><meta charset="utf-8">
<meta http-equiv="Content-Security-Policy"
content="default-src 'none'; img-src https: http:; style-src 'unsafe-inline'; script-src 'unsafe-inline'">
<style>
html, body { margin: 0; width: 100%; height: 100%; overflow: hidden; background: #131214; }
img { position: absolute; top: 0; left: 0; width: 100%; height: 100%; object-fit: contain; }
p { color: #d8d7c9; font: 18px sans-serif; padding: 16px; }
</style></head><body><p id="status">Loading map...</p><img src="]=]
local HTML_SUFFIX = [=[" alt="Map image unavailable"
onload="document.getElementById('status').style.display='none'"
onerror="this.style.display='none';document.getElementById('status').textContent='Map image unavailable.'">
</body></html>]=]

function PLUGIN:BuildMapHTML(url)
	if type(url) ~= "string" or not url:match("^https?://%S+$") then return end
	local escaped = url:gsub("&", "&amp;"):gsub("\"", "&quot;"):gsub("<", "&lt;"):gsub(">", "&gt;")

	return HTML_PREFIX .. escaped .. HTML_SUFFIX
end

function PLUGIN:PopulateMapMenu(container)
	local maps = self:GetInstalledMaps(LocalPlayer())
	if #maps == 0 then
		ix.cotzUI.Label(container, "Equip a PDA with an installed map to view Maps.")

		return
	end
	local selector = ix.cotzUI.StyleCombo(container:Add("DComboBox"))
	selector:Dock(TOP)
	ix.cotzUI.SetHeight(selector, 34)
	local status = ix.cotzUI.Label(container, "")
	local image = container:Add("DHTML")
	image:Dock(FILL)
	image:SetAllowLua(false)
	selector.OnSelect = function(_, _, _, id)
		local definition = self.maps[id]
		local html = self:BuildMapHTML(ix.config.Get(definition.urlConfig, ""))
		status:SetText(html and "" or "No map image is available.")
		status:SetVisible(html == nil)
		image:SetVisible(html ~= nil)
		if html then image:SetHTML(html) end
	end
	for _, map in ipairs(maps) do selector:AddChoice(map.name, map.id) end
	selector:ChooseOptionID(1)
end

function PLUGIN:CreateMenuButtons(tabs)
	if #self:GetInstalledMaps(LocalPlayer()) == 0 then return end
	tabs["maps"] = function(container)
		self:PopulateMapMenu(container)
	end
end
