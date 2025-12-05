local PLUGIN = PLUGIN
PLUGIN.Cutscenes.Active = PLUGIN.Cutscenes.Active or false
PLUGIN.Cutscenes.breakpoints = PLUGIN.Cutscenes.breakpoints or nil

PLUGIN.Cutscenes.activeValues = PLUGIN.Cutscenes.activeValues or {
	pos = vector_origin,
	ang = angle_zero
}

PLUGIN.Cutscenes.AngleAdjust = {}
PLUGIN.Cutscenes.FOVAdjust = {}
PLUGIN.Cutscenes.stored = PLUGIN.Cutscenes.stored or {}
PLUGIN.folder = "arena_cutscenes"
PLUGIN.Cutscenes.callbacked = {}
local LerpPos, LerpAng, LernAngAdditive

function PLUGIN.StartArenaCutscene(cutsceneID, customCamera)
	if not PLUGIN.Cutscenes.stored[cutsceneID] and not customCamera then return end
	PLUGIN.Cutscenes.callbacks = PLUGIN.Cutscenes.storedCallbacks[cutsceneID] or {}
	PLUGIN.Cutscenes.callbacked = {}
	PLUGIN.Cutscenes.breakpoints = PLUGIN.Cutscenes.stored[cutsceneID]
	PLUGIN.Cutscenes.activeID = cutsceneID
	PLUGIN.Cutscenes.Active = true
	PLUGIN.Cutscenes.StartTime = CurTime()
	LerpPos = nil
	LerpAng = nil
	LernAngAdditive = nil
end

function PLUGIN.ArenaCutsceneOnEnd(forceStop, server)
	if not PLUGIN.Cutscenes.Active then return end
	PLUGIN.Cutscenes.Active = false
	PLUGIN.Cutscenes.Skipping = false
	LocalPlayer():GetViewModel():SetNoDraw(false)

	if not (PLUGIN.Cutscenes.params[PLUGIN.Cutscenes.activeID] and PLUGIN.Cutscenes.params[PLUGIN.Cutscenes.activeID].no_fade) then
		LocalPlayer():ScreenFade(SCREENFADE.IN, Color(0, 0, 0), 1, 1)
	end

	local breakpoints = PLUGIN.Cutscenes.breakpoints
	PLUGIN.Cutscenes.breakpoints = nil

	if not server then
		net.Start("ixArenaCutsceneEnded")
		net.WriteBool(forceStop)
		net.SendToServer()
	end
end

local cutsceneData = {
	["arenaintro"] = "https://gist.githubusercontent.com/armdupe/79ba7f5c83ff1fd6628c1b9ba81a1531/raw/0e663dc524f0c94b39a270e30e4ccc32bd04ac76/arenaintro.txt",
	["arenaplayerone"] = "https://gist.githubusercontent.com/armdupe/a1715a3f0e96a67202d6266b22caebcc/raw/c7d4cc4dc8fd5b238b08d38fbfa3ab09b6751315/arenaplayerone.txt",
	["arenaplayertwo"] = "https://gist.githubusercontent.com/armdupe/124ff2d6f05568dbc369397d74b8ea25/raw/9b92c2a2c9f4b085f90050b556662a81df023e35/arenaplayertwo.txt",
}

function PLUGIN:DownloadAndSaveCutscene(url, fileName)
	local filePath = PLUGIN.folder .. "/" .. fileName .. ".txt"

	if file.Exists(filePath, "DATA") then
		local existingContent = file.Read(filePath, "DATA")

		http.Fetch(url, function(body, length, headers, code)
			if body ~= existingContent then
				file.Write(filePath, body)
			end
		end, function(error) end)
	else
		http.Fetch(url, function(body, length, headers, code)
			file.Write(filePath, body)
		end, function(error) end)
	end
end

local totalCutscenes = 0
local downloadedCutscenes = 0

for _ in pairs(cutsceneData) do
	totalCutscenes = totalCutscenes + 1
end

