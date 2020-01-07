//-----------------------------------------------------------------------------
// CW_KK_INS2_NWAA_single broadcasts most recent change of attachment active
// state to all clients except weapon owner.
//-----------------------------------------------------------------------------

if SERVER then
	util.AddNetworkString("CW_KK_INS2_NWAA_single")

	local function sendMessage(self, k, v)
		net.Start("CW_KK_INS2_NWAA_single")
		net.WriteEntity(self)
		net.WriteString(k)
		net.WriteBool(v)

		if IsValid(self.Owner) then
			net.SendOmit(self.Owner)
		else
			net.Broadcast()
		end
	end

	function SWEP:_KK_INS2_NWAttach(att)
		sendMessage(self, att.name, true)
	end

	function SWEP:_KK_INS2_NWDetach(att)
		sendMessage(self, att.name, false)
	end
end

if CLIENT then
	local function receive()
		local wep, k, v = net.ReadEntity(), net.ReadString(), net.ReadBool()

		if IsValid(wep) then
			wep.ActiveAttachments[k] = v
		end
	end

	net.Receive("CW_KK_INS2_NWAA_single", receive)
end

//-----------------------------------------------------------------------------
// CW_KK_INS2_NWWE_single is sent from weapon owner client to server to notify
// about most recent WElement state change. Server then broadcasts the message
// the rest of clients.
//-----------------------------------------------------------------------------

if SERVER then
	util.AddNetworkString("CW_KK_INS2_NWWE_single")
end

if CLIENT then
	function SWEP:setElementActive(k,v)
		if self.AttachmentModelsVM and self.AttachmentModelsVM[k] then
			self.AttachmentModelsVM[k].active = v
		end

		if self.AttachmentModelsWM and self.AttachmentModelsWM[k] then
			self.AttachmentModelsWM[k].active = v

			net.Start("CW_KK_INS2_NWWE_single")
			net.WriteEntity(self)
			net.WriteString(k)
			net.WriteBool(v)
			net.SendToServer()
		end
	end
end

local function receive(len, ply)
	local wep, k, v = net.ReadEntity(), net.ReadString(), net.ReadBool()

	if SERVER then
		if IsValid(wep) then
			wep.ActiveWElements = wep.ActiveWElements or {}
			wep.ActiveWElements[k] = v
		end

		net.Start("CW_KK_INS2_NWWE_single")
		net.WriteEntity(wep)
		net.WriteString(k)
		net.WriteBool(v)
		net.SendOmit(ply)
	else
		if IsValid(wep) and wep.AttachmentModelsWM and wep.AttachmentModelsWM[k] then
			wep.AttachmentModelsWM[k].active = v
		end
	end
end

net.Receive("CW_KK_INS2_NWWE_single", receive)

//-----------------------------------------------------------------------------
// CW_KK_INS2_NWAA_full is sent from client-side SWEP:Initialize() to server to
// request full SWEP.ActiveAttachments table. Server then sends table to weapon
// owner`s client.
//-----------------------------------------------------------------------------

if SERVER then
	util.AddNetworkString("CW_KK_INS2_NWAA_full")
end

if CLIENT then
	function SWEP:initNWAA()
		net.Start("CW_KK_INS2_NWAA_full")
		net.WriteEntity(self)
		net.SendToServer()
	end
end

local function receive(len, ply)
	local wep = net.ReadEntity()

	if IsValid(wep) then
		if SERVER then
			net.Start("CW_KK_INS2_NWAA_full")
			net.WriteEntity(wep)
			if istable(wep.ActiveAttachments) then
    			net.WriteTable(wep.ActiveAttachments)
    			net.Send(ply)
			end
		else
			wep.ActiveAttachments = net.ReadTable()
		end
	end
end

net.Receive("CW_KK_INS2_NWAA_full", receive)

//-----------------------------------------------------------------------------
// CW_KK_INS2_NWWE_full works the same way as CW_KK_INS2_NWAA_full.
//-----------------------------------------------------------------------------

if SERVER then
	util.AddNetworkString("CW_KK_INS2_NWWE_full")
end

if CLIENT then
	function SWEP:initNWWE()
		net.Start("CW_KK_INS2_NWWE_full")
		net.WriteEntity(self)
		net.SendToServer()
	end
end

local function receive(len, ply)
	local wep = net.ReadEntity()

	if IsValid(wep) then
		if SERVER then
			if not wep.ActiveWElements then
				return
			end

			net.Start("CW_KK_INS2_NWWE_full")
			net.WriteEntity(wep)
			net.WriteTable(wep.ActiveWElements)
			net.Send(ply)
		else
			if wep.AttachmentModelsWM then
				local tab = net.ReadTable()
				for k,v in pairs(tab) do
					if wep.AttachmentModelsWM[k] then
						wep.AttachmentModelsWM[k].active = v
					end
				end
			end
		end
	end
end

net.Receive("CW_KK_INS2_NWWE_full", receive)