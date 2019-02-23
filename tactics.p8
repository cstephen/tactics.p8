pico-8 cartridge // http://www.pico-8.com
version 8
__lua__

-- prefix global variables with g_
g_numportals = 5
g_select = {x = 18, y = 0}
g_gridsize = {x = 128, y = 32}

-- state variables
g_turn = "player"
g_moving = false
g_attacking = false

g_back = false
g_alternate = 20
g_moveanimation = nil
g_spaces = nil

g_units = {
  good = {},
  evil = {}
}

g_mapcorner = {
  x = 18,
  y = 0
}

g_mapanimatecounter = 0

g_mapanimations = {
  {192, 193},
  {194, 195},
  {196, 197},
  {198, 199},
  {200, 201},
  {202, 203},
  {204, 205},
  {206, 207},
  {208, 209},
  {210, 211},
  {212, 213},
  {214, 215},
  {216, 217},
  {218, 219}
}

g_colors = {
  good = 11,
  evil = 14
}

g_sprites = {
  knight = {
    good = 1,
    evil = 17
  },
  dwarf = {
    good = 2,
    evil = 18
  },
  lancer = {
    good = 3,
    evil = 19
  },
  archer = {
    good = 4,
    evil = 20
  },
  frank = {
    evil = 64
  },
  wolf = {
    evil = 65
  },
  skelet = {
    evil = 66
  },
  witch = {
    evil = 67
  },
  zombie = {
    evil = 68
  },
  ghost = {
    evil = 69
  },
  lagoon = {
    evil = 70
  },
  jack = {
    evil = 71
  }
}

g_archetypes = {
  knight = {
    basehp = 10,
    basemight = 3,
    basespeed = 2,
    levelhp = 3,
    levelmight = 2,
    levelspeed = 1,
    attackmin = 0,
    attackmax = 1,
    maxhp = 0,
    hp = 0,
    might = 0,
    speed = 0,
    terrain = {
      grass = 1,
      beach = 1,
      water = 1,
      deepwater = 1,
      cemetary = 1,
      bridge = 1,
      obstacle = 0
    }
  },
  dwarf = {
    basehp = 15,
    basemight = 4,
    basespeed = 1,
    levelhp = 5,
    levelmight = 3,
    levelspeed = 1,
    attackmin = 0,
    attackmax = 1,
    maxhp = 0,
    hp = 0,
    might = 0,
    speed = 0,
    terrain = {
      grass = 1,
      beach = 1,
      water = 1,
      deepwater = 1,
      cemetary = 1,
      bridge = 1,
      obstacle = 0
    }
  },
  lancer = {
    basehp = 10,
    basemight = 2,
    basespeed = 2,
    levelhp = 2,
    levelmight = 1,
    levelspeed = 1,
    attackmin = 0,
    attackmax = 2,
    maxhp = 0,
    hp = 0,
    might = 0,
    speed = 0,
    terrain = {
      grass = 2,
      beach = 2,
      water = 1,
      deepwater = 1,
      cemetary = 2,
      bridge = 2,
      obstacle = 0
    }
  },
  archer = {
    basehp = 5,
    basemight = 1,
    basespeed = 3,
    levelhp = 1,
    levelmight = 1,
    levelspeed = 1,
    attackmin = 1,
    attackmax = 2,
    maxhp = 0,
    hp = 0,
    might = 0,
    speed = 0,
    terrain = {
      grass = 2,
      beach = 2,
      water = 1,
      deepwater = 1,
      cemetary = 2,
      bridge = 2,
      obstacle = 0
    }
  },
  frank = {
    basehp = 10,
    basemight = 3,
    basespeed = 1,
    levelhp = 2,
    levelmight = 2,
    levelspeed = 2,
    attackmin = 0,
    attackmax = 1,
    maxhp = 0,
    hp = 0,
    might = 0,
    speed = 0,
    terrain = {
      grass = 1,
      beach = 1,
      water = 0,
      deepwater = 0,
      cemetary = 1,
      bridge = 1,
      obstacle = 0
    }
  },
  wolf = {
    basehp = 5,
    basemight = 1,
    basespeed = 4,
    levelhp = 2,
    levelmight = 1,
    levelspeed = 2,
    attackmin = 0,
    attackmax = 2,
    maxhp = 0,
    hp = 0,
    might = 0,
    speed = 0,
    terrain = {
      grass = 2,
      beach = 2,
      water = 0,
      deepwater = 0,
      cemetary = 2,
      bridge = 2,
      obstacle = 0
    }
  },
  skelet = {
    basehp = 2,
    basemight = 1,
    basespeed = 6,
    levelhp = 1,
    levelmight = 1,
    levelspeed = 2,
    attackmin = 0,
    attackmax = 1,
    maxhp = 0,
    hp = 0,
    might = 0,
    speed = 0,
    terrain = {
      grass = 1,
      beach = 1,
      water = 0,
      deepwater = 0,
      cemetary = 1,
      bridge = 1,
      obstacle = 0
    }
  },
  witch = {
    basehp = 1,
    basemight = 1,
    basespeed = 3,
    levelhp = 1,
    levelmight = 1,
    levelspeed = 2,
    attackmin = 0,
    attackmax = 1,
    maxhp = 0,
    hp = 0,
    might = 0,
    speed = 0,
    terrain = {
      grass = 2,
      beach = 2,
      water = 2,
      deepwater = 2,
      cemetary = 2,
      bridge = 2,
      obstacle = 2
    }
  },
  zombie = {
    basehp = 4,
    basemight = 1,
    basespeed = 2,
    levelhp = 1,
    levelmight = 1,
    levelspeed = 2,
    attackmin = 0,
    attackmax = 2,
    maxhp = 0,
    hp = 0,
    might = 0,
    speed = 0,
    terrain = {
      grass = 2,
      beach = 2,
      water = 0,
      deepwater = 0,
      cemetary = 2,
      bridge = 1,
      obstacle = 0
    }
  },
  ghost = {
    basehp = 4,
    basemight = 1,
    basespeed = 3,
    levelhp = 1,
    levelmight = 1,
    levelspeed = 3,
    attackmin = 0,
    attackmax = 2,
    maxhp = 0,
    hp = 0,
    might = 0,
    speed = 0,
    terrain = {
      grass = 1,
      beach = 1,
      water = 1,
      deepwater = 1,
      cemetary = 1,
      bridge = 1,
      obstacle = 1
    }
  },
  lagoon = {
    basehp = 2,
    basemight = 1,
    basespeed = 2,
    levelhp = 1,
    levelmight = 1,
    levelspeed = 2,
    attackmin = 0,
    attackmax = 2,
    maxhp = 0,
    hp = 0,
    might = 0,
    speed = 0,
    terrain = {
      grass = 0,
      beach = 1,
      water = 2,
      deepwater = 2,
      cemetary = 1,
      bridge = 0,
      obstacle = 0
    }
  },
  jack = {
    basehp = 2,
    basemight = 1,
    basespeed = 2,
    levelhp = 1,
    levelmight = 1,
    levelspeed = 2,
    attackmin = 0,
    attackmax = 2,
    maxhp = 0,
    hp = 0,
    might = 0,
    speed = 0,
    terrain = {
      grass = 1,
      beach = 1,
      water = 0,
      deepwater = 0,
      cemetary = 1,
      bridge = 1,
      obstacle = 0
    }
  }
}

