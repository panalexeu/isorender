function love.load() 
    require "class"
    require "level"
    require "quad"
    require "tile"
    
    -- load graphics (quads and spreadsheets) 
    quads = {
        tiles = {}
    } 
    local tiles_sheet = love.graphics.newImage("assets/tiles.png")
    load_quads(tiles_sheet, 16, 16, "tiles")
    
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

function load_quads(sheet, w, h, key) 
    local sheet_w, sheet_h = sheet:getDimensions()

    for i=0,sheet_h-h,h do
        for j=0,sheet_w-w,w do
            local quad_ = quad:new(sheet, j, i, w, h, sheet_w, sheet_h)
            table.insert(quads[key], quad_)
        end 
    end 
end  