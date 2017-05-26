local Vec2 = require"vec2" -- Llamámos al módulo de vectores
local _ = require"moses"   -- Llamámos al módulo de manejo de tablas https://github.com/Yonaba/Moses

local function centroid(clust)
  local vals = {}
  for i = 1, #clust do
    vals[i] = clust[i].val
  end
  local max = _.max(vals)
  local pos = _.find(vals, max)
  return clust[pos]
end

-- Seleccionar centroides

--[[
Los centroides serán los vectores más grandes en una partición equitativa.

Cada media hora se vectorizará del siguiente modo:

 | media hora |
 |  erlangs   |

En este caso haremos una partición equitativa de 4 turnos con 7 intervalos de media hora.

--]]

-- Creamos una tabla de vectores por partición.

local particion_1 = {
    Vec2.new(1, 0), -- 8:00 - 8:30
    Vec2.new(2, 0), -- 8:30 - 9:00
    Vec2.new(3, 1), -- 9:00 - 9:30
    Vec2.new(4, 2), -- 9:30 - 10:00
    Vec2.new(5, 4), -- 10:00 - 10:30
    Vec2.new(6, 4), -- 10:30 - 11:00
    Vec2.new(7, 7), -- 11:00 - 11:30 
}

local centroide_1 = centroid(particion_1)

print(centroide_1.p1, centroide_1.p2) -- Comprobamos que el centroide es el 
                                      -- séptimo de la primera partición
