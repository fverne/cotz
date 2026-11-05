ix.poaching = ix.poaching or {}

ix.poaching.Sharpness = {
	default = 100,
	maximum = 101,
	wearPerPoach = 2,
}

function ix.poaching.GetSharpness(knife)

	return math.Clamp(knife:GetData("sharpness", ix.poaching.Sharpness.default), 0, ix.poaching.Sharpness.maximum)
end

function ix.poaching.GetKnifeTier(knife)
	local bonus = ix.poaching.GetSharpness(knife) > ix.poaching.Sharpness.default and 1 or 0

	return knife.knifetier + bonus
end

function ix.poaching.WearKnife(knife)
	local sharpness = math.min(ix.poaching.GetSharpness(knife), ix.poaching.Sharpness.default)
	knife:SetData("sharpness", math.max(0, sharpness - ix.poaching.Sharpness.wearPerPoach))
end
