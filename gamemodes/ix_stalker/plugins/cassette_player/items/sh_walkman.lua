ITEM.name = "Walkman"
ITEM.description = "A portable cassette player."
ITEM.longdesc = "This older cassette player can play tapes out loud for everyone to hear. It has seen extensive use, as much of the paint is scraped off. You can hardly tell which button is the play button."
ITEM.price = 15000
ITEM.model = "models/kek1ch/portable_player.mdl"
ITEM.width = 2
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(73, 2.9500000476837, 200),
	ang = Angle(110.06369781494, 2.2929935455322, 4.5859870910645),
	fov = 2.17
}
ITEM.exRender = true
ITEM.weight = 1.12

function ITEM:GetDescription()
	local str = self.description

	local customData = self:GetData("custom", {})
	if(customData.desc) then
		str = str.." \n\n"..customData.desc
	else
		str = str.." \n\n"..self.longdesc
	end

	if self:GetData("CurTape", nil) == nil then
		str = str.." \n\nInserted tape: None."
	else
		str = str.." \n\nInserted tape: "..ix.item.list[self:GetData("CurTape", nil)].name.."."
	end

	return str
end

if (CLIENT) then
	function ITEM:PopulateTooltip(tooltip)
		if !self.entity then
			

			ix.util.PropertyDesc(tooltip, "Rare Item", Color(200, 200, 200))
			ix.util.PropertyDesc(tooltip, "Electronic Device", Color(200, 200, 200))
			ix.util.PropertyDesc(tooltip, "Batteries Included", Color(200, 200, 200))

			tooltip:SizeToContents()
		end
	end
end

ITEM.functions.play = {
    name = "Play Tape",
    tip = "useTip",
    icon = "icon16/stalker/split.png",
    OnCanRun = function(item)				
		return (!IsValid(item.entity) and item:GetData("CurTape", nil) != nil)
	end,
    OnRun = function(item)
    	local entity = item.player
		local curtape = item:GetData("CurTape", nil)
		local tape = ix.item.list[curtape]

		if entity.sound then
			entity.sound:Stop()
		end

		tape.options = {}
		for k, v in pairs(tape.cassette_options) do
			tape.options[#tape.options + 1] = k
		end

		entity.CurCassette = data
		entity.sound = CreateSound(entity, table.Random(tape.options))
		entity.sound:Play()
		entity.sound:SetSoundLevel(0)
		--entity:Repeat(tape.cassette_options)
		entity:EmitSound("stalkersound/inv_properties.mp3", 40)
		
		return false
	end,
}

ITEM.functions.insert = {
    name = "Insert Tape",
    tip = "useTip",
    icon = "icon16/stalker/attach.png",
    isMulti = true,
    OnCanRun = function(item)				
		return (!IsValid(item.entity) and item:GetData("CurTape", nil) == nil)
	end,
	multiOptions = function(item, client)
		local targets = {}
        local char = client:GetCharacter()
		
        if (char) then
			local inv = char:GetInventory()

			if (inv) then
				local items = inv:GetItems()

				for k, v in pairs(items) do
					if v.isCassette then
						table.insert(targets, {
							name = v.name,
							data = {v:GetID()},
						})
					else
						continue
					end
				end
			end
		end

        return targets
	end,
    OnRun = function(item, data)
		if !data[1] then
			return false
		end

		local target = data[1]
		local items = item.player:GetCharacter():GetInventory():GetItems()

		for k, invItem in pairs(items) do
			if (data[1]) then
				if (invItem:GetID() == data[1]) then
					target = invItem

					break
				end
			else
				client:Notify("No item selected.")
				return false
			end
		end

		item:SetData("CurTape", target.uniqueID)
		target:Remove()
		item.player:EmitSound("stalkersound/inv_slot.mp3", 40)
		
		return false
	end,
}

ITEM.functions.remove = {
    name = "Remove Tape",
    tip = "useTip",
    icon = "icon16/stalker/detach.png",
    OnCanRun = function(item)				
		return (!IsValid(item.entity) and item:GetData("CurTape", nil) != nil)
	end,
    OnRun = function(item, data)
		local inv = item.player:GetCharacter():GetInventory()
		local curtape = item:GetData("CurTape", nil)
		item:StopSound()

		inv:Add(curtape)
		item:SetData("CurTape", nil)
		item.player:EmitSound("stalkersound/inv_slot.mp3", 40)
		
		return false
	end,
}

ITEM.functions.stopsound = {
    name = "Stop Playing",
    tip = "useTip",
    icon = "icon16/stalker/throw.png",
    OnCanRun = function(item)
		return (!IsValid(item.entity) and item:GetData("CurTape", nil) != nil)
	end,
    OnRun = function(item, data)
		item:StopSound()
		item.player:EmitSound("stalkersound/inv_properties.mp3", 40)
		
		return false
	end,
}

ITEM:Hook("drop", function(item)
	item:StopSound()
end)

function ITEM:StopSound()
	local entity = self.player
	if entity.sound then
		entity.sound:Stop()
	end
end