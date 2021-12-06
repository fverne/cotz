local PLUGIN = PLUGIN
PLUGIN.name = "Special Sale"
PLUGIN.author = "gumlefar"
PLUGIN.desc = "Special items spot sale plugin"

PLUGIN.priceModifier = 1.5
PLUGIN.dailySaleCount = 2
PLUGIN.weeklySaleCount = 3


PLUGIN.artifacts = {
	--"makarov"
	"battery",
	/*"bloodsuckerjaw",
	"boarhoof",
	"burershand",
	"chimerasclaw",
	"controllerskull",
	"dogtail",
	"flesheye",
	"pseudodogtail",
	"pseudogiantsfoot",
	"rodentsear",
	"snorksfoot",
	"zombiehand",
	"crowbeak",*/
}
PLUGIN.currentSales = PLUGIN.currentSales or {
	dailySales = {},
	weeklySales = {},
	dailySalesDate = 0,
	weeklySalesDate = 0,
}

local playerMeta = FindMetaTable("Player")
-- Boring getters
function PLUGIN:getArtifactList()
	return self.artifacts
end

function PLUGIN:getDailySales()
	return self.currentSales[1]
end

function PLUGIN:getWeeklySales()
	return self.currentSales[2]
end

function PLUGIN:getDailySalesDate()
	return self.currentSales[3]
end

function PLUGIN:getWeeklySalesDate()
	return self.currentSales[4]
end
--End of the boring stuff


function PLUGIN:cleanSales(id, isDaily)
	if isDaily then
		table.remove(self.currentSales[1], id)
	else
		table.remove(self.currentSales[2], id)
	end
end

