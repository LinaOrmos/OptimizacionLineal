local Vec2 = require"vec2"  -- Llamámos al módulo de vectores
local _    = require"moses" -- Llamámos al módulo de manejo de tablas https://github.com/Yonaba/Moses

-- Seleccionar centroides

--[[
Los centroides serán los vectores más grandes en una partición equitativa.

Cada media hora se vectorizará del siguiente modo:

 | media hora |
 |  erlangs   |

En este caso haremos una partición equitativa de 4 turnos con 7 intervalos de media hora.

--]]

-- función para encontrar centroide en partición

local function centroid(clust)
  local vals = {}
  for i = 1, #clust do
    vals[i] = clust[i].val
  end
  local max = _.max(vals)
  local pos = _.find(vals, max)
  return clust[pos]
end

-- Creamos una tabla de vectores por partición.

local particion_1 = {
  Vec2.new(1, 0, "8:00 - 8:30"),   -- 8:00 - 8:30
  Vec2.new(2, 0, "8:30 - 9:00"),   -- 8:30 - 9:00
  Vec2.new(3, 1, "9:00 - 9:30"),   -- 9:00 - 9:30
  Vec2.new(4, 2, "9:30 - 10:00"),  -- 9:30 - 10:00
  Vec2.new(5, 4, "10:00 - 10:30"), -- 10:00 - 10:30
  Vec2.new(6, 4, "10:30 - 11:00"), -- 10:30 - 11:00
  Vec2.new(7, 7, "11:00 - 11:30"), -- 11:00 - 11:30 
}

local centroide_1 = centroid(particion_1)

print(centroide_1.p1, centroide_1.p2, centroide_1.tag) -- Comprobamos qué centroide es

local particion_2 = {
  Vec2.new(8, 6, "11:30 - 12:00"),   -- 11:30 - 12:00
  Vec2.new(9, 7, "12:00 - 12:30"),   -- 12:00 - 12:30
  Vec2.new(10, 7, "12:30 - 13:00"),  -- 12:30 - 13:00
  Vec2.new(11, 7, "13:00 - 13:30"),  -- 13:00 - 13:30
  Vec2.new(12, 8, "13:30 - 14:00"),  -- 13:30 - 14:00
  Vec2.new(13, 11, "14:00 - 14:30"), -- 14:00 - 14:30
  Vec2.new(14, 7, "14:30 - 15:30"),  -- 14:30 - 15:30 
}

local centroide_2 = centroid(particion_2)

print(centroide_2.p1, centroide_2.p2, centroide_2.tag)
