local PLUGIN = PLUGIN
PLUGIN.name = "Sherpas"
PLUGIN.author = "verne"
PLUGIN.desc = "Tools for helpful players."

ix.char.RegisterVar("SherpaVendors", {
	field = "SherpaVendors",
	fieldType = ix.type.text,
	default = {},
	bNoDisplay = true,
})

local charMeta = ix.meta.character or {}

function charMeta:HasSherpaVendor(sherpavendor)
  	local sherpaVendors = self:GetSherpaVendors()
	for k, v in pairs(sherpaVendors) do
		if sherpavendor == v then
			return true
		end
	end

	return false
end


ix.command.Add("CharResetSherpaVendors", {
	adminOnly = true,
	arguments = {
		ix.type.character,
	},
	OnRun = function(self, client, character)
		if character then
			local target = character
		
			target:SetSherpaVendors({})
			client:Notify("Reset the sherpa vendor list of "..character:GetName())
	    end
	end
})

ix.command.Add("TakeVendorMoney", {
	-- adminOnly = true,
    description = "Take money from the vendor and add to yourself.",
	-- arguments = {},
	OnRun = function(self, client)
		local character = client:GetCharacter()
		if character then
            local trace = client:GetEyeTraceNoCursor()
		    local hitpos = trace.HitPos + trace.HitNormal*5
            for _, v in ipairs(ents.FindByClass("ix_vendor_adv")) do
                local dist = hitpos:Distance(client:GetPos())
                local distance = v:GetPos():Distance( hitpos )
                if distance <= 16 then
					if !character:HasSherpaVendor(v:GetDisplayName()) then
						client:Notify("You don't have access to this vendor!")

						continue
					end

                    local vendorMoney = v:GetMoney()

					v:TakeMoney(vendorMoney)
                    client:GetCharacter():GiveMoney(vendorMoney)

					client:Notify( "Added ".. vendorMoney.. " from " .. v:GetDisplayName().. " to you.")
                end
		    end
	    end
	end,
	OnCheckAccess = function(self, client)
		if !table.IsEmpty(client:GetCharacter():GetSherpaVendors()) then
			return true
		end
	end
})

ix.command.Add("CharAddCurrentSherpaVendor", {
	adminOnly = true,
    description = "Adds the looked at vendor name to a characters sherpa vendor list.",
	arguments = {
		ix.type.character
	},
	OnRun = function(self, client, character)
		if character then
			local target = character
            local sherpaVendors = target:GetSherpaVendors()


            local trace = client:GetEyeTraceNoCursor()
		    local hitpos = trace.HitPos + trace.HitNormal*5
            for _, v in ipairs(ents.FindByClass("ix_vendor_adv")) do
                local dist = hitpos:Distance(client:GetPos())
                local distance = v:GetPos():Distance( hitpos )
                if distance <= 16 then
                    
                    client:Notify( "Added ".. v:GetDisplayName().. " to " .. character:GetName())
                    table.insert(sherpaVendors, v:GetDisplayName())
                end
		    end
            
			target:SetSherpaVendors(sherpaVendors)
	    end
	end
})

ix.command.Add("CharRemoveCurrentSherpaVendor", {
	adminOnly = true,
    description = "Removes the looked at vendor name from a characters sherpa vendor list.",
	arguments = {
		ix.type.character
	},
	OnRun = function(self, client, character)
		if character then
			local target = character
            local sherpaVendors = target:GetSherpaVendors()

            local trace = client:GetEyeTraceNoCursor()
		    local hitpos = trace.HitPos + trace.HitNormal*5
            for _, vendor in ipairs(ents.FindByClass("ix_vendor_adv")) do
                local dist = hitpos:Distance(client:GetPos())
                local distance = vendor:GetPos():Distance( hitpos )
                if distance <= 16 then

                    local vendorToRemove
                    for k, v in pairs(sherpaVendors) do
                        if vendor:GetDisplayName() == v then
                            client:Notify( "Removed  "..v.. " from " .. character:GetName())
                            table.remove(sherpaVendors, k)
                            break
                        end
                    end
                end
		    end

			target:SetSherpaVendors(sherpaVendors)
	    end
	end
})


ix.command.Add("CharAddSherpaVendor", {
	adminOnly = true,
    description = "Adds the vendor name to a characters sherpa vendor list.",
	arguments = {
		ix.type.character,
        ix.type.string
	},
	OnRun = function(self, client, character, vendorname)
		if character then
			local target = character
            local sherpaVendors = target:GetSherpaVendors()
                    
            client:Notify( "Added ".. vendorname.. " to " .. character:GetName())
            table.insert(sherpaVendors, vendorname)
            
			target:SetSherpaVendors(sherpaVendors)
	    end
	end
})

ix.command.Add("CharRemoveSherpaVendor", {
	adminOnly = true,
    description = "Removes the vendor name from a characters sherpa vendor list.",
	arguments = {
		ix.type.character,
        ix.type.string
	},
	OnRun = function(self, client, character, vendorname)
		if character then
			local target = character
            local sherpaVendors = target:GetSherpaVendors()
            local vendorToRemove
            for k, v in pairs(sherpaVendors) do
                if vendorname == v then
                    client:Notify( "Removed  "..v.. " from " .. character:GetName())
                    table.remove(sherpaVendors, k)
                    break
                end
            end

			target:SetSherpaVendors(sherpaVendors)
	    end
	end
})



function PLUGIN:CanPlayerTradeWithVendor(client, entity, uniqueID, selling)
	local vendorname = entity:GetDisplayName()

	if entity:GetSherpa() then
		if selling and client:GetCharacter():HasSherpaVendor(vendorname) then
			return true
		end
	end
end
