local PLUGIN = PLUGIN

function PLUGIN:GetStorageEquipmentBounds(width, height, inventoryWidth, inventoryHeight, storageWidth, storageHeight)
	local gap = math.max(4, math.floor(width * 0.008))
	local inventoryX = width - inventoryWidth - gap
	local equipmentX = storageWidth + gap * 2
	local equipmentHeight = math.min(height - gap * 2, math.max(inventoryHeight, storageHeight))

	return {
		inventory = {x = inventoryX, y = math.max(gap, (height - inventoryHeight) / 2)},
		storage = {x = gap, y = math.max(gap, (height - storageHeight) / 2)},
		equipment = {
			x = equipmentX, y = (height - equipmentHeight) / 2,
			w = math.max(1, inventoryX - equipmentX - gap), h = equipmentHeight,
		},
	}
end

PLUGIN.uiGroups = {
	{name = "PROTECTION", slots = {1, 2, 3, 4, 5}},
	{name = "WEAPONS", slots = {6, 7, 8}},
	{name = "DEVICES", slots = {9, 10, 11, 12, 13, 14, 15}},
}

local function columnCount(width, minimum, gap, maximum)
	return math.max(1, math.min(maximum, math.floor((width + gap) / (minimum + gap))))
end

function PLUGIN:GetEquipmentLayout(width, height, scale)
	local gap = math.max(4, math.floor(8 * scale))
	width = math.max(1, width)
	local footerColumns = columnCount(width, 110 * scale, gap, 5)
	local footerRowHeight = math.floor(38 * scale)
	local headerHeight = math.floor(26 * scale)
	local footerHeight = headerHeight + math.ceil(5 / footerColumns) * footerRowHeight + gap
	local bodyHeight = math.max(1, height - footerHeight - gap)
	local columns = {
		columnCount(width, 92 * scale, gap, 5),
		columnCount(width, 170 * scale, gap, 3),
		columnCount(width, 74 * scale, gap, 7),
	}
	local cardHeights = {
		math.max(112 * scale, math.min(180 * scale, bodyHeight * 0.29)),
		math.max(100 * scale, math.min(150 * scale, bodyHeight * 0.25)),
		math.max(88 * scale, math.min(125 * scale, bodyHeight * 0.21)),
	}
	local result = {groups = {}, cards = {}, footer = {}, footerHeight = footerHeight, gap = gap}
	local y = 0

	for groupIndex, group in ipairs(self.uiGroups) do
		result.groups[groupIndex] = {x = 0, y = y, w = width, h = headerHeight}
		y = y + headerHeight + gap
		local count = columns[groupIndex]
		local cardWidth = (width - gap * (count - 1)) / count
		local cardHeight = math.floor(cardHeights[groupIndex])

		for position, index in ipairs(group.slots) do
			local column = (position - 1) % count
			local row = math.floor((position - 1) / count)
			local x = column * (cardWidth + gap)
			local itemWidth = cardWidth
			if groupIndex == 2 and count == 3 then
				local usable = width - gap * 2
				itemWidth = usable * (position == 3 and 0.18 or 0.41)
				x = (position - 1) * (usable * 0.41 + gap)
			end
			result.cards[index] = {x = x, y = y + row * (cardHeight + gap), w = itemWidth, h = cardHeight}
		end

		y = y + math.ceil(#group.slots / count) * (cardHeight + gap) + gap
	end

	local footerWidth = (width - gap * (footerColumns - 1)) / footerColumns
	for index = 1, 5 do
		result.footer[index] = {
			x = ((index - 1) % footerColumns) * (footerWidth + gap),
			y = headerHeight + math.floor((index - 1) / footerColumns) * footerRowHeight,
			w = footerWidth, h = footerRowHeight - gap,
		}
	end
	result.contentHeight = y

	return result
end
