function SWEP:InitAttachments()
	if SERVER and IsValid(self.Owner) then self:CallOnClient("InitAttachments","") end
	
	self.AttachmentCache = self.AttachmentCache or {}	
	self.Attachments = self.Attachments or {}
	
	for keyv,tab in pairs(self.Attachments) do
		if tab.atts then
			for k,attid in pairs(tab.atts) do
				if !self.AttachmentCache[attid] then
					self.AttachmentCache[attid] = {
						active = false,
						key = keyv
						--Add more later
					}
				end
				self:Detach(attid)
			end
		end
	end
end

function SWEP:Attach( attid, nonetwork )
	local self_tbl = self.AttachmentCache[attid]
	if self_tbl then
		if self_tbl.active then return end
		local tbl = TFA_ATT[attid]
		if tbl then
			if SERVER and !nonetwork then self:CallOnClient("Attach",attid) end
			tbl.AttachBase(tbl,self)
			tbl.Attach(tbl,self)
			self.AttachmentCache[attid].active = true
		else
			print("That attachment isn't registered.  Please register it.")
		end
	else
		print("That attachment isn't supported.  Please add it to SWEP table.")
	end
end

function SWEP:Detach( attid, nonetwork )
	local self_tbl = self.AttachmentCache[attid]
	if self_tbl then
		if !self_tbl.active then return end
		local tbl = TFA_ATT[attid]
		if tbl then
			if SERVER and !nonetwork then self:CallOnClient("Detach",attid) end
			tbl.DetachBase(tbl,self)
			tbl.Detach(tbl,self)
			self.AttachmentCache[attid].active = false
		else
			print("That attachment isn't registered.  Please register it.")
		end
	else
		print("That attachment isn't supported.  Please add it to SWEP table.")
	end
end