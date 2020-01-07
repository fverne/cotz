local PLUGIN = PLUGIN

ITEM.name = "Attachment"
ITEM.description = "An attachment. It goes on a weapon."
ITEM.category = "Attachments"
ITEM.model = "models/Items/BoxSRounds.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.price = 1
ITEM.slot = 1
ITEM.flag = "R"
ITEM.isAttachment = true
ITEM.attSearch = { "kk_ins2_kobra", }
ITEM.quantity = 1


-- Slot Numbers Defined:

-- Sights = 1
-- Barrels = 2
-- Lasers/Lights = 3
-- Magazines = 4
-- Underbarrel = 5

-- Additional slots can be added so long as they line up with the SWEP's attachment code appropriately.

function ITEM:GetDescription()
	local description = self.description
	description = description.."\nWeight: "..self.weight.."kg"
	return description
end

local function attachment(item, data)
    local client = item.player
    local char = client:GetChar()
    local inv = char:GetInv()
    local items = inv:GetItems()
    local target
    for k, invItem in pairs(items) do
        if data then
            if (invItem:GetID() == data[1]) then
                target = invItem
                break
            end
        end
    end
    if (!target) then
        client:NotifyLocalized("No Weapon Found")

        return false
    else
        local class = target.class
        local SWEP = weapons.Get(class)

        if (target.isCW) then
            -- Insert Weapon Filter here if you just want to create weapon specific shit. 
            local atts = SWEP.Attachments
            local mods = target:GetData("attachments", {})
            
            if (atts) then		                                
                -- Is the Weapon Slot Filled?
                if (mods[item.slot]) then
                    client:NotifyLocalized("Attachment already fills this slot")

                    return false
                end

                local pokemon

                for atcat, data in pairs(atts) do
                    if (pokemon) then
                        break
                    end
                    
                    for k, name in pairs(data.atts) do
                        if (pokemon) then
                            break
                        end

                        for _, doAtt in pairs(item.attSearch) do
                            if (name == doAtt) then
                                pokemon = doAtt
                                break
                            end
                        end
                    end
                end

                if (!pokemon) then
                    client:NotifyLocalized("Attachment does not fit")

                    return false
                end
                
                curPrice = target:GetData("RealPrice")
        	    if !curPrice then
        		    curPrice = target.price
        		end
		
                target:SetData("RealPrice", (curPrice + item.price))
                
                mods[item.slot] = {item.uniqueID, pokemon}
                target:SetData("attachments", mods)
                local wepon = client:GetActiveWeapon()

                if (IsValid(wepon) and wepon:GetClass() == target.class) then
                    wepon:attachSpecificAttachment(pokemon)
                end
				
				local itemweight = item.weight or 0
                local targetweight = target:GetData("weight",0)
                local totweight = itemweight + targetweight
                target:SetData("weight", totweight)
				
				client:EmitSound("cw/holster4.wav")

                return true
            else
                client:NotifyLocalized("notCW")
            end
        end
    end

    client:NotifyLocalized("No Weapon Found")
    return false
end

ITEM.functions.Attach = {
    name = "Attach",
    tip = "Puts this attachment on the specified weapon.",
	icon = "icon16/stalker/attach.png",
    
    
    OnCanRun = function(item)
        return (!IsValid(item.entity))
    end,
	
    OnRun = function(item, data)
		return attachment(item, data)
	end,
    
    isMulti = true,
    
    multiOptions = function(item, client)
        --local client = item.player
        local targets = {}
        local char = client:GetChar()
        if (char) then
            local inv = char:GetInv()
            if (inv) then
                local items = inv:GetItems()
                for k, v in pairs(items) do
                    if (v.isPLWeapon and v.isCW) then
                        table.insert(targets, {
                        name = L(v.name),
                        data = {v:GetID()},
                    })
					else
						continue
					end
				end
			end
		end
    return targets
	end,
}