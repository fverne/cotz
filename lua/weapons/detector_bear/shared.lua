sound.Add({	name		= "V92_Uni_QuickMove",
	channel		= CHAN_WEAPON,
	level		= 100,
	volume		= 1.0,
	pitch		= { 95, 105 },
	sound		= "jessev92/weapons/univ/throw_gren.wav",
})

sound.Add({	name		= "V92_Uni_Draw",
	channel		= CHAN_BODY,
	level		= 75,
	volume		= 1.0,
	pitch		= { 95, 105 },
	sound		= "jessev92/weapons/univ/draw1.wav",
})

sound.Add({	name		= "V92_Uni_Holster",
	channel		= CHAN_BODY,
	level		= 75,
	volume		= 1.0,
	pitch		= { 95, 105 },
	sound		= "jessev92/weapons/univ/holster1.wav",
})


SWEP.PrintName			= "Bear Detector"
SWEP.Slot				= 4
SWEP.SlotPos			= 1
SWEP.Category = "S.T.A.L.K.E.R. Detector Sweps"
SWEP.Author	= "Subleader and AirBlack"
SWEP.Contact = ""
SWEP.Purpose = ""
SWEP.Instructions = "Right click for throw a bolt."
SWEP.Base	= "base_sweps_detector"
SWEP.HoldType = "idle_melee"
SWEP.ViewModelFOV = 70
SWEP.ViewModelFlip = true
SWEP.UseHands = false
SWEP.ViewModel = "models/weapons/v_cw_fraggrenade.mdl"
SWEP.WorldModel = "models/kali/miscstuff/stalker/detector_bear.mdl"
SWEP.ShowViewModel = true
SWEP.ShowWorldModel = true
SWEP.Spawnable	= true
SWEP.AdminSpawnable	= true

SWEP.UseDel = CurTime()

function SWEP:IdleTiming()
end

SWEP.Primary.Delay				= 0
SWEP.Primary.Recoil				= 0
SWEP.Primary.Damage				= 0
SWEP.Primary.NumShots			= 0
SWEP.Primary.Cone				= 0
SWEP.Primary.ClipSize			= -1
SWEP.Primary.DefaultClip		= -1
SWEP.Primary.Automatic   		= false
SWEP.Primary.Ammo         		= "pistol"
SWEP.Secondary.Delay			= 0
SWEP.Secondary.Recoil			= 0
SWEP.Secondary.Damage			= 0
SWEP.Secondary.NumShots			= 0
SWEP.Secondary.Cone		  		= 0
SWEP.Secondary.ClipSize			= -1
SWEP.Secondary.DefaultClip		= -1
SWEP.Secondary.Automatic   		= false
SWEP.Secondary.Ammo         	= "none"

SWEP.ViewModelBoneMods = {
	["l-ring-low"] = { scale = Vector(1, 1, 1), pos = Vector(-0.186, 0.925, -0.556), angle = Angle(-50, 16.666, 0) },
	["l-thumb-low"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-15.5, 27.777, -32.223) },
	["l-pinky-low"] = { scale = Vector(1, 1, 1), pos = Vector(0.925, 0.925, 0.555), angle = Angle(-90, 45.555, -32.223) },
	["l-middle-low"] = { scale = Vector(1, 1, 1), pos = Vector(0.185, 0, 0.185), angle = Angle(0, 0, 0) },
	["l-index-low"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(21.111, -12.223, 3.332) },
	["lwrist"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, -72.223) },
	["r-index-low"] = { scale = Vector(1, 1, 1), pos = Vector(-0.186, 0, 0), angle = Angle(-1.111, -1.111, 16.666) },
	["r-thumb-low"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(10, -14.445, 16.666) },
	["r-middle-low"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(36.666, 0, 0) },
	["r-pinky-low"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(36.666, 0, 0) },
	["Base"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
	["r-ring-low"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(34.444, 0, 0) },
	["Dummy01"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) }
}

SWEP.IronSightsPos = Vector(0, 0, 0)
SWEP.IronSightsAng = Vector(0, 0, 0)

