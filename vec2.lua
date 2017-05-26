local Vec2 = {}
local mt = {__index = Vec2}

function Vec2.mean(...)
  local t = {...}
  local acc = 0
  for i = 1, #t do
    acc = acc + t[i]
  end
  return acc / #t
end

function Vec2.new(p1, p2, tag)
  local self = {
    p1 = p1,
    p2 = p2,
    tag = tag
  }
  self.val = p1 + p2
  setmetatable(self, mt)
  return self
end

function Vec2:euclid(vec)
  local dist = math.sqrt(math.pow(self.p1 - vec.p1, 2) + math.pow(self.p2 - vec.p2, 2))
  return dist
end
