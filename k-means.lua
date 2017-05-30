local Vec2 = require"vec2"  -- Llamámos al módulo de vectores
local _    = require"moses" -- Llamámos al módulo de manejo de tablas https://github.com/Yonaba/Moses

-- Seleccionar centroides

--[[
Los centroides serán los vectores con más erlangs en una partición equitativa.

Cada media hora se vectorizará del siguiente modo:

 | media hora |
 |  erlangs   |

En este caso haremos una partición equitativa de 4 turnos con 7 intervalos de media hora.

--]]

-- función para encontrar centroide en partición

local function centroid(clust)
  local vals = {}
  for i = 1, #clust do
    vals[i] = clust[i].p2
  end
  local max = _.max(vals)
  local pos = _.find(vals, max)
  return clust[pos]
end

-- Creamos una tabla de vectores por partición.

local particion_1 = {
  Vec2.new(1, 167, "9:00 - 9:30"),      -- 9:00 - 9:30
  Vec2.new(2, 173, "9:30 - 10:00"),     -- 9:30 - 10:00
  Vec2.new(3, 179, "10:00 - 10:30"),    -- 10:00 - 10:30
  Vec2.new(4, 172, "10:30 - 11:00"),    -- 10:30 - 11:00
  Vec2.new(5, 147, "11:00 - 11:30"),    -- 11:00 - 11:30
}

local centroide_1 = centroid(particion_1)

--print(centroide_1.p1, centroide_1.p2, centroide_1.tag) -- Comprobamos qué centroide es

local particion_2 = {
  Vec2.new(6, 156, "11:30 - 12:00"),   -- 11:30 - 12:00
  Vec2.new(7, 138, "12:00 - 12:30"),   -- 12:00 - 12:30 
  Vec2.new(8, 140, "12:30 - 13:00"),   -- 12:30 - 13:00
  Vec2.new(9, 114, "13:00 - 13:30"),   -- 13:00 - 13:30
  Vec2.new(10, 117, "13:30 - 14:00"),  -- 13:30 - 14:00
}

local centroide_2 = centroid(particion_2)

--print(centroide_2.p1, centroide_2.p2, centroide_2.tag)

local particion_3 = {
  Vec2.new(11, 110, "14:00 - 14:30"),  -- 14:00 - 14:30
  Vec2.new(12, 110, "14:30 - 15:00"),  -- 14:30 - 15:00
  Vec2.new(13, 95, "15:00 - 15:30"),   -- 15:00 - 15:30
  Vec2.new(14, 104, "15:30 - 16:00"),  -- 15:30 - 16:00
  Vec2.new(15, 105, "16:00 - 16:30"),  -- 16:00 - 16:30
}

local centroide_3 = centroid(particion_3)

--print(centroide_3.p1, centroide_3.p2, centroide_3.tag)

local particion_4 = {
  Vec2.new(16, 98, "16:30 - 17:00"),  -- 16:30 - 17:00
  Vec2.new(17, 101, "17:00 - 17:30"), -- 17:00 - 17:30
  Vec2.new(18, 101, "17:30 - 18:00"), -- 17:30 - 18:00
  Vec2.new(19, 87, "18:00 - 18:30"),  -- 18:00 - 18:30
  Vec2.new(20, 91, "18:30 - 19:00"),  -- 18:30 - 19:00
  Vec2.new(21, 48, "19:00 - 19:30"),  -- 19:00 - 19:30
}

local centroide_4 = centroid(particion_4)

--print(centroide_4.p1, centroide_4.p2, centroide_4.tag)

local particion_5 = {
  Vec2.new(22, 64, "19:30 - 20:00"),  -- 19:30 - 20:00
  Vec2.new(23, 5, "20:00 - 20:30"),   -- 20:00 - 20:30
  Vec2.new(24, 7, "20:30 - 21:00"),   -- 20:30 - 21:00
  Vec2.new(25, 2, "21:00 - 21:30"),   -- 21:00 - 21:30
  Vec2.new(26, 2, "21:30 - 22:00"),   -- 21:30 - 22:00
}

local centroide_5 = centroid(particion_5)

-- Clustering

local cluster = { {}, {}, {}, {}, {} }

cluster[1].centroid = centroide_1
cluster[2].centroid = centroide_2
cluster[3].centroid = centroide_3
cluster[4].centroid = centroide_4
cluster[5].centroid = centroide_5

-- Calculamos la distancia euclidiana entre cada vector y el centroide
-- y asignamos cada uno a su cluster más cercano.


-- funcion para asignar vectores a cada cluster y re-cálculo del centroide

