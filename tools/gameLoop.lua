local GameLoop = {}

local insert = table.insert
local remove = table.remove

function GameLoop:create()
    local game = {}

    game.tickers = {}
    for layer = 0, 5 do
    	game.tickers[1] = {}
    end

    function game:addgameLoop(obj)
        insert(self.tickers,obj)
    end

    function GameLoop:update(dt)

        for i = 0,#self.tickers do
            local obj = self.tickers[i]
            --obj:tick(dt) <-- Tickers currently do not have ":tick"
         end

    end

    return game
end

return GameLoop    