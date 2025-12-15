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
function PLUGIN:OnItemTransferred(item, curInv, targetInv)
	if curInv:GetID() == 0 then
		local pickupClient = targetInv:GetOwner()
		ix.chat.Send(pickupClient, "iteminternal", Format("picks up the %s.", item:GetName()), false)

		if item:GetData("bTemporary") then
			item:SetData("bTemporary", false)
		end
	end

	if targetInv:GetID() == 0 then
		local dropClient = curInv:GetOwner()
		if dropClient then
			ix.chat.Send(dropClient, "iteminternal", Format("drops their %s.", item:GetName()), false)
		end
	end
end

function PLUGIN:PopulateItemTooltip(tooltip, item)
	if item.entity and item:GetData("bTemporary") then
		ix.util.MarkedDeletionDesc(tooltip)
		-- ix.util.PropertyDesc(tooltip, "Marked for Deletion", Color(255, 0, 0), ix.util.GetMaterial("vgui/ui/stalker/armorupgrades/explosion.png"), 1000)
	end
end

function PLUGIN:ShouldCollide(ent1, ent2)
	if ( ent1.IsSTALKERNPC and ent2.IsSTALKERNPC ) then return false end
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
	ix.log.AddType("jumpExploit", function(client, map, pos)
		return string.format("%s has tried to do the jump exploit on %s! Pos: %s", client:Name(), map, pos)
	end)

    function PLUGIN:KeyPress(client, key)
        local char = client:GetCharacter()
        if not char then return end

        if key == IN_JUMP then
            if client:OnGround() then
                local current = client:GetLocalVar("stm", 0)
                local value = math.Clamp(current - 20, -5, 100)
                client:SetLocalVar("stm", value)
                char:SetData("jumppos", client:GetPos())
            end
        elseif key == IN_DUCK then
            if not client:OnGround() and not char:GetData("markedexploiter", false) and char:GetData("jumppos", false) then
                char:SetData("markedexploiter", game.GetMap():lower()) -- protective measure, no load zone teleport exploit 4 u :)
            end
        end
    end

    function PLUGIN:PlayerLoadedCharacter(client, character, lastChar)
        -- wait for spawnsaver to setpos first
        timer.Simple(0.5, function()
            if not IsValid(client) then return end
            local savedpos = character:GetData("jumppos", false)

            if character:GetData("markedexploiter", false) == game.GetMap():lower() and isvector(savedpos) then
                client:SetPos(savedpos)
                client:Notify("Your position was reset! Please stop trying to do the jump exploit. :^)")
                ix.log.Add(client, "jumpExploit", game.GetMap():lower(), tostring(savedpos))
                character:SetData("markedexploiter", false)
                character:SetData("jumppos", false)
            end
        end)
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

		local char = ply:GetCharacter()
		local ismarked = char:GetData("markedexploiter", false)

		if char then
			if ismarked then
				if ismarked == game.GetMap():lower() then
					char:SetData("markedexploiter", false)
				end
			else
				if char:GetData("jumppos", false) then
					char:SetData("jumppos", false)
				end
			end
		end

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

ix.option.Add("inventoryScale", ix.type.number, 1, {
	category = "appearance", min = 0.1, max = 2, decimals = 1
})


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

	-- removes default helix intro, as we have our own cotzintro
	function PLUGIN:LoadIntro()
		return true
	end
end

--removal of helix commands we dont use
--removal of helix chats we dont use
function PLUGIN:InitializedPlugins()
	ix.command.list["becomeclass"] = nil
	ix.command.list["chardesc"] = nil
	ix.command.list["eventpda"] = nil
	-- ix.command.list["looc"] = nil
	ix.command.list["charfallover"] = nil
	ix.command.list["chargetup"] = nil
	ix.command.list["setvoicemail"] = nil
end

--needs to be done for both chat class and command
function PLUGIN:InitializedChatClasses()
	-- ix.chat.classes["looc"] = nil
	ix.chat.classes["connect"] = nil
	ix.chat.classes["disconnect"] = nil
end


local icon = Material("vgui/icons/news.png")

ix.chat.Register("playerjoin", {
	CanSay = function(self, speaker, text)
		return true
	end,
	OnChatAdd = function(self, speaker, text)
		chat.AddText(Color(0,191,255), "[LPDA-SYSTEM] ", Color(0,241,255), icon, ": "..text)
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
		chat.AddText(Color(0,191,255), "[LPDA-SYSTEM] ", Color(0,241,255), icon, ": "..text)
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
	-- -- LPDA join
	-- function PLUGIN:CharacterLoaded(character)
	-- 	ix.chat.Send(nil, "playerjoin", string.format("%s has connected to STALKERNET.", character:GetName()))
	-- end
	
	-- -- LPDA disconnect
	-- function PLUGIN:PlayerDisconnected(client)
	-- 	if( client:GetCharacter() ) then
	-- 		ix.chat.Send(nil, "playerleave", string.format("%s has lost connection to STALKERNET.", client:GetCharacter():GetName()))
	-- 	end
	-- end
	
	local newsicon = "vgui/icons/news.png"
	--GPDA join
	function PLUGIN:CharacterLoaded(character)
		local message = string.format("%s has connected to STALKERNET.", character:GetName())
		ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
			name = "SYSTEM",
			message = message,
			icon = newsicon,
			sound = "stalkersound/pda/pda_news.wav"
		})
		ix.crossserverchat.PostMessage("SYSTEM", message, newsicon)
	end

	--GPDA disconnect
	function PLUGIN:PlayerDisconnected(client)
		if( client:GetCharacter() ) then
			local message = string.format("%s has lost connection to STALKERNET.", client:GetCharacter():GetName())
			ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
				name = "SYSTEM",
				message = message,
				icon = newsicon,
				sound = "stalkersound/pda/pda_news.wav",
			})
			ix.crossserverchat.PostMessage("SYSTEM", message, newsicon)
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
		if client:GetCharacter() then
			timer.Simple(0.25, function() 
				if client:GetCharacter() then
					client:SetWepRaised(false)
				end
			end)
		end
	end
end

function PLUGIN:CanTransferItem(item, oldInventory, newInventory)
	if (newInventory and item:GetData("equip")) then
		local owner = item:GetOwner()

		if (IsValid(owner)) then
			owner:Notify("You can't transfer equipped items!")
		end

		return false
	end

	if item.noDrop then
		local owner = item:GetOwner()
		if IsValid(owner) and newInventory != oldInventory then
			owner:Notify("That item cannot be transferred out of your inventory!")

			return false
		end
	end

	return true
end