SWEP.WElements = {
	["Bear"] = { type = "Model", model = "models/kali/miscstuff/stalker/detector_bear.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4.675, 1.557, -2.597), angle = Angle(-106.364, -167.144, 12.857), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {[1] = 1} }
}

SWEP.VElements = {
	["detector"] = { type = "Model", model = "models/kali/miscstuff/stalker/detector_bear.mdl", bone = "lwrist", rel = "", pos = Vector(4, 1.1, -0.519), angle = Angle(-59.611, 31.558, 162.468), size = Vector(0.699, 0.699, 0.699), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {[1] = 1} },
	--["detector"] = { type = "Model", model = "models/kali/miscstuff/stalker/detector_bear.mdl", bone = "l-upperarm", rel = "", pos = Vector(8.831, 0.518, -2.5), angle = Angle(33.895, 68.96, 17.531), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {[1] = 1} },
	["element_name"] = { type = "Model", model = "models/kali/miscstuff/stalker/bolt.mdl", bone = "Base", rel = "", pos = Vector(0, 0, 0), angle = Angle(12.857, -29.222, 180), size = Vector(0.755, 0.755, 0.755), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

function SWEP:PrimaryAttack()
    if (self.UseDel < CurTime() and self.Owner:GetCharacter():GetInventory():HasItem("value_bolts")) then
        local noremove = false
        self.UseDel = CurTime() + 3
        self.Owner:DoAttackEvent()
        self.Weapon:SendWeaponAnim(ACT_VM_PULLPIN)
        self.Owner:ViewPunch(Angle(10, -10, 0))

        if (SERVER) then
            timer.Simple(0.9, function()
                local item = self.Owner:GetCharacter():GetInventory():HasItem("value_bolts")
                if not item then return end

                if (item.quantity) then
                    item:SetData("quantity", item:GetData("quantity", item.quantity) - 1)
                    noremove = (item:GetData("quantity", item.quantity) > 0)
                end

                if (not noremove) then
                    item:Remove()
                end

                self:EmitSound(Sound("weapons/slam/throw.wav", 100, 100))
                local bolt = ents.Create("ent_stalker_bolt")
                bolt:SetPos(self.Owner:GetShootPos() + self.Owner:GetAimVector() * 10)
                bolt:SetAngles(self.Owner:EyeAngles())
                bolt:Spawn()
                bolt:SetOwner(self.Owner)
                bolt:Fire("kill", "", 12)
                bolt:GetPhysicsObject():ApplyForceCenter(self.Owner:GetVelocity() + self.Owner:GetAimVector() * 5000)
                bolt:GetPhysicsObject():AddAngleVelocity(Vector(math.random(-500, 500), math.random(-500, 500), math.random(-500, 500)))
                bolt:GetPhysicsObject():SetMass(1)
            end)

            if GetConVarNumber("vnt_stalker_bolt_ammo") ~= 0 then
                self:TakePrimaryAmmo(1)
            end
        end

        timer.Simple(0.75, function()
            self.Weapon:SendWeaponAnim(ACT_VM_DRAW)
        end)
    end
end

function SWEP:SecondaryAttack()
    if (self.UseDel < CurTime() and self.Owner:GetCharacter():GetInventory():HasItem("value_bolts")) then
        local noremove = false
        self.UseDel = CurTime() + 3
        self.Owner:DoAttackEvent()
        self.Weapon:SendWeaponAnim(ACT_VM_PULLPIN)
        self.Owner:ViewPunch(Angle(-2, 0, 0))

        if (SERVER) then
            timer.Simple(0.9, function()
                local item = self.Owner:GetCharacter():GetInventory():HasItem("value_bolts")
                if not item then return end

                if (item.quantity) then
                    item:SetData("quantity", item:GetData("quantity", item.quantity) - 1)
                    noremove = (item:GetData("quantity", item.quantity) > 0)
                end

                if (not noremove) then
                    item:Remove()
                end

                self:EmitSound(Sound("weapons/slam/throw.wav", 100, 100))
                local bolt = ents.Create("ent_stalker_bolt")
                bolt:SetPos(self.Owner:GetShootPos() + self.Owner:GetAimVector() * 10)
                bolt:SetAngles(self.Owner:EyeAngles())
                bolt:Spawn()
                bolt:SetOwner(self.Owner)
                bolt:Fire("kill", "", 12)
                bolt:GetPhysicsObject():ApplyForceCenter(self.Owner:GetVelocity() + self.Owner:GetAimVector() * 2500)
                bolt:GetPhysicsObject():AddAngleVelocity(Vector(math.random(-500, 500), math.random(-500, 500), math.random(-500, 500)))
                bolt:GetPhysicsObject():SetMass(1)
            end)

            if GetConVarNumber("vnt_stalker_bolt_ammo") ~= 0 then
                self:TakePrimaryAmmo(1)
            end
        end

        timer.Simple(0.75, function()
            self.Weapon:SendWeaponAnim(ACT_VM_DRAW)
        end)
    end
end

function SWEP:Deploy()
	timer.Simple( 0.75, function()
	end)
	return true
end

local anomalies = {}

anomalies["models/nasca/etherealsrp_artifacts/urchin.mdl"] = true -- Urchin
anomalies["models/lostsignalproject/items/artefacts/needles.mdl"] = true -- Thorn
anomalies["models/lostsignalproject/items/artefacts/electra_flash.mdl"] = true -- Sparkler
anomalies["models/lostsignalproject/items/artefacts/slug.mdl"] = true -- Slug
anomalies["models/lostsignalproject/items/artefacts/sparkler.mdl"] = true -- Slime
anomalies["models/lostsignalproject/items/artefacts/kislushka.mdl"] = true -- Mycelia
anomalies["models/lostsignalproject/items/artefacts/moonlight.mdl"] = true -- Moonlight
anomalies["models/lostsignalproject/items/artefacts/mica.mdl"] = true -- Mica
anomalies["models/gibs/hgibs.mdl"] = true -- Memento Mori
anomalies["models/lostsignalproject/items/artefacts/glassbeads.mdl"] = true -- Mama's Beads
anomalies["models/lostsignalproject/items/artefacts/kolobok.mdl"] = true -- Kolobok
anomalies["models/lostsignalproject/items/artefacts/ring.mdl"] = true -- Halo
anomalies["models/lostsignalproject/items/artefacts/chelust.mdl"] = true -- Grandmama's Beads
anomalies["models/artefacts/atom.mdl"] = true -- Galaxy
anomalies["models/lostsignalproject/items/artefacts/glass.mdl"] = true -- Flash
anomalies["models/lostsignalproject/items/artefacts/flame.mdl"] = true -- Flame
anomalies["models/lostsignalproject/items/artefacts/eye.mdl"] = true -- Eye
anomalies["models/lostsignalproject/items/artefacts/atom.mdl"] = true -- Dwarf Galaxy
anomalies["models/lostsignalproject/items/artefacts/drop.mdl"] = true -- Droplet
anomalies["models/lostsignalproject/items/artefacts/crystal.mdl"] = true -- Crystal
anomalies["models/artefacts/full_empty.mdl"] = true -- Capacitor
anomalies["models/lostsignalproject/items/artefacts/cocoon.mdl"] = true -- Bone Cluster
anomalies["models/artefacts/empty.mdl"] = true -- Blown Capacitor
anomalies["models/nasca/etherealsrp_artifacts/battery.mdl"] = true -- Battery
anomalies["models/lostsignalproject/items/artefacts/black_angel.mdl"] = true -- Arachno

--[[
anomalies["models/nasca/etherealsrp_artifacts/battery.mdl"] = true
anomalies["models/nasca/etherealsrp_artifacts/wrenched.mdl"] = true
anomalies["models/nasca/etherealsrp_artifacts/crystal_thorn.mdl"] = true
anomalies["models/nasca/etherealsrp_artifacts/droplet.mdl"] = true
anomalies["models/nasca/etherealsrp_artifacts/fireball.mdl"] = true
anomalies["models/nasca/etherealsrp_artifacts/flash.mdl"] = true
anomalies["models/nasca/etherealsrp_artifacts/jellyfish.mdl"] = true
anomalies["models/nasca/etherealsrp_artifacts/meatchunk.mdl"] = true
anomalies["models/nasca/etherealsrp_artifacts/moonlight.mdl"] = true
anomalies["models/nasca/etherealsrp_artifacts/nightstar.mdl"] = true
anomalies["models/nasca/etherealsrp_artifacts/shell.mdl"] = true
anomalies["models/nasca/etherealsrp_artifacts/slime.mdl"] = true
anomalies["models/nasca/etherealsrp_artifacts/slug.mdl"] = true
anomalies["models/nasca/etherealsrp_artifacts/soul.mdl"] = true
anomalies["models/nasca/etherealsrp_artifacts/sparkler.mdl"] = true
anomalies["models/nasca/etherealsrp_artifacts/stoneblood.mdl"] = true
anomalies["models/nasca/etherealsrp_artifacts/stoneflower.mdl"] = true
anomalies["models/nasca/etherealsrp_artifacts/thorn.mdl"] = true
anomalies["models/nasca/etherealsrp_artifacts/mamas_beads.mdl"] = true

anomalies["models/nasca/etherealsrp_artifacts/bubble.mdl"] = true
anomalies["models/nasca/etherealsrp_artifacts/crystal.mdl"] = true
anomalies["models/nasca/etherealsrp_artifacts/eye.mdl"] = true
anomalies["models/nasca/etherealsrp_artifacts/firefly.mdl"] = true
anomalies["models/nasca/etherealsrp_artifacts/flame.mdl"] = true
anomalies["models/nasca/etherealsrp_artifacts/goldfish.mdl"] = true
anomalies["models/nasca/etherealsrp_artifacts/gravi.mdl"] = true
anomalies["models/nasca/etherealsrp_artifacts/kolobok.mdl"] = true
anomalies["models/nasca/etherealsrp_artifacts/mica.mdl"] = true
anomalies["models/nasca/etherealsrp_artifacts/snowflake.mdl"] = true
anomalies["models/nasca/etherealsrp_artifacts/urchin.mdl"] = true
]]--

if CLIENT then
	local matScreen = Material("models/kali/miscstuff/stalker/detectors/detector_bear_c"); // ��������, ������� ����
	local RTTexture = GetRenderTarget("DTC_BEAR", 512, 512); // ����� ��������

	local dot = surface.GetTextureID("models/kali/miscstuff/stalker/detectors/detector_bear_segment_copy");
	local bg = surface.GetTextureID("models/kali/miscstuff/stalker/detectors/detector_bear_copy");

	function SWEP:RenderScreen()

		local NewRT = RTTexture;
		local oldW = ScrW();
		local oldH = ScrH();
		local ply = LocalPlayer();

		matScreen:SetTexture( "$basetexture", NewRT);

		local OldRT = render.GetRenderTarget();
		render.SetRenderTarget(NewRT);
		render.SetViewPort( 0, 0, 512, 512);

		cam.Start2D();

			render.Clear( 50, 50, 100, 0 );

			surface.SetDrawColor( 255, 255, 255, 255 );
			surface.SetTexture( bg );
			surface.DrawTexturedRect( 0, 0, 512, 512);

			surface.SetTexture(dot);


			local anoms = {}
			for k,v in pairs(ents.GetAll()) do
				if v:GetClass() == "ix_item" then
					if anomalies[string.lower(v:GetModel())] then
						table.insert(anoms, v)
					end
				end
			end
			local dist = 301
			local ent = nil
			for k,v in pairs(anoms) do
				if v:GetPos():Distance(LocalPlayer():GetPos()) < dist then
					dist = v:GetPos():Distance(LocalPlayer():GetPos())
					ent = v
				end
			end
			if dist < 300 then
				local ang = ply:GetAngles();
				local pos = ent:GetPos() - ply:GetShootPos()
				surface.SetDrawColor(255, 255, 255, 255)
				pos:Rotate(Angle(0, -1*ang.Yaw, 0));
				if (math.abs(pos.z)<2000) then
					surface.DrawTexturedRectRotated( 131, 118, 150, 150, ((pos:Angle().y % 15) / 15 < 0.5 and pos:Angle().y - (pos:Angle().y % 15) or (pos:Angle().y % 15) / 15 >= 0.5 and pos:Angle().y - (pos:Angle().y % 15)  + 15) + 30  )//�������. �� ������� ������� ������� ���� �� 15(� ��������� 24 �������. 360/24 = 15) � ���� ������� ������ �������� 15, �� �� ���� �������� �������, � ���� ������� ������ �������� 15, �� �� ���� �������� ������� � ���������� 15. ��� ����� ������. ����� ������� �� �������� ����, ������� 15. ������� 'Black Pheonix'� �� �����.
				end
			end

		cam.End2D();

		render.SetRenderTarget(OldRT);
		render.SetViewPort( 0, 0, oldW, oldH )

	end
end
SWEP.LastBeep = 0
function SWEP:Think()
	if CLIENT then
		local anoms = {}
		for k,v in pairs(ents.GetAll()) do
			if v:GetClass() == "ix_item" then
				if anomalies[string.lower(v:GetModel())] then
					table.insert(anoms, v)
				end
			end
		end
		local dist = 301
		local ent = nil
		for k,v in pairs(anoms) do
			if v:GetPos():Distance(self.Owner:GetPos()) < dist then
				dist = v:GetPos():Distance(self.Owner:GetPos())
				ent = v
			end
		end
		if dist < 300 and self.LastBeep + dist/300 - CurTime() <= 0 then
			self.LastBeep = CurTime()
			self.Owner:EmitSound(Sound("stalkerdetectors/echo.wav"), 100, 100)//math.Clamp(250-dist/2,50,250))
		end
	end
end
