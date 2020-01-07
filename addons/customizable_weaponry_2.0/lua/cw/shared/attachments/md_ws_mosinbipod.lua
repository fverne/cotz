local att = {}
att.name = "md_ws_mosinbipod"
att.displayName = "Bipod"
att.displayNameShort = "Bipod"

att.statModifiers = {
	OverallMouseSensMult = -0.1,
	DrawSpeedMult = -0.15
}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/bipod")
	att.description = {
		[1] = {t = "When deployed:", c = CustomizableWeaponry.textColors.REGULAR},
		[2] = {t = "Recoil decreases by 70%", c = CustomizableWeaponry.textColors.POSITIVE},
		[3] = {t = "Greatly improves hip fire accuracy", c = CustomizableWeaponry.textColors.POSITIVE}
	}
end

function att:attachFunc()
	self.BipodInstalled = true
	self.BipodWasDeployed = false
end

function att:detachFunc()
	self.BipodInstalled = false
	
	self:restoreSound()
end

	
function att:elementRender()
	local yes = self.dt.BipodDeployed	
	local no = self.BipodWasDeployed
	local bipod = self.AttachmentModelsVM.md_ws_mosinbipod.ent	
	
	if yes != no then
	
		if yes then
		
			bipod:SetBodygroup(0,1)
			
		else
		
			bipod:SetBodygroup(0,0)
			
		end	
		
	end
	
	self.BipodWasDeployed = yes
	
end

CustomizableWeaponry:registerAttachment(att)