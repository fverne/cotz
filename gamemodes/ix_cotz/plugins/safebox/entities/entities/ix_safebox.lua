ENT.Type = "anim"
ENT.PrintName = "Safebox"
ENT.Category = "Helix"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.bNoPersist = true

if (SERVER) then
	function ENT:Initialize()
		self:SetModel("models/props_junk/trashdumpster01a.mdl")
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
		self:SetUseType(SIMPLE_USE)

		local physObj = self:GetPhysicsObject()

		if (IsValid(physObj)) then
			physObj:EnableMotion(true)
			physObj:Wake()
		end
	end

	function ENT:Use(activator)
		if (CurTime() < (activator.ixNextOpen or 0)) then
			return
		end

		local openTime = ix.config.Get("safeboxOpenTime", 1)

		ix.safebox.Restore(activator, function()
			if (openTime > 0) then
				activator:SetAction("@storageSearching", openTime)
				activator:DoStaredAction(self, function()
					if (IsValid(activator) and activator:Alive()) then
						net.Start("ixSafeboxOpen")
						net.Send(activator)
					end
				end, openTime, function()
					if (IsValid(activator)) then
						activator:SetAction()
					end
				end)
			else
				net.Start("ixSafeboxOpen")
				net.Send(activator)
			end
		end)

		activator.ixNextOpen = CurTime() + 1
	end
else
	ENT.PopulateEntityInfo = true

	function ENT:OnPopulateEntityInfo(tooltip)
		local title = tooltip:AddRow("name")
		title:SetImportant()
		title:SetText(self.PrintName)
		title:SetBackgroundColor(ix.config.Get("color"))
		title:SizeToContents()

		local description = tooltip:AddRow("description")
		description:SetText("It can permanently hold stuff.")
		description:SizeToContents()
	end
end