function PLUGIN:getNewDailySales()
	self.currentSales[1] = {}
	
	for i=1, self.dailySaleCount do
		self.currentSales[1][i] = self.artifacts[ math.random( #self.artifacts ) ]
	end
	
	self.currentSales[3] = os.time()
end

function PLUGIN:getNewWeeklySales()
	self.currentSales[2] = {}
	
	for i=1, self.weeklySaleCount do
		self.currentSales[2][i] = self.artifacts[ math.random( #self.artifacts ) ]
	end
	
	self.currentSales[4] = os.time()
end

function PLUGIN:checkSalesDate()
	if (os.time() - self:getDailySalesDate()) > 86400 then
		self:getNewDailySales()
	end
	if (os.time() - self:getWeeklySalesDate()) > 604800 then
		self:getNewWeeklySales()
	end
end

function PLUGIN:sellArtifact(client, artiID, isDaily)
	if isDaily then
		local test = self.currentSales[1]
		local arti = test[artiID]
		local find = client:GetCharacter():GetInventory():HasItem(arti)
		
		if find then
			client:GetCharacter():GiveMoney(ix.item.list[arti].price*self.priceModifier)
			self:cleanSales(artiID, isDaily)
			find:Remove()
			client:Notify("You sold "..ix.item.list[arti].name.." for "..ix.currency.Get(ix.item.list[arti].price*self.priceModifier)..".")
		else
			client:Notify("You do not have this item")
		end
	else
		local test = self.currentSales[2]
		local arti = test[artiID]
		local find = client:GetCharacter():GetInventory():HasItem(arti)
		
		if find then
			client:GetCharacter():GiveMoney(ix.item.list[arti].price*self.priceModifier)
			self:cleanSales(artiID, isDaily)
			find:Remove()
			client:Notify("You sold "..ix.item.list[arti].name.." for "..ix.currency.Get(ix.item.list[arti].price*self.priceModifier)..".")
		else
			client:Notify("You do not have this item")
		end
	end
end

if (CLIENT) then
	netstream.Hook("saleSpecialOpn", function(client, entity, artSales)

		if IsValid(entity) then

			local frame = vgui.Create("ixStalkerFrame")
			frame:SetTitle( "Artifact Sales" )
			frame:SetVisible( true )
			--frame:SetDrawOnTop(true)
			frame:SetDraggable( true )
			frame:ShowCloseButton( false )
			frame:Center()
			frame:MakePopup()
			frame:SetSize(600, 800)
			frame:SetPos((ScrW()/2)-300,(ScrH()/2)-400)
			
			local sentence = frame:Add("DLabel")
			sentence:Dock(TOP)
			sentence:SetContentAlignment(8)
			sentence:SetFont("stalkerregularfont")
			sentence:SetText("Hello Stalker, I'm looking for these items and I will pay good.")
			sentence:SetTall(100)
			sentence:DockMargin(5, 5, 5, 0)

			local meme = frame:Add("DLabel")
			meme:Dock(TOP)
			meme:SetContentAlignment(8)
			meme:SetText("Daily Sales")
			meme:DockMargin(5, 5, 5, 0)
			meme:SetFont("stalkerregulartitlefont")
			meme:SetTall(ScrH()*0.04)
			
			for k, v in ipairs(artSales[1]) do
				
				local btn = frame:Add("ixStalkerButton")
				btn:Dock(TOP)
				btn:SetText(ix.item.list[v].name.." - "..ix.item.list[v].price*ix.plugin.list["specialsale"].priceModifier)
				btn:DockMargin(btn:GetParent():GetWide()*0.35, 5, btn:GetParent():GetWide()*0.35, 0)
				btn:SetTall(ScrH()*0.04)
				btn:SetFont("stalkerregularfont")

				function btn.DoClick()
					local arti = k
				
					netstream.Start("saleSpecial", arti, true)
					frame:Close()
				end
			end
			
			
			local meme2 = frame:Add("DLabel")
			meme2:Dock(TOP)
			meme2:SetContentAlignment(8)
			meme2:SetText("Weekly Sales")
			meme2:DockMargin(5, 5, 5, 0)
			meme2:SetFont("stalkerregulartitlefont")
			meme2:SetTall(ScrH()*0.04)
			
			
			for k, v in ipairs(artSales[2]) do
				
				local btn = frame:Add("ixStalkerButton")
				btn:Dock(TOP)
				btn:SetText(ix.item.list[v].name.." - "..ix.item.list[v].price*ix.plugin.list["specialsale"].priceModifier)
				btn:DockMargin(btn:GetParent():GetWide()*0.35, 5, btn:GetParent():GetWide()*0.35, 0)
				btn:SetTall(ScrH()*0.04)
				btn:SetFont("stalkerregularfont")

				function btn.DoClick()
					local arti = k
					
					netstream.Start("saleSpecial", arti, false)
					frame:Close()
				end
			end

			frame:PostLayoutUpdate()
		end
	end)
else
	netstream.Hook("saleSpecial", function(client, artID, isDaily)
		ix.plugin.list["specialsale"]:sellArtifact(client, artID, isDaily)
	end)
	
	function PLUGIN:LoadData()
		data = self:GetData()

		self.currentSales = data.currentSales or {}

		if #self.currentSales == 0 then
			PLUGIN:getNewDailySales()
			PLUGIN:getNewWeeklySales()
		end

		for k, v in ipairs(data.persistList or {}) do
			local entity = ents.Create("ix_specialsale")
			entity:SetPos(v.pos)
			entity:SetAngles(v.angles)
			entity:Spawn()
		end
	end

	function PLUGIN:SaveData()
		--self:setData(self.currentSales)

		local data = {}
		for k, v in ipairs(ents.FindByClass("ix_specialsale")) do
			data[#data + 1] = {
				pos = v:GetPos(),
				angles = v:GetAngles(),
			}
		end
		local data2 = {
			currentSales = self.currentSales,
			persistList = data,
		}

		self:SetData(data2)
	end
end

ix.command.Add("specialsalegetnew", {
	adminOnly = true,
	OnRun = function(self, client, arguments)
		PLUGIN:getNewDailySales()
		PLUGIN:getNewWeeklySales()
	end
})

ix.command.Add("specialsaleprintcurrent", {
	adminOnly = true,
	OnRun = function(self, client, arguments)
		PrintTable(PLUGIN.currentSales)
	end
})