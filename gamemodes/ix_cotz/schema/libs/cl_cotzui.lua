ix.cotzUI = ix.cotzUI or {}
local UI = ix.cotzUI
local fontScale

UI.colors = {
	background = Color(19, 18, 20, 235),
	card = Color(12, 13, 12, 215),
	border = Color(93, 94, 86, 180),
	text = Color(216, 215, 201),
	muted = Color(116, 119, 107),
	green = Color(105, 139, 87),
	teal = Color(73, 140, 143),
	amber = Color(167, 143, 81),
	red = Color(154, 84, 70),
	track = Color(41, 43, 38),
}
local COLORS = UI.colors

local function refreshLayout(panel)
	if panel.cotzRefresh then panel:cotzRefresh() end
	for _, child in ipairs(panel:GetChildren()) do refreshLayout(child) end
end

function UI.Scale(value)
	local scale = math.Clamp(math.min(ScrW() / 1920, ScrH() / 1080), 0.75, 2)
	if fontScale ~= scale then
		fontScale = scale
		for name, size in pairs({Title = 25, Label = 19, Small = 17}) do
			surface.CreateFont("cotzUI" .. name, {
				font = "alsina", size = math.floor(size * scale), weight = 500, extended = true,
			})
		end
	end

	return math.ceil(value * scale)
end

function UI.SetHeight(panel, height)
	panel.cotzRefresh = function(control) control:SetTall(UI.Scale(height)) end
	panel:cotzRefresh()
end

function UI.PaintCard(_, width, height)
	surface.SetDrawColor(COLORS.card)
	surface.DrawRect(0, 0, width, height)
	surface.SetDrawColor(COLORS.border)
	surface.DrawOutlinedRect(0, 0, width, height)
end

function UI.StyleButton(button)
	button:SetFont("cotzUISmall")
	button:SetTextColor(COLORS.text)
	button.Paint = function(control, width, height)
		local disabled = not control:IsEnabled()
		control:SetTextColor(disabled and COLORS.muted or COLORS.text)
		surface.SetDrawColor(control:IsHovered() and not disabled and COLORS.track or COLORS.card)
		surface.DrawRect(0, 0, width, height)
		surface.SetDrawColor(control:IsHovered() and not disabled and COLORS.teal or COLORS.border)
		surface.DrawOutlinedRect(0, 0, width, height)
	end

	return button
end

function UI.StyleEntry(entry)
	entry:SetFont("cotzUISmall")
	entry.Paint = function(control, width, height)
		surface.SetDrawColor(COLORS.card)
		surface.DrawRect(0, 0, width, height)
		surface.SetDrawColor(control:HasFocus() and COLORS.teal or COLORS.border)
		surface.DrawOutlinedRect(0, 0, width, height)
		control:DrawTextEntryText(COLORS.text, COLORS.teal, COLORS.text)
	end

	return entry
end

function UI.StyleScroll(scroll)
	local bar = scroll:GetVBar()
	scroll.cotzRefresh = function() bar:SetWide(UI.Scale(6)) end
	scroll:cotzRefresh()
	bar:SetHideButtons(true)
	bar.Paint = function(_, width, height)
		surface.SetDrawColor(COLORS.track)
		surface.DrawRect(0, 0, width, height)
	end
	bar.btnGrip.Paint = function(_, width, height)
		surface.SetDrawColor(COLORS.border)
		surface.DrawRect(0, 0, width, height)
	end
end

