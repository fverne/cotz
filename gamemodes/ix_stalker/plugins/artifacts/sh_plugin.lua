PLUGIN.name = "Artifacts"
PLUGIN.author = "Lt. Taylor"
PLUGIN.desc = "Adds a relatively simple artifact system"

function PLUGIN:ArtifactChange(client)
    -- INIT VALUES
    local artiheal = client:GetNetVar("ArtiHealAmt")/10) or 0           -- Healing
    local artihealcur = client:GetNetVar("ArtiHealCur")/10) or 0
    
    local rads = client:GetNetVar("Rads")/10) or 0                      -- Radiation
    local radscur = client:GetNetVar("RadsCur")/10) or 0
    
    local antirads = client:GetNetVar("AntiRads")/10) or 0              -- Anti-Radiation
    local antiradscur = client:GetNetVar("AntiRadsCur")/10) or 0
    
    local endbuff = client:GetNetVar("EndBuff")/10) or 0                -- Endurance buff
    local endbuffcur = client:GetNetVar("EndBuffCur")/10) or 0
    
    local endred = client:GetNetVar("EndRed")/10) or 0                  -- Endurance debuff
    local endredcur = client:GetNetVar("EndRedCur")/10) or 0
    
    local woundheal = client:GetNetVar("WoundHeal")/10) or 0
    local woundhealcur = (client:GetNetVar("WoundHealCur")/10) or 0
    
    local maxweight = client:GetChar():GetData("MaxWeight",50)
    local weightbuff = client:GetNetVar("WeightBuff") or 0
    local weightprev = client:GetNetVar("WeightBuffCur") or 0
    
    local theal = timer.Exists("ArtiHeal")                          -- Timers
    local trads = timer.Exists("Rads")
    local tradsred = timer.Exists("RadsRed")
    local tend = timer.Exists("Endurance")
    local twound = timer.Exists("WoundHeal")
    
                                                                    -- Ensure valid values
    if artiheal < 0 then
        client:SetNetVar("ArtiHealAmt", 0)
        artiheal = 0
    end
    
    if rads < 0 then
        client:SetNetVar("Rads", 0)
        rads = 0
    end
    
    if antirads < 0 then
        client:SetNetVar("AntiRads", 0)
        antirads = 0
    end
    
    if endbuff < 0 then
        client:SetNetVar("EndBuff", 0)
    end
    
    if endred < 0 then
        client:SetNetVar("EndRed", 0)
    end
    
    if weightbuff > weightprev then
        local newweight = maxweight + weightbuff
        client:GetChar():SetData("MaxWeight",newweight)
        client:SetNetVar("WeightBuffCur",weightbuff)
    elseif weightprev > weightbuff then
        local newweight = maxweight - (weightprev - weightbuff)
        client:GetChar():SetData("MaxWeight",newweight)
        client:SetNetVar("WeightBuffCur",weightbuff)
    end
    
    -- HEAL FUNCTION
        
    if theal == false and artiheal > 0 then                  -- If the timer doesn't exist and it should, make it
        timer.Create("ArtiHeal", 10, 0, function()
            if (client:IsValid() and client:Alive()) then
                client:SetHealth(math.Clamp(client:Health() + artiheal), 0, client:GetMaxHealth())
            end
        end)
        client:SetNetVar("ArtiHealCur", artiheal)
    
    elseif theal == true and artiheal <= 0 then              -- If the timer exists and shouldn't, remove it
        timer.Remove("ArtiHeal")
    
    elseif theal == true and artihealcur ~= artiheal then    -- If the timer exists and should, but has the wrong value, fix it
        timer.Adjust("ArtiHeal", 10, 0, function()
            if (client:IsValid() and client:Alive()) then
                client:SetHealth(math.Clamp((client:Health() + artiheal), 0, client:GetMaxHealth()))
            end
        end)
        client:SetNetVar("ArtiHealCur", artiheal)
    end
    
    -- WOUND HEAL FUNCTION
    
    if twound == false and woundheal > 0 then                  -- If the timer doesn't exist and it should, make it
        timer.Create("WoundHeal", 5, 0, function()
            if (client:IsValid() and client:Alive()) then
                local newheal = (woundheal / 2)
                client:SetHealth(math.Clamp((client:Health() + newheal), 0, client:GetMaxHealth()))
            end
        end)
        client:SetNetVar("WoundHealCur", woundheal)
    
    elseif twound == true and woundheal <= 0 then              -- If the timer exists and shouldn't, remove it
        timer.Remove("WoundHeal")
    
    elseif twound == true and woundhealcur ~= woundheal then    -- If the timer exists and should, but has the wrong value, fix it
        timer.Adjust("WoundHeal", 5, 0, function()
            if (client:IsValid() and client:Alive()) then
                local newheal = (woundheal / 2)
                client:SetHealth(math.Clamp((client:Health() + newheal), 0, client:GetMaxHealth()))
            end
        end)
        client:SetNetVar("WoundHealCur", woundheal)
    end
    
    -- RADIATION FUNCTION
    if rads > antirads then
        if trads == false then
            timer.Create("Rads", 3, 0, function()
                if (client:IsValid() and client:Alive()) then
                    
                    if client:Health() <= 0 then
                        client:Kill()
                    end
                    
                    local accumrad = client:GetNetVar("AccumRads") or 0
                    local radiation = (rads - antirads)
                    local buildup = accumrad + radiation
                    local damage = (100 * (buildup/5000))
                    client:SetNetVar("AccumRads", buildup)
                    if client:Alive() == false then
                        client:SetNetVar("AccumRads", 0)
                        timer.Remove("Rads")
                    end
                    
                    client:SetHealth(math.Clamp((client:Health() - damage), 0, client:GetMaxHealth()))
                end
            end)
            client:SetNetVar("RadsCur", rads)
            client:SetNetVar("AntiRadsCur", antirads)
        elseif rads ~= radscur or antirads ~= antiradscur then
            timer.Adjust("Rads", 3, 0, function()
                if (client:IsValid() and client:Alive()) then
                    
                    if client:Health() <= 0 then
                        client:Kill()
                    end
                    
                    local accumrad = client:GetNetVar("AccumRads") or 0
                    local radiation = (rads - antirads)
                    local buildup = accumrad + radiation
                    local damage = (100 * (buildup/5000))
                    client:SetNetVar("AccumRads", buildup)
                    if client:Alive() == false then
                        client:SetNetVar("AccumRads", 0)
                        timer.Remove("Rads")
                    end
                    
                    client:SetHealth(math.Clamp((client:Health() - damage), 0, client:GetMaxHealth()))
                end
            end)
            client:SetNetVar("RadsCur", rads)
            client:SetNetVar("AntiRadsCur", antirads)
        end
    else
        if trads == true then
            timer.Remove("Rads")
        end
        local radstart = client:GetNetVar("AccumRads") or 0
        if radstart > 0 then
            timer.Create("RadsRed", 3, 0, function()
                if (client:IsValid() and client:Alive()) then
                    if timer.Exists("Rads") then
                       timer.Remove("Rads") 
                    end
                    
                    if client:Health() <= 0 then
                        client:Kill()
                    end
                    
                    local accumrad = client:GetNetVar("AccumRads") or 0 -- accumulated radiation
                    local antiradcalc = (antirads - rads) or 0          -- antiradiation artis help
                    local modifier = (1 + antiradcalc)                  -- add the antiradiation artis and a baseline -1 to rad together
                    local radred = (accumrad - modifier)                -- reduce the accumulated radiation value by the modifier
                    local damage = (100 * (radred/5000))                -- determine how much damage the player will receive
                    
                    client:SetNetVar("AccumRads", radred)               -- Update the accumulated radiation value
                    if radred <= 0 or client:Alive() == false then
                        client:SetNetVar("AccumRads", 0)
                        timer.Remove("RadsRed") 
                    end
                    
                    client:SetHealth(math.Clamp((client:Health() - damage), 0, client:GetMaxHealth()))
                end
            end)
            client:SetNetVar("AntiRadsCur", antirads)
            
        elseif tradsred == true and antiradscur ~= antirads then
            timer.Adjust("RadsRed", 3, 0, function()
                if (client:IsValid() and client:Alive()) then
                    if timer.Exists("Rads") then
                       timer.Remove("Rads") 
                    end
                    
                    if client:Health() <= 0 then
                        client:Kill()
                    end
                    
                    local accumrad = client:GetNetVar("AccumRads") or 0 -- accumulated radiation
                    local antiradcalc = (antirads - rads) or 0          -- antiradiation artis help
                    local modifier = (1 + antiradcalc)                  -- add the antiradiation artis and a baseline -1 to rad together
                    local radred = (accumrad - modifier)                -- reduce the accumulated radiation value by the modifier
                    local damage = (100 * (radred/5000))                -- determine how much damage the player will receive
                    
                    client:SetNetVar("AccumRads", radred)               -- Update the accumulated radiation value
                    if radred <= 0 or client:Alive() == false then
                        client:SetNetVar("AccumRads", 0)
                        timer.Remove("RadsRed") 
                    end
                    
                    client:SetHealth(math.Clamp((client:Health() - damage), 0, client:GetMaxHealth()))
                end
            end)
        end
    end
    
    -- ENDURANCE FUNCTION
    
    if endbuff > 0 or endred > 0 then
        if tend == false then
            timer.Create("Endurance", 1, 0, function()
                local stamina = client:GetLocalVar("stm", 0)
                local difference = (endbuff - endred)
                local newstam = (stamina + difference)
                client:SetLocalVar("stm", newstam)
            end)
        else
            timer.Adjust("Endurance", 1, 0, function()
                local stamina = client:GetLocalVar("stm", 0)
                local difference = (endbuff - endred)
                local newstam = (stamina + difference)
                client:SetLocalVar("stm", newstam)
            end)
        end
    else
        if tend == true then
            timer.Remove("Endurance")
        end
    end
