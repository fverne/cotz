-- Beam materials and appearance adapted from the newer Anomaly pack's Gauss effect (Flaymi).
local BEAM = Material("effects/pfx_light3")
local TRAIL = Material("effects/pfx_anomaly_8_trail")
local BEAM_COLOR = Color(255, 255, 255)
local TRAIL_COLOR = Color(150, 150, 150)
local LIFETIME = 1 / 3

function EFFECT:Init(data)
	self.StartPos = data:GetStart()
	self.EndPos = data:GetOrigin()
	local weapon = data:GetEntity()

	if IsValid(weapon) then
		local model = weapon:GetOwner() == LocalPlayer() and weapon.CW_VM or weapon.WMEnt

		if IsValid(model) then
			local muzzle = model:GetAttachment(model:LookupAttachment(weapon.MuzzleAttachmentName))
			if muzzle then self.StartPos = muzzle.Pos end
		end
	end
	self.ExpiresAt = CurTime() + LIFETIME
	self:SetRenderBoundsWS(self.StartPos, self.EndPos)
end

function EFFECT:Think()
	return CurTime() < self.ExpiresAt
end

function EFFECT:Render()
	local alpha = math.Clamp((self.ExpiresAt - CurTime()) / LIFETIME, 0, 1)
	BEAM_COLOR.a = alpha * 255
	TRAIL_COLOR.a = alpha * 255
	local length = self.StartPos:Distance(self.EndPos) / 128
	render.SetMaterial(BEAM)
	render.DrawSprite(self.StartPos, 48 * alpha, 48 * alpha, BEAM_COLOR)
	render.DrawBeam(self.StartPos, self.EndPos, 15, 0, length, BEAM_COLOR)
	render.SetMaterial(TRAIL)
	render.DrawBeam(self.StartPos, self.EndPos, 15, 0, length, TRAIL_COLOR)
end