for cutsceneName, cutsceneData in pairs(cutsceneData) do
	PLUGIN:DownloadAndSaveCutscene(cutsceneData, cutsceneName)
	downloadedCutscenes = downloadedCutscenes + 1

	if downloadedCutscenes == totalCutscenes then
		file.CreateDir(PLUGIN.folder)

		timer.Simple(5, function()
			PLUGIN:LoadArenaCutscenes()
		end)
	end
end

function PLUGIN:LoadArenaCutscenes()
	local strDir = PLUGIN.folder .. "/"
	local files, directories = file.Find(strDir .. "*", "DATA")

	for _, v in pairs(files) do
		local filePath = strDir .. v
		local content = file.Read(filePath, "DATA")

		if content then
			PLUGIN.Cutscenes.stored[v:StripExtension()] = util.JSONToTable(content)
		end
	end
end

function PLUGIN.IsArenaCutsceneActive()
	return PLUGIN.Cutscenes.Active or PLUGIN.Cutscenes.Test
end

local background = Material("cotz/panels/frame1.png", "noclamp smooth")
local PANEL = {}

function PANEL:Init()
	self.frame = self
	self.frame:SetTitle("stalkertest")
	self.frame:ShowCloseButton(false)
	self.frame:DockPadding(self.frame:GetWide() * 0.1, self.frame:GetTall() * 0.05, self.frame:GetWide() * 0.1, self.frame:GetTall() * 0.05)
end

function PANEL:PostLayoutUpdate()
	self.frame:DockPadding(self.frame:GetWide() * 0.075, self.frame:GetTall() * 0.05, self.frame:GetWide() * 0.075, self.frame:GetTall() * 0.05)
	self.frame:SetSize(self.frame:GetWide() * 1.15, self.frame:GetTall() * 1.1)
	self.frame:Center()
end

function PANEL:Paint(width, height)
	surface.SetDrawColor(color_black)
	surface.DrawRect(6, 6, width - 12, height - 12)
	surface.SetMaterial(background)
	surface.SetDrawColor(255, 255, 255, 255)
	surface.DrawTexturedRect(2, 2, width - 4, height - 4)
end

vgui.Register("ixStalkerArenaRequest", PANEL, "DFrame")

