local PANEL = {}
PANEL.View = {}
local scale = 1.8
local x, y = nil

function PANEL:Init()
    hook.Add("ShouldDrawCrosshair", "pdaMapHideCrosshair", function() return false end)
    ix.gui.pdaMap = self
    self.delayTime = 0
    self:SetTitle("")
    self:SetSize(1333, 750)
    self:SetPos(ScrW() / 2 - 666, ScrH() / 2 - 375)
    self:MakePopup()
    self.mousePosX, self.mousePosY = gui.MousePos()
    self:ShowCloseButton(false)

    if not x then
        x = LocalPlayer():GetPos().x
    end

    if not y then
        y = LocalPlayer():GetPos().y
    end

    local dx, dy = self:GetPos()
    self.View.angles = Angle(90, 0, 0)
    self.View.ortho = true
    self.View.x = dx + 64
    self.View.y = dy + 64
    self.View.w = self:GetWide() - 128
    self.View.h = self:GetTall() - 142
    self.View.ortholeft = -self.View.w
    self.View.orthoright = self.View.w
    self.View.orthotop = -self.View.h
    self.View.orthobottom = self.View.h
    self.View.dopostprocess = false
    self.View.drawhud = false
    self.View.drawviewmodel = false
    self.View.drawmonitors = false
    self.buttonPanels = {}
    local w = self:GetWide()
    local h = self:GetTall()
    local inRadius = {}
end

function PANEL:Paint(w, h)
    surface.SetDrawColor(235, 235, 235, 50)
    surface.DrawRect(64, 64, w - 128, h - 132)
    surface.SetDrawColor(255, 255, 255, 255)
    surface.SetMaterial(Material("cotz/panels/pda.png"))
    surface.DrawTexturedRect(0, 0, w, h)
    self.View.origin = Vector(x or 0, y or 0, 1000 * scale)
    self.View.ortholeft = -self.View.w * scale
    self.View.orthoright = self.View.w * scale
    self.View.orthotop = -self.View.h * scale
    self.View.orthobottom = self.View.h * scale
    self.View.zfar = 10000 * scale
    render.RenderView(self.View)
    local dx, dy = self:LocalToScreen(0, 0)
    render.SetScissorRect(self.View.x, self.View.y, self.View.x + self.View.w, self.View.y + self.View.h, true)

    for k, v in pairs(ents.GetAll()) do
        if v ~= LocalPlayer() then
            if v:IsPlayer() and v:GetCharacter() and v:GetMoveType() ~= MOVETYPE_NOCLIP or v:IsNPC() then
                if LocalPlayer():GetPos():Distance(v:GetPos()) <= 512 then
                    v:SetNoDraw(false)
                else
                    v:SetNoDraw(true)
                end
            end
        end
    end

    local playerIcon = Material("vgui/icons/quest.png") -- temporary icon
    surface.SetDrawColor(255, 255, 255, 255)
    surface.SetMaterial(playerIcon)
    surface.DrawTexturedRect(w / 2 + (y - LocalPlayer():GetPos().y) / scale * 0.5 - 12, h / 2 + (x - LocalPlayer():GetPos().x) / scale * 0.5 - 20, 24, 24)
    render.SetScissorRect(0, 0, 0, 0, false)
    draw.SimpleText("PRESS [TAB] TO CLOSE", "stalkerregulartitlefont", 82, h - 120, Color(255, 255, 255), TEXT_ALIGN_LEFT)

    if input.IsKeyDown(KEY_ESCAPE) then
        self:PreRemove()
        self:Remove()
    end
end

function PANEL:OnMouseWheeled(delta)
    scale = math.Clamp(scale - delta * 0.1, 1.8, 5)
end

function PANEL:OnMousePressed(lmb)
    self.mousePosX, self.mousePosY = gui.MousePos()
    self.cachedPosX, self.cachedPosY = gui.MousePos()
end

function PANEL:OnMouseReleased()
    self.mousePosX, self.mousePosY = gui.MousePos()
end

function PANEL:ComputeDragDelta(diff)
    if diff > -1 and diff < 1 then return 0 end

    return -(diff * scale)
end

function PANEL:AddOriginX(deltaOriginX)
    y = y + deltaOriginX
end

function PANEL:AddOriginY(deltaOriginY)
    x = x + deltaOriginY
end

function PANEL:OnKeyCodePressed(key)
    self.delayTime = self.delayTime or CurTime()

    if key == KEY_TAB then
        if self.delayTime < CurTime() then
            self:PreRemove()

            timer.Simple(0.1, function()
                self:Remove()
            end)
        end

        self.delayTime = CurTime() + 0.5
    end
end

function PANEL:Think()
    self:MoveToFront()

    if input.IsButtonDown(MOUSE_LEFT) then
        local mousePosX, mousePosY = gui.MousePos()
        local deltaX = self:ComputeDragDelta(self.mousePosX - mousePosX)
        local deltaY = self:ComputeDragDelta(self.mousePosY - mousePosY)
        self:AddOriginX(deltaX)
        self:AddOriginY(deltaY)
        self.mousePosX, self.mousePosY = gui.MousePos()
    end
end

function PANEL:OnClose()
end

function PANEL:PreRemove()
    ix.gui.lastHelpMenuTab = "readme"

    if IsValid(ix.gui.menu) then
        ix.gui.menu:Remove()
        vgui.Create("ixMenu")
    else
        vgui.Create("ixMenu")
    end
end

function PANEL:OnRemove()
    hook.Remove("ShouldDrawCrosshair", "pdaMapHideCrosshair")

    for k, v in pairs(ents.GetAll()) do
        if v:IsPlayer() and v:GetCharacter() and v:GetMoveType() ~= MOVETYPE_NOCLIP or v:IsNPC() then
            v:SetNoDraw(false)
        end
    end
end

vgui.Register("pdaMap", PANEL, "DFrame")