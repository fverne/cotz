ix.util = ix.util or {}

local SegmentedBarTexture = ix.util.GetMaterial("cotz/panels/hp1.png", "noclamp smooth") 

function ix.util.GetColorFromValue(value, minVal, maxVal)
    local hue = math.Remap(value, minVal, maxVal, 0, 210)
    local color = HSVToColor(math.max(hue, 0), 0.8, 1)
    
    return color
end

function ix.util.ProtectionTranslator(value, minVal, maxVal)
    local mappedValue = math.Remap(value, minVal, maxVal, 0, 100)
    local mappedValue = math.max(mappedValue, 0)

    if mappedValue <= 5 then
        return "None"
    elseif mappedValue <= 10 then
        return "Negligible"
    elseif mappedValue <= 20 then
        return "Bad"
    elseif mappedValue <= 30 then
        return "Weak"
    elseif mappedValue <= 40 then
        return "Decent"
    elseif mappedValue <= 50 then
        return "Good"
    elseif mappedValue <= 60 then
        return "Thick"
    elseif mappedValue <= 70 then
        return "Strong"
    elseif mappedValue <= 80 then
        return "Excellent"
    elseif mappedValue <= 90 then
        return "Impenetrable"
    elseif mappedValue > 90 then
        return "Perfect"
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
    displayedValue:SetText(ix.util.ProtectionTranslator(value, minVal, maxVal))
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
        ix.util.DrawResistance(parentTooltip, "Ballistics: ", item:getBR(), 1 - 0.00, 1 - 0.48)
    end
    if item:getSR() then
        ix.util.DrawResistance(parentTooltip, "Rupture: ", item:getSR(), 1 - 0.00, 1 - 0.86)
    end
    if item:getPR() != 1 then
        ix.util.DrawResistance(parentTooltip, "Psychic: ", item:getPR(), 1 - 0.00, 1 - 0.50)
    end
    if item:getAR() then
        ix.util.DrawResistance(parentTooltip, "Anomalous: ", item:getAR(), 1 -  0.00, 1 - 0.80)
    end
    if item.radProt then
        ix.util.DrawResistance(parentTooltip, "Radiation: ", item.radProt, 1 - 0.00, 1 - 1)
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
        ix.util.DrawResistance(parentTooltip, "Ballistics: ", item:getBR(), 0.00, 0.20)
    end
    if item:getSR() then
        ix.util.DrawResistance(parentTooltip, "Rupture: ", item:getSR(), 0.00, 0.10)
    end
    if item:getPR() != 1 then
        ix.util.DrawResistance(parentTooltip, "Psychic: ", item:getPR(), 0.00, 0.50)
    end
    if item:getAR() then
        ix.util.DrawResistance(parentTooltip, "Anomalous: ", item:getAR(), 0.00, 0.10)
    end
    if item.radProt then
        ix.util.DrawResistance(parentTooltip, "Radiation: ", item.radProt, 0.00, 0.60)
    end

    parentTooltip:GetParent():SizeToContents()
end