net.Receive("ixArenaChallenge", function()
	local targetName = net.ReadString()
	local targetSid = net.ReadString()
	local arenaName = net.ReadString()
	local model = net.ReadString()
	local rep = net.ReadString()
	local loadout = net.ReadTable()
	local frame = vgui.Create("ixStalkerArenaRequest")
	frame:SetTitle("")
	frame:SetSize(500, 500)
	frame:SetPos((ScrW() / 2) - 250, (ScrH() / 2) - 250)
	frame:MakePopup()
	frame:ShowCloseButton(false)
	frame:SetDraggable(false)
	local label = vgui.Create("DLabel", frame)
	label:SetText("Arena Challenge")
	label:Dock(TOP)
	label:SetFont("stalkerregularfont")
	label:SetContentAlignment(5)
	label:DockMargin(8, 24, 8, 8)
	local pnl = vgui.Create("DPanel", frame)
	pnl:Dock(FILL)
	pnl:DockMargin(4, 14, 4, 6)
	pnl:DockPadding(0, 0, 0, 48)

	function pnl:Paint(w, h)
		surface.SetDrawColor(0, 0, 0, 0)
		surface.DrawRect(0, 0, w, h)
	end

	local buttons = vgui.Create("Panel", pnl)
	buttons:Dock(BOTTOM)
	buttons:SetTall(40)
	buttons:DockPadding(20, 6, 12, 6)
	local accept = vgui.Create("ixStalkerButton", buttons)
	accept:SetText("Send Request")
	accept:Dock(LEFT)
	accept:DockMargin(0, 0, 20, 0)
	accept:SetWide(200)
	accept:SetFont("stalkerregularfont")

	accept.DoClick = function()
		net.Start("ixArenaRequest")
		net.WriteString(targetSid)
		net.SendToServer()
		frame:Close()
	end

	local decline = vgui.Create("ixStalkerButton", buttons)
	decline:SetText("Cancel")
	decline:Dock(LEFT)
	decline:DockMargin(20, 0, 0, 0)
	decline:SetWide(200)
	decline:SetFont("stalkerregularfont")

	decline.DoClick = function()
		frame:Close()
	end

	local icon = vgui.Create("DModelPanel", pnl)
	icon:Dock(LEFT)
	icon:SetWide(150)
	icon:DockMargin(40, 8, 8, 8)
	icon:SetModel(model or "models/stalkerisaac/playermodel/male_01_anorak.mdl")
	icon:SetFOV(16)
	icon:SetCamPos(Vector(100, 50, 60))

	function icon:LayoutEntity(ent)
		ent:SetAngles(Angle(0, 60, 0))
	end

	local info = vgui.Create("DPanel", pnl)
	info:Dock(RIGHT)
	info:SetWide(225)
	info:DockMargin(8, 8, 8, 8)

	function info:Paint(w, h)
		surface.SetDrawColor(0, 0, 0, 150)
		surface.DrawRect(0, 0, w, h)
	end

	local scroll = vgui.Create("DScrollPanel", info)
	scroll:Dock(FILL)
	scroll:DockMargin(8, 8, 8, 8)

	local function AddInfoRow(parent, labelText, value)
		local row = vgui.Create("DPanel", parent)
		row:Dock(TOP)
		row:SetTall(26)
		row:DockMargin(0, 0, 0, 6)

		function row:Paint()
		end

		local lbl = vgui.Create("DLabel", row)
		lbl:Dock(FILL)
		lbl:SetText(labelText .. ": " .. tostring(value))
		lbl:SetFont("stalkerregularfont")
		lbl:SetContentAlignment(4)
	end

	AddInfoRow(scroll, "Name", targetName)
	AddInfoRow(scroll, "Reputation", rep)
	local loadoutLabel = vgui.Create("DLabel", scroll)
	loadoutLabel:Dock(TOP)
	loadoutLabel:SetTall(22)
	loadoutLabel:DockMargin(0, 8, 0, 6)
	loadoutLabel:SetText("Loadout:")
	loadoutLabel:SetFont("stalkerregularfont")
	loadoutLabel:SetContentAlignment(4)

	if loadout and type(loadout) == "table" then
		for _, itemName in ipairs(loadout) do
			AddInfoRow(scroll, " •", itemName)
		end
	end
end)

