local PLUGIN = PLUGIN
PLUGIN.name = "Burger"
PLUGIN.author = "El Diablo"
PLUGIN.desc = "Adds a command to summon a burger"


ix.command.Add("GodBlessAmerica", {
    alias = {"burger", "cheeseburger"},
    description = "Summon a cheeseburger.",
    OnRun = function(self, client)
        target = client:GetCharacter()
        if not target then
            client:Notify("Not available.")
            return
        end
        if (CurTime() > client:GetNetVar("hamburgertime", 0)) then
            local bSuccess, error = target:GetInventory():Add("food_burger", 1)
            if (bSuccess) then
                client:Notify("Summoned a cheeseburger!")
                client:SetNetVar("hamburgertime",CurTime()+60)
            else
                client:Notify("No space for the cheeseburger!")
                client:SetNetVar("hamburgertime",CurTime()+5)
            end
        else
            client:Notify("Wait for "..math.floor((client:GetNetVar("hamburgertime", 0)-CurTime())).." seconds.")
        end
    end
})