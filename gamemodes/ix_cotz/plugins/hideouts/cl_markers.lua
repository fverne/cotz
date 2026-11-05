local PLUGIN = PLUGIN
local ROLE_ORDER = {"container", "vendor", "exit", "spawn", "storage"}
local openFrame

net.Receive("cotz/hideouts/marker", function()
	local entity = net.ReadEntity()
	if not IsValid(entity) then return end
	if IsValid(openFrame) then openFrame:Remove() end
	local frame = vgui.Create("DFrame")
	openFrame = frame
	frame:SetTitle("Hideout template marker")
	frame:SetSize(ScrW() * 0.36, ScrH() * 0.48)
	frame:Center()
	frame:MakePopup()
	local body = frame:Add("DScrollPanel")
	body:Dock(FILL)
	local function label(text)
		local panel = body:Add("DLabel")
		panel:Dock(TOP)
		panel:DockMargin(8, 6, 8, 6)
		panel:SetText(text)
		panel:SetWrap(true)
		panel:SetAutoStretchVertical(true)
	end
	label("Place and rotate this marker with the physgun, then include it in the shell dupe. "
		.. "Utilities use its exact position and angles. Spawn markers mark the player's feet and facing direction.")
	local role = body:Add("DComboBox")
	role:Dock(TOP)
	role:SetTall(30)
	for _, id in ipairs(ROLE_ORDER) do
		role:AddChoice(PLUGIN.markerRoles[id].name, id, id == entity:GetMarkerRole())
	end
	label("Permanent container slot ID (unique in this dupe). Keep it when moving or resaving a container.")
	local slot = body:Add("DTextEntry")
	slot:Dock(TOP)
	slot:SetTall(30)
	slot:SetText(entity:GetSlotID())
	slot:SetUpdateOnType(true)
	label("Container upgrade recipe")
	local recipe = body:Add("DComboBox")
	recipe:Dock(TOP)
	recipe:SetTall(30)
	for _, id in ipairs({"general", "ammo", "medical"}) do
		recipe:AddChoice(PLUGIN.containerRecipes[id].name, id, id == entity:GetRecipeID())
	end
	local function updateFields(_, _, id)
		slot:SetEnabled(id == "container")
		recipe:SetEnabled(id == "container")
		if id == "container" and slot:GetValue() == "" then
			slot:SetText("storage_" .. entity:EntIndex())
			recipe:ChooseOptionID(1)
		end
	end
	role.OnSelect = updateFields
	updateFields(nil, nil, entity:GetMarkerRole())
	label("Use one exit and vendor, up to 8 spawns and 32 personal containers. "
		.. "Container markers replace the manual container list. Only squad rooms create a vendor; "
		.. "only personal rooms create containers. Legacy recovery storage is optional for old stashes.")
	local save = frame:Add("DButton")
	save:Dock(BOTTOM)
	save:SetTall(34)
	save:SetText("Save marker settings")
	function save:DoClick()
		if not IsValid(entity) or (self.nextSave or 0) > CurTime() then return end
		local _, roleID = role:GetSelected()
		local _, recipeID = recipe:GetSelected()
		local ok, reason = PLUGIN:ValidateMarkerSettings(roleID, slot:GetValue(), recipeID)
		if not ok then Derma_Message(reason, "Hideout marker", "OK") return end
		self.nextSave = CurTime() + 0.5
		net.Start("cotz/hideouts/marker-save")
		net.WriteEntity(entity)
		net.WriteString(roleID)
		net.WriteString(slot:GetValue())
		net.WriteString(recipeID or "")
		net.SendToServer()
		frame:Close()
	end
end)

local previousScreenSizeChanged = PLUGIN.OnScreenSizeChanged
function PLUGIN:OnScreenSizeChanged(...)
	previousScreenSizeChanged(self, ...)
	if IsValid(openFrame) then
		openFrame:SetSize(ScrW() * 0.36, ScrH() * 0.48)
		openFrame:Center()
	end
end
