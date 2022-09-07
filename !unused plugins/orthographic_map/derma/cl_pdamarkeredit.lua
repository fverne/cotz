local PANEL = {}

ix.mapicons = {
    [1] = "vgui/icons/stash.png",
    [2] = "vgui/icons/quester.png",
    [3] = "vgui/icons/quest.png",
    [4] = "vgui/icons/quest2.png",
    [5] = "cyanide/pda/vgui/icons/guide.png",
    [6] = "cyanide/pda/vgui/icons/storage2.png",
    [7] = "cyanide/pda/vgui/icons/art.png",
}

function PANEL:Init()
	ix.markerEdit = ix.markerEdit
	self.color_label = Color(255,255,255)
	self.text_label = ix.markers[ix.markerEdit][1] or "Marker"
	self.marker_mat = self.marker_mat or ix.markers[ix.markerEdit or 1][4]
	self.iconSize = math.Round((tonumber(32) / 2160) * ScrH(), 0)

	self:SetSize(ScrW() * 0.5, ScrH() * 0.5)
	self:Center()
	self:MakePopup()
	self:SetTitle("")
	self:MoveToFront()
	

	self.mixer = self:Add("DColorMixer")
	self.mixer:Dock(FILL)
	self.mixer:SetPalette(true)
	self.mixer:SetAlphaBar(true)
	self.mixer:SetWangs(true)
	self:SetData(nil, ix.markers[ix.markerEdit][5])
	self.mixer.ValueChanged = function(_, col)
		self.color_label = col
	end

	self.scroll = vgui.Create("DScrollPanel", self)
	self.scroll:Dock(LEFT)
	self.scroll:SetSize(100,100)

	for k, v in ipairs(ix.mapicons) do
		if (k) then
			local btnMat = Material(v)
			local btn = self.scroll:Add("DButton")
			btn:SetText("")
			btn:SetSize(200, 100)
			btn:Dock(TOP)
			btn:DockMargin(0, 0, 5, 5)
			btn.Paint = function(_, w, h)
				surface.SetDrawColor(0,0,0,255)
				surface.DrawOutlinedRect(0, 0, w, h)
				surface.SetDrawColor( 255, 255, 255, 255 )
				surface.SetMaterial(btnMat)
				surface.DrawTexturedRect(w/2 - 30, h/2 - 30, 60, 60)
			end
			btn.DoClick = function()
				self.marker_mat = v
			end
		end
	end

	self.button_delete = self:Add("DButton")
	self.button_delete:SetText("Delete")
	self.button_delete:SetIcon("icon16/cross.png")
	self.button_delete:Dock(BOTTOM)

	self.button_delete.DoClick = function()
		LocalPlayer():Notify("'"..ix.markers[ix.markerEdit][1].."' has been deleted from your PDA map!") 
		table.remove(ix.markers, ix.markerEdit)

		self:Remove()
	end

	self.button_done = self:Add("DButton")
	self.button_done:SetText("Save")
	self.button_done:SetIcon("icon16/accept.png")
	self.button_done:Dock(BOTTOM)

	self.button_done.DoClick = function()
		local text = self.textEntry:GetValue()
		LocalPlayer():Notify("Saved Marker Edits!") 

		ix.markers[ix.markerEdit][1] = self.text_label 
		ix.markers[ix.markerEdit][4] = self.marker_mat
		ix.markers[ix.markerEdit][5] = self.color_label

		self:Remove()
	end
	
	local btnMat = Material("vgui/icons/stash.png")
	self.label = self:Add("EditablePanel")
	self.label:Dock(BOTTOM)
	self.label:SetSize(64, 64)
	self.label.Paint = function(this, w, h)
		surface.SetDrawColor(ColorAlpha(color_white, 100))
		surface.DrawRect(0, 0, w, h)

		local x, y = w * 0.5, h / 2

		draw.SimpleTextOutlined(self.text_label, "stalkerregularsmallfont2", x - 1, y - self.iconSize, self.color_label, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, color_black)
		surface.SetDrawColor( 255, 255, 255, 255 )
		surface.SetMaterial(Material(self.marker_mat or ix.markers[ix.markerEdit or 1][4]))
		surface.DrawTexturedRect(w/2 - 12, h/2 - 6, 24, 24)
	end

	self.textEntry = self:Add("DTextEntry")
	self.textEntry:SetPlaceholderText("Enter a name for the marker")
	self.textEntry:Dock(BOTTOM)
	self:SetData(ix.markers[ix.markerEdit][1] .. "" .. self.textEntry:GetValue())
	self.textEntry.OnChange = function(this)
		local text = this:GetValue()

		if (#text < 1) then
			text = ""
		end

		self.text_label = text
	end
end

function PANEL:SetData(text, color, index)
	if (color) then
		self.color_label = color
		self.mixer:SetColor(color)
	end

	if (text) then
		self.text_label = text
		self.textEntry:SetValue(text)
	end

	if (index) then
		self.index_label = index
	end
end

function PANEL:Think()
	self:MoveToFront()
	if !IsValid(ix.gui.pdaMap) then
		self:Remove()
	end
end

vgui.Register("ixPDAMapMarkerEdit", PANEL, "DFrame")