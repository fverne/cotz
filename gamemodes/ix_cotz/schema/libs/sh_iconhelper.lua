
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
function ix.util.DrawStatusIcon(iconstring, value, posX, posY, sizeX, sizeY)
    local background = Material("placeholder/here.png")
    local icon = Material(iconstring)

    --draw the circle background, and color it accordingly
    surface.SetMaterial(background)
    if value > 85 then
        surface.SetDrawColor(Color(0, 0, 0, 0))
    elseif value > 75 then
        surface.SetDrawColor(Color(131, 131, 131))
    elseif value > 55 then
        surface.SetDrawColor(Color(177, 255, 103))
    elseif value > 35 then
        surface.SetDrawColor(Color(255, 252, 91))
    elseif value > 15 then
        surface.SetDrawColor(Color(255, 183, 88))
    elseif value <= 15 then
        surface.SetDrawColor(Color(255, 106, 106))
    end
    surface.DrawTexturedRect(posX, posY, sizeX, sizeY)

    --draw the icon on top of the background
    if value <= 85 then
        surface.SetMaterial(icon)
        surface.SetDrawColor(Color(0, 0, 0, 255))
        surface.DrawTexturedRect(posX, posY, sizeX, sizeY) -- TODO: Make this smaller than the background
    end
end


-- draws buff icons, such as healing, psyblock, staminaregen with a white square background
function ix.util.DrawBuffIcon(iconstring, posX, posY, sizeX, sizeY)
    local background = Material("placeholder/here.png")
    local icon = Material(iconstring)

    --draw the square background, and color it accordingly
    surface.SetMaterial(background)
    surface.SetDrawColor(Color(255, 255, 255))
    surface.DrawTexturedRect(posX, posY, sizeX, sizeY)

    --draw the icon on top of the background
    surface.SetMaterial(icon)
    surface.SetDrawColor(Color(0, 0, 0, 255))
    surface.DrawTexturedRect(posX, posY, sizeX, sizeY) -- TODO: Make this smaller than the background
end