
local math_Approach = math.Approach

CustomizableWeaponry_KK.ins2.matproxy = CustomizableWeaponry_KK.ins2.matproxy or {}

// Scope Lense

CustomizableWeaponry_KK.ins2.matproxy.lense = CustomizableWeaponry_KK.ins2.matproxy.lense or {}
local proxy = CustomizableWeaponry_KK.ins2.matproxy.lense

proxy.name = "IronsightVectorResult"

function proxy:init(mat, values)
	self.mults = {}

	self.ResultTo = values.resultvar
	self.ResultBase = Vector(values.resultdefault)
	self.ResultAdd = Vector(values.resultzoomed) - self.ResultBase
end

function proxy:bind(mat, ent)
	if !IsValid(ent) then return end

	local mul = self.mults[ent] or 0.5

	if IsValid(ent.wepParent) and ent.wepParent.CW20Weapon and ent.wepParent:isAiming() then
		mul = math_Approach(mul, 1, FrameTime() * 2)
	else
		mul = math_Approach(mul, 0, FrameTime() * 2)
	end

	mat:SetVector(self.ResultTo, self.ResultBase + mul * self.ResultAdd)
	self.mults[ent] = mul
end

matproxy.Add(proxy)

// Scope Rendertarget

CustomizableWeaponry_KK.ins2.matproxy.scope = CustomizableWeaponry_KK.ins2.matproxy.scope or {}
local proxy = CustomizableWeaponry_KK.ins2.matproxy.scope

proxy.name = "Scope"

function proxy:init(mat, values)
	-- self.resultVars = self.resultVars or {}
	-- self.resultVars[values.resultvar] = true
	-- self.ResultTo = values.resultvar
	-- self.ResultBase = Vector(values.resultdefault)
	-- self.ResultAdd = Vector(values.resultzoomed) - self.ResultBase
end

function proxy:bind(mat, ent)
	if !IsValid(ent) then return end

	-- print("scope proxy", ent, CurTime())

	-- local mul = self.mults[ent] or 0.5

	-- if IsValid(ent.wepParent) and ent.wepParent.CW20Weapon and ent.wepParent:isAiming() then
		-- mul = math_Approach(mul, 1, FrameTime() * 2)
	-- else
		-- mul = math_Approach(mul, 0, FrameTime() * 2)
	-- end

	-- mat:SetVector(self.ResultTo, self.ResultBase + mul * self.ResultAdd)
	-- self.mults[ent] = mul
end

matproxy.Add(proxy)
