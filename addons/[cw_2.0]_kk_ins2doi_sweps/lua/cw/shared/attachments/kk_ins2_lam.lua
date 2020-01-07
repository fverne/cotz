local att = {}
att.name = "kk_ins2_lam"
att.displayName = "Laser Aiming Module"
att.displayNameShort = "LAM"
att.laserRange = 4096
att.laserBeamRange = 75
att.colorType = CustomizableWeaponry.colorableParts.COLOR_TYPE_BEAM

att.statModifiers = {
	VelocitySensitivityMult = -0.2,
	// OverallMouseSensMult = -0.15,
	HipSpreadMult = -0.2,
	DrawSpeedMult = -0.1,
	MaxSpreadIncMult = -0.25
}

local colDefault = CustomizableWeaponry.colorableParts.defaultColors[att.colorType].color

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/" .. att.name)
	att.description = {
		[1] = {t = "[impulse 100] toggles on/off.", c = CustomizableWeaponry.textColors.REGULAR},
	}
	local beam = Material("cw2/reticles/aim_reticule")
	local laserDot = Material("cw2/reticles/aim_reticule")

	att.reticle = "cw2/reticles/aim_reticule"
	local td = {}
	local pos, ang

	function att:_elementRender(beamAtt)
		if not beamAtt then return end
		if (self.hasInstalledStencilSight and self:hasInstalledStencilSight() and self._KK_INS2_stencilsDisableLaser) then return end

		pos = beamAtt.Pos
		ang = beamAtt.Ang

		ang:RotateAroundAxis(ang:Right(), self.LaserAngAdjust.p)
		ang:RotateAroundAxis(ang:Up(), self.LaserAngAdjust.y)
		ang:RotateAroundAxis(ang:Forward(), self.LaserAngAdjust.r)

		local fw = ang:Forward()

		local laserPos = pos + ang:Right() * self.LaserPosAdjust.x + ang:Forward() * self.LaserPosAdjust.y + ang:Up() * self.LaserPosAdjust.z

		td.start = laserPos
		td.endpos = td.start + fw * att.laserRange
		td.filter = self.Owner

		local tr = util.TraceLine(td)

		if not self.lastLaserPos then
			self.lastLaserPos = tr.HitPos
		end

		local dist = math.Clamp(att.laserRange * tr.Fraction, 0, att.laserBeamRange)

		if util.PointContents(tr.HitPos) != CONTENTS_SOLID and not self.NearWall then
			local renderColor = self:getSightColor(att.name) or colDefault
			local laserHQ = GetConVarNumber("cw_laser_quality") > 1

			renderColor.a = 100
			render.SetMaterial(beam)

			render.DrawBeam(laserPos + fw, laserPos + fw * dist, 0.1, 0, 0.99, renderColor)

			if laserHQ then
				renderColor.a = 50
				render.DrawBeam(laserPos + fw, laserPos + fw * dist, 0.6, 0, 0.99, renderColor)

				renderColor.a = 25
				render.DrawBeam(laserPos + fw, laserPos + fw * dist, 1, 0, 0.99, renderColor)
			end

			renderColor.a = 255

			render.SetMaterial(laserDot)

			if GetConVarNumber("cw_laser_blur") >= 1 then
				render.DrawBeam(self.lastLaserPos, tr.HitPos, 1.5, 0, 0.99, renderColor)

				local dist = math.Clamp(self.lastLaserPos:Distance(tr.HitPos), 0, 2)

				dist = 1 - (dist / 2)

				if dist < 2 then
					renderColor.a = 255 * dist
					render.DrawSprite(tr.HitPos, 1.5, 1.5, renderColor)

					if laserHQ then
						renderColor.a = 33 * dist
						render.DrawSprite(tr.HitPos, 3, 3, renderColor)
					end
				end
			else
				render.DrawSprite(tr.HitPos, 1.5, 1.5, renderColor)

				if laserHQ then
					renderColor.a = 33
					render.DrawSprite(tr.HitPos, 3, 3, renderColor)
				end
			end

			self.lastLaserPos = tr.HitPos
		end
	end

	function att:elementRender()
		if not self.ActiveAttachments[att.name] then return end

		-- if (self.dt.INS2LAMMode % 2) == 1 then // TODO: forget
		if (self:GetNWInt("INS2LAMMode") % 2) == 1 then
			local beamAtts = {}
			local element = self.AttachmentModelsVM[att.name]

			if element and IsValid(element.ent) then
				local attId = element.laserAtt or 1
				table.insert(beamAtts, element.ent:GetAttachment(1))
			end

			if element and element.models then
				for _,subElement in pairs(element.models) do
					if IsValid(subElement.ent) then
						local attId = subElement.laserAtt or 1
						table.insert(beamAtts, subElement.ent:GetAttachment(attId))
					end
				end
			end

			if table.Count(beamAtts) < 1 then
				table.insert(beamAtts, self.CW_VM:GetAttachment(1))
			end

			for _,beamAtt in pairs(beamAtts) do
				self.lastLaserPos = nil // TODO: fix?
				att._elementRender(self, beamAtt)
			end
		else
			self.lastLaserPos = nil
		end
	end

	function att:getLEMState()
		return false
	end
end

function att:attachFunc()
	self:SetNWInt("INS2LAMMode", 0)
end

CustomizableWeaponry:registerAttachment(att)
