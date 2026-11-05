local PLUGIN = PLUGIN
local ROLE_ORDER = {"container", "vendor", "exit", "spawn", "storage"}
local UI = ix.cotzUI
local openFrame

net.Receive("cotz/hideouts/marker", function()
	local entity = net.ReadEntity()
	if not IsValid(entity) then return end
	if IsValid(openFrame) then openFrame:Remove() end
	local frame, body = UI.Frame("Hideout template marker", 0.55, 0.65, 720)
	openFrame = frame
	local function label(text)
		return UI.Label(body, text)
	end
	label("Place and rotate this marker with the physgun, then include it in the shell dupe. "
		.. "Utilities use its exact position and angles. Spawn markers mark the player's feet and facing direction.")
	local role = body:Add("DComboBox")
	role:Dock(TOP)
	UI.SetHeight(role, 34)
	UI.StyleCombo(role)
	for _, id in ipairs(ROLE_ORDER) do
		role:AddChoice(PLUGIN.markerRoles[id].name, id, id == entity:GetMarkerRole())
	end
	label("Permanent container slot ID (unique in this dupe). Keep it when moving or resaving a container.")
	local slot = UI.StyleEntry(body:Add("DTextEntry"))
	slot:Dock(TOP)
	UI.SetHeight(slot, 34)
	slot:SetText(entity:GetSlotID())
	slot:SetUpdateOnType(true)
	label("Container upgrade recipe")
	local recipe = body:Add("DComboBox")
	recipe:Dock(TOP)
	UI.SetHeight(recipe, 34)
	UI.StyleCombo(recipe)
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
	local save = UI.StyleButton(frame:Add("DButton"))
	save:Dock(BOTTOM)
	UI.SetHeight(save, 34)
	save:SetText("Save marker settings")
	function save:DoClick()
		if not IsValid(entity) or (self.nextSave or 0) > CurTime() then return end
		local _, roleID = role:GetSelected()
		local _, recipeID = recipe:GetSelected()
		local ok, reason = PLUGIN:ValidateMarkerSettings(roleID, slot:GetValue(), recipeID)
		if not ok then UI.Message(reason, "Hideout marker", "OK") return end
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
