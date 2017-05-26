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

--print(centroide_1.p1, centroide_1.p2, centroide_1.tag) -- Comprobamos qué centroide es

local particion_2 = {
  Vec2.new(8, 6, "11:30 - 12:00"),   -- 11:30 - 12:00
  Vec2.new(9, 7, "12:00 - 12:30"),   -- 12:00 - 12:30
  Vec2.new(10, 7, "12:30 - 13:00"),  -- 12:30 - 13:00
  Vec2.new(11, 7, "13:00 - 13:30"),  -- 13:00 - 13:30
  Vec2.new(12, 8, "13:30 - 14:00"),  -- 13:30 - 14:00
  Vec2.new(13, 11, "14:00 - 14:30"), -- 14:00 - 14:30
  Vec2.new(14, 7, "14:30 - 15:30"),  -- 14:30 - 15:00 
}

local centroide_2 = centroid(particion_2)

--print(centroide_2.p1, centroide_2.p2, centroide_2.tag)

local particion_3 = {
  Vec2.new(15, 6, "15:00 - 15:30"), -- 15:00 - 15:30
  Vec2.new(16, 7, "15:30 - 16:00"), -- 15:30 - 16:00
  Vec2.new(17, 7, "16:00 - 16:30"), -- 16:00 - 16:30
  Vec2.new(18, 8, "16:30 - 17:00"), -- 16:30 - 17:00
  Vec2.new(19, 6, "17:00 - 17:30"), -- 17:00 - 17:30
  Vec2.new(20, 5, "17:30 - 18:00"), -- 17:30 - 18:00
  Vec2.new(21, 6, "18:00 - 18:30"), -- 18:00 - 18:30
}

local centroide_3 = centroid(particion_3)

--print(centroide_3.p1, centroide_3.p2, centroide_3.tag)

local particion_4 = {
  Vec2.new(22, 5, "18:30 - 19:00"), -- 18:30 - 19:00
  Vec2.new(23, 4, "19:00 - 19:30"), -- 19:00 - 19:30
  Vec2.new(24, 5, "19:30 - 20:00"), -- 19:30 - 20:00
  Vec2.new(25, 1, "20:00 - 20:30"), -- 20:00 - 20:30
  Vec2.new(26, 2, "20:30 - 21:00"), -- 20:30 - 21:00
  Vec2.new(27, 1, "21:00 - 21:30"), -- 21:00 - 21:30
  Vec2.new(28, 2, "21:30 - 22:00"), -- 21:30 - 22:00
}

local centroide_4 = centroid(particion_4)

--print(centroide_4.p1, centroide_4.p2, centroide_4.tag)

-- Clustering

local cluster = { {}, {}, {}, {} }

cluster[1].centroid = centroide_1
cluster[2].centroid = centroide_2
cluster[3].centroid = centroide_3
cluster[4].centroid = centroide_4

-- Calculamos la distancia euclidiana entre cada vector y el centroide
-- y asignamos cada uno a su cluster más cercano.


-- funcion para asignar vectores a cada cluster y re-cálculo del centroide

local function asignar_cluster(vec)
  local distancias = {
    vec:euclid(cluster[1].centroid),
    vec:euclid(cluster[2].centroid),
    vec:euclid(cluster[3].centroid),
    vec:euclid(cluster[4].centroid)
  }
  
  local min = _.min(distancias)
  local pos = _.find(distancias, min)
  
  table.insert(cluster[pos], vec)
  
  local punto1 = 0
  local punto2 = 0
  
  for i = 1, #cluster[pos] do
    punto1 = punto1 + cluster[pos][i].p1
    punto2 = punto2 + cluster[pos][i].p2
  end
  
  punto1 = punto1 / #cluster[pos]
  punto2 = punto2 / #cluster[pos]
  
  cluster[pos].centroid = Vec2.new(punto1, punto2)
end

-- Iniciamos con la primera partición

for p = 1, #particion_1 do
  asignar_cluster(particion_1[p])
end

for c = 1, #cluster do
  print("Centroide del cluster #"..c, cluster[c].centroid.p1, cluster[c].centroid.p2)
end
