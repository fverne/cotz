PLUGIN.name = "Weight"
PLUGIN.author = "Vex"
PLUGIN.description = "Allows for weight to be added to items."

ix.weight = ix.weight or {}

ix.config.Add("maxWeight", 30, "The maximum weight in Kilograms someone can carry in their inventory.", nil, {
	data = {min = 1, max = 100},
	category = "Weight"
})

ix.config.Add("maxOverWeight", 20, "The maximum amount of weight in Kilograms they can go over their weight limit, this should be less than maxWeight to prevent issues.", nil, {
	data = {min = 1, max = 100},
	category = "Weight"
})

ix.util.Include("sh_meta.lua")
ix.util.Include("sv_plugin.lua")

function ix.weight.WeightString(weight, imperial)
	if (imperial) then
		if (weight < 0.453592) then -- Filthy imperial system; Why do I allow their backwards thinking?
			return math.Round(weight * 35.274, 2).." oz"
		else
			return math.Round(weight * 2.20462, 2).." lbs"
		end
	else
		if (weight < 1) then -- The superior units of measurement.
			return math.Round(weight * 1000, 2).." g"
		else
			return math.Round(weight, 2).." kg"
		end
	end
end

function ix.weight.BaseWeight(character) -- gets total carry cap, not the base carry cap
	local base = ix.config.Get("maxWeight", 30)
	local carryinc = character:GetTotalExtraCarry()

	return base + carryinc
end

function ix.weight.CanCarry(weight, carry, character) -- Calculate if you are able to carry something.
	local max = ix.weight.BaseWeight(character) + ix.config.Get("maxOverWeight", 20)

	return (weight + carry) <= max
end

if (CLIENT) then
	ix.option.Add("imperial", ix.type.bool, false, {
		category = "_stalkersettings"
	})

	function PLUGIN:PopulateItemTooltip(tooltip, item)
		local weight = item:GetWeight()
		local carryinc = item:GetCarryInc()

		if !item.entity then
			if (carryinc) then
				ix.util.PropertyDesc2(tooltip, "Carry Capacity Increase: "..ix.weight.WeightString(carryinc, ix.option.Get("imperial", false)), Color(255, 255, 255), Material("vgui/ui/stalker/armorupgrades/carryweightinc.png"))
			end
		end

		if (weight) then
			ix.util.PropertyDesc3(tooltip, "Weight: "..ix.weight.WeightString(weight, ix.option.Get("imperial", false)), Color(255, 255, 255), Material("vgui/ui/stalker/weaponupgrades/weight.png"), 999)
		end
	end
end

function PLUGIN:HUDPaint()
	local lp = LocalPlayer()
	local char = lp:GetCharacter()
	if (!lp:GetCharacter() or !lp:Alive() or ix.gui.characterMenu:IsVisible() or ix.option.Get("disablehud", false)) then return end

	local max = (ix.weight.BaseWeight(char) + ix.config.Get("maxOverWeight", 5))
	local curWeight = char:GetData("carry", 0)

	-- weight calculation to make it fit to DrawStatusIcon function is a bit weird, but works
	if curWeight > (0.9 * ix.weight.BaseWeight(char)) then
		ix.util.DrawStatusIcon("stalker/ui/overencumbered.png", (max - (curWeight * 1.3)) / max * 100, ScrW()*0.92, ScrH()*0.79)
	end
end
