function love.load() 
    require "class"
    require "level"
    require "tile"
    
    level_load()
end

function love.update(dt)
    if game_state == "level" then 
        level_update(dt)
    end
end

function love.draw() 
    if game_state == "level" then 
        level_draw()
    end 
end 