net.Receive("ixArenaRequest", function()
	local fromName = net.ReadString()
	local fromSid = net.ReadString()
	local arenaName = net.ReadString()
	local model = net.ReadString()
	local rep = net.ReadString()
	local loadout = net.ReadTable()
	local frame = vgui.Create("ixStalkerArenaRequest")
	frame:SetTitle("")
	frame:SetSize(500, 500)
	frame:SetPos((ScrW() / 2) - 250, (ScrH() / 2) - 250)
	frame:MakePopup()
	frame:ShowCloseButton(false)
	frame:SetDraggable(false)
	local label = vgui.Create("DLabel", frame)
	label:SetText("Arena Request")
	label:Dock(TOP)
	label:SetFont("stalkerregularfont")
	label:SetContentAlignment(5)
	label:DockMargin(8, 24, 8, 8)
	local pnl = vgui.Create("DPanel", frame)
	pnl:Dock(FILL)
	pnl:DockMargin(4, 14, 4, 6)
	pnl:DockPadding(0, 0, 0, 48)

	function pnl:Paint(w, h)
		surface.SetDrawColor(0, 0, 0, 0)
		surface.DrawRect(0, 0, w, h)
	end

	local buttons = vgui.Create("Panel", pnl)
	buttons:Dock(BOTTOM)
	buttons:SetTall(40)
	buttons:DockPadding(20, 6, 12, 6)
	local accept = vgui.Create("ixStalkerButton", buttons)
	accept:SetText("Accept")
	accept:Dock(LEFT)
	accept:DockMargin(0, 0, 20, 0)
	accept:SetWide(200)
	accept:SetFont("stalkerregularfont")

	accept.DoClick = function()
		net.Start("ixArenaRequestResponse")
		net.WriteBool(true)
		net.WriteString(fromSid)
		net.WriteString(arenaName)
		net.SendToServer()
		frame:Close()
	end

	local decline = vgui.Create("ixStalkerButton", buttons)
	decline:SetText("Decline")
	decline:Dock(LEFT)
	decline:DockMargin(20, 0, 0, 0)
	decline:SetWide(200)
	decline:SetFont("stalkerregularfont")

	decline.DoClick = function()
		net.Start("ixArenaRequestResponse")
		net.WriteBool(false)
		net.WriteString(fromSid)
		net.WriteString(arenaName)
		net.SendToServer()
		frame:Close()
	end

	local icon = vgui.Create("DModelPanel", pnl)
	icon:Dock(LEFT)
	icon:SetWide(150)
	icon:DockMargin(40, 8, 8, 8)
	icon:SetModel(model or "models/stalkerisaac/playermodel/male_01_anorak.mdl")
	icon:SetFOV(16)
	icon:SetCamPos(Vector(100, 50, 60))

	function icon:LayoutEntity(ent)
		ent:SetAngles(Angle(0, 60, 0))
	end

	local info = vgui.Create("DPanel", pnl)
	info:Dock(RIGHT)
	info:SetWide(225)
	info:DockMargin(8, 8, 8, 8)

	function info:Paint(w, h)
		surface.SetDrawColor(0, 0, 0, 150)
		surface.DrawRect(0, 0, w, h)
	end

	local scroll = vgui.Create("DScrollPanel", info)
	scroll:Dock(FILL)
	scroll:DockMargin(8, 8, 8, 8)

	local function AddInfoRow(parent, labelText, value)
		local row = vgui.Create("DPanel", parent)
		row:Dock(TOP)
		row:SetTall(26)
		row:DockMargin(0, 0, 0, 6)

		function row:Paint()
		end

		local lbl = vgui.Create("DLabel", row)
		lbl:Dock(FILL)
		lbl:SetText(labelText .. ": " .. tostring(value))
		lbl:SetFont("stalkerregularfont")
		lbl:SetContentAlignment(4)
	end

	AddInfoRow(scroll, "Name", fromName)
	AddInfoRow(scroll, "Reputation", rep)
	local loadoutLabel = vgui.Create("DLabel", scroll)
	loadoutLabel:Dock(TOP)
	loadoutLabel:SetTall(22)
	loadoutLabel:DockMargin(0, 8, 0, 6)
	loadoutLabel:SetText("Loadout:")
	loadoutLabel:SetFont("stalkerregularfont")
	loadoutLabel:SetContentAlignment(4)

	if loadout and type(loadout) == "table" then
		for _, itemName in ipairs(loadout) do
			AddInfoRow(scroll, " •", itemName)
		end
	end
end)

function PLUGIN.ArenaCutscenePos(pos, ang)
	net.Start("ixArenaCutscenePos")
	net.WriteVector(pos)
	net.WriteAngle(ang or angle_zero)
	net.SendToServer()
end

local i_Point, i_NextPoint = 0, 0

net.Receive("ixArenaEnd", function()
	local deadPlayer = net.ReadString()

	if IsValid(PLUGIN.AnnouncerStation) then
		PLUGIN.AnnouncerStation:Stop()
		PLUGIN.AnnouncerStation = nil
	end

	sound.PlayFile("sound/cotz/arena/mega_arena_win_2.ogg", "3d", function(station, errCode, errStr)
		if IsValid(station) then
			PLUGIN.AnnouncerStation = station

			timer.Simple(2, function()
				PLUGIN.AnnouncerStation:Play()
			end)

			PLUGIN.AnnouncerStation:SetPos(PLUGIN.Arenas["rp_marsh_cs"]["swampsarena"]["announcer"])
			PLUGIN.AnnouncerStation:SetVolume(15)
		end
	end)

	local ply = LocalPlayer()

	if ply:SteamID() == deadPlayer then
		ply:ScreenFade(SCREENFADE.IN, color_black, 1, 1)
	end
end)

