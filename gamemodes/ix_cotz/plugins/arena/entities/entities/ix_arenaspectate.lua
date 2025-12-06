local PLUGIN = PLUGIN
AddCSLuaFile()
ENT.Type = "anim"
ENT.PrintName = "Arena Spectate"
ENT.Category = "Helix"
ENT.Spawnable = true
ENT.AdminOnly = true

function ENT:SetupDataTables()
	self:NetworkVar("Bool", 0, "Active")
end

if SERVER then
	function ENT:Initialize()
		self:SetModel("models/z-o-m-b-i-e/st/technica/st_tv_vesna_01.mdl")
		self:SetSolid(SOLID_VPHYSICS)
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetUseType(SIMPLE_USE)
		self:SetActive(false)
		local physObj = self:GetPhysicsObject()

		if IsValid(physObj) then
			physObj:EnableMotion(true)
			physObj:Wake()
		end
	end

	function ENT:Use(activator)
		if not self:GetActive() then
			activator:Notify("The arena is currently inactive.")
			return
		end

		PLUGIN:ToggleSpectateArena(activator)
	end

	function ENT:OnRemove()
	end
else
	local GLOW_MATERIAL = Material("sprites/glow04_noz.vmt")
	local colors = {
		[false] = Color(255, 0, 0),
		[true] = Color(0, 255, 0),
	}

	function ENT:Draw(flags)
		if LocalPlayer():GetPos():Distance(self:GetPos()) < 2048 then
			self:DrawModel()
			local position = self:GetPos() + self:GetForward() * -10 + self:GetUp() * 5 - self:GetRight() * 11
			render.SetMaterial(GLOW_MATERIAL)
			render.DrawSprite(position, 14, 14, colors[self:GetActive()] or color_white)
		end
	end

	ENT.PopulateEntityInfo = true

	function ENT:OnPopulateEntityInfo(container)
		local name = container:AddRow("name")
		name:SetImportant()
		name:SetText("Arena TV")
		name:SizeToContents()
		local descriptionText = self:GetNetVar("Description", "A television that broadcasts Arena fights. (Press E to spectate the Arena)")

		if descriptionText ~= nil then
			local description = container:AddRow("Description")
			description:SetText(descriptionText)
			description:SizeToContents()
		end
	end
end