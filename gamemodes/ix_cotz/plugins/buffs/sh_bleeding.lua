local settings = {
	{"bleedingChanceScale", 100, 1, 1000, "Damage giving a 100% bleeding chance."},
	{"bleedingChanceExponent", 2, 0.1, 10, "Exponent emphasizing severe hits."},
	{"bleedingMaximum", 100, 1, 1000, "Maximum bleeding severity."},
	{"bleedingDamageScale", 0.01, 0, 1, "HP lost per second per severity point."},
	{"bleedingClotRate", 0.2, 0, 100, "Severity naturally removed each second."},
}

for _, setting in ipairs(settings) do
	ix.config.Add(setting[1], setting[2], setting[5], nil, {
		category = "Bleeding",
		data = {min = setting[3], max = setting[4], decimals = 2},
	})
end

ix.util.Include("sv_bleeding.lua")
