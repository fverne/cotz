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

	function PLUGIN:SpawnMenuOpen()
		if LocalPlayer():GetCharacter():HasFlags("petN") or LocalPlayer():IsAdmin() then
			return true
		else
			return false
		end
	end

	function PLUGIN:ContextMenuOpen()
		if LocalPlayer():GetCharacter():HasFlags("petN") or LocalPlayer():IsAdmin() then
			return true
		else
			return false
		end
	end
end

function PLUGIN:GetDefaultAttributePoints(client, count)
	return 40
end

do
	ix.char.RegisterVar("attributes", {
		field = "attributes",
		fieldType = ix.type.text,
		default = {},
		index = 4,
		category = "attributes",
		isLocal = true,
		OnDisplay = function(self, container, payload)
			local maximum = hook.Run("GetDefaultAttributePoints", LocalPlayer(), payload) or ix.config.Get("maxAttributes", 30)

			if (maximum < 1) then
				return
			end

			local attributes = container:Add("DPanel")
			attributes:Dock(TOP)

			local y
			local total = 0

			payload.attributes = {}

			-- total spendable attribute points
			local totalBar = attributes:Add("ixAttributeBar")
			totalBar:SetMax(maximum)
			totalBar:SetValue(maximum)
			totalBar:Dock(TOP)
			totalBar:DockMargin(2, 2, 2, 2)
			totalBar:SetText("Attribute Points left:".." ("..totalBar:GetValue()..")")
			totalBar:SetReadOnly(true)
			totalBar:SetColor(Color(20, 120, 20, 255))

			y = totalBar:GetTall() + 4

			for k, v in SortedPairsByMemberValue(ix.attributes.list, "name") do
				if v.secondary == true then
					continue
				end

				payload.attributes[k] = 0

				local bar = attributes:Add("ixAttributeBar")
				bar:SetMax(40)
				bar:SetValue(20)
				bar:SetMin(20)
				bar:Dock(TOP)
				bar:DockMargin(2, 2, 2, 2)
				bar:SetText(L(v.name.." ("..bar:GetValue()..")"))
				payload.attributes[k] = bar:GetValue()
				bar.OnChanged = function(this, difference)
					if ((total + difference) > maximum) then
						return false
					end

					total = total + difference
					payload.attributes[k] = bar.value+difference
					bar:SetText(L(v.name.." ("..bar.value+difference..")"))

					totalBar:SetValue(totalBar.value - difference)
					totalBar:SetText("Attribute Points left:".." ("..totalBar:GetMax()-total..")")
				end

				if (v.noStartBonus) then
					bar:SetReadOnly()
				end

				y = y + bar:GetTall() + 4
			end

			attributes:SetTall(y)
			return attributes
		end,
		OnValidate = function(self, value, data, client)
			if (value != nil) then
				if (istable(value)) then
					local count = 0

					for _, v in pairs(value) do
						count = count + v
					end

					if (count > (300)) then
						return false, "unknownError"
					end
				else
					return false, "unknownError"
				end
			end
		end,
		ShouldDisplay = function(self, container, payload)
			return !table.IsEmpty(ix.attributes.list)
		end
	})
end