local function asignar_cluster(vec)
  local distancias = {
    vec:euclid(cluster[1].centroid),
    vec:euclid(cluster[2].centroid),
    vec:euclid(cluster[3].centroid),
    vec:euclid(cluster[4].centroid),
    vec:euclid(cluster[5].centroid)
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

---
-- Iniciamos con la primera partición
---

for p = 1, #particion_1 do asignar_cluster(particion_1[p]) end

for c = 1, #cluster do
  print("Centroide del cluster #"..c, cluster[c].centroid.p1, cluster[c].centroid.p2)
end

-- Horarios del cluster #1

print"Horarios del cluster #1:"
for l = 1, #cluster[1] do print(cluster[1][l].tag) end

---
-- Continuamos con la segunda particion
---

for p = 1, #particion_2 do asignar_cluster(particion_2[p]) end

for c = 1, #cluster do
  print("Centroide del cluster #"..c, cluster[c].centroid.p1, cluster[c].centroid.p2)
end

-- Horarios del cluster #1

print"Horarios del cluster #1:"
for l = 1, #cluster[1] do print(cluster[1][l].tag) end

-- Horarios del cluster #2

print"Horarios del cluster #2:"
for l = 1, #cluster[2] do print(cluster[2][l].tag) end

---
-- Tercera partición
---

for p = 1, #particion_3 do asignar_cluster(particion_3[p]) end

for c = 1, #cluster do
  print("Centroide del cluster #"..c, cluster[c].centroid.p1, cluster[c].centroid.p2)
end

-- Horarios del cluster #1

print"Horarios del cluster #1:"
for l = 1, #cluster[1] do print(cluster[1][l].tag) end

-- Horarios del cluster #2

print"Horarios del cluster #2:"
for l = 1, #cluster[2] do print(cluster[2][l].tag) end

-- Horarios del cluster #3

print"Horarios del cluster #3:"
for l = 1, #cluster[3] do print(cluster[3][l].tag) end

---
-- Cuarta partición
---

for p = 1, #particion_4 do asignar_cluster(particion_4[p]) end

for c = 1, #cluster do
  print("Centroide del cluster #"..c, cluster[c].centroid.p1, cluster[c].centroid.p2)
end

-- Horarios del cluster #1

print"Horarios del cluster #1:"
for l = 1, #cluster[1] do print(cluster[1][l].tag) end

-- Horarios del cluster #2

print"Horarios del cluster #2:"
for l = 1, #cluster[2] do print(cluster[2][l].tag) end

-- Horarios del cluster #3

print"Horarios del cluster #3:"
for l = 1, #cluster[3] do print(cluster[3][l].tag) end

-- Horarios del cluster #4

print"Horarios del cluster #4:"
for l = 1, #cluster[4] do print(cluster[4][l].tag) end


---
-- Quinta partición
---

for p = 1, #particion_5 do asignar_cluster(particion_5[p]) end

for c = 1, #cluster do
  print("Centroide del cluster #"..c, cluster[c].centroid.p1, cluster[c].centroid.p2)
end

-- Horarios del cluster #1

print"Horarios del cluster #1:"
for l = 1, #cluster[1] do print(cluster[1][l].tag) end

-- Horarios del cluster #2

print"Horarios del cluster #2:"
for l = 1, #cluster[2] do print(cluster[2][l].tag) end

-- Horarios del cluster #3

print"Horarios del cluster #3:"
for l = 1, #cluster[3] do print(cluster[3][l].tag) end

-- Horarios del cluster #4

print"Horarios del cluster #4:"
for l = 1, #cluster[4] do print(cluster[4][l].tag) end

-- Horarios del cluster #5

print"Horarios del cluster #5:"
for l = 1, #cluster[5] do print(cluster[5][l].tag) end
---------------------------------------------------------------------

-- Se vuelve a calcular la distancia euclidiana de cada vector respecto al nuevo centroide de cada cluster
-- Con el nuevo cálculo se reasignan los horarios

local cluster_nuevo = { {}, {}, {}, {}, {} }

local function recalc(vec)
  local distancias = {
    vec:euclid(cluster[1].centroid),
    vec:euclid(cluster[2].centroid),
    vec:euclid(cluster[3].centroid),
    vec:euclid(cluster[4].centroid),
    vec:euclid(cluster[5].centroid)
  }
  local min = _.min(distancias)
  local pos = _.find(distancias, min)
  table.insert(cluster_nuevo[pos], vec)
end


for p = 1, #particion_1 do 
  recalc(particion_1[p])
end

for p = 1, #particion_2 do 
  recalc(particion_2[p])
end

for p = 1, #particion_3 do 
  recalc(particion_3[p])
end

for p = 1, #particion_4 do 
  recalc(particion_4[p])
end

for p = 1, #particion_5 do 
  recalc(particion_5[p])
end

print"Horario 1"
for l = 1, #cluster_nuevo[1] do print(cluster_nuevo[1][l].tag) end
print"Horario 2"
for l = 1, #cluster_nuevo[2] do print(cluster_nuevo[2][l].tag) end
print"Horario 3"
for l = 1, #cluster_nuevo[3] do print(cluster_nuevo[3][l].tag) end
print"Horario 4"
for l = 1, #cluster_nuevo[4] do print(cluster_nuevo[4][l].tag) end
print"Horario 5"
for l = 1, #cluster_nuevo[5] do print(cluster_nuevo[5][l].tag) end


