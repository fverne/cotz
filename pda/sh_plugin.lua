PLUGIN.name = "PDA chatting system"
PLUGIN.author = "verne"
PLUGIN.description = "PDA chatting system, supporting avatars and nicknames"

ix.config.Add("pdaWiringEnabled", false, "If true, PDA Wiring will be enabled.", nil, {
	category = "PDA Wiring"
})

ix.config.Add("pdaWiringCooldown", 120, "The cooldown between wiring another transaction again.", nil, {
	data = {min = 0, max = 600},
	category = "PDA Wiring"
})

ix.config.Add("pdaWiringSendTime", 20, "The time it takes for the transaction to go through.", nil, {
	data = {min = 0, max = 600},
	category = "PDA Wiring"
})

ix.config.Add("pdaWiringReputationNeeded", true, "If true, PDA wiring will require a reputation threshold to be used.", nil, {
	category = "PDA Wiring"
})

ix.config.Add("pdaWiringReputationNeededMinimum", 50, "The minimum amount of reputation needed to access PDA Wiring. Check reputation plugin for threshold values. DEFAULT = ROOKIE (50 REPUTATION)", nil, {
	data = {min = 0, max = 20943},
	category = "PDA Wiring"
})

ix.config.Add("pdaWiringReputationNeededRank", "Rookie", "The rank name set in the notification for reputation needed for PDA Wiring. Check reputation plugin for ranks.", nil, {
	category = "PDA Wiring"
})

ix.config.Add("pdaWiringMaximumTransactionLimit", 10000, "The maximum amount of money a person can wire within one transaction.", nil, {
    data = {min = 1, max = 999999},
	category = "PDA Wiring"
})

ix.config.Add("pdaLocalRange", 450, "The distance (in units) that /lpda (local ooc) messages can be heard within, similar to /looc.", nil, {
	data = {min = 0, max = 4000},
	category = "PDA Chat"
})

--[[
	Helpers to check whether a player currently owns/has equipped a PDA-type item.
	These look directly at the item's own "equip" data (set by ITEM.functions.Equip/EquipUn)
	instead of trusting a mirrored flag on the character, so they stay accurate even if an
	equipped PDA is dropped, traded, or otherwise removed from the inventory.
]]
local function ixPDAGetEquipped(client)
	local char = IsValid(client) and client:GetCharacter()

	if (!char) then return nil end

	local inv = char:GetInventory()

	if (!inv) then return nil end

	for _, item in pairs(inv:GetItems()) do
		if (item.isPDA and item:GetData("equip")) then
			return item
		end
	end

	return nil
end -- Checks whether the player has a PDA equipped, even if it is in their inventory.

local function ixPDAHasInInventory(client)
	local char = IsValid(client) and client:GetCharacter()

	if (!char) then return false end

	local inv = char:GetInventory()

	if (!inv) then return false end

	for _, item in pairs(inv:GetItems()) do
		if (item.isPDA) then
			return true
		end
	end

	return false
end -- Checks whether the player has a PDA in their inventory, even if it is not equipped.

