-- game of life
-- jryzkns 2018

-- https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life

local unrequited = require("unrequited")

zoomfactor = 10

function love.load()
        game = {}
        game.xdim = 1000
        game.ydim = 600
        game.title = "life - jryzkns"

        unrequited:windowsetup(game.xdim,game.ydim,game.title)

        game.world = {}
        for i=1,game.xdim/zoomfactor do
                game.world[i] = {}
                for j=1,game.ydim/zoomfactor do
                        game.world[i][j] = false
                end
        end

        game.evolution_delay = 15
        game.paused = true

        -- the main piece!
        function game:evolve()
                -- print("evolve!")
                -- print("current evolution delay:".. tostring(game.evolution_delay).. " frames" .. "current frame: ".. unrequited.photographs)

                local new_world = {}

                -- check everything in the world
                for i=1,game.xdim/zoomfactor do
                        new_world[i] = {}
                        for j=1,game.ydim/zoomfactor do

                                local lifecount = 0

                                for hori = -1,1 do
                                        for vert = -1,1 do
                                                local checkx, checky = i + hori, j + vert
                                                if checkx == 0 then checkx = game.xdim/zoomfactor end
                                                if checkx == game.xdim/zoomfactor + 1 then checkx = 1 end
                                                if checky == 0 then checky = game.ydim/zoomfactor end
                                                if checky == game.ydim/zoomfactor + 1 then checky = 1 end

                                                if game.world[checkx][checky] then
                                                        lifecount = lifecount + 1 
                                                end

                                        end
                                end

                                if game.world[i][j] then lifecount = lifecount - 1 end -- to discount self

                                -- assume you die in the end
                                local new_life = false

                                -- if you are alive
                                if game.world[i][j] then
                                        -- if you have optimal amount of neighbours
                                        if lifecount == 2 or lifecount == 3 then
                                                new_life = true
                                        end
                                else -- if you are not alive
                                        -- by reproduction you become alive
                                        if lifecount == 3 then
                                                new_life = true
                                        end
                                end

                                new_world[i][j] = new_life

                        end
                end

                game.world = new_world

        end
end

function love.update(dt)
        if not game.paused then
                unrequited:update()
                if(unrequited.photographs % game.evolution_delay == 0) then
                game:evolve()
                end
        end
end

function love.keypressed(key)
        if key == "p" then unrequited:remember_me() 
        elseif key == "space" then game.paused = not game.paused
        elseif key == "s" then game:evolve()
        end
end

function love.keyreleased(key)
        if key == "escape" then unrequited:heartbreak() end
end

function love.mousepressed(x,y,button,istouch)
        if button == 1 then
                game.world[math.floor(x/zoomfactor)+1][math.floor(y/zoomfactor)+1] = not game.world[math.floor(x/zoomfactor)+1][math.floor(y/zoomfactor)+1]
        end
end

function love.wheelmoved(x,y)
        -- janky but it works
        if game.evolution_delay >= 1 then
                game.evolution_delay = game.evolution_delay + y
        else
                game.evolution_delay = 1        
        end
end

function love.draw()

        if game.paused then
                love.graphics.printf("paused",0,0,200)
        end

        for k=1,game.xdim/zoomfactor do
                for l=1,game.ydim/zoomfactor do
                        love.graphics.push()
                                love.graphics.translate((k-1)*zoomfactor,(l-1)*zoomfactor)
                                if game.world[k][l] then
                                        love.graphics.setColor(1,1,1)
                                        love.graphics.rectangle("fill",0,0,zoomfactor,zoomfactor)
                                else
                                        love.graphics.setColor(0.5,0.5,0.5,0.2)
                                        love.graphics.rectangle("line",0,0,zoomfactor,zoomfactor) 
                                end
                        love.graphics.pop()
                        
                end
        end

end