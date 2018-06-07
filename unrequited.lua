local unrequited = {}

unrequited.photographs = 0

function unrequited:update()
        unrequited.photographs = unrequited.photographs + 1

end

function unrequited:generic_entity_load(x,y,spritepath)
        local ent = {}
        ent.x,ent.y=x,y
        if spritepath then
                ent.sprite = love.graphics.newImage(spritepath)
                function ent:draw()
                        love.graphics.push()
                                love.graphics.translate(ent.x,ent.y)
                                love.graphics.draw(ent.sprite)
                        love.graphics.pop()
                end
        end
        return ent
end

function unrequited:ghost(clause)
        return not clause
end

function unrequited:generic_animation_load(x,y,spritepath,frames,framex,framey,animationdescaling)
        local ent = unrequited:generic_entity_load(x,y,spritepath)
        ent.animation, ent.frames = {},frames
        for i=0,ent.frames - 1 do
                ent.animation[i] = love.graphics.newQuad(i*framex, 0, framex, framey, ent.sprite:getDimensions())
        end
        function ent:draw(t) -- this overwrites the draw() from generic_entity_load
                love.graphics.push()
                love.graphics.translate(ent.x,ent.y)
                love.graphics.draw(ent.sprite,ent.animation[math.floor(t/animationdescaling)%ent.frames])
                love.graphics.pop()
        end
        return ent
end

function unrequited:generic_window(x,y,w,h)
        local ent = unrequited:generic_entity_load(x,y,nil)
        ent.show = false
        ent.width,ent.height = w,h
        return ent

end

function unrequited:windowsetup(xdim,ydim,title)
        love.window.setMode(xdim,ydim)
        love.window.setTitle(title)
end

function unrequited:bgmsetup(audiopath,mode) --mode can only be "static" or "streaming"
        local bgm = love.audio.newSource(audiopath,mode)
        bgm:setLooping(true)
        bgm:play()
end

function unrequited:graphicsreset()
        love.graphics.setColor(1,1,1)
        love.graphics.origin()
end

function unrequited:heartbreak()
        love.event.quit()
end

function unrequited:remember_me()
        --screenshot saved in ~/.local/share/love/$(project)/
        love.filesystem.createDirectory("unrequited memories")
        local filename = "unrequited memories/unrequited_memory" .. os.time() .. ".png" 
        love.graphics.captureScreenshot(filename)
end

return unrequited