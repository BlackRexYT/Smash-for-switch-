local rect = require "objects.rect"

local Entity = {}

function Entity:new(x,y,w,h,id)
    local ent = rect:new(x,y,w,h)

    ent.vel = rect:new(0,0)
    ent.dir = rect:new(0,0)
    ent.speed = rect:new (0,0)

    ent.id = id or "objects"

    function ent:load()end
    function ent:tick(dt)end
    function ent:draw()end

    return ent
end

return Entity