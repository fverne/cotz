ITEM.name = "PDA"
ITEM.model = "models/lostsignalproject/items/devices/pda.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.category = "Communication"
ITEM.price = 1000
ITEM.busflag = {"hardware"}
ITEM.equipIcon = ix.util.GetMaterial("materials/vgui/ui/stalker/misc/equip.png")
ITEM.img = ix.util.GetMaterial("vgui/hud/pda1.png")
ITEM.repairCost = ITEM.price/100*1

function ITEM:GetDescription()
	return "A PDA that encourages long range communication between individuals. Being the newest version of the PDA series, this allows the user to both select an avatar, but also select their own username." .. "\n\nAvatar: " .. self:GetData("avatar","vgui/icons/face_31.png") .. "\n\nNickname: " .. self:GetData("nickname", "meme")
end

ITEM.functions.setavatar = { -- sorry, for name order.
	name = "Select Avatar",
	tip = "useTip",
	icon = "icon16/stalker/customize.png",
	OnRun = function(item)
		item.player:RequestString("Set Avatar", "What avatar do you want this PDA to use? Select any material path.", function(text)
			if text != "" then
				item:SetData("avatar", text)
				item:GetOwner():GetCharacter():SetData("pdaavatar", text)
			end
		end, item:GetData("avatar", "vgui/icons/face_31.png"))
		return false
	end,
	OnCanRun = function(item)
		local client = item.player

		return !IsValid(item.entity) and IsValid(client)
	end
}

ITEM.functions.setnickname = { -- sorry, for name order.
	name = "Set your nickname",
	tip = "useTip",
	icon = "icon16/stalker/customize.png",
	OnRun = function(item)
		item.player:RequestString("Set Nickname", "What nickname do you want to use with this PDA?", function(text)
			item:SetData("nickname", text)
			item:GetOwner():GetCharacter():SetData("pdanickname", text)
		end, item:GetData("nickname", item.player:Name()))
		return false
	end,
}

function ITEM:OnEquipped()
	self.player:GetCharacter():SetData("pdaavatar", self:GetData("avatar", "lutz"))
	self.player:GetCharacter():SetData("pdanickname", self:GetData("nickname", "lutz"))
end

function ITEM:OnUnEquipped()

end

function ITEM:OnInstanced()
	self:SetData("avatar", "vgui/icons/face_31.png")
	self:SetData("nickname", "NEW_USER")
end