end

hook.Add("ArtifactChange","Artifact_Change", ArtifactChange)

hook.Add("PlayerDeath","ArtiWipe", function(client)

	for k,v in pairs(client:GetChar():GetInv():GetItems()) do
		if v.isArtefact then
			v:SetData("equip",nil)
		end
	end
	
	if timer.Exists("ArtiHeal") then timer.Remove("ArtiHeal") end
	if timer.Exists("Rads") then timer.Remove("Rads") end
	if timer.Exists("RadsRed") then timer.Remove("RadsRed") end
	if timer.Exists("Endurance") then timer.Remove("Endurance") end
	if timer.Exists("WoundHeal") then timer.Remove("WoundHeal") end

	client:SetNetVar("ArtiHealAmt",0)
    client:SetNetVar("ArtiHealCur",0)
    client:SetNetVar("Rads",0)
    client:SetNetVar("RadsCur",0)
	client:SetNetVar("AccumRads", 0)
    client:SetNetVar("AntiRads",0)
    client:SetNetVar("AntiRadsCur",0)
    client:SetNetVar("EndBuff",0)
    client:SetNetVar("EndBuffCur",0)
    client:SetNetVar("EndRed",0)
    client:SetNetVar("EndRedCur",0)
    client:SetNetVar("WoundHeal",0)
    client:SetNetVar("WoundHealCur",0)
	
	hook.Run("ArtifactChange", client)
end)