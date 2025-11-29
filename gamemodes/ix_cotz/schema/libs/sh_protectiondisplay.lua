ix.util = ix.util or {}

local SegmentedBarTexture = ix.util.GetMaterial("cotz/panels/hp1.png", "noclamp smooth") 

function ix.util.GetColorFromValue(value, minVal, maxVal)
    local minHue, maxHue = 0, 210
    local saturation = 0.6
    local hue = math.Remap(value, minVal, maxVal, minHue, maxHue)

    if hue < minHue or hue > maxHue then -- in case values go outside bounds, with attachments for instance
        saturation = 1
    end

    local color = HSVToColor(math.Clamp(hue, minHue, maxHue), saturation, 1)
    
    return color
end

function ix.util.ProtectionTranslator(value, minVal, maxVal)
    local mappedValue = math.Remap(value, minVal, maxVal, 0, 100)

    if mappedValue < 0 then
        return "Drawback"
    elseif mappedValue == 0 then
        return "None"
    elseif mappedValue <= 5 then
        return "Negligible"
    elseif mappedValue <= 10 then
        return "Trivial"
    elseif mappedValue <= 15 then
        return "Bad"
    elseif mappedValue <= 20 then
        return "Minor"
    elseif mappedValue <= 30 then
        return "Weak"
    elseif mappedValue <= 40 then
        return "Decent"
    elseif mappedValue <= 50 then
        return "Good"
    elseif mappedValue <= 60 then
        return "Strong"
    elseif mappedValue <= 70 then
        return "Excellent"
    elseif mappedValue <= 80 then
        return "Incredible"
    elseif mappedValue <= 90 then
        return "Supreme"
    elseif mappedValue <= 100 then
        return "Perfect"
    elseif mappedValue > 100 then
        return "Anomalous"
    end
end


function ix.util.DrawResistance(parentTooltip, resistanceName, value, minVal, maxVal)
    if !parentTooltip:GetRow("resistances") then
        local descheader = parentTooltip:AddRow("resistances")
		descheader:SetText("\nRESISTANCES:")
		descheader:SizeToContents()
		descheader:SetContentAlignment(4)
    end

    local anchor = parentTooltip:AddRowAfter("resistances", resistanceName)
    anchor:SetText("")
    anchor:SetContentAlignment(4)

	local text = anchor:Add("DLabel")
    text:SetPos(12, 0)
    text:SetText(resistanceName)
    text:SetFont("ixSmallFont")
	text:SizeToContents()

    local displayedValue = anchor:Add("DLabel")
--    displayedValue:SetText(ix.util.ProtectionTranslator(value, minVal, maxVal))
    displayedValue:SetText((math.floor(math.Remap(value, minVal, maxVal, 0, 100)+0.5)).."%")
    displayedValue:SetColor(ix.util.GetColorFromValue(value, minVal, maxVal))
    displayedValue:SetFont("ixSmallFont")
	displayedValue:SizeToContents()
    displayedValue:MoveRightOf(text)
end


function ix.util.DrawSuitResistances(parentTooltip, item)
    if !parentTooltip:GetRow("resistances") then
        local descheader = parentTooltip:AddRow("resistances")
		descheader:SetText("\nPROTECTION LEVELS:")
		descheader:SizeToContents()
		descheader:SetContentAlignment(4)
    end

    if item:getBR() then
        -- ix.util.DrawResistance(parentTooltip, "Ballistics: ", item:getBR(), 1 - 0.00, 1 - 0.95)
        ix.util.DrawResistance(parentTooltip, "Ballistics: ", item:getBR(), 1 - 0.00, 0.00)
    end
    if item:getSR() then
        ix.util.DrawResistance(parentTooltip, "Rupture: ", item:getSR(), 1 - 0.00, 0.00)
    end
    if item:getAR() then
        ix.util.DrawResistance(parentTooltip, "Anomalous: ", item:getAR(), 1 -  0.00, 0.00)
    end
    if item:getPR() != 1 then
        ix.util.DrawResistance(parentTooltip, "Psychic: ", item:getPR(), 1 - 0.00, 0.00)
    end
    if item.percentageRadProt > 0 then
        ix.util.DrawResistance(parentTooltip, "Radiation: ", item.percentageRadProt, 0.00, 1)
    end

    parentTooltip:GetParent():SizeToContents()
end

function ix.util.DrawGearResistances(parentTooltip, item)
    if !parentTooltip:GetRow("resistances") then
        local descheader = parentTooltip:AddRow("resistances")
		descheader:SetText("\nPROTECTION LEVELS:")
		descheader:SizeToContents()
		descheader:SetContentAlignment(4)
    end

    if item:getBR() then
        ix.util.DrawResistance(parentTooltip, "Ballistics: ", item:getBR(), 0.00, 1)
    end
    if item:getSR() then
        ix.util.DrawResistance(parentTooltip, "Rupture: ", item:getSR(), 0.00, 1)
    end
    if item:getAR() then
        ix.util.DrawResistance(parentTooltip, "Anomalous: ", item:getAR(), 0.00, 1)
    end
    if item:getPR() > 0 then
        ix.util.DrawResistance(parentTooltip, "Psychic: ", item:getPR(), 0.00, 1)
    end
    if item.percentageRadProt > 0  then
        ix.util.DrawResistance(parentTooltip, "Radiation: ", item.percentageRadProt, 0.00, 1)
    end

    parentTooltip:GetParent():SizeToContents()
end