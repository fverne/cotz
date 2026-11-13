local PLUGIN = PLUGIN
local OPEN_TIMER = "cotz/tutorial/open"
local OPEN_INTERVAL = 0.25
local pendingCharacterID
local displayedCharacterID
local loadedCharacterID
local openingMenu
local openingHelp

PLUGIN.tutorialSections = {
	{
		title = "Your PDA",
		text = "Press Tab to open your PDA. Its tabs give you access to your inventory, Tasks, Progression, and Encyclopedia. Start here when you need to check what you are carrying or find your next objective.",
		image = "",
		caption = "Image placeholder: PDA tabs and Encyclopedia",
	},
	{
		title = "Inventory and equipment",
		text = "Drag items with the left mouse button to arrange your inventory. Right-click an item to see its available actions, including use and equipment actions. Check your equipment slots and item descriptions before leaving town; carrying an item does not always mean it is equipped.",
		image = "",
		caption = "Image placeholder: inventory actions and equipment slots",
	},
	{
		title = "Town contacts and work",
		text = "Speak to town contacts to find work, trade, and learn what they offer. Read each job's requirements before accepting it. Use Tasks to review your work and Progression to check contact milestones. Return to the relevant contact when you are ready to hand in what they asked for.",
		image = "",
		caption = "Image placeholder: a town contact and the Tasks tab",
	},
	{
		title = "Before you head out",
		text = "Watch your health, hunger, and thirst. Bring food, water, and medical supplies, and read what each supply actually treats. Healing does not stop bleeding by itself. Anomalies and radiation can make a short trip dangerous; watch your route, prepare your equipment, and travel with other stalkers when you can.",
		image = "",
		caption = "Image placeholder: survival indicators and field supplies",
	},
	{
		title = "Find this guide again",
		text = "You can close the PDA and return to this guide whenever you need it: press Tab, choose Encyclopedia, then Tutorial. Readme introduces Call of the Zone, and Keybinds lists more controls. This guide opens automatically only once for each new character.",
		image = "",
		caption = "Image placeholder: Encyclopedia with Tutorial selected",
	},
}

local function addImage(container, section)
	local imagePanel = container:Add("DPanel")
	imagePanel:Dock(TOP)
	local material = section.image and section.image ~= "" and Material(section.image, "smooth") or nil
	if material and material:IsError() then material = nil end

	local caption = ix.cotzUI.Label(container, section.caption)
	caption:SetContentAlignment(5)

	imagePanel.PerformLayout = function(panel, width)
		local ratio = material and material:Width() / math.max(material:Height(), 1) or 16 / 9
		local height = math.max(1, math.min(width / ratio, ScrH() * 0.35))
		if panel:GetTall() ~= height then panel:SetTall(height) end
	end
	imagePanel.Paint = function(panel, width, height)
		ix.cotzUI.PaintCard(panel, width, height)
		if not material then return end

		local scale = math.min(width / math.max(material:Width(), 1), height / math.max(material:Height(), 1))
		local imageWidth, imageHeight = material:Width() * scale, material:Height() * scale
		surface.SetDrawColor(255, 255, 255)
		surface.SetMaterial(material)
		surface.DrawTexturedRect((width - imageWidth) / 2, (height - imageHeight) / 2, imageWidth, imageHeight)
	end

	if not material then
		local placeholder = ix.cotzUI.Label(imagePanel, "Screenshot to be added")
		placeholder:Dock(FILL)
		placeholder:SetContentAlignment(5)
	end
end

function PLUGIN:PopulateTutorial(tabs)
	tabs.tutorial = function(container)
		ix.cotzUI.StyleScroll(container)
		ix.cotzUI.Label(container, "Getting started in Call of the Zone", true)

		for _, section in ipairs(self.tutorialSections) do
			local card = ix.cotzUI.Card(container)
			ix.cotzUI.Label(card, section.title, true)
			ix.cotzUI.Label(card, section.text)
			addImage(card, section)
		end
	end
end

local function stopOpening()
	timer.Remove(OPEN_TIMER)
	pendingCharacterID = nil
	openingMenu = nil
	openingHelp = nil
end

function PLUGIN:OpenTutorial()
	local menu = ix.gui.menu
	if not IsValid(menu) then menu = vgui.Create("ixMenu") end
	if menu.bClosing then return end

	for _, button in ipairs(menu.tabs.buttons) do
		if button.name == "help" then
			button:SetSelected(true)
			local container = menu:GetSubpanel(button.id)

			for _, child in ipairs(container:GetChildren()) do
				if child.categorySubpanels and child.categories and child.categories.tutorial then
					child:OnCategorySelected("tutorial")

					return menu, child
				end
			end
		end
	end
end

local function tryOpening()
	if not ix.config.Get("tutorialPopupEnabled", true) then
		stopOpening()
		return
	end

	local client = LocalPlayer()
	if not IsValid(client) then return end
	local character = client:GetCharacter()
	if not character then return end
	if character:GetID() ~= pendingCharacterID then
		if loadedCharacterID == pendingCharacterID then return end
		stopOpening()
		return
	end

	if openingMenu then
		-- Wait one UI tick before acknowledging, and retain eligibility if the opening was interrupted.
		if IsValid(openingMenu) and not openingMenu.bClosing and IsValid(openingHelp)
			and openingMenu:GetActiveTab() == "help" and openingHelp:IsVisible()
			and openingHelp.activeCategory == openingHelp.categorySubpanels.tutorial then
			displayedCharacterID = pendingCharacterID
			net.Start("cotz/tutorial/shown")
				net.WriteUInt(pendingCharacterID, 32)
			net.SendToServer()
		end

		stopOpening()
		return
	end

	if IsValid(ix.gui.characterMenu) or IsValid(ix.gui.intro) or gui.IsGameUIVisible() then return end
	local creation = ix.plugin.Get("charcreation")
	if creation and creation:IsIntroActive() then return end
	if hook.Run("ShouldSuppressMenu", client) then return end

	openingMenu, openingHelp = PLUGIN:OpenTutorial()
end

net.Receive("cotz/tutorial/open", function()
	local characterID = net.ReadUInt(32)
	if pendingCharacterID == characterID or displayedCharacterID == characterID then return end
	stopOpening()
	pendingCharacterID = characterID
	timer.Create(OPEN_TIMER, OPEN_INTERVAL, 0, tryOpening)
end)

function PLUGIN:CharacterLoaded(character)
	loadedCharacterID = character:GetID()
	if pendingCharacterID and character:GetID() ~= pendingCharacterID then stopOpening() end
end
