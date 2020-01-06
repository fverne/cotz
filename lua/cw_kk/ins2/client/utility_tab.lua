
// Content Status

local CCSectionBuilder = {}

CCSectionBuilder.icm = CustomizableWeaponry_KK.ins2.isContentMounted4
CCSectionBuilder.iconOk = "icon16/tick.png"
CCSectionBuilder.iconNOk = "icon16/cross.png"
CCSectionBuilder.iconEh = "icon16/error.png"
CCSectionBuilder.colOk = Color(0,150,0)
CCSectionBuilder.colNOk = Color(200,0,0)
CCSectionBuilder.colEh = Color(200,130,0)

function CCSectionBuilder:_individualLabelDockMargin(label)
	label:DockMargin(16,0,16,0)
end

function CCSectionBuilder:_packLabelDockMargin(panel)
	panel:DockMargin(8,0,8,0)
end

// content packs
function CCSectionBuilder:_addLineBaseGame(panel)
	local ok = self.icm({Folder = "weapons/baseGameContentOK"})
	local label = panel:AddControl("Label", {Text =
		(ok and "[OK]" or "[MISSING]") ..
		" INS2 / INS2-DS content"
	})

	self:_individualLabelDockMargin(label)
	label:SetTextColor(ok and self.colOk or self.colNOk)
end

function CCSectionBuilder:_addLineAO5Mod(panel)
	local ok = self.icm({Folder = "weapons/ao5ModContentOK"})
	local label = panel:AddControl("Label", {Text =
		(ok and "[OK]" or "[MISSING]") ..
		" AO5 content"
	})

	self:_individualLabelDockMargin(label)
	label:SetTextColor(ok and self.colOk or self.colNOk)
end

function CCSectionBuilder:_addLineDOIGame(panel)
	local ok = self.icm({Folder = "weapons/doiGameContentOK"})
	local label = panel:AddControl("Label", {Text =
		(ok and "[OK]" or "[MISSING]") ..
		" DOI / DOI-DS content"
	})

	self:_individualLabelDockMargin(label)
	label:SetTextColor(ok and self.colOk or self.colNOk)
end

function CCSectionBuilder:_addLineNamMod(panel)
	local ok = self.icm({Folder = "weapons/namModContentOK"})
	local recOk = self.icm({Folder = "weapons/doiNamModContentOK"})
	local label = panel:AddControl("Label", {Text =
		(ok and (recOk and "[OK]" or "[DOI edition recmndd]") or "[MISSING]") ..
		" B2K content"
	})

	self:_individualLabelDockMargin(label)
	label:SetTextColor(ok and (recOk and self.colOk or self.colEh) or self.colNOk)
end

function CCSectionBuilder:_addLineEXTPack(panel)
	local ok = self.icm({Folder = "weapons/extPackContentOK"})
	local label = panel:AddControl("Label", {Text =
		(ok and "[OK]" or
		(CustomizableWeaponry_KK.ins2.ws and "[OUTDATED]" or "[MISSING]")) ..
		" EXT Pack content"
	})

	self:_individualLabelDockMargin(label)
	label:SetTextColor(ok and self.colOk or self.colNOk)
end

function CCSectionBuilder:_addLineDOIWW1Mod(panel)
	local ok = self.icm({Folder = "weapons/doiWW1ModContentOK"})
	local label = panel:AddControl("Label", {Text =
		(ok and "[OK]" or "[MISSING]") ..
		" SS content"
	})

	self:_individualLabelDockMargin(label)
	label:SetTextColor(ok and self.colOk or self.colNOk)
end

// weapon packs
function CCSectionBuilder:_addSectionBase(panel)
	local backgroundPanel = vgui.Create("DPanel", panel)
	self:_packLabelDockMargin(backgroundPanel)
	panel:AddItem(backgroundPanel)

		local icon
		icon = vgui.Create("DImage", backgroundPanel)
		icon:SetPos(5,2)
		icon:SetSize(16,16)

		if self.icm({Folder = "weapons/cw_kk_ins2_base"}) then
			icon:SetImage(self.iconOk)
		else
			icon:SetImage(self.iconNOk)
			self:_addLineBaseGame(panel)
		end

		local label
		label = vgui.Create("DLabel", backgroundPanel)
		label:SetText("Base pack")
		label:SetDark(true)
		label:Dock(LEFT)
		label:SizeToContents()

	backgroundPanel:Dock(TOP)
	backgroundPanel:DockPadding(26,0,8,0)
	backgroundPanel:SetSize(200,20)
	backgroundPanel:SetPaintBackground(true)
	backgroundPanel:SizeToContents()
