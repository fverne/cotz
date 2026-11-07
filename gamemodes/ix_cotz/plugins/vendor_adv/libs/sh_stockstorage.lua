ix.vendorStock = ix.vendorStock or {}

for _, key in ipairs({"vendorStock", "vendorRestockClaims"}) do
	ix.char.RegisterVar(key, {
		field = key,
		fieldType = "cotzMediumText",
		default = {},
		bNoNetworking = true,
		bNoDisplay = true,
	})
end