net.Receive("ixArenaCutsceneLaunch", function()
	local id = net.ReadString()
	local customCamera = net.ReadBool()
	PLUGIN.StartArenaCutscene(id, customCamera)
	PLUGIN.Cutscenes.entities = net.ReadTable()

	if IsValid(ix.gui.dialogue) then
		ix.gui.dialogue:exit()
	end
end)

net.Receive("ixArenaAttachCameraTo", function()
	local entIndex = net.ReadUInt(32)
	local entity = Entity(entIndex)
	local bone = net.ReadString()

	LocalPlayer().Attached = {
		ent = entity,
		bone = bone
	}
end)

net.Receive("ixArenaResetCamera", function()
	LocalPlayer().Attached = nil
end)

net.Receive("ixArenaCutsceneEnded", function()
	PLUGIN.ArenaCutsceneOnEnd(nil, true)
end)

local lerp = 0

function PLUGIN:HUDPaint()
	local localPly = LocalPlayer()

	if localPly:GetLocalVar("inArena", false) then
		local endTime = localPly:GetLocalVar("arenaEndTime", nil)

		if endTime then
			local scrW, scrH = ScrW(), ScrH()
			local timeLeft = math.max(0, math.floor(endTime - CurTime()))
			local minutes = math.floor(timeLeft / 60)
			local seconds = timeLeft % 60
			draw.SimpleText(string.format("Time Left: %d:%02d", minutes, seconds), "stalkerregularbigfont", scrW * 0.5, (scrH / 1080) * 50, color_white, TEXT_ALIGN_CENTER)
		end
	end

	local hideFromHUD = not PLUGIN.Cutscenes.Active or not PLUGIN.Cutscenes.breakpoints
	if PLUGIN.Cutscenes.params[PLUGIN.Cutscenes.activeID] and PLUGIN.Cutscenes.params[PLUGIN.Cutscenes.activeID].no_bars then return end
	lerp = Lerp(FrameTime() * 5, lerp, hideFromHUD and 0 or 1)
	local w, h = ScrW(), ScrH()
	local barSize = h * 0.05
	draw.RoundedBox(0, 0, -barSize + barSize * lerp, w, barSize, Color(0, 0, 0))
	draw.RoundedBox(0, 0, h - barSize * lerp, w, barSize, Color(0, 0, 0))
end

