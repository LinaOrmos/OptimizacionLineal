-- Módulo auxiliar para manejo de vectores.

local Vec2 = {}
local mt = {__index = Vec2}

-- promedios
function Vec2.mean(...)
  local t = {...}
  local acc = 0
  for i = 1, #t do
    acc = acc + t[i]
  end
  return acc / #t
end

-- Objeto vector
function Vec2.new(p1, p2)
  local self = {
    p1 = p1,
    p2 = p2
  }
  setmetatable(self, mt)
  return self
end

-- Distancia euclidiana
-- TODO: Crear generalización del algoritmo en 'n' dimensiones.
function Vec2:euclid(vec)
  local dist = math.sqrt(math.pow(self.p1 - vec.p1, 2) + math.pow(self.p2 - vec.p2, 2))
  return dist
end

return Vec2