--removal of helix chats we dont use
hook.Add("InitializedChatClasses", "ixChatRemoval2", function()
	ix.chat.classes["ooc"] = nil
	ix.chat.classes["pm"] = nil

	ix.chat.Register("ooc", {
		CanSay = function(self, speaker, text)
			-- Anyone can use // or /OOC, even without a PDA equipped - it just won't show their PDA identity.
			return true
		end,
		OnChatAdd = function(self, speaker, text, bAnonymous, data)
			local character = speaker:GetCharacter()
			local pdaItem = ixPDAGetEquipped(speaker)

			local displayName = pdaItem and character:GetData("pdanickname", character:GetName()) or character:GetName()
			local avatarPath = pdaItem and character:GetPdaavatar() or "vgui/icons/face_31.png"

			chat.AddText(Color(0,191,255), "[OOC-"..displayName.."] ", Material(avatarPath), color_white, ": "..text)
		end,
		prefix = {"//", "/OOC"},
		description = "Send an out-of-character message to everyone on the server",
		CanHear = function(self, speaker, listener)
			-- Global, like normal OOC - no distance check.
			listener:EmitSound( "stalkersound/da-2_beep1.ogg", 90, 100, 1, CHAN_AUTO )
			return true
		end,
	})

	ix.chat.Register("looc", {
		CanSay = function(self, speaker, text)
			-- Anyone can use /looc or /lpda, even without a PDA equipped - it just won't show their PDA identity.
			return true
		end,
		OnChatAdd = function(self, speaker, text, bAnonymous, data)
			local character = speaker:GetCharacter()
			local pdaItem = ixPDAGetEquipped(speaker)

			--local displayName = pdaItem and character:GetData("pdanickname", character:GetName()) or character:GetName()
			local avatarPath = pdaItem and character:GetPdaavatar() or "vgui/icons/face_31.png" -- Avatar shown in out-of-character chat; if the player has no PDA equipped, the default avatar is shown.

			chat.AddText(Color(0,191,255), "[LOOC-"..speaker:GetCharacter():GetName().."] ", Material(avatarPath), color_white, ": "..text)
		end,
		prefix = {"/looc", "/lpda"},
		description = "Send a local out-of-character message to nearby players",
		CanHear = function(self, speaker, listener)
			if (!IsValid(speaker) or !IsValid(listener)) then return false end

			-- Works like /looc: only players within range can see/hear it. Does NOT require a PDA.
			if (speaker:GetPos():DistToSqr(listener:GetPos()) > (ix.config.Get("pdaLocalRange", 450) ^ 2)) then
				return false
			end

			listener:EmitSound( "stalkersound/da-2_beep1.ogg", 90, 100, 1, CHAN_AUTO )
			return true
		end,
	})

	ix.chat.Register("pm", {
		format = "[PMPDA] %s %s -> %s %s: %s",
		color = Color(0, 191, 255, 255),
		deadCanChat = true,

		OnChatAdd = function(self, speaker, text, bAnonymous, data)
			chat.AddText(self.color, "[PPDA-"..speaker:GetCharacter():GetData("pdanickname", speaker:GetCharacter():GetName()).."] ", " ", Material(speaker:GetCharacter():GetPdaavatar()), color_white, " TO  ", self.color, "[PPDA-"..data.target:GetCharacter():GetData("pdanickname", data.target:GetCharacter():GetName()).." ] ", " ", Material(data.target:GetCharacter():GetPdaavatar()), color_white, "\nMESSAGE : ", text)
			surface.PlaySound("stalkersound/pda/pda.wav")
		end
	})
end)

ix.chat.Register("gpda", {
	CanSay = function(self, speaker, text)
		return true
	end,
	OnChatAdd = function(self, speaker, text, bAnonymous, data)
		chat.AddText(Color(180,61,61), "[GPDA-"..speaker:GetCharacter():GetName().."] ", Material(speaker:GetCharacter():GetPdaavatar()), color_white, ": "..text)
	end,
	description = "Send a message over the Global PDA network",
	CanHear = function(self, speaker, listener)
		listener:EmitSound( "stalkersound/da-2_beep1.ogg", 90, 100, 1, CHAN_AUTO )
		return true
	end,
})

ix.command.Add("gpda", {
	description = "Send a message over the Global PDA network",
	arguments = {
		ix.type.text
	},
	OnRun = function(self, client, message)
		if (!ixPDAHasInInventory(client)) then return client:Notify("[STALKERNET] You need a PDA to use this channel.") end
		if (!ixPDAGetEquipped(client)) then return client:Notify("[STALKERNET] You need to attach the PDA to your belt (\"Attach to Belt\") to use this channel.") end

		ix.chat.Send(client, "gpda", message)

		ix.crossserverchat.PostMessage(nil, client:GetName(), message, client:GetCharacter() and client:GetCharacter():GetPdaavatar() or "vgui/icons/face_31.png")
	end
})

-- Overwrites defualt PM Command
function PLUGIN:InitializedPlugins()
	ix.command.list["pm"] = nil

	ix.command.Add("ppda", {
		description = "@cmdPM",
		arguments = {
			ix.type.player,
			ix.type.text
		},
		alias = {"PM", "pmpda"},
		OnRun = function(self, client, target, message)
			if (!ixPDAHasInInventory(client)) then return client:Notify("[STALKERNET] You need a PDA to use this channel.") end
			if (!ixPDAGetEquipped(client)) then return client:Notify("[STALKERNET] You need to attach the PDA to your belt (\"Attach to Belt\") to use this channel.") end

			if ((client.ixNextPM or 0) < CurTime()) then
				ix.chat.Send(client, "pm", message, false, {client, target}, {target = target})

				client.ixNextPM = CurTime() + 0.5
				target.ixLastPM = client
			end
		end
	})
end

ix.char.RegisterVar("pdaavatar", {
	field = "pdaavatar",
	fieldType = ix.type.string,
	default = "vgui/icons/face_31.png",
	bNoDisplay = true,
})

