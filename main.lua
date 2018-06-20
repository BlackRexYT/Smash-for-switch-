Renderer    = require "tools.renderer"
GameLoop    = require "tools.gameLoop"
rect        = require "objects.rect"
entity      = require "objects.entity"
Vec2        = require "tools.vec2"
anim8       = require "libraries.anim8"
bump        = require "bump"
camera      = require "camera"

love.graphics.setDefaultFilter( "nearest" )

renderer = Renderer:create()
gameLoop = GameLoop:create()

g_Width  = love.graphics.getWidth()
g_Height = love.graphics.getHeight()

g_GameTime = 0

local ent = entity:new(32,32,64,64,"Player")

local fps = 30

function ent:load()
  gameLoop:addLoop(self)
  tlm:load()
end

function ent:tick(dt)
  print(self.id)
end

local player = {}

player.y = {}

rightpicframes = {}

leftpicframes = {}

jumppicframes = {}

standing = true

facing = false

crouching = false

jumping = false

function love.load()
  frames = {}

  Lframes = {}
  for i = 2,7 do
    table.insert(rightpicframes,love.graphics.newImage("characters/sonic" .. i .. ".png"))
  end

  for ii = 2,7 do
    table.insert(leftpicframes,love.graphics.newImage("characters/sonicflip" .. ii .. ".png"))
  end

  for iii = 1,9 do
    table.insert(jumppicframes,love.graphics.newImage("characters/sonicjumping" .. iii .. ".png"))
  end

  playerimg = rightpicframes[1]
  playerimg = leftpicframes[1]
  playerimg = jumppicframes[1]

  nxtframe = 1
  player.y_velocity = 1
  player.jump_height = -200
  player.gravity = -500
  player.speed = 200
  player.x = g_Width / 2
  player.y = g_Height / 2.3
  player.ground = player.y
  myImg = love.graphics.newImage("Assets/bg.png")
  stage = love.graphics.newImage("Assets/mainstage.png")
  player.img = love.graphics.newImage("characters/sonic.png")
  crouch = love.graphics.newImage("characters/soniccrouch1.png")
end
thetimer = 0.1

tspeed = 200

-- its something here
function love.update(dt)
  standing = true

  if player.y_velocity ~= 0 then
    player.y = player.y + player.y_velocity * dt
    player.y_velocity = player.y_velocity - player.gravity * dt
  end
  if player.y > player.ground then
    player.y_velocity = 0
    player.y = player.ground
  end
  if love.keyboard.isDown('space') and not crouching then
    if player.y_velocity == 0 then
      player.y_velocity = player.jump_height
    end
    standing = false
    jumping = true

    else
    jumping = false
  end
  g_GameTime = g_GameTime + dt
  -- the game thinks im holding d
  if love.keyboard.isDown('d') and not crouching then
    player.x = player.x + tspeed * dt
    facing = false
    standing = false
  end
  if thetimer > 0.1 then
    nxtframe = nxtframe + 1
    thetimer = 0
  end
  if nxtframe > 8 then
    nxtframe = 1
    -- thats the d button press ^
  elseif love.keyboard.isDown('a') and not crouching then
    facing = true
    standing = false
    player.x = player.x - tspeed * dt
  end

  thetimer = thetimer + dt
  if thetimer > 0.1 then
    nxtframe = nxtframe + 1
    thetimer = 0
    if nxtframe > 4 then
      nxtframe = 1
    end
  end
  if love.keyboard.isDown('lctrl') then
    standing = false
    crouching = true
  else
    crouching = false
  end
end
function love.draw()
    love.graphics.rectangle("line",205,160,400,200)
    love.graphics.draw(myImg,0,0)
    love.graphics.draw(stage,200,26)
    love.graphics.print("FPS: "..tostring(love.timer.getFPS( )).."\nFACING: "..tostring(facing).."\nSTANDING: "..tostring(standing).."\nCROUCHING: "..tostring(crouching).."\nJUMPING: "..tostring(jumping))
    if colliding then
    print("Collision Detected")
  end
    if standing then
      if facing == true then
        love.graphics.draw(player.img, player.x + 32, player.y, 0, -1, 1, 0, 32)
      elseif facing == false then
        love.graphics.draw(player.img, player.x, player.y, 0, 1, 1, 0, 32)
      end
    elseif crouching then
      if facing == true then
        love.graphics.draw(crouch, player.x + 32, player.y, 0, -1, 1, 0, 32)
      elseif facing == false then
        love.graphics.draw(crouch, player.x, player.y, 0, 1, 1, 0, 32)
      end
    else
      if facing == true then
        love.graphics.draw(leftpicframes[nxtframe], player.x, player.y, 0, 1, 1, 0, 32)
      elseif facing == false then
        love.graphics.draw(rightpicframes[nxtframe], player.x, player.y, 0, 1, 1, 0, 32)
      end
    end
    if jumping then
      if facing == true then
        love.graphics.draw(jumppicframes[nxtframe], player.x, player.y, 0, 1, -1, 0, 32)
      elseif facing == false then
        love.graphics.draw(jumppicframes[nxtframe], player.x, player.y, 0, 1, 1, 0, 32)
      end
  end
end