-- isometric logic rendering is defined here 

function level_load() 
    game_state = "level"
    tile_size_x = 16
    tile_size_y = 8 
    level_objects = {
        tiles = {},
    } 
    local tilemap = {
        {1, 1, 1, 1}, 
        {0, 1, 1, 0}, 
        {0, 1, 1, 0}, 
        {0, 1, 1, 0}
    }
    load_map(tilemap)
end 

function level_draw()
    -- draw tiles 
    for i=1,#level_objects.tiles do
        local tile = level_objects.tiles[i]
        love.graphics.setColor(tile.color[1], tile.color[2], tile.color[3], 1)
        love.graphics.rectangle("line", tile.x, tile.y, tile.size_x, tile.size_y)
    end 
end 

function level_update(dt) 
end

function load_map(tilemap)
    for i=1,#tilemap  do 
        for j=1,#tilemap[i] do 
            if tilemap[i][j] == 1 then
                local x_pos = j * tile_size_x
                local y_pos = i * tile_size_y
                local color = {0.529, 0.808, 0.922} -- just a skyblue for now 
                local tile_ = tile:new(x_pos, y_pos, tile_size_x, tile_size_y, color)
                table.insert(level_objects.tiles, tile_)
            end 
        end 
    end 
end 
