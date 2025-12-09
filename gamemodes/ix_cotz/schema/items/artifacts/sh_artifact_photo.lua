ITEM.name = "Photo of a loved one"
ITEM.model ="models/lostsignalproject/items/misc/damaged_ammo.mdl"
ITEM.description = "A small photo."
ITEM.longdesc = "While looking like a regular small photo, with a picture of a loved one, rumour has it the photo changes depending on who holds it. Staring at it almost takes you home..."
ITEM.width = 1
ITEM.height = 1
ITEM.price = 1000
ITEM.JumpPower = 0
ITEM.flag = "A"
ITEM.rarity = 6

ITEM.baseweight = 0.020
ITEM.varweight  = 0.006

ITEM.img = ix.util.GetMaterial("propic/rat/rat")

function ITEM:PaintOver(item, w, h)
    surface.SetDrawColor(182, 182, 182)
    surface.DrawRect(0, 0, w, h)

    surface.SetMaterial(ix.util.GetMaterial(item:GetData("img", item.img)))
    surface.SetDrawColor(255, 255, 255)
    surface.DrawTexturedRect(2, 2, w-4, h-4)
end

ITEM.functions.use = {
	name = "Stare",
    icon = "icon16/help.png",
    sound = "icon16/stalker/read.png",
    OnRun = function(item)
        if(item:GetData("cooldown",0) < os.time())then

            ix.util.PlayerPerformBlackScreenAction(item.player, "Reminiscing", 15, function(player) 
                item:SetData("cooldown", os.time() + (60*15) )

                local client = item:GetOwner()
                local character = client:GetCharacter()

                local townspawndata = {Vector(-7182.672852, -10445.850586, 4972.751465), Angle(0,0,0), "rp_marsh_cs"}

                if not (townspawndata[3] == game.GetMap())then
                    character:SetData("newpos", townspawndata)
                    ix.plugin.list["simplecrossserver"]:RedirectPlayerNoLoadZone(client, townspawndata[3])
                end

                client:SetPos(townspawndata[1])
            end)
        end

        return false
    end,
    OnCanRun = function(item)
        return !IsValid(item.entity) and item:GetData("cooldown",0) < os.time() and item.invID == item.player:GetCharacter():GetInventory():GetID()
    end
}