end

function CCSectionBuilder:_addSectionAO5(panel)
	local backgroundPanel = vgui.Create("DPanel", panel)
	self:_packLabelDockMargin(backgroundPanel)
	panel:AddItem(backgroundPanel)

		local icon
		icon = vgui.Create("DImage", backgroundPanel)
		icon:SetPos(5,2)
		icon:SetSize(16,16)

		if self.icm({Folder = "weapons/cw_kk_ins2_ao5"}) then
			icon:SetImage(self.iconOk)
		else
			icon:SetImage(self.iconNOk)

			self:_addLineBaseGame(panel)
			self:_addLineAO5Mod(panel)
		end

		local label
		label = vgui.Create("DLabel", backgroundPanel)
		label:SetText("Army of Five pack")
		label:SetDark(true)
		label:Dock(LEFT)
		label:SizeToContents()

	backgroundPanel:Dock(TOP)
	backgroundPanel:DockPadding(26,0,8,0)
	backgroundPanel:SetSize(200,20)
	backgroundPanel:SetPaintBackground(true)
	backgroundPanel:SizeToContents()
end

function CCSectionBuilder:_addSectionNam(panel)
	local backgroundPanel = vgui.Create("DPanel", panel)
	self:_packLabelDockMargin(backgroundPanel)
	panel:AddItem(backgroundPanel)

		local icon
		icon = vgui.Create("DImage", backgroundPanel)
		icon:SetPos(5,2)
		icon:SetSize(16,16)

		if self.icm({Folder = "weapons/cw_kk_ins2_nam"}) then
			if not self.icm({Folder = "weapons/doiNamModContentOK"}) then
				icon:SetImage(self.iconEh)
				self:_addLineNamMod(panel)
			else
				icon:SetImage(self.iconOk)
			end
		else
			icon:SetImage(self.iconNOk)

			self:_addLineDOIGame(panel)
			self:_addLineNamMod(panel)
		end

		local label
		label = vgui.Create("DLabel", backgroundPanel)
		label:SetText("Born to Kill pack")
		label:SetDark(true)
		label:Dock(LEFT)
		label:SizeToContents()

	backgroundPanel:Dock(TOP)
	backgroundPanel:DockPadding(26,0,8,0)
	backgroundPanel:SetSize(200,20)
	backgroundPanel:SetPaintBackground(true)
	backgroundPanel:SizeToContents()
end

function CCSectionBuilder:_addSectionDOI(panel)
	local backgroundPanel = vgui.Create("DPanel", panel)
	self:_packLabelDockMargin(backgroundPanel)
	panel:AddItem(backgroundPanel)

		local icon
		icon = vgui.Create("DImage", backgroundPanel)
		icon:SetPos(5,2)
		icon:SetSize(16,16)

		if self.icm({Folder = "weapons/cw_kk_ins2_doi"}) then
			icon:SetImage(self.iconOk)
		else
			icon:SetImage(self.iconNOk)

			self:_addLineDOIGame(panel)
			self:_addLineEXTPack(panel)
		end

		local label
		label = vgui.Create("DLabel", backgroundPanel)
		label:SetText("Day of Infamy pack")
		label:SetDark(true)
		label:Dock(LEFT)
		label:SizeToContents()

	backgroundPanel:Dock(TOP)
	backgroundPanel:DockPadding(26,0,8,0)
	backgroundPanel:SetSize(200,20)
	backgroundPanel:SetPaintBackground(true)
	backgroundPanel:SizeToContents()
end

function CCSectionBuilder:_addSectionExt(panel)
	local backgroundPanel = vgui.Create("DPanel", panel)
	self:_packLabelDockMargin(backgroundPanel)
	panel:AddItem(backgroundPanel)

		local icon
		icon = vgui.Create("DImage", backgroundPanel)
		icon:SetPos(5,2)
		icon:SetSize(16,16)

		if self.icm({Folder = "weapons/cw_kk_ins2_cstm"}) then
			icon:SetImage(self.iconOk)
		else
			icon:SetImage(self.iconNOk)

			self:_addLineBaseGame(panel)
			self:_addLineEXTPack(panel)
		end

		local label
		label = vgui.Create("DLabel", backgroundPanel)
		label:SetText("EXT pack")
		label:SetDark(true)
		label:Dock(LEFT)
		label:SizeToContents()

	backgroundPanel:Dock(TOP)
	backgroundPanel:DockPadding(26,0,8,0)
	backgroundPanel:SetSize(200,20)
	backgroundPanel:SetPaintBackground(true)
	backgroundPanel:SizeToContents()
end

