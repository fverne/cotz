-- Minimal Source engine Vector, Angle, LocalToWorld and WorldToLocal for standalone specs.
local VectorMeta = {}
VectorMeta.__index = VectorMeta

function Vector(x, y, z)
	return setmetatable({x = x or 0, y = y or 0, z = z or 0}, VectorMeta)
end

VectorMeta.__add = function(a, b) return Vector(a.x + b.x, a.y + b.y, a.z + b.z) end
VectorMeta.__sub = function(a, b) return Vector(a.x - b.x, a.y - b.y, a.z - b.z) end
VectorMeta.__unm = function(a) return Vector(-a.x, -a.y, -a.z) end
VectorMeta.__mul = function(a, b)
	if type(a) == "number" then a, b = b, a end
	if type(b) == "number" then return Vector(a.x * b, a.y * b, a.z * b) end

	return Vector(a.x * b.x, a.y * b.y, a.z * b.z)
end
VectorMeta.__div = function(a, b) return Vector(a.x / b, a.y / b, a.z / b) end

function VectorMeta:Dot(other)
	return self.x * other.x + self.y * other.y + self.z * other.z
end

function VectorMeta:Length()
	return math.sqrt(self:Dot(self))
end

function VectorMeta:Normalize()
	local length = self:Length()
	if length > 0 then
		self.x, self.y, self.z = self.x / length, self.y / length, self.z / length
	end
end

local AngleMeta = {}
AngleMeta.__index = AngleMeta

function Angle(p, y, r)
	return setmetatable({p = p or 0, y = y or 0, r = r or 0}, AngleMeta)
end

function isvector(value)
	return getmetatable(value) == VectorMeta
end

function isangle(value)
	return getmetatable(value) == AngleMeta
end

local rad, deg = math.rad, math.deg
local atan2 = math.atan2 or math.atan

-- Columns: forward, left, up.
local function toMatrix(angle)
	local sp, cp = math.sin(rad(angle.p)), math.cos(rad(angle.p))
	local sy, cy = math.sin(rad(angle.y)), math.cos(rad(angle.y))
	local sr, cr = math.sin(rad(angle.r)), math.cos(rad(angle.r))
	local forward = Vector(cp * cy, cp * sy, -sp)
	local right = Vector(-sr * sp * cy + cr * sy, -sr * sp * sy - cr * cy, -sr * cp)
	local up = Vector(cr * sp * cy + sr * sy, cr * sp * sy - sr * cy, cr * cp)

	return {forward, -right, up}
end

local function toAngle(matrix)
	local forward, left, up = matrix[1], matrix[2], matrix[3]
	local xy = math.sqrt(forward.x * forward.x + forward.y * forward.y)
	if xy > 0.001 then
		return Angle(deg(atan2(-forward.z, xy)), deg(atan2(forward.y, forward.x)), deg(atan2(left.z, up.z)))
	end

	return Angle(deg(atan2(-forward.z, xy)), deg(atan2(-left.x, left.y)), 0)
end

local function rotate(matrix, vector)
	return matrix[1] * vector.x + matrix[2] * vector.y + matrix[3] * vector.z
end

local function unrotate(matrix, vector)
	return Vector(matrix[1]:Dot(vector), matrix[2]:Dot(vector), matrix[3]:Dot(vector))
end

function LocalToWorld(localPos, localAngle, originPos, originAngle)
	local origin = toMatrix(originAngle)
	local child = toMatrix(localAngle)

	return originPos + rotate(origin, localPos),
		toAngle({rotate(origin, child[1]), rotate(origin, child[2]), rotate(origin, child[3])})
end

function WorldToLocal(worldPos, worldAngle, originPos, originAngle)
	local origin = toMatrix(originAngle)
	local child = toMatrix(worldAngle)

	return unrotate(origin, worldPos - originPos),
		toAngle({unrotate(origin, child[1]), unrotate(origin, child[2]), unrotate(origin, child[3])})
end

-- A bone matrix stand-in for idle animation samples.
function SourceMathMatrix(pos, angle)
	return {
		GetTranslation = function() return pos end,
		GetAngles = function() return angle end,
	}
end

return {toMatrix = toMatrix, toAngle = toAngle}
