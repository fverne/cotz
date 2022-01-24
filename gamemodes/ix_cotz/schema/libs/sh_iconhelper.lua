
ix.util.text = ix.util.text or {}

-- returns material of the given item - either img or the exIcon
function ix.util.GetItemIcon(item)
    local icon
    local exIcon = ikon:GetIcon(item.uniqueID)

    if item.img then
        icon = item.img
    elseif item.exRender then
        if (exIcon) then
            icon = exIcon
        else
            ikon:renderIcon(
                item.uniqueID,
                item.width,
                item.height,
                item:GetModel(),
                item.material,
                item.iconCam
            )
            local tmpIcon = ikon:GetIcon(item.uniqueID)
            item = tmpIcon
        end
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


-- draws buff icons, such as healing, psyblock, staminaregen with a white square background
function ix.util.DrawBuffIcon(iconstring, posX, posY, sizeX, sizeY, col)
    local background = ix.util.GetMaterial("stalker/ui/square.png", "noclamp smooth")
    local icon = ix.util.GetMaterial(iconstring, "noclamp smooth")
    local padding = sizeX * 0.1
    local color = col or Color(255, 255, 255)

    --draw the square background, and color it accordingly
    surface.SetMaterial(background)
    surface.SetDrawColor(color)
    surface.DrawTexturedRect(posX, posY, sizeX, sizeY)

    --draw the icon on top of the background
    surface.SetMaterial(icon)
    surface.SetDrawColor(Color(0, 0, 0, 255))
    surface.DrawTexturedRect(posX, posY + padding, sizeX, sizeY - (padding * 2))
end