function CCSectionBuilder:_addSectionDOIWW1(panel)
	local backgroundPanel = vgui.Create("DPanel", panel)
	self:_packLabelDockMargin(backgroundPanel)
	panel:AddItem(backgroundPanel)

		local icon
		icon = vgui.Create("DImage", backgroundPanel)
		icon:SetPos(5,2)
		icon:SetSize(16,16)

		if self.icm({Folder = "weapons/cw_kk_ins2_doi_ww1"}) then
			icon:SetImage(self.iconOk)
		else
			icon:SetImage(self.iconNOk)

			self:_addLineDOIGame(panel)
			self:_addLineDOIWW1Mod(panel)
		end

		local label
		label = vgui.Create("DLabel", backgroundPanel)
		label:SetText("Screaming Steal")
		label:SetDark(true)
		label:Dock(LEFT)
		label:SizeToContents()

	backgroundPanel:Dock(TOP)
	backgroundPanel:DockPadding(26,0,8,0)
	backgroundPanel:SetSize(200,20)
	backgroundPanel:SetPaintBackground(true)
	backgroundPanel:SizeToContents()
end

// weapon pack order
function CCSectionBuilder:_updatePanel()
	local panel = self._panel

	if !IsValid(panel) then return end

	-- panel:ClearControls()

	self:_addSectionBase(panel)
	self:_addSectionExt(panel)
	self:_addSectionDOI(panel)
	self:_addSectionNam(panel)
	self:_addSectionAO5(panel)
	self:_addSectionDOIWW1(panel)
end

function CCSectionBuilder:SetPanel(panel)
	self._panel = panel
	self:_updatePanel()
end

// Reset button

local presetFastest = {
	["cw_kk_ins2_animate_reticle"] = 1,
	["cw_kk_ins2_draw_vm_in_rt"] = 0,
	["cw_kk_ins2_ins_nade_ctrls"] = 1,
	["cw_kk_ins2_rig"] = 2,
	["cw_kk_ins2_rigskin"] = 0,
	["cw_kk_ins2_scopelightingfix"] = 0,
	["cw_kk_ins2_shell_sound"] = 1,
	["cw_kk_ins2_shell_time"] = 5,
	["cw_kk_ins2_shell_vm"] = 0,
	["cw_kk_ins2_sprint"] = 1
}

local function addSettingsPresetSection(panel)
	local cvarKeys = table.GetKeys(CustomizableWeaponry_KK.ins2.conVars.main)
	local defaults = {}

	for _,k in pairs(cvarKeys) do
		defaults[k] = CustomizableWeaponry_KK.ins2.conVars.main[k]:GetDefault()
	end

	panel:AddControl("ComboBox", {
		MenuButton = 1,
		Folder = "cw_kk_ins2_cfg",
		Options = {
			["Default"] = defaults,
			["Fastest"] = presetFastest,
		},
		CVars = cvarKeys
	}):DockMargin(8, 0, 8, 8)
end

// Other

local function updateRigSkinSlider(slider)
	slider:SetMinMax(0, 0)
	slider:SetDark(false)
	slider:SetText("^^ Skin")

	local ply = LocalPlayer()
	local wep = ply:GetActiveWeapon()

	if !IsValid(wep) then
		slider:SetText("Equip INS SWEP.")
		return
	end

	if !wep.KKINS2Wep then
		slider:SetText("Equip INS SWEP.")
		return
	end

	local max = wep:getRigSkinMax()
	slider:SetMax(max)
	slider:SetDark(max > 0)
	slider:SetText("^^ Skin (" .. ((max == 0) and "none" or (max + 1) .. " found)"))
	slider:SetValue(max > 0 and 0 or 1)
end

local function addRigsSection(panel)
	local rslider = panel:AddControl("Slider", {
		Label = "Rig:",
		Type = "Integer",
		Min = "1",
		Max = CustomizableWeaponry_KK.ins2.hands.cacheSize,
		Command = "cw_kk_ins2_rig"
	})

	rslider:DockMargin(8, 0, 8, 0)

	local rlabel = panel:AddControl("Label", {Text = "meh"})
	rlabel:DockMargin(8, 0, 8, 16)

	local rigSkinSlider = panel:AddControl("Slider", {
		Label = "^^ Skin:",
		Type = "Integer",
		Min = "0",
		Max = "0",
		Command = "cw_kk_ins2_rigskin"
	})

	rigSkinSlider:DockMargin(8, 0, 8, 0)

	updateRigSkinSlider(rigSkinSlider)

	function rslider:OnValueChanged(v)
		rlabel:SetText("^^ " .. (CustomizableWeaponry_KK.ins2.hands:_get(v)[2]))
		updateRigSkinSlider(rigSkinSlider)
	end
