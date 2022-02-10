
--[[--
Interactable entities that can be held in inventories.

Items are objects that are contained inside of an `Inventory`, or as standalone entities if they are dropped in the world. They
usually have functionality that provides more gameplay aspects to the schema. For example, the zipties in the HL2 RP schema
allow a player to tie up and search a player.

For an item to have an actual presence, they need to be instanced (usually with `ix.item.Instance`). Items describe the
properties, while instances are a clone of these properties that can have their own unique data (e.g an ID card will have the
same name but different numerical IDs). You can think of items as the class, while instances are objects of the `Item` class.
]]
-- @classmod Item

local ITEM = ix.meta.item or {}

--- Returns the material of the item.
-- @realm shared
-- @treturn string The material of the item
function ITEM:GetMaterial()
	return self.material or ""
end

function ITEM:GetColor()
	return self.color or Color(255, 255, 255, 255)
end