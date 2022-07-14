local PLUGIN = PLUGIN

PLUGIN.name = "Personal Storage"
PLUGIN.author = "gm1003 ツ - modified by verne"
PLUGIN.description = "Adds upgradable personal storage to characters."

ix.config.Add("bankW", 3, "How many slots in a row there is by default in the bank inventory.", nil, {
	data = {min = 0, max = 20},
	category = "Bank"
})
ix.config.Add("bankH", 2, "How many slots in a column there is by default in the bank inventory.", nil, {
	data = {min = 0, max = 20},
	category = "Bank"
})
ix.config.Add("bankWMax", 6, "How many slots in a row there is by default in the bank inventory.", nil, {
	data = {min = 0, max = 20},
	category = "Bank"
})
ix.config.Add("bankHMax", 4, "How many slots in a column there is by default in the bank inventory.", nil, {
	data = {min = 0, max = 20},
	category = "Bank"
})

function PLUGIN:OnCharacterCreated(client, character)
    ix.inventory.New(character:GetID(), "bankInvType", function(inventory)
        character:SetData("bankID", inventory:GetID())
    end)
end

ix.command.Add("debugupgradesafewidth", {
	adminOnly = true,
	arguments = {
		ix.type.player,
	},
	OnRun = function(self, client, target)
        local bankW = target:GetCharacter():GetData("bankW", ix.config.Get("bankW", 2))
        if bankW < ix.config.Get("bankWMax", 2) then
            target:GetCharacter():SetData("bankW", bankW+1)
            client:Notify("Updated the target inventory to width: "..target:GetCharacter():GetData("bankW"))
        else
            client:Notify("Cannot update target inventory! It's width is maxed, which is "..target:GetCharacter():GetData("bankW", ix.config.Get("bankW", 3)))
        end
    end,
})

ix.command.Add("debugupgradesafeheight", {
	adminOnly = true,
	arguments = {
		ix.type.player,
	},
	OnRun = function(self, client, target)
        local bankH = target:GetCharacter():GetData("bankH", ix.config.Get("bankH", 2))
        if bankH < ix.config.Get("bankHMax", 2) then
            target:GetCharacter():SetData("bankH", bankH+1)
            client:Notify("Updated the target inventory to height: "..target:GetCharacter():GetData("bankH"))
        else
            client:Notify("Cannot update target inventory! It's height maxed, which is "..target:GetCharacter():GetData("bankH", ix.config.Get("bankH", 2)))
        end
    end,
})

ix.command.Add("debugupgradesafereset", {
	adminOnly = true,
	arguments = {
		ix.type.player,
	},
	OnRun = function(self, client, target)
        target:GetCharacter():SetData("bankW", ix.config.Get("bankW", 2))
        target:GetCharacter():SetData("bankH", ix.config.Get("bankH", 2))
        client:Notify("Reset target inventory.")
    end,
})

ix.command.Add("debugupgradesafeopen", {
	adminOnly = true,
	arguments = {
		ix.type.player,
	},
	OnRun = function(self, client, target)
        local character = client:GetCharacter()			
        local ID = character:GetData("bankID")
        local bank

        local bankstruct = {}
        bankstruct[ID] = {character:GetData("bankW", ix.config.Get("bankW", 3)), character:GetData("bankH", ix.config.Get("bankH", 2))}
    
        if ID then
            ix.inventory.Restore(bankstruct, ix.config.Get("bankW", 3), ix.config.Get("bankH", 2), function(inventory)
                bank = inventory
                bank:SetOwner(character:GetID())
            end)
        else
            bank = ix.inventory.Create(ix.config.Get("bankW", 3), ix.config.Get("bankH", 2), os.time())
            bank:SetOwner(character:GetID())
            bank:Sync(client)
    
            character:SetData("bankID", bank:GetID())
        end

        timer.Simple(0.1, function()
            ix.storage.Open(client, bank, {
                entity = client,
                name = "Personal Storage",
                searchText = "Accessing personal storage...",
                searchTime = ix.config.Get("containerOpenTime", 1)
            })
        end)
    end,
})