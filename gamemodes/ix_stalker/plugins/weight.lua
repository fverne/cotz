PLUGIN.name = "Weight"
PLUGIN.author = "Lt. Taylor"
PLUGIN.desc = "Adds a Weight system for items"

if (SERVER) then
    function PLUGIN:CharacterLoaded(char)
        if char == nil then return end
        local character = char
        local inventory = character:GetInv()
        local weight = 0
        local quantity = 1
        local totweight = 0
        local maxweight = 50
        for x, y in pairs(inventory:GetItems()) do
			if y.weight == nil then continue end
		
            if y.quantity then
                quantity = y.quantity
            end
            if y:GetData("weight") ~= nil then
                weight = y:GetData("weight",0)
            elseif y.weight ~= nil then
                weight = y.weight
            end
            
            if y.isCW then
                if weight ~= (y.weight + y:GetData("weight",0)) then
            	    weight = y.weight + y:GetData("weight",0)
            	end
            end
            
            totweight = ((quantity * weight) + totweight)
                    
            if y.name == "Small Backpack" and maxweight < 55 then
                maxweight = 55
            end
                    
            if y.name == "Large Backpack" and maxweight < 60 then
                maxweight = 60
            end
        end
        character:SetData("Weight", totweight)
        character:SetData("MaxWeight", maxweight)
    end
elseif (CLIENT) then
    function PLUGIN:PostDrawInventory(panel)
        if LocalPlayer():GetChar() == nil then return end
        local character = LocalPlayer():GetChar()
        local weight = 0.000
        weight = character:GetData("Weight",0)
        local maxweight = 0.000 
        maxweight = character:GetData("MaxWeight",50)
        if IsValid(panel) then
            panel:SetTitle(L"inv" .. " | " .. weight .. "kg of " .. maxweight .. "kg" )
        end
    end
end

function PLUGIN:PlayerInteractItem(client, action, item)
    local carrybuff = client:GetNetVar("WeightBuffCur") or 0
    local character = client:GetChar()
    local inventory = character:GetInv()
    local weight = 0
    local quantity = 1
    local totweight = 0
    local maxweight = (50 + carrybuff)
	
	if action == "take" then
		if item.weight then
			if item.quantity ~= nil and item.quantity ~= 0 then
				totweight = (totweight + (item.quantity * item.weight))
			else
				totweight = (totweight + item.weight)
			end
		end
    elseif action == "drop" then
		if item.weight then
			if item.quantity ~= nil and item.quantity ~= 0 then
				totweight = (totweight - (item.quantity * item.weight))
			else
				totweight = (totweight + item.weight)
			end
		end
	end
	
    for x, y in pairs(inventory:GetItems()) do
		if y.weight == nil then continue end
		
        if y.quantity ~= nil and y.quantity ~= 0 then
            quantity = y.quantity
        end
		
    	weight = y:GetData("weight",0)
		
    	if y.weight ~= nil then
    	    weight = weight + y.weight
    	end
		
        if y.isCW or y.isArmor then
            if weight ~= (y.weight + y:GetData("weight",0)) then
            	weight = y.weight + y:GetData("weight",0)
            end
        end

		totweight = ((quantity * weight) + totweight)
    end
    character:SetData("Backpack",nil)
    character:SetData("MaxWeight", maxweight)
    character:SetData("Weight", totweight)
end