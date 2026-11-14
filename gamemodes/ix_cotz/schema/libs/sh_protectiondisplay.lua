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


function ix.util.DrawResistance(tooltip, resistanceName, value, flatValue)
	local name = resistanceName:gsub(":%s*$", "")
	local kind = name:lower()
	local text = name .. ": " .. ix.itemProperties.Format(kind, value)
	if flatValue ~= nil then
		text = text .. "; absorption " .. ix.itemProperties.Format(kind, flatValue / 100)
	end

	ix.itemProperties.AddRow(tooltip, "protection/" .. kind, text)
end

function ix.util.DrawSuitResistances(tooltip, item)
	ix.itemProperties.PopulateProtection(tooltip, item)
end

function ix.util.DrawGearResistances(tooltip, item)
	ix.itemProperties.PopulateProtection(tooltip, item)
end
