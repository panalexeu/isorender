-- all of isometric logic rendering is defined here 

function level_load() 
    game_state = "level"
    screen_w = love.graphics.getWidth()
    screen_h = love.graphics.getHeight()
    tile_size = 16
    origin_x = screen_w / 2 
    origin_y = screen_h / 2
    diamond_w = 8 
    diamond_h = 4
    layer_elavation = 8
    level_objects = {
        tiles = {},
    } 
    cur_tile = 1 
    timer = 0
    local layers = {
        {
            {4, 0, 0, 0}, 
            {0, 0, 0, 0}, 
            {0, 0, 0, 0}, 
            {0, 0, 0, 0}
        },
        {
            {4, 0, 0, 0}, 
            {0, 0, 0, 0}, 
            {0, 0, 0, 0}, 
            {0, 0, 0, 0}
        },
        {
            {4, 0, 0, 0}, 
            {0, 0, 0, 0}, 
            {0, 0, 0, 0}, 
            {0, 0, 0, 0}
        },
        {
            {3, 3, 0, 0}, 
            {3, 0, 0, 0}, 
            {0, 0, 0, 0}, 
            {0, 0, 0, 0}
        },
        {
            {2, 2, 2, 0}, 
            {2, 2, 0, 0}, 
            {2, 0, 0, 0}, 
            {0, 0, 0, 0}
        },
        {
            {1, 1, 1, 1}, 
            {1, 1, 1, 1}, 
            {1, 1, 1, 0}, 
            {1, 1, 0, 0}
        }
    }
    load_map(layers)
    tiles_sort(level_objects.tiles)
end 

function level_draw()
    draw_diamond_grid()
    draw_tiles()
end 

function draw_tiles() 
    love.graphics.setColor(1,1,1,1)

    for i=1,#level_objects.tiles do
        local tile = level_objects.tiles[i]
        if tile.visible then
            love.graphics.draw(tile.quad.img, tile.quad.quad, tile.proj_x, tile.proj_y)
        end
    end 
end 

function draw_diamond_grid()
    love.graphics.setColor(1,1,1, 0.33)

    for i=0, screen_w-tile_size, tile_size do     
        love.graphics.line(i, 0, i, screen_h)
    end 

    for j=0, screen_h-tile_size, tile_size do 
        love.graphics.line(0, j, screen_w, j)
    end 
end 

function level_update(dt) 
    -- render tiles one by one as they are sorted by the depth 
    timer = timer + dt 
    if timer > 0.1 then
        level_objects.tiles[cur_tile].visible = true 
        timer = 0 
        cur_tile = cur_tile + 1
        if cur_tile > #level_objects.tiles then cur_tile = #level_objects.tiles end 
    end
end

function level_keypressed(key, scancode)
end 

function level_keyreleased(key, scancode)
end

function level_mousepressed(x ,y, button)
end

function level_mousereleased(x, y, button)
end

function load_map(layers)
    for k=#layers,1,-1 do
        local layer = layers[k]
        for i=1,#layer do 
            for j=1,#layer[i] do 
                local value = layer[i][j]
                if value > 0 then
                    local proj_x = ((j - i) * diamond_w) + origin_x
                    local proj_y = ((i + j) * diamond_h) + (k * layer_elavation) + origin_y
                    local quad = quads.tiles[value]
                    local tile_ = tile:new(j, i, proj_x, proj_y, diamond_w, diamond_h, quad, false, k)
                    table.insert(level_objects.tiles, tile_)
                end 
            end 
        end 
    end
end 

function tiles_sort(tiles)
    -- todo if possible replace bubble sort with something else here 
    -- sorts tiles so that tiles from lower layers come first, and tiles within a layer are sorted by depth (lim->0(y) first)
    for i=1,#tiles do
        local max_j = i
        for j=i,#tiles do
            if tiles[j].y < tiles[max_j].y and tiles[j].layer == tiles[i].layer then
                max_j = j
            end
        end 
        -- swap 
        local temp = tiles[max_j] 
        tiles[max_j] = tiles[i]
        tiles[i] = temp
    end
end

function filter_tiles(tiles)
-- todo implement here function that removes tiles that are not visible from being rendred 
end 