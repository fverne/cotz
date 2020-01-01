if not CustomizableWeaponry then return end

AddCSLuaFile()

hook.Add("InitPostEntity", "CW_KK_GM_HANDS_INIT", function()
	weapons.GetStored("cw_base").UseHands = false
end)

if CLIENT then
	local hands, pos, ang

	CustomizableWeaponry.callbacks:addNew("initialize", "KK_GM_HANDS", function(wep)
		if wep and wep.UseHands and wep.elementRender then
			wep.CW_GREN:SetModel("models/weapons/cstrike/c_eq_fraggrenade.mdl")
			
			wep.elementRender.KK_GM_HANDS = function(self)
				hands = self.Owner:GetHands()
				
				if CurTime() > self.grenadeTime then
					hands:SetParent(self.CW_VM)
					hands:AddEffects(EF_BONEMERGE)
					if self.ViewModelFlip then
						render.CullMode(MATERIAL_CULLMODE_CW)
							hands:DrawModel()
						render.CullMode(MATERIAL_CULLMODE_CCW)
					else
						hands:DrawModel()
					end
				else
					hands:SetParent(self.CW_GREN)
					hands:AddEffects(EF_BONEMERGE_FASTCULL)
				end				
			end
			
			wep.drawGrenade = function(self)
				if CurTime() > self.grenadeTime then
					return
				end
				
				if self.CW_GREN:GetCycle() >= 0.98 then
					return
				end
				
				pos, ang = EyePos(), EyeAngles()
				
				self.GrenadePos.z = Lerp(FrameTime() * 10, self.GrenadePos.z, 0)
				
				pos = pos + ang:Up() * self.GrenadePos.z
				pos = pos + ang:Forward() * 2
				
				self.CW_GREN:SetPos(pos)
				self.CW_GREN:SetAngles(ang)
				self.CW_GREN:FrameAdvance(FrameTime())
				self.CW_GREN:FrameAdvance(FrameTime())
				
				cam.IgnoreZ(true)
					self.CW_GREN:DrawModel()
					self.Owner:GetHands():DrawModel()
				cam.IgnoreZ(false)
			end
		end
	end)
end
