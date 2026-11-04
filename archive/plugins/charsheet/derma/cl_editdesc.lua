local PANEL = {}

function PANEL:Init()
	self:SetSize(ScrW()*0.35, ScrH()*0.8)	
	self:MakePopup()
	self:Center()
	self:SetTitle("Character Sheet")

	self.controls = self:Add("DPanel")
	self.controls:Dock(BOTTOM)
	self.controls:SetTall(30)
	self.controls:DockMargin(0, 5, 0, 0)
	
	self.photo = self.controls:Add("DTextEntry")
	self.photo:Dock(FILL)
	self.photo:SetMultiline(true)
	self.photo:SetEditable(true)

	self.confirm = self.controls:Add("DButton")
	self.confirm:Dock(RIGHT)
	self.confirm:SetDisabled(false)
	self.confirm:SetText("Finish")
	
	self.hardcontents = self:Add("DPanel")
	self.hardcontents:Dock(FILL)
	self.hardcontents:SizeToContents()
	self.hardcontents:SetTall(self.hardcontents:GetParent():GetTall()*0.3)
	self.hardcontents:DockMargin(0, 5, 0, 0)

	self.titles = self.hardcontents:Add("DPanel")
	self.titles:Dock(LEFT)
	self.titles:SetWide(self:GetWide()*0.3)

	self.titlesright = self.hardcontents:Add("DPanel")
	self.titlesright:Dock(FILL)
	self.titlesright:SizeToContents()

	self.confirm.DoClick = function(this)
		local url = self.photo:GetValue()
		local character = LocalPlayer():GetCharacter()
		local sheet = character:GetData("charsheetinfo", {})
		sheet["Full Name"].right = charsheetfullnameright:GetValue()
		sheet["Nickname"].right = charsheetnicknameright:GetValue()
		sheet["Age"].right = charsheetageright:GetValue()
		sheet["Race"].right = charsheetraceright:GetValue()
		sheet["Nationality"].right = charsheetnationalityright:GetValue()
		sheet["Physical Description"].right = charsheetphysdescright:GetValue()
		sheet["Psychological Description"].right = charsheetpsychdescright:GetValue()
		sheet["Backstory"].right = charsheetbackstoryright:GetValue()
		sheet["Injuries"].right = charsheetinjuriesright:GetValue()

		netstream.Start("ixDescriptionSendText", text, url, sheet)
		self:Close()
	end

	self.controls.Paint = function(this, w, h)
		local url = self.photo:GetValue()
		draw.SimpleText(Format(string.len(url)), "DermaDefault", 10, h/2, color_white, TEXT_ALIGN_LEFT, 1)
	end
end

function PANEL:setText(text, url)
	self.photo:SetValue(url or "Place your link")
end

