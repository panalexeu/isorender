-- isometric logic rendering is defined here 
-- TODO look at code in more detail tomorrow, implement layer sorting, should be one time O(N) tiles sort with earlier layers being rendered first

function level_load() 
    game_state = "level"
    origin_x = 32
    origin_y = 0
    tile_size_x = 16
    tile_size_y = 16
    diamond_w = 8 
    diamond_h = 4
    layer_elavation = 8
    level_objects = {
        tiles = {},
    } 
    local layers = {
        {
            {4, 2, 2, 0}, 
            {2, 2, 2, 0}, 
            {2, 2, 2, 0}, 
            {0, 0, 0, 0}
        },
        {
            {4, 2, 2, 0}, 
            {2, 2, 2, 0}, 
            {2, 2, 2, 0}, 
            {0, 0, 0, 0}
        },
        {
            {4, 2, 2, 0}, 
            {2, 2, 2, 0}, 
            {2, 2, 2, 0}, 
            {0, 0, 0, 0}
        },
        {
            {4, 2, 2, 0}, 
            {2, 2, 2, 0}, 
            {2, 2, 2, 0}, 
            {0, 0, 0, 0}
        }
    }
    load_map(layers)
    tiles_sort(level_objects.tiles)
end 

function level_draw()
    -- draw tiles 
    for i=1,#level_objects.tiles do
        local tile = level_objects.tiles[i]
        print(tile.layer)
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
                    local y_proj = ((i + j) * diamond_h) + (k * layer_elavation) + origin_y
                    local quad = quads.tiles[value]
                    local tile_ = tile:new(x_proj, y_proj, diamond_w, diamond_h, quad, k)
                    table.insert(level_objects.tiles, tile_)
                end 
            end 
        end 
    end
end 

function tiles_sort(tiles)
    -- todo implement merge sort here 
    -- for now just bubble sort o(n^2)
    -- this function can also be omitted if traverse layers in reversed order 
    for i=1,#tiles do
        local max_j = i
        for j=i,#tiles do
            if tiles[j].layer > tiles[max_j].layer then
                max_j = j
            end
        end 
        -- swap 
        local temp = tiles[max_j] 
        tiles[max_j] = tiles[i]
        tiles[i] = temp
    end
end