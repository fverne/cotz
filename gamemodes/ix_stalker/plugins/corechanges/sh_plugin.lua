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


--	ix.plugin.SetUnloaded("stamina", true)
--	ix.plugin.SetUnloaded("strength", true)
--  ix.plugin.SetUnloaded("doors", true)

function PLUGIN:LoadFonts(font, genericFont)
	surface.CreateFont("ixTypingIndicator", {
		font = "alsina",
		size = 128,
		extended = true,
		weight = 1000
	})
end


if (SERVER) then
	function PLUGIN:KeyPress(client, key)
		if (key == IN_JUMP) then
			if (client:OnGround()) then
				local current = client:GetLocalVar("stm", 0)
				local value = math.Clamp(current - 20, -5, 100)

				client:SetLocalVar("stm", value)
			end
		end
	end
end

if (CLIENT) then
	function PLUGIN:CharacterLoaded()
		ix.option.Set("minimalTooltips", true, true)
		ix.option.stored["minimalTooltips"].hidden = function() return true end
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

function PLUGIN:InitializedChatClasses()
	ix.chat.classes["looc"] = nil
end