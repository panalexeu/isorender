function love.load() 
    require "class"
    require "level"
    require "quad"
    require "tile"
    
    -- load graphics (quads and spreadsheets) 
    tile_size = 16  
    quads = {
        tiles = {}
    } 
    local tiles_sheet = love.graphics.newImage("assets/tiles.png")
    load_quads(tiles_sheet, tile_size, tile_size, "tiles")
    
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

function love.keypressed(key, scancode)
    -- key is the character produced based on the current keyboard layout, so it can change if the layout changes
    -- scancode is the physical position of the key on the keyboard, so it stays the same no matter the layout

    print(key, scancode)

    if scancode == 'escape' then love.event.quit() end 
end  

function love.keyreleased(key, scancode)
end

function love.mousepressed(x, y, button)
    print(x, y, button)
end 

function love.mousereleased(x, y, button)
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