g_terrainsprites = {
  deepwater = {
    min = 192,
    max = 201
  },
  water = {
    min = 202,
    max = 219
  },
  beach = {
    min = 220,
    max = 228
  },
  grass = {
    min = 229,
    max = 237
  },
  cemetary = {
    min = 238,
    max = 242
  },
  bridge = {
    min = 243,
    max = 243
  }
}

function _init()
  g_bg = gridinit()
  g_breadcrumbs = gridinit()
  g_typemask = gridinit()
  g_terrain = gridinit()

  gridclear(g_bg, {sprite = 0})
  gridclear(g_breadcrumbs, {})
  gridclear(g_typemask, "neutral")
  gridclear(g_terrain, "obstacle")

  processterrain()

  add(g_units.good, createunit("knight", 1, "good", 18, 0))
  -- add(g_units.good, createunit("dwarf", 1, "good", 19, 0))
  -- add(g_units.good, createunit("lancer", 1, "good", 18, 1))
  -- add(g_units.good, createunit("archer", 1, "good", 19, 1))

  local randomunits = {
    "frank",
    "wolf",
    "skelet",
    "witch",
    "zombie",
    "ghost",
    "lagoon",
    "jack"
  }

  for i=0, 30 do
    local type = randomunits[flr(rnd(#randomunits)) + 1]

    local randx
    local randy
    local terraintype

    repeat
      randx = flr(rnd(127)) + 1
      randy = flr(rnd(31)) + 1
      terraintype = g_terrain[randx][randy]
    until g_archetypes[type].terrain[terraintype] > 0

    add(g_units.evil, createunit(type, 1, "evil", randx, randy))
  end

  for i=0, g_gridsize.x do
    for j=0, g_gridsize.y do
      local sprite = mget(i, j)
      if sprite > 127 and sprite < 192 then
        g_typemask[i][j] = "obstacle"
      end
    end
  end
end

function _update()
  if g_turn == "player" then
    playerturn()
  else
    enemyturn()
  end
end

function _draw()
  cls()

  mapanimate()
  map(g_mapcorner.x, g_mapcorner.y, 0, 0, 16, 16)

  griddraw(g_bg)
  unitdraw()
  selectdraw()

  if g_moveanimation != nil then
    moveanimate()
  end

  if g_battleanimation != nil then
    battleanimate()
  end
end

function processterrain()
  for i=0, g_gridsize.x - 1 do
    for j=0, g_gridsize.y - 1 do
      for terrain in pairs(g_terrainsprites) do
        if mget(i, j) >= g_terrainsprites[terrain].min
        and mget(i, j) <= g_terrainsprites[terrain].max then
          g_terrain[i][j] = terrain
        end
      end
    end
  end
end

function playerturn()
  if btnp(0) then
    if g_select.x > 0
    and g_battleanimation == nil then
      g_select.x -= 1
      if g_select.x - g_mapcorner.x < 0 then
        g_mapcorner.x -= 1
        mapsliceanimate(0, nil)
      end
    end
  end

  if btnp(1) then
    if g_select.x < 127
    and g_battleanimation == nil then
      g_select.x += 1
      if g_select.x - g_mapcorner.x > 15 then
        g_mapcorner.x += 1
        mapsliceanimate(15, nil)
      end
    end
  end

  if btnp(2) then
    if g_select.y > 0
    and g_battleanimation == nil then
      g_select.y -= 1
      if g_select.y - g_mapcorner.y < 0 then
        g_mapcorner.y -= 1
        mapsliceanimate(nil, 0)
      end
    end
  end

  if btnp(3) then
    if g_select.y < 31
    and g_battleanimation == nil then
      g_select.y += 1
      if g_select.y - g_mapcorner.y > 15 then
        g_mapcorner.y += 1
        mapsliceanimate(nil, 15)
      end
    end
  end

  if btnp(4) and g_moveanimation == nil then
    if g_moving == false
    and g_attacking == false then
      for unit in all(getunit(g_select.x, g_select.y)) do
        g_chosen = unit
      end
      if g_chosen != nil
      and g_chosen.alignment == "good"
      and g_chosen.actionover == false then
        g_moving = "player"
        g_spaces = exploremoves(g_chosen.x, g_chosen.y, {"good", "neutral"}, {"obstacle", "evil"}, false)
      end
    elseif g_moving == "player"
    and g_attacking == false
    and g_valid[g_select.x] != nil
    and g_valid[g_select.x][g_select.y] != nil then
      if validaction("move") then
        move(g_select.x, g_select.y, {"good", "neutral"}, {"evil"})
      end
    elseif g_moving == false
    and g_attacking == "player"
    and g_battleanimation == nil then
      if validaction("attack") then
        attack({
          x = g_select.x,
          y = g_select.y
        })
      elseif g_select.x == g_chosen.x and g_select.y == g_chosen.y then
        gridclear(g_bg, {sprite = 0})
        g_moving = false
        g_attacking = false
        endaction()
      end
    end
  end

  if btnp(5) then
    if g_moving == "player"
    and g_attacking == false then
      gridclear(g_bg, {sprite = 0})
      g_moving = false
      modifyunit(g_chosen, {
        moving = false
      })
    elseif g_moving == false
    and g_attacking == "player" then
      g_back = true
      gridclear(g_bg, {sprite = 0})
      move(g_lastspace.x, g_lastspace.y, {"good", "neutral"}, {"evil"})
      g_spaces = exploremoves(g_chosen.x, g_chosen.y, {"good", "neutral"}, {"obstacle", "evil"}, true)
      g_moving = "player"
      g_attacking = false
    end
  end
end

function validaction(type)
  for space in all(g_spaces) do
    if g_select.x == space.x and g_select.y == space.y then
      if type == "move" then
        if g_typemask[g_select.x][g_select.y] == "neutral" then
          return true
        elseif g_select.x == g_chosen.x and g_select.y == g_chosen.y then
          for unit in all(getunit(g_select.x, g_select.y)) do
            return true
          end
        end
      elseif type == "attack" then
        return true
      end
    end
  end
  return false
end

function movespace()
  for space in all(g_spaces) do
    local maxspaces = explorerange(space.x, space.y, g_chosen.attackmax, nil, {"good"}, {}, false)
    local minspaces = explorerange(space.x, space.y, g_chosen.attackmin, nil, {"good"}, {}, false)
    local attackspaces = subtractspaces(maxspaces, minspaces)

    if #attackspaces == 1 then
      return space
    end
  end

  return randomspace()
end

function attackspace()
  return randomspace()
end

function randomspace()
  local attempted = {}
  while #attempted < #g_spaces do
    local random = flr(rnd(#g_spaces))
    if inarray(random, attempted) == false then
      add(attempted, random)
      local space = g_spaces[flr(rnd(#g_spaces)) + 1]
      if space.x == g_chosen.x and space.y == g_chosen.y and #getunit(space.x, space.y) == 1 then
        return space
      elseif g_typemask[space.x][space.y] != "evil" then
        return space
      end
    end
  end
  return {
    x = g_chosen.x,
    y = g_chosen.y
  }
end

function unitdistance(unit1, unit2)
  return abs(unit1.x - unit2.x) + abs(unit1.y - unit2.y)
end

function towardcomrade(unit)
  return movespace()
end

function enemyturn()
  if g_moving == false and g_attacking == false and g_battleanimation == nil then
    for evilunit in all(g_units.evil) do
      local withinproximity = false

      for goodunit in all(g_units.good) do
        local distance = abs(evilunit.x - goodunit.x) + abs(evilunit.y - goodunit.y)
        if distance < 15 then
          withinproximity = true
        end
      end

      if evilunit.actionover == false then
        if withinproximity == false then
          g_chosen = evilunit
          endaction()
        else
          g_mapcorner = {
            x = evilunit.x - 8,
            y = evilunit.y - 8
          }

          if g_mapcorner.x < 0 then
            g_mapcorner.x = 0
          elseif g_mapcorner.x + 16 > 127 then
            g_mapcorner.x = 111
          end

          if g_mapcorner.y < 0 then
            g_mapcorner.y = 0
          elseif g_mapcorner.y + 16 > 31 then
            g_mapcorner.y = 15
          end

          g_chosen = evilunit
          local comrades = minmaxrange(g_chosen.x, g_chosen.y, 0, g_chosen.basespeed, nil, nil, {"evil"}, {}, false, false)
          g_spaces = exploremoves(g_chosen.x, g_chosen.y, {"evil", "neutral"}, {"obstacle", "good"}, false)
          g_select = movespace()

          g_moving = "enemy"
          move(g_select.x, g_select.y, {"evil", "neutral"}, {"good"})
          return
        end
      end
    end
  elseif g_moving == false and g_attacking == "enemy" then
    attack(attackspace())
    g_attacking = false
  end
end

function copy(src)
  local dest = {}
  for key, value in pairs(src) do
    dest[key] = value
  end
  return dest
end

function inarray(needle, haystack)
  for item in all(haystack) do
    if item == needle then
      return true
    end
  end
  return false
end

function subtractspaces(sequence1, sequence2)
  local different = false

  for obj1 in all(sequence1) do
    for obj2 in all(sequence2) do
      for key, value in pairs(obj2) do
        if obj1[key] != value then
          different = true
        end
      end
      if different == false then
        del(sequence1, obj1)
      end
    end
  end

  return sequence1
end

function statprint(text, x, y, color, width)
  rectfill(x, y, x + width, y + 8, 0)
  print(text, x + 2, y + 2, color)
end

function gridinit()
  local grid = {}
  for i=0, g_gridsize.x do
    grid[i] = {}
  end
  return grid
end

function gridclear(grid, value)
  for i=0, g_gridsize.x do
    for j=0, g_gridsize.y do
      grid[i][j] = value
    end
  end
end

function griddraw(grid)
  for i=g_mapcorner.x, g_mapcorner.x + 16 do
    for j=g_mapcorner.y, g_mapcorner.y + 16 do
      local pos = spritepos(grid[i][j].sprite)
      sspr(pos.x * 8, pos.y * 8, 8, 8, (i - g_mapcorner.x) * 8, (j - g_mapcorner.y) * 8)
    end
  end
end

function unitdraw()
  for alignment, units in pairs(g_units) do
    for unit in all(units) do
      if unit.moving == false then
        local pos = spritepos(unit.sprite)
        sspr(pos.x * 8, pos.y * 8, 8, 8, (unit.x - g_mapcorner.x) * 8, (unit.y - g_mapcorner.y) * 8)
      end
    end
  end
end

function mapanimate()
  for i=g_mapcorner.x, g_mapcorner.x + 16 do
    for j=g_mapcorner.y, g_mapcorner.y + 16 do
      if g_mapanimatecounter % g_alternate == 0 then
        for mapanimation in all(g_mapanimations) do
          for k=1, #mapanimation do
            if mget(i, j) == mapanimation[k]
            and g_mapanimatecounter == k * g_alternate then
              mset(i, j, mapanimation[k % #mapanimation + 1])
              break
            end
          end
        end
      end
    end
  end

  if g_mapanimatecounter == g_alternate * 2 then
    g_mapanimatecounter = 0
  end

  g_mapanimatecounter += 1
end

function mapsliceanimate(x, y)
  for idx=0, 15 do
    for mapanimation in all(g_mapanimations) do
      for k=1, #mapanimation do
        local sprite

        if x != nil then
          sprite = mget(g_mapcorner.x + x, g_mapcorner.y + idx)
        elseif y != nil then
          sprite = mget(g_mapcorner.x + idx, g_mapcorner.y + y)
        end

        if sprite == mapanimation[#mapanimation - (k - 1)]
        and g_mapanimatecounter >= (k - 1) * g_alternate
        and g_mapanimatecounter <= k * g_alternate then
          if x != nil then
            mset(g_mapcorner.x + x, g_mapcorner.y + idx, mapanimation[k])
          elseif y != nil then
            mset(g_mapcorner.x + idx, g_mapcorner.y + y, mapanimation[k])
          end
        end
      end
    end
  end
end

function spritepos(s)
  local sprite = {}
  sprite.x = s % 16
  sprite.y = flr(s / 16)
  return sprite
end

function selectdraw()
  local screenpos = {
    x = g_select.x - g_mapcorner.x,
    y = g_select.y - g_mapcorner.y
  }

  spr(255, screenpos.x * 8, screenpos.y * 8)

  local unit = getunit(g_select.x, g_select.y)[1]
  if unit != nil then
    local screen = {
      pos = {
        x = 100,
        y = 1
      },
      width = 26
    }

    if g_battleanimation == nil then
      showstats(unit, screen)
    end
  end
end

function battleanimate()
  g_battleanimation.frame += 1

  local frame = g_battleanimation.frame
  local counterattack = g_battleanimation.counterattack
  local good = g_battleanimation.good
  local evil = g_battleanimation.evil

  local statpos = {
    good = {
      x = 16,
      y = 69
    },
    evil = {
      x = 82,
      y = 69
    }
  }

  if frame > 30 and frame < 116 then
    local friendlystats = {
      pos = statpos[g_chosen.alignment],
      width = 31
    }
    showstats(g_chosen, friendlystats)

    local enemystats = {
      pos = statpos[g_enemy.alignment],
      width = 31
    }
    showstats(g_enemy, enemystats)
  end

  local nudgefactor
  if good.alignment == "good" then
    nudgefactor = 1
  else
    nudgefactor = -1
  end

  if frame <= 30 then
    zoom(0, 1)
  elseif frame > 60 and frame <= 63 then
    nudge("good", 1 * nudgefactor)
  elseif frame > 63 and frame <= 66 then
    damage("evil")
    nudge("good", -1 * nudgefactor)
  elseif frame > 81 and frame <= 83 then
    if counterattack == true and g_enemy.hp > 0 then
      nudge("evil", -1 * nudgefactor)
    end
  elseif frame > 83 and frame <= 86 then
    if counterattack == true and g_enemy.hp > 0 then
      damage("good")
      nudge("evil", 1 * nudgefactor)
    end
  elseif frame > 116 and frame <= 146 then
    zoom(116, -1)
  elseif frame > 146 then
    if g_chosen.hp == 0 then
      die(g_chosen)
    else
      g_chosen.sprite = good.sprite
    end

    if g_enemy.hp == 0 then
      die(g_enemy)
    else
      g_enemy.sprite = evil.sprite
    end

    g_battleanimation = nil
    g_attacking = false

    endaction()
    return
  end

  local pos = spritepos(good.sprite)
  sspr(pos.x * 8, pos.y * 8, 8, 8, good.move.x, good.move.y, good.size.x, good.size.y)

  pos = spritepos(evil.sprite)
  sspr(pos.x * 8, pos.y * 8, 8, 8, evil.move.x, evil.move.y, evil.size.x, evil.size.y)
end

function zoom(baseframe, direction)
  local progress

  local zoompos = {
    good = {
      x = 29,
      y = 40
    },
    evil = {
      x = 95,
      y = 40
    }
  }

  if direction > 0 then
    progress = g_battleanimation.frame - baseframe
  else
    progress = 30 - (g_battleanimation.frame - baseframe)
  end

  local scale = 8 + 8 * (progress / 15)

  g_battleanimation.good.size = {
    x = scale,
    y = scale
  }

  g_battleanimation.good.move = {
    x = ((g_chosen.x - g_mapcorner.x) * 8 + (((zoompos[g_chosen.alignment].x - (g_chosen.x - g_mapcorner.x) * 8) / 30) * progress)) - g_battleanimation.good.size.x / 2 + 4,
    y = ((g_chosen.y - g_mapcorner.y) * 8 + (((zoompos[g_chosen.alignment].y - (g_chosen.y - g_mapcorner.y) * 8) / 30) * progress)) - g_battleanimation.good.size.y / 2 + 4
  }

  g_battleanimation.evil.size = {
    x = scale,
    y = scale
  }

  g_battleanimation.evil.move = {
    x = ((g_enemy.x - g_mapcorner.x) * 8 + (((zoompos[g_enemy.alignment].x - (g_enemy.x - g_mapcorner.x) * 8) / 30) * progress)) - g_battleanimation.evil.size.x / 2 + 4,
    y = ((g_enemy.y - g_mapcorner.y) * 8 + (((zoompos[g_enemy.alignment].y - (g_enemy.y - g_mapcorner.y) * 8) / 30) * progress)) - g_battleanimation.evil.size.y / 2 + 4
  }
end

function nudge(alignment, direction)
  g_battleanimation[alignment].move = {
    x = g_battleanimation[alignment].move.x + direction,
    y = g_battleanimation[alignment].move.y
  }
end

function damage(alignment)
  if alignment == "good"
  and g_enemy.hp > 0 then
    g_chosen.hp -= g_enemy.might / 3 * g_enemy.level
    g_enemy.xp += g_chosen.level / 10
    if g_chosen.hp < 1 then
      g_chosen.hp = 0
      g_enemy.xp += g_chosen.level / 5
    end
    if g_enemy.xp >= 3 ^ g_chosen.level then
      g_enemy.xp = 0
      levelup(g_enemy, g_enemy.level + 1)
    end
  elseif alignment == "evil"
  and g_chosen.hp > 0 then
    g_enemy.hp -= g_chosen.might / 3 * g_chosen.level
    g_chosen.xp += g_enemy.level / 10
    if g_enemy.hp < 1 then
      g_enemy.hp = 0
      g_chosen.xp += g_enemy.level / 5
    end
    if g_chosen.xp >= 3 ^ g_chosen.level then
      g_chosen.xp = 0
      levelup(g_chosen, g_chosen.level + 1)
    end
  end
end

function die(dyingunit)
  g_typemask[dyingunit.x][dyingunit.y] = "neutral"

  for alignment, units in pairs(g_units) do
    for unit in all(units) do
      if dyingunit == unit then
        del(units, unit)
      end
    end
  end
end

function endaction()
  g_chosen.actionover = true
  local turnover = true

  if g_turn == "player" then
    for unit in all(g_units.good) do
      if unit.actionover == false then
        turnover = false
      end
    end

    if turnover == true then
      endturn("player")
    end
  else
    for unit in all(g_units.evil) do
      if unit.actionover == false then
        turnover = false
      end
    end

    if turnover == true then
      endturn("enemy")
    end
  end
end

function endturn(side)
  if side == "player" then
    g_turn = "enemy"

    for unit in all(g_units.evil) do
      unit.actionover = false
    end

    g_lastselect = {
      x = g_select.x,
      y = g_select.y
    }

    g_lastmapcorner = {
      x = g_mapcorner.x,
      y = g_mapcorner.y,
    }
  else
    g_turn = "player"

    for unit in all(g_units.good) do
      unit.actionover = false
      if unit.hp < unit.maxhp then
        unit.hp += 1
      end
    end

    g_select = {
      x = g_lastselect.x,
      y = g_lastselect.y
    }

    g_mapcorner = {
      x = g_lastmapcorner.x,
      y = g_lastmapcorner.y
    }
  end

  g_moving = false
  g_attacking = false
end

function showstats(unit, screen)
  statprint(unit.type, screen.pos.x, screen.pos.y, g_colors[unit.alignment], screen.width)
  statprint("lvl:" .. unit.level, screen.pos.x, screen.pos.y + 8, g_colors[unit.alignment], screen.width)
  statprint("hp:" .. flr(unit.hp + 0.5), screen.pos.x, screen.pos.y + 16, g_colors[unit.alignment], screen.width)
  statprint("xp:" .. flr((unit.xp / (3 ^ unit.level)) * 100) .. "%", screen.pos.x, screen.pos.y + 24, g_colors[unit.alignment], screen.width)
end

function createunit(type, level, alignment, x, y)
  local new = copy(g_archetypes[type])
  new.sprite = g_sprites[type][alignment]
  new.type = type
  new.level = level
  new.alignment = alignment
  new.x = x
  new.y = y
  new.xp = 0
  new.moving = false
  new.actionover = false

  levelup(new, level)
  new.hp = new.maxhp

  g_typemask[x][y] = alignment
  return new
end

function modifyunit(unit, modifications)
  for key, value in pairs(modifications) do
    unit[key] = value
  end
end

function levelup(unit, level)
  modifyunit(unit, {
    maxhp = unit.basehp + unit.levelhp * (level - 1),
    might = unit.basemight + unit.levelmight * (level - 1),
    speed = unit.basespeed + unit.levelspeed * (level - 1),
    level = level
  })
end

function moveunit(unit, x, y)
  modifyunit(unit, {
    x = x,
    y = y
  })
  unit.moving = false
  if #getunit(g_lastspace.x, g_lastspace.y) == 0 then
    g_typemask[g_lastspace.x][g_lastspace.y] = "neutral"
  end
  g_typemask[x][y] = unit.alignment
end

function getunit(x, y)
  local found = {}
  for alignment, units in pairs(g_units) do
    for unit in all(units) do
      if unit.x == x and unit.y == y then
        add(found, unit)
      end
    end
  end
  return found
end

function exploremoves(x, y, passable, obstacles, attacking)
  return explorerange(g_chosen.x, g_chosen.y, g_chosen.speed, 254, passable, obstacles, true, attacking)
end

function moveanimate()
  local segment = g_moveanimation.segment
  local select = g_moveanimation.select
  local begin = g_moveanimation.begin
  local finish = g_moveanimation.finish
  local pixelpos = g_moveanimation.pixelpos
  local sprite = g_moveanimation.sprite
  local attacktargets = g_moveanimation.attacktargets

  local currentcell = {
    x = pixelpos.x / 8,
    y = pixelpos.y / 8
  }

  if currentcell.x == begin.x
  and currentcell.y == begin.y then
    gridclear(g_bg, {sprite = 0})
  end

  if segment - 1 < #g_breadcrumbs[select.x][select.y] then
    if currentcell.x == g_breadcrumbs[select.x][select.y][segment].x
    and currentcell.y == g_breadcrumbs[select.x][select.y][segment].y then
      g_previousspace = {
        x = g_breadcrumbs[select.x][select.y][segment].x,
        y = g_breadcrumbs[select.x][select.y][segment].y
      }
      g_moveanimation.segment += 1
    else
      pixelpos.x += g_breadcrumbs[select.x][select.y][segment].x - g_previousspace.x
      pixelpos.y += g_breadcrumbs[select.x][select.y][segment].y - g_previousspace.y
    end

    local movescreenpos = {
      x = pixelpos.x - (g_mapcorner.x * 8),
      y = pixelpos.y - (g_mapcorner.y * 8)
    }

    spr(sprite, movescreenpos.x, movescreenpos.y)
  end

  if currentcell.x == finish.x
  and currentcell.y == finish.y then
    moveunit(g_chosen, finish.x, finish.y)
    g_moving = false
    g_moveanimation = nil
    g_spaces = exploreattacks(attacktargets)
  end
end

function move(x, y, friendlies, enemies)
  if g_back == false then
    g_lastspace = {
      x = g_chosen.x,
      y = g_chosen.y
    }

    g_moveanimation = {
      segment = 1,
      select = {
        x = g_select.x,
        y = g_select.y
      },
      begin = {
        x = g_chosen.x,
        y = g_chosen.y
      },
      finish = {
        x = x,
        y = y
      },
      pixelpos = {
        x = g_chosen.x * 8,
        y = g_chosen.y * 8
      },
      sprite = g_chosen.sprite,
      attacktargets = enemies
    }

    modifyunit(g_chosen, {
      moving = true
    })
  else
    g_typemask[g_chosen.x][g_chosen.y] = "neutral"
    moveunit(g_chosen, g_lastspace.x, g_lastspace.y)
    modifyunit(g_chosen, {
      moving = false
    })
    g_back = false
  end
end

function exploreattacks(targets)
  local attackspaces = minmaxrange(g_chosen.x, g_chosen.y, g_chosen.attackmin, g_chosen.attackmax, 0, 253, targets, {}, true, true)
  if #attackspaces > 0 then
    if g_turn == "player" then
      g_attacking = "player"
    else
      g_attacking = "enemy"
    end
  else
    endaction()
  end

  return attackspaces
end

function attack(target)
  g_enemy = getunit(target.x, target.y)[1]

  gridclear(g_bg, {sprite = 0})

  g_battleanimation = {
    frame = 0,
    good = {
      sprite = g_chosen.sprite,
      alignment = g_chosen.alignment
    },
    evil = {
      sprite = g_enemy.sprite,
      alignment = g_enemy.alignment
    }
  }

  local counteralignment = nil
  if g_enemy.alignment == "good" then
    counteralignment = {"evil"}
  else
    counteralignment = {"good"}
  end

  local g_spaces = minmaxrange(g_enemy.x, g_enemy.y, g_enemy.attackmin, g_enemy.attackmax, 0, 253, counteralignment, {}, true, true)

  g_battleanimation.counterattack = false
  for space in all(g_spaces) do
    if space.x == g_chosen.x and space.y == g_chosen.y then
      g_battleanimation.counterattack = true
    end
  end

  gridclear(g_bg, {sprite = 0})
  g_chosen.sprite = 0
  g_enemy.sprite = 0
end

function explorerange(x, y, steps, sprite, alignments, obstacles, storebreadcrumb, attacking)
  g_valid = {}
  spaces = {}
  return crawlspace(x, y, steps, sprite, alignments, obstacles, {}, storebreadcrumb, spaces, attacking)
end

function minmaxrange(x, y, min, max, minsprite, maxsprite, targets, obstacles, storebreadcrumb, attacking)
  local maxspaces = explorerange(x, y, max, maxsprite, targets, obstacles, storebreadcrumb, attacking)
  local minspaces = explorerange(x, y, min, minsprite, targets, obstacles, storebreadcrumb, attacking)
  return subtractspaces(maxspaces, minspaces)
end

function crawlspace(x, y, steps, sprite, alignments, obstacles, breadcrumb, storebreadcrumb, spaces, attacking)
  if g_valid[x] == nil then
    g_valid[x] = {}
  end

  if g_valid[x][y] == nil then
    g_valid[x][y] = {}
  end

  local betterpath = g_valid[x][y].steps == nil or g_valid[x][y].steps < steps

  if betterpath == true then
    g_valid[x][y].steps = steps
    g_valid[x][y].alignment = g_typemask[x][y]
    for alignment in all(alignments) do
      if g_typemask[x][y] == alignment then
        if sprite != nil then
          g_bg[x][y] = {sprite = sprite}
        end
        add(spaces, {
          x = x,
          y = y
        })
      end
    end
  end

  add(breadcrumb, {
    x = x,
    y = y
  })

  if storebreadcrumb == true and betterpath == true then
    g_breadcrumbs[x][y] = copy(breadcrumb)
  end

  if validspace(x - 1, y, steps, obstacles) then
    local movepoints = 1

    local terrainskill = g_chosen.terrain[g_terrain[x-1][y]]
    if attacking == false and terrainskill > 0 then
      movepoints = 1 / terrainskill
    end

    crawlspace(x - 1, y, steps - movepoints, sprite, alignments, obstacles, copy(breadcrumb), storebreadcrumb, spaces, attacking)
  end

  if validspace(x + 1, y, steps, obstacles) then
    local movepoints = 1

    local terrainskill = g_chosen.terrain[g_terrain[x+1][y]]
    if attacking == false and terrainskill > 0 then
      movepoints = 1 / terrainskill
    end

    crawlspace(x + 1, y, steps - movepoints, sprite, alignments, obstacles, copy(breadcrumb), storebreadcrumb, spaces, attacking)
  end

  if validspace(x, y - 1, steps, obstacles) then
    local movepoints = 1

    local terrainskill = g_chosen.terrain[g_terrain[x][y-1]]
    if attacking == false and terrainskill > 0 then
      movepoints = 1 / terrainskill
    end

    crawlspace(x, y - 1, steps - movepoints, sprite, alignments, obstacles, copy(breadcrumb), storebreadcrumb, spaces, attacking)
  end

  if validspace(x, y + 1, steps, obstacles) then
    local movepoints = 1

    local terrainskill = g_chosen.terrain[g_terrain[x][y+1]]
    if attacking == false and terrainskill > 0 then
      movepoints = 1 / terrainskill
    end

    crawlspace(x, y + 1, steps - movepoints, sprite, alignments, obstacles, copy(breadcrumb), storebreadcrumb, spaces, attacking)
  end

  return spaces
end

function validspace(x, y, steps, obstacles)
  if x < 0 or x >= 128 or y < 0 or y >= 32 then
    return false
  end

  for obstacle in all(obstacles) do
    if g_typemask[x][y] == obstacle then
      return false
    end
  end

  if steps <= 0 then
    return false
  end

  return true
end

__gfx__
000000000000007d000660000000007600f000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000007dc006666000000776600f500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000007dc0006666600000566000f540700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000557dc000005667700056560333333670000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000005dc000005357700053500000f040700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000005355000053507000535000000f550000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000053505000335000005350000000f500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000035000000030000003500000000f000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000d7000000000660006700000000000f000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000cd700000006666006677000000002f000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000cd70000066666000662000007042f000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000cd7220776620000626200076eeeeee0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000cd2000772e2000002e20007040f000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000022e2000702e2000002e2000022f000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000202e2000002ee000002e200002f000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000002e000000e00000002e00000f000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
05555550040000400077770000555500003333000077770000bbbb00000330000000000000000000000000000000000000000000000000000000000000000000
0353535004444440077777700555555003333330077777700bbbbbb0099999900000000000000000000000000000000000000000000000000000000000000000
0333333004444440071771705555555503833830077777700b1bb1b0999999990000000000000000000000000000000000000000000000000000000000000000
0313313004244240077777700ffffff003333330071771700bbbbbb0991991990000000000000000000000000000000000000000000000000000000000000000
0333333004444440077777700f1ff1f003333330077777703bbbbbb3999999990000000000000000000000000000000000000000000000000000000000000000
6333333604444440007777000ffffff000333300077777703bbbbbb3919999190000000000000000000000000000000000000000000000000000000000000000
03311330004224000071170000f11f00003883000777777033b11b33991111990000000000000000000000000000000000000000000000000000000000000000
033333300002200000777700000ff000003383000707707033bbbb33099999900000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
111dd111dddddddd1113311100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
11dccd11dddccddd113ff31100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1dccccd1ddccccdd13ffff3100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
dcccccd2dcccccd23fffff3500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
dccccdd2dccccdd23ffff33500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
dcccdd22dcccdd223fff335500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1dcdd221ddcdd22d13f3355100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
11222211dd2222dd1155551100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1111111111111111cc111111cc111111111111cc111111cc11111111111111111111111111111111cccccccccccccccc11cccccc11cccccccccccc11cccccc11
1111cc1111111111c111cc11c11111111111111c1111111c1111cc11111111111111cc1111111111cccc11cccccccccc1ccc11cc1cccccccccccccc1ccccccc1
11cc11cc11cc11cc11cc11cc11cc11cc111111111111111111cc11cc11cc11cc11cc11cc11cc11cccc11cc11cc11cc11cc11cc11cc11cc11cccccccccccccccc
111111111111cc11111111111111cc111111111111111111111111111111cc11111111111111cc11cccccccccccc11cccccccccccccc11cccccccccccccccccc
11111111111111111111111111111111111111111111111111111111111111111111111111111111cccccccccccccccccccccccccccccccccccccccccccccccc
11cc11111111111111cc11111111111111cc11111111111111111111111111111111111111111111cc11cccccccccccccc11cccccccccccccc11cccccccccccc
cc11cc11cc11cc11cc11cc11cc11cc11cc11cc11cc11cc11c1111111c11111111111111c1111111c11cc11cc11cc11cc11cc11cc11cc11cc11cc11cc11cc11cc
1111111111cc11111111111111cc11111111111111cc1111cc111111cc111111111111cc111111cccccccccccc11cccccccccccccc11cccccccccccccc11cccc
ccccccccccccccccccccccccccccccccddccccccddccccccccccccddccccccddccccccccccccccccccccccccccccccccddddddddccddddddddddddccdddddddd
cccc11cccccccccccccc11ccccccccccdccc11ccdccccccccccccccdcccccccdcccc11cccccccccccccc11ccccccccccddddddddcddddddddddddddcdddddddd
cc11cc11cc11cc11cc11cc11cc11cc11cc11cc11cc11cc11cccccccccccccccccc11cc11cc11cc11cc11cc11cc11cc11dddddddddddddddddddddddddddddddd
cccccccccccc11cccccccccccccc11cccccccccccccc11cccccccccccccccccccccccccccccc11cccccccccccccc11ccddddd7ddddddd7ddddddd7ddddddd7dd
ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccdddddddddddddddddddddddddddddddd
cccccccccccccccccccccccccccccccccc11cccccccccccccc11ccccccccccccccccccccccccccccccccccccccccccccd7ddddddd7ddddddd7dddddddddddddd
1ccccccc1cccccccccccccc1ccccccc111cc11cc11cc11cc11cc11cc11cc11ccdcccccccdccccccccccccccdcccccccdddddddddddddddddddddddddcddddddd
11cccccc11cccccccccccc11cccccc11cccccccccc11cccccccccccccc11ccccddccccccddccccccccccccddccccccddddddddddddddddddddddddddccdddddd
dddddddd11dddddddddddd11dddddddddddddddd11111111dd111111111111dd111111111111111111111111cc111111111111cc111111112222222222222211
dddddddd1dddddddddddddd1dddddddddddddddd13111111d31111111311111d131111111311111113111111c31111111311111c131111112222222222222221
dddddddddddddddddddddddddddddddddddddddd1311113113111131131111311311113113111131131111311311113113111131131111312722222227222222
ddddd7ddddddd7ddddddd7ddddddd7ddddddd7dd1111113111111131111111311111113111111131111111311111113111111131111111312222227222222272
dddddddddddddddddddddddddddddddddddddddd1111111111111111111111111111111111111111111111111111111111111111111111112222222222222222
d7ddddddd7ddddddd7ddddddddddddddd7dddddd1113111111131111111311111113111111131111111311111113111111131111111311112222222222222222
dddddddcdddddddddddddddd1dddddddddddddd1311311113113111131131111d1131111311311113113111d3113111111131111311311112227222222272222
ddddddccdddddddddddddddd11dddddddddddd11311111113111111131111111dd11111131111111311111dd3111111111111111311111117222222222222222
22222222222222222222222222222222222222222222222222222222000000000000000000000000000000000000000000000000aaaaaaaacccccccc77000077
2222222222222222222222222222222222222222222222222227d222000000000000000000000000000000000000000000000000aaaaaaaacccccccc70000007
2722222227222222272222222222e22222222222227777222227d222000000000000000000000000000000000000000000000000aaaaaaaacccccccc00000000
22222272222222722222227222222ee22222222227777762277777d2000000000000000000000000000000000000000000000000aaaaaaaacccccccc00000000
222222222222222222222222222222222222222227666762277777d2000000000000000000000000000000000000000000000000aaaaaaaacccccccc00000000
2222222222222222222222222222222222222222277777622227d222000000000000000000000000000000000000000000000000aaaaaaaacccccccc00000000
122722222227222222272222e222222222222222276667622227d222000000000000000000000000000000000000000000000000aaaaaaaacccccccc70000007
1122222272222222722222222ee2222222222222277777622227d222000000000000000000000000000000000000000000000000aaaaaaaacccccccc77000077
__gff__
0000080000000000000000000000000000000800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
cacacacacacacacacadcdcdcdcdcdcdcdcdcdcdcdcdcdcdce5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5cacacacacacacacacacacacacacacacacacacacacacacacacacacacae5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5eef5eef5eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
cacacacacacacacacadfdcdcdcdcdcdcdcdcdcdcdcdcdcdce5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5d0cacacacacacacacacacacacacacacacacacacacacacacacacacad2e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5eeeeeeeeeeeeeef6eeeeeeeeeeeeeef6eeeeeeeeeeeeeeeeeeeeeeeeeeeeee
cacacacacacacacacacad6dcdcdcdcdcdcdcdcdcdcdcdcdce5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5eccacacacacacacacacacacacacacacacacacacacacacacacaebe5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5eef5eef5eeeef6f6f6eeeeeeeeeef6f6f6eeeeeeeeeeeeeeeeeeeeeeeeeeee
cacacacacacacacacacacadfdcdcdcdcdcdcdcdcdcdcdcdce8e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5d0cacacacacacacacacacacacacacacacacacacacacacad2e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5eeeeeeeeeeeeeef6eeeeeef6eeeeeef6eeeeeeeeeeeeeeeeeeeeeeeeeeeeee
cacacacacacacacacacacacad6dcdcdcdcdcdcdcdcdcdcdcdce2e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5eccacacacacacacacacacacacacacacacaebe5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5eef5eef5eeeeeeeeeeeef6f6f6eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
cacacacacacacacacacacacacadfdcdcdcdcdcdcdcdcdcdc81dce8e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5d0cacacacacacacacacacacacacacad2e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5eeeeeeeeeeeeeeeeeef6f6f6f6f6eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
c0c0c4cacacacacacacacacacacacad6dcdcdcdcdcdcdcdc81dcdce2e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5eef5eef5eeeeeeeeeeeef6f6f6eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
c0c0c0d0cacacacacacacacacacacacadfdcdcdcdcdcdcdcdcdc81dce8e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5eeeeeeeeeeeeeef6eeeeeef6eeeeeef6eeeeeeeeeeeeeeeeeeeeeeeeeeeeee
c0c0c0c0c0c0c0c4cacacacacacacacacacad6dcdcdcdcdcdcdc81dcdce2e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5eef5eef5eeeef6f6f6eeeeeeeeeef6f6f6eeeeeeeeeeeeeeeeeeeeeeeeeeee
c0c0c0c0c0c0c0c0d0cacacacacacacacacacadfdcdcdcdcdcdcdcdcdcdce8e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5eeeeeeeeeeeeeef6eeeeeeeeeeeeeef6eeeeeeeeeeeeeeeeeeeeeeeeeeeeee
c0c0c0c0c0c0c0c0c0c0c4cacacacacacacacacacacacacacacad6dcdcdcdce2e8e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5eef5eef5eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
c0c0c0c0c0c0c0c0c0c0c0cacacacacacacacacacacacacacacacadfdcdcdcdcdcdcdcdcdce2e8e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5f0eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
c0c0c0c0c0c0c0c0c0c0c0d0cacacacacacacacacacacacacacacacacacacacacacacacad6dfdcdcdcdce2e8e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5ebe5e5e5e5e5e5e5e5e5e5e5
c0c0c0c0c0c0c0c0c0c0c0c0c0c0c4cacacacacacacacacacacacacacacacacacacacacacacacacacad6dfdce2e8e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5
c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0cacacacacacacacacacacacacacacacacacacacacacacacacacacacad6dfdcdce2e8e5e5e5e5e5e5e5e5e5e5e5eae1dcdcdcdcdcdcdcdce2e8e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5
c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0cacacacacacacacacacacacacacacacacacacacacacacacacacacacacacacad6dfdcdcdcdcdcdcdcf3f3f3f3dcdce0d4cacacacacacad6dfdcdcdce2e8e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5
c0c0c0c0c0c0c0c0c0c0c0c0c0c0c8cacacacacacacacacacacacacacacacacacacacacacacacacacacacacacacacacacacacacacacacaf3f3f3f3cacacacacacacacacacacacacacad6dfdce2e8e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5
c0c0c0c0c0c0c0c0c0c0c0c0c0cccacacacacacacacacacacacacacacacacacacacacacacacacacacacacacacacacacacacacacacacacaf3f3f3f3cacacacacacacacacacacacacacacacad6dfdcdce2e8e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5
c0c0c0c0c0c0c0c0c0c0c0c0c8cacacacacacacacacacacacacacacacacacacacacacacacacacacacacacacacacacacacacacacacacacaf3f3f3f3cacacacacacacacacacacacacacacacacacacad6dfe2e8e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5
c0c0c0c0c0c0c0c0c0cccacacacacacacacacacacacacacacacacacacacacacacacacacacacacacacacacacacacacacacacacacacacacaf3f3f3f3cacacacacacacacacacacacacacacacacacacacad6dfe2e8e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5
c0c0c0c0c0c0c0c0c8cacacacacacacacacacacacacacadadddcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcded8cacacacacacacacacacacacaf3f3f3f3cacacacacacacacacacacacacacacacacacacacacad6dfe2e8e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e1dcdcdcdcdce2e8e5e5e5e5e5e5e5e5e5e5
c0c0c0c0c0cccacacacacacacacacacacacacacacadddcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcded8cacacacacacaf3f3f3f3cacacacacacacacacacacacacacacacacacacacacacad6dfe2e8e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e9e1dcdcdce0d4cacacad6dfdcdce2e8e5e5e5e5e5e5e5
c0c0c0c0c8cacacacacacacacacacacacacacacadadcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdce6e7e3dcdcdcdcdcdcdcf3f3f3f3cacacacacacacacacacacacacacacacacacacacacacacad6dfe2e8e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e9e1dcdcdce0d4cacacacacacacacacacad6dfdcdce2e8e5e5e5e5
c0c0cccacacacacacacacacacacacacacacadddcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdce4e5e5e5e5e5e5e5e5e5e5f3f3f3f3dcdcdcdcdcded8cacacacacacacacacacacacacacacacacad6dfdce2e8e5e5e5e5e5e5e5e5e5e5e1dcdcdcdcd4cacacacacacacacacacacacacacacacacad6dfe2e5e5e5e5
c0c8cacacacacacacacacacacacacacacadadcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdce6e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e7e3dcdcdcdcded8cacacacacacacacacacacacacacacacad6dce2e5e5e5e5e5e5e5e5e5e5e3dcdcdcdcd8cacacacacacacacacacacacacacacacacacad6dce8e5e5e5
cacacacacacacacacacacacacacacadddcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdce4e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e7e3dcdcded8cacacacacacacacacacacacacacacacadfdce8e5e5e5e5e5e5e5e5e5e5e7e3dcdcdcdcded8cacacacacacacacacacacacacacacacadce2e5e5e5
cacacacacacacacacacacacacacadadcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdce6e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e7e3dcded8cacacacacacacacacacacacacacad6dce2e8e5e5e5e5e5e5e5e5e5e5e5e5e5e5e7e3dcdcdcdcdcdcded8cacacacacacacacacadcdce5e5e5
cacacacacacacacacacacadadddcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdce4e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e7e3dcdcded8cacacacacacacacacacacacacadfdce2e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e7e3dcdcdcded8cacacacadadce4e5e5e5
cacacacacacacacacadddcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdce6e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e7e3dcded8cacacacacacacacacacacacad6dcdce8e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e7e3dcdcdcdcdcdce4e6e5e5e5
cacacacacacacacadadcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdce4e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e7e3dcdcded8cacacacacacacacacacacadcdce2e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5
cacacacacacadddcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdce6e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e7e3dcdcded8cacacacacacacacacacadcdcdce5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5
cacacacacacadcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdce5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e7dcdcdecacacacacacacacacacadcdcdce5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5
__sfx__
00010000000000000000000000003400000000000001b0001b000000001c000000001e00020000230002500028000290002a0002c0002c0002c00000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__music__
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344