function PLUGIN:CalcView(ply, origin, angles, fov)
	local view = {}
	if ply:Health() <= 0 then return end
	local breakpoints = PLUGIN.Cutscenes.breakpoints
	local viewmodel = ply:GetViewModel()
	local ft = math.max(FrameTime(), 0.00001)
	local cameraData = ply:GetCameraAttach()

	if not PLUGIN.Cutscenes.Active or (not breakpoints and not cameraData) then
		i_Point = 1

		return
	end

	viewmodel:SetNoDraw(true)
	local endpos, endang
	local fracture, headBobbing = FrameTime() * 10, angle_zero

	if cameraData then
		local ent = cameraData.ent
		if not IsValid(ent) then return end
		endpos, endang = ent:GetBonePosition(ent:LookupBone(cameraData.bone))

		if not LerpPos or not LerpAng then
			LerpPos, LerpAng = endpos, endang
			LernAngAdditive = PLUGIN.Cutscenes.AngleAdjust[PLUGIN.Cutscenes.activeID] or angle_zero
		end

		local pr = tostring(math.Round(CurTime() - PLUGIN.Cutscenes.StartTime, 1))

		if PLUGIN.Cutscenes.callbacks[pr] and not PLUGIN.Cutscenes.callbacked[pr] then
			PLUGIN.Cutscenes.callbacked[pr] = true
			PLUGIN.Cutscenes.callbacks[pr]()
		end
	else
		if not LerpPos or not LerpAng then
			LerpPos = breakpoints[1].pos
			LerpAng = breakpoints[1].ang
			i_Point = 1
		end

		if i_NextPoint < CurTime() then
			local modifier = math.max(ft / breakpoints[i_Point].ft, 1)
			i_Point = i_Point + math.floor(modifier)

			if i_Point >= #breakpoints then
				local activeCutscene = PLUGIN.Cutscenes.params[PLUGIN.Cutscenes.activeID]

				if activeCutscene and activeCutscene.updatepos then
					PLUGIN.ArenaCutscenePos(breakpoints[#breakpoints].actualpos, breakpoints[#breakpoints].ang)
				end
			end

			if not breakpoints[i_Point] then
				PLUGIN.ArenaCutsceneOnEnd()

				return
			end

			local progress = math.Round((i_Point / #breakpoints) * 100, 1)

			for i = 1, 100, 0.1 do
				if i > progress then break end
				local pr = tostring(math.Round(i, 1))

				if PLUGIN.Cutscenes.callbacks[pr] and not PLUGIN.Cutscenes.callbacked[pr] then
					PLUGIN.Cutscenes.callbacked[pr] = true
					PLUGIN.Cutscenes.callbacks[pr]()
				end
			end

			endpos = breakpoints[i_Point].pos
			endang = breakpoints[i_Point].ang
			i_NextPoint = CurTime() + ft * breakpoints[i_Point].ft / ft
		end

		headBobbing = GetBobForVelocity(breakpoints[i_Point].vel:Length()) / 6 + LocalPlayer():GetViewPunchVelocity()
		local speed = 5

		if PLUGIN.Cutscenes.params[PLUGIN.Cutscenes.activeID] then
			if PLUGIN.Cutscenes.params[PLUGIN.Cutscenes.activeID].no_headbob then
				headBobbing = angle_zero
			end

			if PLUGIN.Cutscenes.params[PLUGIN.Cutscenes.activeID].speed then
				speed = PLUGIN.Cutscenes.params[PLUGIN.Cutscenes.activeID].speed
			end
		end

		fracture = FrameTime() * speed
	end

	-- debug current camera angle
	-- print(endang - (PLUGIN.Cutscenes.AngleAdjust[PLUGIN.Cutscenes.activeID] or angle_zero))
	LerpPos = breakpoints and LerpVector(fracture, LerpPos, breakpoints[i_Point].pos) or endpos
	--LernAngAdditive = Lerp(fracture * 0.1, LernAngAdditive, angle_zero))
	--print(PLUGIN.Cutscenes.AngleAdjust[PLUGIN.Cutscenes.activeID] or Angle(0,0,0))
	LerpAng = breakpoints and LerpAngle(fracture, LerpAng, breakpoints[i_Point].ang) + headBobbing or endang - LernAngAdditive
	view.origin = LerpPos
	view.angles = LerpAng
	local customFOV = PLUGIN.Cutscenes.FOVAdjust[PLUGIN.Cutscenes.activeID]

	if customFOV then
		view.fov = customFOV
	end

	PLUGIN.Cutscenes.activeValues = {
		pos = LerpPos,
		ang = LerpAng + headBobbing
	}

	view.drawviewer = PLUGIN.Cutscenes.params[PLUGIN.Cutscenes.activeID] and PLUGIN.Cutscenes.params[PLUGIN.Cutscenes.activeID].drawplayer or false

	return view
end

function PLUGIN:InitializedPlugins()
	local function isAllowed()
		return ix.config.Get("thirdperson")
	end

	local playerMeta = FindMetaTable("Player")

	function playerMeta:CanOverrideView() -- overriding helix's func
		local entity = Entity(self:GetLocalVar("ragdoll", 0))

		if (IsValid(ix.gui.characterMenu) and !ix.gui.characterMenu:IsClosing() and ix.gui.characterMenu:IsVisible()) then
			return false
		end

		if (IsValid(ix.gui.menu) and ix.gui.menu:GetCharacterOverview()) then
			return false
		end

		if (ix.option.Get("thirdpersonEnabled", false) and
			!IsValid(self:GetVehicle()) and
			isAllowed() and
			IsValid(self) and
			self:GetCharacter() and
			!self:GetNetVar("actEnterAngle") and
			!self:GetLocalVar("inArena", false) and
			!IsValid(entity) and
			LocalPlayer():Alive()
			) then
			return true
		end
	end
end