function UI.StyleFrame(frame)
	UI.Scale(1)
	frame.lblTitle:SetFont("cotzUITitle")
	frame.lblTitle:SetTextColor(COLORS.text)
	frame.Paint = function(_, width, height)
		surface.SetDrawColor(COLORS.background)
		surface.DrawRect(0, 0, width, height)
		surface.SetDrawColor(COLORS.border)
		surface.DrawOutlinedRect(0, 0, width, height)
		surface.DrawLine(0, UI.Scale(32), width, UI.Scale(32))
	end
	frame.btnClose:SetText("×")
	UI.StyleButton(frame.btnClose)
	local performLayout = frame.PerformLayout
	frame.PerformLayout = function(control, width, height)
		performLayout(control, width, height)
		local padding, header = UI.Scale(12), UI.Scale(40)
		control:DockPadding(padding, header, padding, padding)
		control.lblTitle:SetPos(padding, 0)
		control.lblTitle:SetSize(width - header - padding * 2, header - UI.Scale(8))
		control.btnClose:SetSize(UI.Scale(26), UI.Scale(24))
		control.btnClose:SetPos(width - UI.Scale(32), UI.Scale(4))
	end

	return frame
end

function UI.Frame(title, widthFraction, heightFraction, maxWidth)
	local frame = UI.StyleFrame(vgui.Create("DFrame"))
	frame:SetTitle(title)
	local function resize(control)
		control.screenWidth, control.screenHeight = ScrW(), ScrH()
		control:SetSize(math.min(ScrW() * widthFraction, UI.Scale(maxWidth)), ScrH() * heightFraction)
		control:Center()
		refreshLayout(control)
		control:InvalidateLayout(true)
		control:InvalidateChildren(true)
	end
	local think = frame.Think
	frame.Think = function(control)
		think(control)
		if control.screenWidth ~= ScrW() or control.screenHeight ~= ScrH() then resize(control) end
	end
	resize(frame)
	frame:MakePopup()
	local scroll = frame:Add("DScrollPanel")
	scroll:SetZPos(1)
	scroll:Dock(FILL)
	UI.StyleScroll(scroll)

	return frame, scroll
end

