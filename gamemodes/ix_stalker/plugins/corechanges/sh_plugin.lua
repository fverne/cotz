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

	function PLUGIN:GetFallDamage(client, speed)
		return (speed / 8)
	end
end

if (CLIENT) then
	function PLUGIN:LoadFonts(font, genericFont)
		surface.CreateFont("ix3D2DFont", {
			font = font,
			size = 128,
			extended = true,
			weight = 100
		})

		surface.CreateFont("ix3D2DMediumFont", {
			font = font,
			size = 48,
			extended = true,
			weight = 100
		})

		surface.CreateFont("ix3D2DSmallFont", {
			font = font,
			size = 24,
			extended = true,
			weight = 400
		})

		surface.CreateFont("ixTitleFont", {
			font = font,
			size = ScreenScale(30),
			extended = true,
			weight = 100
		})

		surface.CreateFont("ixSubTitleFont", {
			font = font,
			size = ScreenScale(16),
			extended = true,
			weight = 100
		})

		surface.CreateFont("ixMenuMiniFont", {
			font = font,
			size = math.max(ScreenScale(4), 18),
			weight = 300,
		})

		surface.CreateFont("ixMenuButtonFont", {
			font = font,
			size = ScreenScale(14),
			extended = true,
			weight = 100
		})

		surface.CreateFont("ixMenuButtonFontSmall", {
			font = font,
			size = ScreenScale(10),
			extended = true,
			weight = 100
		})

		surface.CreateFont("ixMenuButtonFontThick", {
			font = font,
			size = ScreenScale(14),
			extended = true,
			weight = 300
		})

		surface.CreateFont("ixMenuButtonLabelFont", {
			font = font,
			size = 28,
			extended = true,
			weight = 100
		})

		surface.CreateFont("ixMenuButtonHugeFont", {
			font = font,
			size = ScreenScale(24),
			extended = true,
			weight = 100
		})

		surface.CreateFont("ixToolTipText", {
			font = font,
			size = 20,
			extended = true,
			weight = 500
		})

		surface.CreateFont("ixMonoSmallFont", {
			font = font,
			size = 12,
			extended = true,
			weight = 800
		})

		surface.CreateFont("ixMonoMediumFont", {
			font = font,
			size = 22,
			extended = true,
			weight = 800
		})

		-- The more readable font.
		font = genericFont

		surface.CreateFont("ixBigFont", {
			font = font,
			size = 36,
			extended = true,
			weight = 1000
		})

		surface.CreateFont("ixMediumFont", {
			font = font,
			size = 25,
			extended = true,
			weight = 1000
		})

		surface.CreateFont("ixNoticeFont", {
			font = font,
			size = math.max(ScreenScale(8), 18),
			weight = 100,
			extended = true,
			antialias = true
		})

		surface.CreateFont("ixMediumLightFont", {
			font = font,
			size = 25,
			extended = true,
			weight = 200
		})

		surface.CreateFont("ixMediumLightBlurFont", {
			font = font,
			size = 25,
			extended = true,
			weight = 200,
			blursize = 4
		})

		surface.CreateFont("ixGenericFont", {
			font = font,
			size = 20,
			extended = true,
			weight = 1000
		})

		surface.CreateFont("ixChatFont", {
			font = font,
			size = math.max(ScreenScale(7), 17) * ix.option.Get("chatFontScale", 1),
			extended = true,
			weight = 600,
			antialias = true
		})

		surface.CreateFont("ixChatFontItalics", {
			font = font,
			size = math.max(ScreenScale(7), 17) * ix.option.Get("chatFontScale", 1),
			extended = true,
			weight = 600,
			antialias = true,
			italic = true
		})

		surface.CreateFont("ixSmallTitleFont", {
			font = font,
			size = math.max(ScreenScale(12), 24),
			extended = true,
			weight = 100
		})

		surface.CreateFont("ixMinimalTitleFont", {
			font = font,
			size = math.max(ScreenScale(8), 22),
			extended = true,
			weight = 800
		})

		surface.CreateFont("ixSmallFont", {
			font = font,
			size = math.max(ScreenScale(6), 17),
			extended = true,
			weight = 500
		})

		surface.CreateFont("ixItemDescFont", {
			font = font,
			size = math.max(ScreenScale(6), 17),
			extended = true,
			shadow = true,
			weight = 500
		})

		surface.CreateFont("ixSmallBoldFont", {
			font = font,
			size = math.max(ScreenScale(8), 20),
			extended = true,
			weight = 800
		})

		surface.CreateFont("ixItemBoldFont", {
			font = font,
			shadow = true,
			size = math.max(ScreenScale(8), 20),
			extended = true,
			weight = 800
		})

		-- Introduction fancy font.
		--font = "Roboto Th"

		surface.CreateFont("ixIntroTitleFont", {
			font = font,
			size = math.min(ScreenScale(128), 128),
			extended = true,
			weight = 100
		})

		surface.CreateFont("ixIntroTitleBlurFont", {
			font = font,
			size = math.min(ScreenScale(128), 128),
			extended = true,
			weight = 100,
			blursize = 4
		})

		surface.CreateFont("ixIntroSubtitleFont", {
			font = font,
			size = ScreenScale(24),
			extended = true,
			weight = 100
		})

		surface.CreateFont("ixIntroSmallFont", {
			font = font,
			size = ScreenScale(14),
			extended = true,
			weight = 100
		})

		surface.CreateFont("ixIconsSmall", {
			font = "fontello",
			size = 22,
			extended = true,
			weight = 500
		})

		surface.CreateFont("ixSmallTitleIcons", {
			font = "fontello",
			size = math.max(ScreenScale(11), 23),
			extended = true,
			weight = 100
		})

		surface.CreateFont("ixIconsMedium", {
			font = "fontello",
			extended = true,
			size = 28,
			weight = 500
		})

		surface.CreateFont("ixIconsMenuButton", {
			font = "fontello",
			size = ScreenScale(14),
			extended = true,
			weight = 100
		})

		surface.CreateFont("ixIconsBig", {
			font = "fontello",
			extended = true,
			size = 48,
			weight = 500
		})
	end

	function PLUGIN:CharacterLoaded()
		-- puts on minimal tooltips by default
		ix.option.Set("minimalTooltips", true, true)

		-- sets options for players that we want them to have
		ix.option.Set("disableAnimations", true, true)
		ix.option.Set("cheapBlur", false, true)
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
		ix.option.stored["legsInVehicle"].hidden = function() return true end
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