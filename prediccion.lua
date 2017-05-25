local luann = require"luann"

math.randomseed(89890)

-- función de predicción por intervalos de media hora

function prediccion(t)
  t.learning_rate = t.learning_rate or 50 -- un número entre 1 y 100
  t.intentos      = t.intentos or 100000 -- intentos de backpropagation
  t.threshold     = t.threshold or 1 -- curvatura de la función (sigmoide)
  t.modelo        = t.modelo or {1,4,8,4,2} -- red
  
-- Estructura de la red:
--[[

        O
      / O \
    O / O \ O \ 
  / O / O \ O   O
 O  
  \ O \ O / O   O
    O \ O / O /
      \ O /
        O

1 perceptron de tiempo
16 células "hidden" dispuestas en 3 capas
2 células de sálida, representando los Erlang y los Agentes Requeridos

--]]

  red = luann:new(t.modelo, t.learning_rate, t.threshold)
  
  -- backpropagation
  -- Para asignar fechas al modelo, se toman la cantidad de un día en un mes. Ej: En mayo hay 5 lunes
  -- Dividimos 1 sobre la cantidad de días.
  local erlang1 = t.erlang1 / 100
  local erlang2 = t.erlang2 / 100
  
  local agentes1 = t.agentes1 / 100
  local agentes2 = t.agentes2 / 100
  
  for i = 1, t.intentos do
    red:bp({t.semana1}, {erlang1, agentes1}) -- 1ro de mayo
    red:bp({t.semana2}, {erlang2, agentes2}) -- 8 de mayo
    --red:bp({.6}, {.04, .0509}) -- 15 de mayo
  end
  
  -- Se activa la red
  red:activate{t.activar}
  print("Erlangs", red[5].cells[1].signal * 100)
  print("Agentes", red[5].cells[2].signal * 100)
end

print"Predicción del lunes (9:00 - 9:30) de la 3ra semana de mayo"

prediccion{
          activar = .6, 
          semana1 = .2, erlang1 = 1, agentes1 = 1.27,
          semana2 = .4, erlang2 = 3, agentes2 = 3.82,
          }