function UI.Button(parent, text, callback)
	local button = UI.StyleButton(parent:Add("DButton"))
	button:Dock(TOP)
	button.cotzRefresh = function(control)
		control:DockMargin(0, UI.Scale(4), UI.Scale(10), UI.Scale(4))
	end
	button:cotzRefresh()
	button:SetText(text)
	button:SetWrap(true)
	button:SetContentAlignment(5)
	button.DoClick = callback
	local performLayout = button.PerformLayout
	button.PerformLayout = function(control, width, height)
		performLayout(control, width, height)
		local padding = UI.Scale(10)
		local lines = ix.util.WrapText(control:GetText(), math.max(1, width - padding * 2), "cotzUISmall")
		local _, lineHeight = surface.GetTextSize("W")
		local tall = math.max(UI.Scale(34), #lines * lineHeight + padding * 2)
		if control:GetTall() ~= tall then control:SetTall(tall) end
	end
	button:SetTall(UI.Scale(34))

	return button
end

function UI.Label(parent, text, heading)
	UI.Scale(1)
	local label = parent:Add("DLabel")
	label:Dock(TOP)
	label.cotzRefresh = function(control)
		control:DockMargin(0, UI.Scale(8), UI.Scale(10), UI.Scale(8))
	end
	label:cotzRefresh()
	label:SetFont(heading and "cotzUILabel" or "cotzUISmall")
	label:SetTextColor(heading and COLORS.text or COLORS.muted)
	label:SetText(text)
	label:SetWrap(true)
	label:SetAutoStretchVertical(true)

	return label
end

function UI.Card(parent)
	local card = parent:Add("DPanel")
	card:Dock(TOP)
	card.cotzRefresh = function(control)
		local padding = UI.Scale(12)
		control.cotzPadding = padding
		control:DockMargin(0, padding, UI.Scale(10), 0)
		control:DockPadding(padding, padding, padding, padding)
	end
	card:cotzRefresh()
	card.Paint = UI.PaintCard
	card.PerformLayout = function(control)
		local padding = UI.Scale(12)
		if control.cotzPadding ~= padding then control:cotzRefresh() end
		local height = padding * 2
		for _, child in ipairs(control:GetChildren()) do
			local _, top, _, bottom = child:GetDockMargin()
			height = height + child:GetTall() + top + bottom
		end
		if control:GetTall() ~= height then control:SetTall(height) end
	end

	return card
end

function UI.StyleMenu(menu)
	UI.Scale(1)
	menu.Paint = UI.PaintCard
	local addOption = menu.AddOption
	menu.AddOption = function(control, ...)
		return UI.StyleButton(addOption(control, ...))
	end

	return menu
end

function UI.Menu()
	return UI.StyleMenu(DermaMenu())
end

function UI.StyleCombo(combo)
	UI.StyleButton(combo)
	combo.OnMenuOpened = function(_, menu)
		UI.StyleMenu(menu)
		for _, option in ipairs(menu:GetCanvas():GetChildren()) do
			if option:GetClassName() == "DMenuOption" then UI.StyleButton(option) end
		end
		menu:InvalidateLayout(true)
	end

	return combo
end

local function dialog(title, text)
	local frame, body = UI.Frame(title, 0.65, 0.45, 720)
	frame:SetBackgroundBlur(true)
	frame:SetDrawOnTop(true)
	UI.Label(body, text, true)
	local actions = frame:Add("DPanel")
	actions:Dock(BOTTOM)
	UI.SetHeight(actions, 38)
	actions:DockMargin(0, UI.Scale(8), 0, 0)
	actions.Paint = function() end
	frame:DoModal()

	return frame, body, actions
end

local function dialogButton(parent, text, callback)
	local button = UI.StyleButton(parent:Add("DButton"))
	button:Dock(LEFT)
	button:DockMargin(0, 0, UI.Scale(8), 0)
	button:SetText(text)
	button.cotzRefresh = function(control) control:SizeToContentsX(UI.Scale(24)) end
	button:cotzRefresh()
	button.DoClick = callback

	return button
end

function UI.Query(text, title, ...)
	local frame, _, actions = dialog(title, text)
	local options = {...}
	for index = 1, #options, 2 do
		local callback = options[index + 1]
		dialogButton(actions, options[index], function()
			frame:Close()
			if callback then callback() end
		end)
	end

	return frame
end

function UI.StringRequest(title, text, default, onEnter, onCancel)
	local frame, body, actions = dialog(title, text)
	local entry = UI.StyleEntry(body:Add("DTextEntry"))
	entry:Dock(TOP)
	UI.SetHeight(entry, 34)
	entry:SetText(default or "")
	local function accept()
		local value = entry:GetValue()
		frame:Close()
		onEnter(value)
	end
	dialogButton(actions, "OK", accept)
	dialogButton(actions, "Cancel", function()
		local value = entry:GetValue()
		frame:Close()
		if onCancel then onCancel(value) end
	end)
	entry.OnEnter = accept
	entry:RequestFocus()
	entry:SelectAllText(true)

	return frame
end

function UI.Message(text, title, buttonText)
	local frame, _, actions = dialog(title, text)
	dialogButton(actions, buttonText or "OK", function() frame:Close() end)

	return frame
end

function UI.DrawMarker(text, x, y, accent)
	local padding = UI.Scale(6)
	surface.SetFont("cotzUISmall")
	local width, height = surface.GetTextSize(text)
	local lines
	local lineHeight = height
	local maxWidth = ScrW() - padding * 4
	if width > maxWidth then
		lines = ix.util.WrapText(text, maxWidth, "cotzUISmall")
		width, height = maxWidth, #lines * lineHeight
	end
	width, height = width + padding * 2, height + padding * 2
	x = math.Clamp(x - width / 2, padding, ScrW() - width - padding)
	y = math.Clamp(y - height, padding, ScrH() - height - padding)
	surface.SetDrawColor(COLORS.background)
	surface.DrawRect(x, y, width, height)
	surface.SetDrawColor(accent or COLORS.teal)
	surface.DrawOutlinedRect(x, y, width, height)
	if lines then
		for index, line in ipairs(lines) do
			draw.SimpleText(line, "cotzUISmall", x + width / 2, y + padding + (index - 1) * lineHeight,
				COLORS.text, TEXT_ALIGN_CENTER)
		end
	else
		draw.SimpleText(text, "cotzUISmall", x + width / 2, y + height / 2,
			COLORS.text, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end
end
