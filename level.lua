-- isometric logic rendering is defined here 

function level_load() 
    game_state = "level"
    origin_x = 32
    origin_y = 0
    tile_size_x = 16
    tile_size_y = 16
    diamond_w = 8 
    diamond_h = 4
    diamond_elavation = 8
    level_objects = {
        tiles = {},
    } 
    local layers = {
        {
            {2, 2, 2, 2}, 
            {2, 2, 2, 2}, 
            {2, 2, 2, 2}, 
            {2, 2, 2, 2}
        },
        {
            {0, 0, 0, 0, 3, 3, 3, 3}, 
            {0, 0, 0, 0, 3, 0, 0, 3}, 
            {0, 0, 0, 0, 3, 0, 0, 3}, 
            {0, 0, 0, 0, 3, 0, 0, 3},
            {3, 3, 3, 3, 3, 0, 0, 3}
        }
    }
    load_map(layers)
end 

function level_draw()
    -- draw tiles 
    for i=1,#level_objects.tiles do
        local tile = level_objects.tiles[i]
        love.graphics.draw(tile.quad.img, tile.quad.quad, tile.x, tile.y)
    end 
end 

function level_update(dt) 
end

function load_map(layers)
    for k=1,#layers do
        local layer = layers[k]
        for i=1,#layer do 
            for j=1,#layer[i] do 
                local value = layer[i][j]
                if value > 0 then
                    local x_proj = ((j - i) * diamond_w) + origin_x
                    local y_proj = ((i + j) * diamond_h) + (k * diamond_elavation) + origin_y
                    print(k * diamond_elavation)
                    local quad = quads.tiles[value]
                    local tile_ = tile:new(x_proj, y_proj, diamond_w, diamond_h, quad)
                    table.insert(level_objects.tiles, tile_)
                end 
            end 
        end 
    end
end 
