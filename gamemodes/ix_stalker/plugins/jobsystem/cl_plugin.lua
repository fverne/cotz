if(CLIENT) then

	local PANEL = {}


	function PANEL:Init()
		if (IsValid(ix.gui.journal)) then
			ix.gui.journal:Remove()
		end

		self:Dock(FILL)

		ix.gui.journal = self


		local client = LocalPlayer()
		local character = client:GetCharacter()
		local jobs = character:GetJobs()
		local finishquests = character:GetData("finishquests", {})

		local rnd = table.Random(jobs)

		local color = ix.config.Get("color", Color(255, 255, 255))

		self.index = {}

		PrintTable(jobs)
		for index, v in pairs(jobs) do
			local job = ix.jobs.list[v.identifier]

			self.index = self:Add("DFrame")
			self.index:Dock(TOP)
			self.index:SetHeight(100)
			self.index:DockMargin(20, 20, 20, 0)
			self.index:SetTitle("Task Giver: "..index or "Unknown")
			self.index:SetDraggable(false)
			self.index:ShowCloseButton(false)

			self.index.icon = self.index:Add("DImage")
			self.index.icon:SetMaterial(job.icon or "propic/event/area")
			self.index.icon:Dock(LEFT)
			self.index.icon:SetWide(96)

			self.index.description = self.index:Add("DLabel")
			self.index.description:SetText(string.format(job.name or "%d Unknown", job.numberRec))
			self.index.description:Dock(TOP)
			self.index.description:DockMargin(10, 2, 0, 0)
			self.index.description:SetFont("ixGenericFont")
			self.index.description:SetColor(Color(255, 255, 255))

			--self.index.description = self.index:Add("DLabel")
			--self.index.description:SetText(description)
			--self.index.description:Dock(TOP)
			--self.index.description:SetFont("ixGenericFont")
			--self.index.description:DockMargin(10, 4, 0, 0)


			self.index.details = self.index:Add("DButton")
			self.index.details:Dock(BOTTOM)
			self.index.details:DockMargin(10, 0, 0, 0)
			self.index.details:SetText("Détails")
			self.index.details.DoClick = function()
				if (IsValid(self.questdetails)) then
					self.questdetails:Remove()
				end

			self.questdetails = self:Add("DFrame")
			self.questdetails:Center()
			self.questdetails:SetSize(500, 350)
			self.questdetails:SetTitle(string.format(job.name or "%d Unknown", job.numberRec))
			self.questdetails:MakePopup()

			self.questdetails.containertop = self.questdetails:Add("DPanel")
			self.questdetails.containertop:SetSize(480, 150)
			self.questdetails.containertop:SetPos(10, 30)

			self.questdetails.objective = self.questdetails.containertop:Add("DPanel")
			self.questdetails.objective:SetPos(160, 10)
			self.questdetails.objective:SetSize(310, 20)

			self.questdetails.objectiveTitle = self.questdetails.objective:Add("DLabel")
			self.questdetails.objectiveTitle:SetText("Objectif(s) de la quête")
			self.questdetails.objectiveTitle:SizeToContents()
			self.questdetails.objectiveTitle:Center()

			self.questdetails.objectiveContainer = self.questdetails.containertop:Add("DPanel")
			self.questdetails.objectiveContainer:SetPos(160, 30.5)
			self.questdetails.objectiveContainer:SetSize(310, 80)

			self.questdetails.objectiveContainerScroll = self.questdetails.objectiveContainer:Add("DScrollPanel")
			self.questdetails.objectiveContainerScroll:SetPos(5, 0)
			self.questdetails.objectiveContainerScroll:SetSize(310, 80)

			self.questdetails.objectiveContainerScrollText = self.questdetails.objectiveContainerScroll:Add("DLabel")
			self.questdetails.objectiveContainerScrollText:SetText(string.format("Progress: ".."%d/%d", v.progress, v.numberRec))
			self.questdetails.objectiveContainerScrollText:Dock(TOP)
			self.questdetails.objectiveContainerScrollText:SizeToContents()

			self.questdetails.bCancel = self.questdetails.containertop:Add("DButton")
			self.questdetails.bCancel:Dock(BOTTOM)
			self.questdetails.bCancel:DockMargin(160, 0, 10, 10)
			self.questdetails.bCancel:SetText("Abandon the quest")
			self.questdetails.bCancel.DoClick = function()
				netstream.Start("QuestCancel", v)
				self:Remove()
				client:Notify("Press the 'Quests' button again to review your quests.")
			end

			self.questdetails.containertop2 = self.questdetails.containertop:Add("DPanel")
			self.questdetails.containertop2:SetSize(150, 150)

			self.questdetails.icon = vgui.Create("Material", self.questdetails.containertop2)
			self.questdetails.icon:SetSize(64, 64)
			self.questdetails.icon:Dock(LEFT)
			self.questdetails.icon:DockMargin(43, 43, 43, 43)
			self.questdetails.icon:SetMaterial(job.icon or "materials/questsicon/unkown.png")

			self.questdetails.containerbottom = self.questdetails:Add("DPanel")
			self.questdetails.containerbottom:SetSize(480, 155)
			self.questdetails.containerbottom:SetPos(10, 185)

			self.questdetails.containerbottom.about = self.questdetails.containerbottom:Add("DPanel")
			self.questdetails.containerbottom.about:SetPos(0, 0)
			self.questdetails.containerbottom.about:SetSize(480, 20)

			self.questdetails.containerbottom.aboutTitle = self.questdetails.containerbottom.about:Add("DLabel")
			self.questdetails.containerbottom.aboutTitle:SetText("Summary of the quest")
			self.questdetails.containerbottom.aboutTitle:SizeToContents()
			self.questdetails.containerbottom.aboutTitle:Center()

			self.questdetails.containerbottom.containerabout = self.questdetails.containerbottom:Add("DPanel")
			self.questdetails.containerbottom.containerabout:SetPos(0, 20)
			self.questdetails.containerbottom.containerabout:SetSize(480, 135)

			self.questdetails.containerbottom.containeraboutscroll = self.questdetails.containerbottom.containerabout:Add("DScrollPanel")
			self.questdetails.containerbottom.containeraboutscroll:SetPos(5, 0)
			self.questdetails.containerbottom.containeraboutscroll:SetSize(478, 135)

			self.questdetails.containerbottom.containeraboutscrolltext = self.questdetails.containerbottom.containeraboutscroll:Add("DLabel")
			self.questdetails.containerbottom.containeraboutscrolltext:SetText(string.format(job.desc or "%d Unknown", job.numberRec))
			self.questdetails.containerbottom.containeraboutscrolltext:Dock(TOP)
			self.questdetails.containerbottom.containeraboutscrolltext:SizeToContents()

--			self.index.rarity = self.index.leftPanel:Add("DLabel")
--			self.index.rarity:SetText(item.rarity .. "%")
--			self.index.rarity:Dock(RIGHT)
--			self.index.rarity:SetFont("ixMediumFont")
--			self.index.rarity:DockMargin(0, -60, 0, 0)

			end
		end
	end

	vgui.Register("ixCharacterJournal", PANEL, "DScrollPanel")


-- ------------------------------------------------------------------------------ --


	local PANEL = {}


	function PANEL:Init()
		if (IsValid(ix.gui.detailsquest)) then
			ix.gui.detailsquest:Remove()
		end

		ix.gui.detailsquest = self


	end

	vgui.Register("ixDetailsQuest", PANEL, "DFrame")


end -- Fin de la condition "CLIENT".