if !ATTACHMENT then ATTACHMENT = {} end

ATTACHMENT.Name = "Base Attachment"
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = {
	color_white,"Line1",
	color_black,"Line2"
}
ATTACHMENT.Icon = nil --Revers to questionmark, please give it an icon though!
ATTACHMENT.IconScale = 0.7
ATTACHMENT.Type = "none"

--[[
ATTACHMENT.Type = "none" -- No visual changes

ATTACHMENT.Type = "model" -- Attach a model as defined by the SWEP
ATTACHMENT.Model = "models/wystan/attachments/acog.mdl"
function ATTACHMENT:RenderCode()--Takes the table as the first argument, weapon as second argument, viewmodel as third
	
end

ATTACHMENT.Type = "quad" -- Attach a model as defined by the SWEP
function ATTACHMENT:RenderCode()--Takes the table as the first argument, weapon as second argument, viewmodel as third
	
end

ATTACHMENT.Type = "sprite" -- Attach a model as defined by the SWEP
ATTACHMENT.Material = "sprites/glow01" --Some sprite

ATTACHMENT.Type = "bodygroup" --For specific weapons, you can change bodygroups.
ATTACHMENT.Bodygroups = {
	V = {--Fill this with whatever indices you want, for view model
		[0] = 1 --[Bodygroup ID] = Bodygroup Value	
	},
	W = {--Fill this with whatever indices you want, for world model
		[0] = 1 --[Bodygroup ID] = Bodygroup Value	
	}
}


]]--

--ATTACHMENT.IronSightsPos = Vector(0, 0, 0) --Ironsights Position for this attachment
--ATTACHMENT.IronSightsAng = Vector(0, 0, 0) --Ironsights Angle (SCK Style) for this attachment

function ATTACHMENT:DoIronSights(wep)

	if !self.IronSightsPos and !self.IronSightsAng then return end

	if !wep.OGIronSightsPos then wep.OGIronSightsPos = wep.IronSightsPos end
	if !wep.OGIronSightsAng then wep.OGIronSightsAng = wep.IronSightsAng end
	
	wep.IronSightsPos = self.IronSightsPos
	wep.IronSightsAng = self.IronSightsAng
end

function ATTACHMENT:RevertIronSights(wep)

	if !self.IronSightsPos and !self.IronSightsAng then return end
	
	if wep.OGIronSightsPos then wep.IronSightsPos = wep.OGIronSightsPos  end
	if wep.OGIronSightsAng then wep.IronSightsAng = wep.OGIronSightsAng  end
end

function ATTACHMENT:AttachBase(wep)--self refers to your weapon
	if !IsValid(wep) then return end
	
	self:DoIronSights(wep)
	
	if self.Type == "bodygroup" then
		
		if !wep.VMBodyGroups then wep.VMBodyGroups = {} end
		if !wep.WMBodyGroups then wep.WMBodyGroups = {} end
		if !wep.OGVMBodyGroups then wep.OGVMBodyGroups = {} end
		if !wep.OGWMBodyGroups then wep.OGWMBodyGroups = {} end
		
		if !wep.AttachmentBodygroups then wep.AttachmentBodygroups = {} end
		if !wep.AttachmentBodygroups[self.ID] then wep.AttachmentBodygroups[self.ID] = {} end
		
		local vg, wg
		vg = wep.AttachmentBodygroups[self.ID].V or {}
		wg = wep.AttachmentBodygroups[self.ID].W or {}
		
		if vg then
			for k,v in pairs(vg) do
				if !wep.OGVMBodyGroups[k] then
					wep.OGVMBodyGroups[k] = wep.VMBodyGroups[k]
				end
				wep.VMBodyGroups[k] = v
			end
		end
		
		if wg then
			for k,v in pairs(wg) do
				if !wep.OGWMBodyGroups[k] then
					wep.OGWMBodyGroups[k] = wep.WMBodyGroups[k]
				end
				wep.WMBodyGroups[k] = v
			end
		end
		
		if wep.DoBodyGroups then wep:DoBodyGroups() end
	end
end

function ATTACHMENT:DetachBase(wep)--self refers to your weapon
	if !IsValid(wep) then return end
	
	self:RevertIronSights(wep)
	
	if self.Type == "bodygroup" then
		
		if !wep.VMBodyGroups then wep.VMBodyGroups = {} end
		if !wep.WMBodyGroups then wep.WMBodyGroups = {} end
		if !wep.OGVMBodyGroups then wep.OGVMBodyGroups = {} end
		if !wep.OGWMBodyGroups then wep.OGWMBodyGroups = {} end
		
		if !wep.AttachmentBodygroups then wep.AttachmentBodygroups = {} end
		if !wep.AttachmentBodygroups[self.ID] then wep.AttachmentBodygroups[self.ID] = {} end
		
		local vg, wg
		vg = wep.AttachmentBodygroups[self.ID].V or {}
		wg = wep.AttachmentBodygroups[self.ID].W or {}
		
		if vg then
			for k,v in pairs(vg) do
				wep.VMBodyGroups[k] = wep.OGVMBodyGroups[k] or 0
				wep.OGVMBodyGroups[k] = nil
			end
		end
		
		if wg then
			for k,v in pairs(wg) do
				wep.WMBodyGroups[k] = wep.OGWMBodyGroups[k] or 0
				wep.OGWMBodyGroups[k] = nil
			end
		end
		
		if wep.DoBodyGroups then wep:DoBodyGroups() end
	end
end

function ATTACHMENT:Detach(wep)
	if !IsValid(wep) then return end
	--print("clack")
end

function ATTACHMENT:Attach()--self refers to your weapon
	if !IsValid(wep) then return end
	--print("click")
end

function ATTACHMENT:Detach()
	if !IsValid(wep) then return end
	--print("clack")
end

if !TFA_ATTACHMENT_ISUPDATING then TFAUpdateAttachments() end