end

local sslabeltxt = {
	"^^ [Cheapest] physmaterial sound",
	"^^ [CW2 Base] timer, custom sound",
	"^^ [KK INS2] callback, custom sound"
}

if CustomizableWeaponry_KK.HOME then
	table.insert(sslabeltxt, "^^ [KK INS2] custom physmaterial")
end

local function addShellSoundSection(panel)
	local ssslider = panel:AddControl("Slider", {
		Label = "Shell sound function:",
		Type = "Integer",
		Min = "1",
		Max = #sslabeltxt,
		Command = "cw_kk_ins2_shell_sound"
	})

	ssslider:SetDecimals(0)
	ssslider:DockMargin(8, 0, 8, 0)

	local sslabel = panel:AddControl("Label", {Text = "meh"})
	sslabel:DockMargin(8, 0, 8, 16)

	function ssslider:OnValueChanged(v)
		sslabel:SetText(sslabeltxt[math.Clamp(math.Round(v or 1), 1, #sslabeltxt)] or "meh")
	end
end

local function addShellCleanupSection(panel)
	local cusbutt = panel:AddControl("Button", {Text = "meh"})

	cusbutt:DockMargin(8, 0, 8, 0)

	function cusbutt:DoClick()
		CustomizableWeaponry_KK.ins2.shells:cleanUpShells()
		self:updateLabel()
	end

	function cusbutt:updateLabel()
		local num = CustomizableWeaponry_KK.ins2.shells.cacheSize
		cusbutt:SetText("Clean up shells [" .. num .. "]")
	end

	cusbutt:updateLabel()

	timer.Create("CW_KK_INS2_SHELL_COUNTER", 3, 0, function()
		if IsValid(cusbutt) then
			cusbutt:updateLabel()
		end
	end)

	hook.Add("PostReloadToolsMenu", "CW_KK_INS2_SHELL_COUNTER_REMOVER", function()
		timer.Remove("CW_KK_INS2_SHELL_COUNTER")
	end)
end

// actual panel

CustomizableWeaponry_KK.panels =
	CustomizableWeaponry_KK.panels or
	{}

CustomizableWeaponry_KK.panels.ins2 = function(panel)
	panel:AddControl("Label", {Text = "INS2/DOI Content Status:"}):DockMargin(0, 0, 8, 0)

	CCSectionBuilder:SetPanel(panel)

	panel:AddControl("Label", {Text = "INS2/DOI Pack Settings:"}):DockMargin(0, 0, 8, 0)

	// cfg
	addSettingsPresetSection(panel)

	// rigs
	addRigsSection(panel)

	// shell sound function
	addShellSoundSection(panel)

	// shell life time
	panel:AddControl("Slider", {
		Label = "Shell life time:",
		Type = "Float",
		Min = "5",
		Max = "60",
		Command = "cw_kk_ins2_shell_time"
	}):DockMargin(8, 0, 8, 0)

	// shell cleanup
	addShellCleanupSection(panel)

	// VM shells
	panel:AddControl("CheckBox", {
		Label = "Alternative shell rendering function",
		Command = "cw_kk_ins2_shell_vm"
	}):DockMargin(8, 8, 8, 0)

	// always animated reticles
	panel:AddControl("CheckBox", {
		Label = "Always animate stencil sight reticle",
		Command = "cw_kk_ins2_animate_reticle"
	}):DockMargin(8, 8, 8, 0)

	// slow grenade attack swap
	panel:AddControl("CheckBox", {
		Label = "INS2-style slow grenade attacks (primary = cook)",
		Command = "cw_kk_ins2_ins_nade_ctrls"
	}):DockMargin(8, 8, 8, 0)

	// scope experiments - lighting
	panel:AddControl("CheckBox", {
		Label = "Fix shadows + break phong on RT Scopes.",
		Command = "cw_kk_ins2_scopelightingfix"
	}):DockMargin(8, 8, 8, 0)

	// sprint anims vs sprint codeims
	panel:AddControl("CheckBox", {
		Label = "Use model sprint anims instead of coded movement.",
		Command = "cw_kk_ins2_sprint"
	}):DockMargin(8, 8, 8, 0)

	if not CustomizableWeaponry_KK.HOME then return end

	// cam3d experiments
	panel:AddControl("CheckBox", {
		Label = "Draw viewmodels in render target scopes",
		Command = "cw_kk_ins2_draw_vm_in_rt"
	}):DockMargin(8, 8, 8, 0)
end