-- NPC talker PDA
local icon = Material("vgui/icons/news.png")
ix.chat.Register("npcpdainternal", {
	CanSay = function(self, speaker, text)

		return true
	end,
	OnChatAdd = function(self, speaker, text, bAnonymous, data)
		chat.AddText(Color(180,61,61), "[GPDA-"..data.name.."] ", Color(0,241,255), icon, ": "..data.message)
	end,
	prefix = {},
	CanHear = function(self, speaker, listener)
		listener:EmitSound( "stalkersound/pda/pda_news.wav", 55, 100, 0.2, CHAN_AUTO )

		return true
	end,
})

ix.command.Add("npcpda", {
	adminOnly = true,
	description = "Write a PDA message from an arbitrary name",
	arguments = {
			ix.type.string,
			ix.type.text
		},
	OnRun = function(self, client, npcname, message)
		// Relay to discord + xserverchat
		ix.util.HandleChat(npcname, message)

		// Send the message for each player
		ix.chat.Send(client, "npcpdainternal", message, nil, nil, {
			name = npcname,
			message = message
		})
	end
})


do
    hook.Add("InitializedConfig", "ixWireCommand", function()
        local WIRE_NAME = string.gsub(ix.util.ExpandCamelCase(ix.currency.plural), "%s", "")

        ix.command.Add("Wire" .. WIRE_NAME, { -- Yeah there is a lot of if statements and config referencing. Do not commit money laundering with this or the UKM will come for you.
            alias = {"WireMoney"},
            description = "Wires the specified amount of money from your account to the target.",
            arguments = {ix.type.string, ix.type.number},
            OnRun = function(self, client, target, amount)
                if not ix.config.Get("pdaWiringEnabled", true) then return client:Notify("[STALKERNET WIRING] Error! - System admin has disabled the ability to wire transactions.") end
                if ix.config.Get("pdaWiringReputationNeeded", true) and client:getReputation() < ix.config.Get("pdaWiringReputationNeededMinimum", 50) then return client:Notify("[STALKERNET WIRING] Error! - You need to be " .. ix.config.Get("pdaWiringReputationNeededRank", "Rookie") .. "+ to unlock this feature.") end
                client.timeNextWire = client.timeNextWire or CurTime()
                if client.timeNextWire > CurTime() then return client:Notify("[STALKERNET WIRING] Error! - You need to wait " .. math.Round(client.timeNextWire - CurTime(), 1) .. " Second(s) until you can wire again.") end
                amount = math.Round(amount)
                if (amount > ix.config.Get("pdaWiringMaximumTransactionLimit")) then return client:Notify("[STALKERNET WIRING] Error! - You can not send more than " .. ix.currency.symbol .. ix.config.Get("pdaWiringMaximumTransactionLimit") .. " in one transaction.") end
                if (amount < 1) then return client:Notify("[STALKERNET WIRING] Error! - The amount must be greater than 0.") end
                if not ix.util.FindPlayer(target) then return client:Notify("[STALKERNET WIRING] Error! - No target account detected") end
                target = ix.util.FindPlayer(target)
                if target == client then return client:Notify("[STALKERNET WIRING] Error! - You cannot wire money to yourself.") end
                if not client:GetCharacter():HasMoney(amount) then return client:Notify("[STALKERNET WIRING] Error! - Lack of funds in account to send.") end
                if (timer.Exists("ixPDAWiringSend" .. client:SteamID())) then return client:Notify("[STALKERNET WIRING] Error! - Transaction already outgoing.") end
                client:Notify("[STALKERNET WIRING] Beginning to wire " .. ix.currency.symbol .. amount .. " to " .. target:Nick() .. " - ETA: " .. ix.config.Get("pdaWiringSendTime", 20) .. " Seconds.")

                timer.Create("ixPDAWiringSend" .. client:SteamID(), ix.config.Get("pdaWiringSendTime", 20), 1, function()
                    target = target
                    if not target:GetCharacter() then return end
                    if not IsValid(target) then return client:Notify("[STALKERNET WIRING] Error! - No target account detected") end
                    if not IsValid(client) then return end
                    if not client:GetCharacter():HasMoney(amount) then return client:Notify("[STALKERNET WIRING] Error! - Lack of funds in account to send.") end
                    client.timeNextWire = CurTime() + ix.config.Get("pdaWiringCooldown", 120)
                    client:GetCharacter():TakeMoney(amount)
                    target:GetCharacter():GiveMoney(amount)
                    client:Notify("[STALKERNET WIRING] Wiring Successful! - " .. ix.currency.symbol .. amount .. " to " .. target:Nick())
                    target:Notify("[STALKERNET WIRING] You have received " .. ix.currency.symbol .. amount .. " from " .. client:Nick())
                end)
            end
        })
    end)
end