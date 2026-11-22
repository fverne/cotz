ix.cotzIcons = ix.cotzIcons or {}

-- Teal used for greyscale icons outside menu buttons, matching the weapon upgrade icons in item properties.
ix.cotzIcons.propertyColor = Color(95, 201, 193)

-- Menu button tints for the greyscale icon16 sets in cotz_ui. Each colour is a least-squares fit of the original
-- full-colour icon against its greyscale master, so tinted icons match the originals. The ws2 originals
-- are multicoloured, so their tints only approximate the dominant hue. Reserve the stalker gold for menu
-- buttons; tooltips and other panels use propertyColor.
ix.cotzIcons.colors = {
	["icon16/stalker_grey/accept.png"] = Color(246, 188, 43),
	["icon16/stalker_grey/attach.png"] = Color(240, 188, 57),
	["icon16/stalker_grey/customize.png"] = Color(242, 188, 53),
	["icon16/stalker_grey/detach.png"] = Color(240, 188, 57),
	["icon16/stalker_grey/dice.png"] = Color(242, 188, 51),
	["icon16/stalker_grey/drink.png"] = Color(243, 188, 49),
	["icon16/stalker_grey/drop.png"] = Color(242, 188, 50),
	["icon16/stalker_grey/eat.png"] = Color(244, 188, 48),
	["icon16/stalker_grey/equip.png"] = Color(242, 188, 49),
	["icon16/stalker_grey/heal.png"] = Color(241, 188, 54),
	["icon16/stalker_grey/load.png"] = Color(242, 188, 52),
	["icon16/stalker_grey/open.png"] = Color(242, 188, 50),
	["icon16/stalker_grey/read.png"] = Color(243, 188, 48),
	["icon16/stalker_grey/repair.png"] = Color(244, 188, 47),
	["icon16/stalker_grey/scrap.png"] = Color(244, 188, 46),
	["icon16/stalker_grey/sell.png"] = Color(242, 188, 51),
	["icon16/stalker_grey/smoke.png"] = Color(246, 188, 42),
	["icon16/stalker_grey/split.png"] = Color(243, 188, 50),
	["icon16/stalker_grey/swallow.png"] = Color(246, 188, 42),
	["icon16/stalker_grey/tgasmask.png"] = Color(241, 188, 52),
	["icon16/stalker_grey/throw.png"] = Color(247, 188, 38),
	["icon16/stalker_grey/unequip.png"] = Color(243, 188, 48),
	["icon16/stalker_grey/unload.png"] = Color(242, 188, 52),
	["icon16/stalker_grey/unload2.png"] = Color(242, 188, 50),
	["icon16/stalker_grey/unlock.png"] = Color(243, 188, 49),

	["icon16/ws2_grey/beer.png"] = Color(250, 255, 230),
	["icon16/ws2_grey/brain--exclamation.png"] = Color(255, 216, 180),
	["icon16/ws2_grey/bug.png"] = Color(130, 255, 133),
	["icon16/ws2_grey/cutlery.png"] = Color(244, 244, 246),
	["icon16/ws2_grey/eye-half.png"] = Color(255, 227, 186),
	["icon16/ws2_grey/pin.png"] = Color(255, 153, 153),
	["icon16/ws2_grey/skull-mad.png"] = Color(255, 251, 247),
	["icon16/ws2_grey/skull.png"] = Color(255, 255, 255),
	["icon16/ws2_grey/target.png"] = Color(255, 212, 212),
	["icon16/ws2_grey/water.png"] = Color(208, 255, 255),
}

-- Returns the tint for a greyscale icon path, or nil when the path is not a known greyscale icon.
function ix.cotzIcons.GetColor(path)
	return ix.cotzIcons.colors[path]
end

-- Sets a DMenuOption's image and tints it when the path is a greyscale icon; other icons keep their colours.
function ix.cotzIcons.SetMenuImage(option, path)
	option:SetImage(path)

	local color = ix.cotzIcons.GetColor(path)
	if not color then
		return
	end

	-- DMenuOption draws its icon through a child DImage created by SetImage.
	local image = option.m_Image
	if IsValid(image) then
		image:SetImageColor(color)
	end
end
