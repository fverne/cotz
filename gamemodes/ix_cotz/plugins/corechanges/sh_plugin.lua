PLUGIN.name = "Core changes"
PLUGIN.author = "verne"
PLUGIN.desc = "Changes some core helix things"

ix.chat.Register("iteminternal", {
	format = "**%s %s",
	GetColor = function(speaker, text)
		return Color(255, 70, 0)
	end,
	CanHear = ix.config.Get("chatRange", 280),
	deadCanChat = true
})

--adds automatic me's when picking up and dropping items
function PLUGIN:OnItemTransferred(item, curInv, inventory)
	if curInv:GetID() == 0 then
		local client = inventory:GetOwner()
		ix.chat.Send(client, "iteminternal", Format("picks up the %s.", item.name), false)
	end

	if inventory:GetID() == 0 then
		local client = curInv:GetOwner()
		if client then
			ix.chat.Send(client, "iteminternal", Format("drops their %s.", item.name), false)
		end
	end
end

-- removes plugins we dont need
ix.plugin.SetUnloaded("stamina", true)
ix.plugin.SetUnloaded("strength", true)
ix.plugin.SetUnloaded("doors", true)
ix.plugin.SetUnloaded("recognition", true)

--remove description box from char creation
ix.char.vars["description"].bNoDisplay = true
ix.char.vars["description"].OnValidate = function() return true	end


ix.config.Add("charloadremove", true, "If enabled, instantly loads first character.", nil, {
	category = "1development"
})

function PLUGIN:PostGamemodeLoaded()
	concommand.Remove( "status" ) -- needs testing...
	concommand.Remove( "ix_togglethirdperson" ) -- needs testing...
end

function PLUGIN:GetGameDescription()
	return (Schema and Schema.name or "Unknown")
end

if (SERVER) then
	-- Stamina drain on jump
	function PLUGIN:KeyPress(client, key)
		if (key == IN_JUMP) then
			if (client:OnGround()) then
				local current = client:GetLocalVar("stm", 0)
				local value = math.Clamp(current - 20, -5, 100)

				client:SetLocalVar("stm", value)
			end
		end
	end

	--funny meme when PostPlayerLoadout breaks in the framework and is never called :)))
	--[[function PLUGIN:PostPlayerLoadout(client)
		local character = client:GetCharacter()
		if (character:GetInventory()) then
			for _, v in pairs(character:GetInventory():GetItems()) do
				v:Call("OnLoadout", client)
			end
		end
	end]]--

	--disable ix fall damage hook
	function PLUGIN:GetFallDamage(client, speed)
		return
	end

	--edit fall damage
	function PLUGIN:OnPlayerHitGround(ply, inWater, onFloater, speed)
		local damage = math.Clamp(math.pow(speed/100, 2.1),0,1000)
		if speed > 400 then
			--ply:EmitSound(FallSound)
			ply:TakeDamage(damage,game.GetWorld(),game.GetWorld())
			return true
		else
			return true
		end

		return true
	end

	--disable damage from trigger_hurt
	function PLUGIN:EntityTakeDamage( target, dmginfo )
		if dmginfo:GetAttacker():GetClass() == "trigger_hurt" and dmginfo:GetDamageType() == DMG_GENERIC then
			return true
		end
	end
end

if (CLIENT) then
	function PLUGIN:CharacterLoaded()
		-- puts on minimal tooltips by default
		ix.option.Set("minimalTooltips", true, true)

		-- sets options for players that we want them to have
		ix.option.Set("disableAnimations", true, true)
		ix.option.Set("cheapBlur", true, true)
		ix.option.Set("language", "english", true)
		ix.option.Set("observerTeleportBack", false, true)



		--hides various settings from the client that dont do anything
		ix.option.stored["minimalTooltips"].hidden = function() return true end
		ix.option.stored["alwaysShowBars"].hidden = function() return true end
		ix.option.stored["animationScale"].hidden = function() return true end
		ix.option.stored["24hourTime"].hidden = function() return true end
		ix.option.stored["openBags"].hidden = function() return true end
		ix.option.stored["disableAnimations"].hidden = function() return true end
		ix.option.stored["cheapBlur"].hidden = function() return true end
		ix.option.stored["language"].hidden = function() return true end
		--ix.option.stored["legsInVehicle"].hidden = function() return true end
	end
	
	--removes help menu tabs (as its now an encyclopedia)
	hook.Add("PopulateHelpMenu", "ixHelpRemove", function(tabs)
	    tabs["flags"] = nil
	    tabs["plugins"] = nil
	end)
end

--removal of helix commands we dont use
--removal of helix chats we dont use
function PLUGIN:InitializedPlugins()
	ix.command.list["becomeclass"] = nil
	ix.command.list["chardesc"] = nil
	ix.command.list["eventpda"] = nil
	ix.command.list["looc"] = nil
	ix.command.list["charfallover"] = nil
	ix.command.list["chargetup"] = nil
	ix.command.list["setvoicemail"] = nil
end

--needs to be done for both chat class and command
function PLUGIN:InitializedChatClasses()
	ix.chat.classes["looc"] = nil
	ix.chat.classes["connect"] = nil
	ix.chat.classes["disconnect"] = nil
end


local icon = Material("vgui/icons/news.png")

ix.chat.Register("playerjoin", {
	CanSay = function(self, speaker, text)
		return true
	end,
	OnChatAdd = function(self, speaker, text)
		chat.AddText(Color(0,191,255), "[GPDA-SYSTEM] ", Color(0,241,255), icon, ": "..text)
	end,
	prefix = {},
	CanHear = function(self, speaker, listener)
		if IsValid(listener) then
			listener:EmitSound( "stalkersound/pda/pda_news.wav", 55, 100, 0.2, CHAN_AUTO )
			return true
		end

		return false
	end,
})

ix.chat.Register("playerleave", {
	CanSay = function(self, speaker, text)
		return true
	end,
	OnChatAdd = function(self, speaker, text)
		chat.AddText(Color(0,191,255), "[GPDA-SYSTEM] ", Color(0,241,255), icon, ": "..text)
	end,
	prefix = {},
	CanHear = function(self, speaker, listener)
		if IsValid(listener) then
			listener:EmitSound( "stalkersound/pda/pda_news.wav", 55, 100, 0.2, CHAN_AUTO ) 
		end
		return true
	end,
})

if (SERVER) then
	function PLUGIN:CharacterLoaded(character)
		ix.chat.Send(nil, "playerjoin", string.format("%s has connected to STALKERNET.", character:GetName()))
	end

	function PLUGIN:PlayerDisconnected(client)
		if( client:GetCharacter() ) then
			ix.chat.Send(nil, "playerleave", string.format("%s has lost connection to STALKERNET.", client:GetCharacter():GetName()))
		end
	end
end


hook.Add("ShouldSuppressMenu", "DeadMenuSuppress", function(client) 
	if(!client:Alive()) then
		return true
	end
end)

if(SERVER)then
	function PLUGIN:PlayerSpawn(client)
		if client then
			timer.Simple(1, function() 
				if client then
					client:SetWepRaised(false)
				end
			end)
		end
	end
end