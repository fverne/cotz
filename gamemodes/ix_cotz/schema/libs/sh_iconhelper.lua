ix.util.text = ix.util.text or {}

-- returns material of the given item - either img or the exIcon
function ix.util.GetItemIcon(item)
    local icon
    local exIcon = ikon:GetIcon(item.uniqueID)

    if item:GetData("img", item.img) then
        icon = ix.util.GetMaterial(item:GetData("img", item.img))
    elseif exIcon then
        icon = exIcon
    else
		ikon:renderIcon(
			item.uniqueID,
			item.width,
			item.height,
			item:GetModel(),
			item.iconCam,
			nil,
			item:GetMaterial()
		)
        icon = ikon:GetIcon(item.uniqueID)
    end

    return icon
end


-- draws status icons, such as hunger, thirst, radiation, with a coloured circle background
function ix.util.DrawStatusIcon(iconstring, value, posX, posY, padding)
    local background = ix.util.GetMaterial("stalker/ui/circle.png", "noclamp smooth")
    local icon = ix.util.GetMaterial(iconstring, "noclamp smooth")
    local sizeX, sizeY = ScrW() * 0.018, ScrH() * 0.030
    padding = padding or 0.1
    local paddingX, paddingY = sizeX * padding, sizeY * padding

    --draw the circle background, and color it accordingly
    surface.SetMaterial(background)
    if value > 90 then
        surface.SetDrawColor(Color(0, 0, 0, 0))
    elseif value > 60 then
        surface.SetDrawColor(Color(131, 131, 131))
    elseif value > 40 then
        surface.SetDrawColor(Color(177, 255, 103))
    elseif value > 20 then
        surface.SetDrawColor(Color(255, 255, 0))
    elseif value > 0 then
        surface.SetDrawColor(Color(255, 183, 88))
    elseif value <= 0 then
        surface.SetDrawColor(Color(255, 0, 0))
    end
    surface.DrawTexturedRect(posX, posY, sizeX, sizeY)

    --draw the icon on top of the background
    if value <= 90 then
        surface.SetMaterial(icon)
        surface.SetDrawColor(Color(0, 0, 0, 255))
        surface.DrawTexturedRect(posX + paddingX, posY + paddingY, sizeX - (paddingX * 2), sizeY - (paddingY * 2))
    end
end


function ix.util.DrawBuffIcon(iconstring, posX, posY, sizeX, sizeY, col, text)
	local padding = ix.cotzUI.Scale(3)
	local color = col or ix.cotzUI.colors.text
	local icon = ix.util.GetMaterial(iconstring, "noclamp smooth")
	surface.SetDrawColor(ix.cotzUI.colors.card)
	surface.DrawRect(posX, posY, sizeX, sizeY)
	surface.SetDrawColor(color)
	surface.DrawOutlinedRect(posX, posY, sizeX, sizeY)
	surface.SetMaterial(icon)
	surface.DrawTexturedRect(posX + padding, posY + padding, sizeX - padding * 2, sizeY - padding * 2)
	if text then
		text = tostring(text)
		surface.SetFont("cotzUISmall")
		local width, height = surface.GetTextSize(text)
		local x, y = posX + sizeX - width - padding, posY + sizeY - height
		surface.SetDrawColor(ix.cotzUI.colors.background)
		surface.DrawRect(x - padding, y, width + padding * 2, height)
		draw.SimpleText(text, "cotzUISmall", x, y, ix.cotzUI.colors.text)
	end
end
