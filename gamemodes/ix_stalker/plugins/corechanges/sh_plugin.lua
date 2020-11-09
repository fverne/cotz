PLUGIN.name = "Core changes"
PLUGIN.author = "verne"
PLUGIN.desc = "Changes some core helix things"

--adds automatic me's when picking up and dropping items
function PLUGIN:OnItemTransferred(item, curInv, inventory)
	if curInv:GetID() == 0 then
		local client = inventory:GetOwner()
		ix.chat.Send(client, "iteminternal", Format("picks up the %s.", item.name), false)
	end

	if inventory:GetID() == 0 then
		local client = curInv:GetOwner()
		ix.chat.Send(client, "iteminternal", Format("drops their %s.", item.name), false)
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
	function PLUGIN:PostPlayerLoadout(client)
		local character = client:GetCharacter()
		if (character:GetInventory()) then
			for _, v in pairs(character:GetInventory():GetItems()) do
				v:Call("OnLoadout", client)
			end
		end
	end
end

if (CLIENT) then
	function PLUGIN:LoadFonts(font, genericFont)
		surface.CreateFont("ixTypingIndicator", {
			font = font,
			size = 128,
			extended = true,
			weight = 1000
		})
	end

	function PLUGIN:CharacterLoaded()
		-- puts on minimal tooltips by default
		ix.option.Set("minimalTooltips", true, true)

		--hides various settings from the client that dont do anything
		ix.option.stored["minimalTooltips"].hidden = function() return true end
		ix.option.stored["alwaysShowBars"].hidden = function() return true end
		ix.option.stored["24hourTime"].hidden = function() return true end
		ix.option.stored["openBags"].hidden = function() return true end
	end
	
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
end

--needs to be done for both chat class and command
function PLUGIN:InitializedChatClasses()
	ix.chat.classes["looc"] = nil
end

hook.Add("ShouldSuppressMenu", "DeadMenuSuppress", function(client) 
	if(!client:Alive()) then
		return true
	end
end)