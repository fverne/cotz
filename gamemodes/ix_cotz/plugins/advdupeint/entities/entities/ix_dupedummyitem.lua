AddCSLuaFile()

DEFINE_BASECLASS( "base_anim" )

ENT.Type = "anim"
ENT.PrintName = "Item Dummy"
ENT.Category = "Helix"
ENT.Spawnable = true
--ENT.RenderGroup = RENDERGROUP_BOTH

function ENT:SetupDataTables()
	self:NetworkVar("String", 	0, 	"ItemUID")
	self:NetworkVar("Bool", 	0, 		"IsSpawnGroup")
	self:NetworkVar("Bool", 	1, 		"ShouldUnfreeze")


	if (SERVER) then
		self:SetItemUID("")
		self:SetIsSpawnGroup(false)
		self:SetShouldUnfreeze(false)
	end
end

function ENT:GetRepresentedItem()
	if (!self:GetIsSpawnGroup()) then
		return { self:GetItemUID() }
	else
		return ix.util.GetRandomItemFromPool(self:GetItemUID())
	end
end

if (SERVER) then
	function ENT:Initialize()
		self:SetModel("models/props_junk/watermelon01.mdl")
		self:SetSolid(SOLID_VPHYSICS)
		self:PhysicsInit(SOLID_VPHYSICS)
		local physObj = self:GetPhysicsObject()

		if (IsValid(physObj)) then
			physObj:EnableMotion(false)
		end
	end

	function ENT:Use( activator )
		if( (self.nextInteract or 0) < CurTime() ) then
			netstream.Start(activator, "ix_dummyItemOpenMenu", activator, self)
			self.nextInteract = CurTime()+1
		end
	end

	function ENT:UpdateTransmitState()
		return TRANSMIT_PVS
	end

	netstream.Hook("ix_dummyItemCommitChanges", function(client, entity, itemuid, isspawngroup, shouldunfreeze)
		entity:SetItemUID(itemuid)
		entity:SetIsSpawnGroup(isspawngroup)
		entity:SetShouldUnfreeze(shouldunfreeze)

		if (!isspawngroup and ix.item.list[itemuid]) then
			entity:SetModel(ix.item.list[itemuid]:GetModel())
			entity:PhysicsInit(SOLID_VPHYSICS)
		end
	end)

else

	function ENT:OnPopulateEntityInfo(tooltip)
		local name = tooltip:AddRow("itemuid")
		name:SetImportant()
		name:SetText("Item/Spawngroup: ["..self:GetItemUID().."]")
		name:SetFont("ixChatFont")
		name:SetMaxWidth(math.max(name:GetMaxWidth(), ScrW() * 0.5))
		name:SizeToContents()

		local spawngroup = tooltip:AddRow("isspawngroup")
		spawngroup:SetImportant()
		spawngroup:SetFont("ixChatFont")
		spawngroup:SetText("Is Spawngroup?: ["..(self:GetIsSpawnGroup() and "True" or "False").."]")
		spawngroup:SetMaxWidth(math.max(spawngroup:GetMaxWidth(), ScrW() * 0.5))
		spawngroup:SizeToContents()
	end

	netstream.Hook("ix_dummyItemOpenMenu", function(client, entity)

		if IsValid(entity) then

			local frame = vgui.Create("DFrame")
			frame:SetTitle( "Dummy Item For Dupes" )
			frame:SetVisible( true )
			--frame:SetDrawOnTop(true)
			frame:SetDraggable( true )
			frame:ShowCloseButton( true )
			frame:Center()
			frame:MakePopup()
			frame:SetSize(600, 400)
			frame:SetPos((ScrW()/2)-300,(ScrH()/2)-200)

			frame.edit = frame:Add("DTextEntry")
			frame.edit:Dock(TOP)
			frame.edit:SetContentAlignment(8)
			frame.edit:SetFont("ixChatFont")
			frame.edit:SetText("")
			frame.edit:SetTall(100)
			frame.edit:SetEditable(true)
			frame.edit:DockMargin(5, 5, 5, 0)

			frame.check = frame:Add("DCheckBoxLabel")
			frame.check:Dock(TOP)
			frame.check:SetContentAlignment(8)
			frame.check:SetFont("ixChatFont")
			frame.check:SetText("Spawngroup? (randomitem library)")
			frame.check:SetTall(100)
			frame.check:DockMargin(5, 5, 5, 0)

			frame.checkunfreeze = frame:Add("DCheckBoxLabel")
			frame.checkunfreeze:Dock(TOP)
			frame.checkunfreeze:SetContentAlignment(8)
			frame.checkunfreeze:SetFont("ixChatFont")
			frame.checkunfreeze:SetText("Unfreeze when spawned?")
			frame.checkunfreeze:SetTall(100)
			frame.checkunfreeze:DockMargin(5, 5, 5, 0)

			local finish = frame:Add("DButton")
			finish:Dock(TOP)
			finish:SetText("Finish")
			finish:DockMargin(5, 5, 5, 0)

			function finish:DoClick()
				netstream.Start("ix_dummyItemCommitChanges", entity, frame.edit:GetValue(), frame.check:GetChecked(), frame.checkunfreeze:GetChecked())

				if (!frame.check:GetChecked() and ix.item.list[frame.edit:GetValue()]) then
					entity:SetModel(ix.item.list[frame.edit:GetValue()]:GetModel())
				end
				frame:Close()
			end

		end
	end)

end