function PANEL:buildSheet(client, isadmin)
	local sheetdata = client:GetCharacter():GetData("charsheetinfo", nil)

	--Full Name
	charsheetfullnameleft = self.titles:Add("DLabel")
	charsheetfullnameleft:Dock(TOP)
	charsheetfullnameleft:SetText(sheetdata["Full Name"].left..": ")
	charsheetfullnameleft:SizeToContents()
	charsheetfullnameleft:SetContentAlignment(7)
	charsheetfullnameleft:SetFont("stalkerregularfont")
	charsheetfullnameleft:SetTall(ScrH()*0.020)

	charsheetfullnameright = self.titlesright:Add("DTextEntry")
	charsheetfullnameright:SetMultiline(true)
	if sheetdata["Full Name"].nonadmin == true or isadmin == true then
		charsheetfullnameright:SetEditable(true)
	else
		charsheetfullnameright:SetEditable(false)
	end
	charsheetfullnameright:Dock(TOP)
	charsheetfullnameright:SetText(sheetdata["Full Name"].right)
	charsheetfullnameright:SizeToContents()
	charsheetfullnameright:SetTall(ScrH()*0.020)
	charsheetfullnameright:SetFont("stalkerregularsmallfont")

	--Nickname
	charsheetnicknameleft = self.titles:Add("DLabel")
	charsheetnicknameleft:Dock(TOP)
	charsheetnicknameleft:SetText(sheetdata["Nickname"].left..": ")
	charsheetnicknameleft:SizeToContents()
	charsheetnicknameleft:SetContentAlignment(7)
	charsheetnicknameleft:SetFont("stalkerregularfont")
	charsheetnicknameleft:SetTall(ScrH()*0.020)

	charsheetnicknameright = self.titlesright:Add("DTextEntry")
	charsheetnicknameright:SetMultiline(true)
	if sheetdata["Nickname"].nonadmin == true or isadmin == true then
		charsheetnicknameright:SetEditable(true)
	else
		charsheetnicknameright:SetEditable(false)
	end
	charsheetnicknameright:Dock(TOP)
	charsheetnicknameright:SetText(sheetdata["Nickname"].right)
	charsheetnicknameright:SizeToContents()
	charsheetnicknameright:SetTall(ScrH()*0.020)
	charsheetnicknameright:SetFont("stalkerregularsmallfont")

	--Age
	charsheetageleft = self.titles:Add("DLabel")
	charsheetageleft:Dock(TOP)
	charsheetageleft:SetText(sheetdata["Age"].left..": ")
	charsheetageleft:SizeToContents()
	charsheetageleft:SetContentAlignment(7)
	charsheetageleft:SetFont("stalkerregularfont")
	charsheetageleft:SetTall(ScrH()*0.020)

	charsheetageright = self.titlesright:Add("DTextEntry")
	charsheetageright:SetMultiline(true)
	if sheetdata["Age"].nonadmin == true or isadmin == true then
		charsheetageright:SetEditable(true)
	else
		charsheetageright:SetEditable(false)
	end
	charsheetageright:Dock(TOP)
	charsheetageright:SetText(sheetdata["Age"].right)
	charsheetageright:SizeToContents()
	charsheetageright:SetTall(ScrH()*0.020)
	charsheetageright:SetFont("stalkerregularsmallfont")

	--Race
	charsheetraceleft = self.titles:Add("DLabel")
	charsheetraceleft:Dock(TOP)
	charsheetraceleft:SetText(sheetdata["Race"].left..": ")
	charsheetraceleft:SizeToContents()
	charsheetraceleft:SetContentAlignment(7)
	charsheetraceleft:SetFont("stalkerregularfont")
	charsheetraceleft:SetTall(ScrH()*0.020)

	charsheetraceright = self.titlesright:Add("DTextEntry")
	charsheetraceright:SetMultiline(true)
	if sheetdata["Race"].nonadmin == true or isadmin == true then
		charsheetraceright:SetEditable(true)
	else
		charsheetraceright:SetEditable(false)
	end
	charsheetraceright:Dock(TOP)
	charsheetraceright:SetText(sheetdata["Race"].right)
	charsheetraceright:SizeToContents()
	charsheetraceright:SetTall(ScrH()*0.020)
	charsheetraceright:SetFont("stalkerregularsmallfont")

	--Nationality
	charsheetnationalityleft = self.titles:Add("DLabel")
	charsheetnationalityleft:Dock(TOP)
	charsheetnationalityleft:SetText(sheetdata["Nationality"].left..": ")
	charsheetnationalityleft:SizeToContents()
	charsheetnationalityleft:SetContentAlignment(7)
	charsheetnationalityleft:SetFont("stalkerregularfont")
	charsheetnationalityleft:SetTall(ScrH()*0.020)

	charsheetnationalityright = self.titlesright:Add("DTextEntry")
	charsheetnationalityright:SetMultiline(true)
	if sheetdata["Nationality"].nonadmin == true or isadmin == true then
		charsheetnationalityright:SetEditable(true)
	else
		charsheetnationalityright:SetEditable(false)
	end
	charsheetnationalityright:Dock(TOP)
	charsheetnationalityright:SetText(sheetdata["Nationality"].right)
	charsheetnationalityright:SizeToContents()
	charsheetnationalityright:SetTall(ScrH()*0.020)
	charsheetnationalityright:SetFont("stalkerregularsmallfont")

	--Physical Description
	charsheetphysdescleft = self.titles:Add("DLabel")
	charsheetphysdescleft:Dock(TOP)
	charsheetphysdescleft:SetText(sheetdata["Physical Description"].left..": ")
	charsheetphysdescleft:SizeToContents()
	charsheetphysdescleft:SetContentAlignment(7)
	charsheetphysdescleft:SetFont("stalkerregularfont")
	charsheetphysdescleft:SetTall(ScrH()*0.060)

	charsheetphysdescright = self.titlesright:Add("DTextEntry")
	charsheetphysdescright:SetMultiline(true)
	if sheetdata["Physical Description"].nonadmin == true or isadmin == true then
		charsheetphysdescright:SetEditable(true)
	else
		charsheetphysdescright:SetEditable(false)
	end
	charsheetphysdescright:Dock(TOP)
	charsheetphysdescright:SetText(sheetdata["Physical Description"].right)
	charsheetphysdescright:SizeToContents()
	charsheetphysdescright:SetTall(ScrH()*0.060)
	charsheetphysdescright:SetFont("stalkerregularsmallfont")

	--Psychological Description
	charsheetpsychdescleft = self.titles:Add("DLabel")
	charsheetpsychdescleft:Dock(TOP)
	charsheetpsychdescleft:SetText(sheetdata["Psychological Description"].left..": ")
	charsheetpsychdescleft:SizeToContents()
	charsheetpsychdescleft:SetContentAlignment(7)
	charsheetpsychdescleft:SetFont("stalkerregularfont")
	charsheetpsychdescleft:SetTall(ScrH()*0.060)

	charsheetpsychdescright = self.titlesright:Add("DTextEntry")
	charsheetpsychdescright:SetMultiline(true)
	if sheetdata["Psychological Description"].nonadmin == true or isadmin == true then
		charsheetpsychdescright:SetEditable(true)
	else
		charsheetpsychdescright:SetEditable(false)
	end
	charsheetpsychdescright:Dock(TOP)
	charsheetpsychdescright:SetText(sheetdata["Psychological Description"].right)
	charsheetpsychdescright:SizeToContents()
	charsheetpsychdescright:SetTall(ScrH()*0.060)
	charsheetpsychdescright:SetFont("stalkerregularsmallfont")

	--Backstory
	charsheetbackstoryleft = self.titles:Add("DLabel")
	charsheetbackstoryleft:Dock(TOP)
	charsheetbackstoryleft:SetText(sheetdata["Backstory"].left..": ")
	charsheetbackstoryleft:SizeToContents()
	charsheetbackstoryleft:SetContentAlignment(7)
	charsheetbackstoryleft:SetFont("stalkerregularfont")
	charsheetbackstoryleft:SetTall(ScrH()*0.080)

	charsheetbackstoryright = self.titlesright:Add("DTextEntry")
	charsheetbackstoryright:SetMultiline(true)
	if sheetdata["Backstory"].nonadmin == true or isadmin == true then
		charsheetbackstoryright:SetEditable(true)
	else
		charsheetbackstoryright:SetEditable(false)
	end
	charsheetbackstoryright:Dock(TOP)
	charsheetbackstoryright:SetText(sheetdata["Backstory"].right)
	charsheetbackstoryright:SizeToContents()
	charsheetbackstoryright:SetTall(ScrH()*0.080)
	charsheetbackstoryright:SetFont("stalkerregularsmallfont")

	--Injuries
	charsheetinjuriesleft = self.titles:Add("DLabel")
	charsheetinjuriesleft:Dock(TOP)
	charsheetinjuriesleft:SetText(sheetdata["Injuries"].left..": ")
	charsheetinjuriesleft:SizeToContents()
	charsheetinjuriesleft:SetContentAlignment(7)
	charsheetinjuriesleft:SetFont("stalkerregularfont")
	charsheetinjuriesleft:SetTall(ScrH()*0.080)

	charsheetinjuriesright = self.titlesright:Add("DTextEntry")
	charsheetinjuriesright:SetMultiline(true)
	if sheetdata["Injuries"].nonadmin == true or isadmin == true then
		charsheetinjuriesright:SetEditable(true)
	else
		charsheetinjuriesright:SetEditable(false)
	end
	charsheetinjuriesright:Dock(TOP)
	charsheetinjuriesright:SetText(sheetdata["Injuries"].right)
	charsheetinjuriesright:SizeToContents()
	charsheetinjuriesright:SetTall(ScrH()*0.080)
	charsheetinjuriesright:SetFont("stalkerregularsmallfont")

	--StalkerNET Status
	charsheetstalkernetleft = self.titles:Add("DLabel")
	charsheetstalkernetleft:Dock(TOP)
	charsheetstalkernetleft:SetText("StalkerNET Rank"..": ")
	charsheetstalkernetleft:SizeToContents()
	charsheetstalkernetleft:SetContentAlignment(7)
	charsheetstalkernetleft:SetFont("stalkerregularfont")
	charsheetstalkernetleft:SetTall(ScrH()*0.030)

	charsheetstalkernetright = self.titlesright:Add("DLabel")
	charsheetstalkernetright:Dock(TOP)
	charsheetstalkernetright:SetText(client:getCurrentRankName())
	charsheetstalkernetright:SizeToContents()
	charsheetstalkernetright:SetTall(ScrH()*0.030)
	charsheetstalkernetright:SetContentAlignment(7)
	charsheetstalkernetright:SetFont("stalkerregularfont")

	--Attributes
	charsheetattributesleft = self.titles:Add("DLabel")
	charsheetattributesleft:Dock(TOP)
	charsheetattributesleft:SetText("Primary Attributes"..": ")
	charsheetattributesleft:SizeToContents()
	charsheetattributesleft:SetContentAlignment(7)
	charsheetattributesleft:SetFont("stalkerregularfont")
	charsheetattributesleft:SetTall(ScrH()*0.020)

	for k, v in SortedPairsByMemberValue(ix.attributes.list, "name") do
		if v.secondary then
			continue
		end

		charsheetattributesright = self.titles:Add("DLabel")
		charsheetattributesright:Dock(TOP)
		charsheetattributesright:SetFont("stalkerregularsmallfont")
		charsheetattributesright:SetText(v.name..": "..client:GetCharacter():GetAttribute(k, 0))
		charsheetattributesright:SizeToContents()
		charsheetattributesright:SetTall(ScrH()*0.016)
	end

	--Secondary Attributes
	charsheetsecattributesleft = self.titles:Add("DLabel")
	charsheetsecattributesleft:Dock(TOP)
	charsheetsecattributesleft:SetText("Secondary Attributes"..": ")
	charsheetsecattributesleft:SizeToContents()
	charsheetsecattributesleft:SetContentAlignment(1)
	charsheetsecattributesleft:SetFont("stalkerregularfont")
	charsheetsecattributesleft:SetTall(ScrH()*0.030)

	for k, v in SortedPairsByMemberValue(ix.attributes.list, "name") do
		if v.secondary == true then
			charsheetsecattributesright = self.titles:Add("DLabel")
			charsheetsecattributesright:Dock(TOP)
			charsheetsecattributesright:SetFont("stalkerregularsmallfont")
			charsheetsecattributesright:SetText(v.name..": "..client:GetCharacter():GetAttribute(k, 0))
			charsheetsecattributesright:SizeToContents()
			charsheetsecattributesright:SetTall(ScrH()*0.016)
		end
	end

	--Perks
	charsheetperksleft = self.titlesright:Add("DLabel")
	charsheetperksleft:Dock(TOP)
	charsheetperksleft:SetText("Perks"..": ")
	charsheetperksleft:SizeToContents()
	charsheetperksleft:SetContentAlignment(7)
	charsheetperksleft:SetFont("stalkerregularfont")
	charsheetperksleft:SetTall(ScrH()*0.020)

	for k, v in SortedPairsByMemberValue(ix.perks.list, "name") do
		charsheetperksright = self.titlesright:Add("DLabel")
		charsheetperksright:Dock(TOP)
		charsheetperksright:SetFont("stalkerregularsmallfont")
		charsheetperksright:SetText(v.name..": "..client:GetCharacter():GetPerk(k, 0))
		charsheetperksright:SizeToContents()
		charsheetperksright:SetTall(ScrH()*0.016)
	end



end

vgui.Register("ixDescriptionEn", PANEL, "DFrame")